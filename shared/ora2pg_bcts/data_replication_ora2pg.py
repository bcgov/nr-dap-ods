#!/usr/bin/env python
# coding: utf-8

# In[1]: Imports
# refer if block at line 38, some imports are conditional
import psycopg
from psycopg_pool import ConnectionPool
from psycopg import Connection
import configparser
import time
import json
import concurrent.futures
from datetime import datetime
import sys
import os
import argparse
import oracledb

start = time.time()

# oracledb.init_oracle_client(lib_dir="/opt/oracle/instantclient_21_12")

# setting to reduce time out errors for oracle connections
oracledb.defaults.fetch_lobs = False

# In[3]: Retrieve Oracle database configuration
oracle_username = os.environ['DB_USERNAME']
oracle_password = os.environ['DB_PASSWORD']
oracle_host = os.environ['DB_HOST']
oracle_port = os.environ['DB_PORT']
oracle_database = os.environ['DATABASE']
# In[4]: Retrieve Postgres database configuration
postgres_username = os.environ['ODS_USERNAME']
postgres_password = os.environ['ODS_PASSWORD']
postgres_host = os.environ['ODS_HOST']
postgres_port = os.environ['ODS_PORT']
postgres_database = os.environ['ODS_DATABASE']
# In[5]: Script parameters
mstr_schema = os.environ['MSTR_SCHEMA']
app_name = os.environ['APP_NAME']
concurrent_tasks = int(os.environ['CONCUR_TASKS'])
audit_table = 'audit_batch_status'
current_date = datetime.now().strftime('%Y-%m-%d')

# concurrent_tasks = int(concurrent_tasks)
# In[5]: Concurrent tasks - number of tables to be replicated in parallel
# concurrent_tasks = 5

# In[6]: Set up Oracle connection pool
dsn = oracledb.makedsn(host=oracle_host, port=oracle_port,
                       service_name=oracle_database)
OrcPool = oracledb.SessionPool(user=oracle_username, password=oracle_password, dsn=dsn, min=concurrent_tasks,
                               max=concurrent_tasks, increment=1, encoding="UTF-8")
# print(oracle_host, oracle_port, oracle_database, oracle_username, oracle_password)
# print('Oracle Pool Successful')

# In[7]: Setup Postgres Pool
PgresPool = ConnectionPool(
    conninfo=f"host={postgres_host} port={postgres_port} dbname={postgres_database} user={postgres_username} password={postgres_password}",
    min_size=concurrent_tasks,
    max_size=concurrent_tasks,
    timeout=10  # how long to wait for a connection before raising an error
)
print('Postgres Connection Successful')


def del_audit_entries_rerun(current_date):
    postgres_connection = PgresPool.getconn()
    postgres_cursor = postgres_connection.cursor()
    del_sql = f"""
  DELETE FROM {mstr_schema}.{audit_table} c
  WHERE application_name='{app_name}' and batch_run_date='{current_date}'
  """
    postgres_cursor.execute(del_sql)
    postgres_connection.commit()
    postgres_cursor.close()
    PgresPool.putconn(postgres_connection)
    return print(del_sql)

# Function to insert the audit batch status entry


def audit_batch_status_insert(table_name, status, error_message='None'):
    postgres_connection = PgresPool.getconn()
    postgres_cursor = postgres_connection.cursor()
    try:
        audit_batch_status_query = f"""INSERT INTO {mstr_schema}.{audit_table} (object_name, application_name, etl_layer, object_execution_status, batch_run_date, error_message) VALUES (%s, %s, %s, %s, current_date, %s)"""
        values = (table_name, app_name, 'replication', status, error_message)
        print(audit_batch_status_query, values)
        postgres_cursor.execute(audit_batch_status_query, values)
        postgres_connection.commit()
        print("Record inserted into audit batch status table")
        return None
    except Exception as e:
        print(
            f"Error inserting record into to audit batch status table: {str(e)}")
        return None
    finally:
        # Return the connection to the pool
        if postgres_connection:
            postgres_cursor.close()
            PgresPool.putconn(postgres_connection)

# In[8]: Function to get active rows from master table


def get_active_tables(mstr_schema, app_name):
    postgres_connection = PgresPool.getconn()
    postgres_cursor = postgres_connection.cursor()
    list_sql = f"""
  SELECT application_name,source_schema_name,source_table_name,target_schema_name,target_table_name,truncate_flag,cdc_flag,full_inc_flag,cdc_column,replication_order,customsql_ind,customsql_query
  FROM {mstr_schema}.cdc_master_table_list c
  WHERE active_ind = 'Y' and application_name='{app_name}'
  ORDER BY replication_order, source_table_name
  """
    with postgres_connection.cursor() as curs:
        curs.execute(list_sql)
        rows = curs.fetchall()
    postgres_connection.commit()
    postgres_cursor.close()
    PgresPool.putconn(postgres_connection)
    return rows

# In[9]: Function to extract data from Oracle


def extract_from_oracle(table_name, source_schema, customsql_ind, customsql_query):
    # Acquire a connection from the pool
    oracle_connection = OrcPool.acquire()
    oracle_cursor = oracle_connection.cursor()
    try:
        if customsql_ind == "Y":
            # Use placeholders in the query and bind the table name as a parameter
            sql_query = customsql_query
            print(sql_query)
            oracle_cursor.execute(sql_query)
            rows = oracle_cursor.fetchall()
            OrcPool.release(oracle_connection)
            return rows
        else:
            sql_query = f'SELECT * FROM {source_schema}.{table_name}'
            print(sql_query)
            oracle_cursor.execute(sql_query)
            rows = oracle_cursor.fetchall()
            OrcPool.release(oracle_connection)
            return rows

    except Exception as e:
        audit_batch_status_insert(table_name, 'failed', str(e))
        print(f"Error extracting data from Oracle: {str(e)}")
        # OrcPool.release(oracle_connection)  #Temporary change
        return []

# In[10]: Function to load data into Target PostgreSQL using data from Source Oracle


def load_into_postgres(table_name, data, target_schema):
    try:
        with PgresPool.connection() as conn:
            with conn.cursor() as cur:
                # Truncate table
                delete_query = f'TRUNCATE TABLE {target_schema}.{table_name}'
                cur.execute(delete_query)

                data_to_insert = [(tuple(row)) for row in data]
                with cur.copy(f"COPY {target_schema}.{table_name} FROM STDIN") as copy:
                    for record in data_to_insert:
                        copy.write_row(record)
                    
        # Insert record to audit batch table
        audit_batch_status_insert(table_name, 'success')

    except Exception as e:
        print(f"Error loading data into PostgreSQL: {str(e)}")
        audit_batch_status_insert(table_name, 'failed', str(e))
    

# In[11]: Function to call both extract and load functions


def load_data_from_src_tgt(table_name, source_schema, target_schema, customsql_ind, customsql_query):
    # Extract data from Oracle
    print(f'Source: Thread {table_name} started at ' +
          datetime.now().strftime("%H:%M:%S"))
    # Ensure table name is in uppercase
    oracle_data = extract_from_oracle(
        table_name, source_schema, customsql_ind, customsql_query)
    print(f'Source: Extraction for {table_name} completed at ' +
          datetime.now().strftime("%H:%M:%S"))

    if oracle_data:
        # Load data into PostgreSQL
        load_into_postgres(table_name, oracle_data, target_schema)
        print(f"Target: Data loaded into table: {table_name}")
        print(f'Target: Thread {table_name} ended at ' +
              datetime.now().strftime("%H:%M:%S"))


# In[12]: Initializing concurrency
if __name__ == '__main__':
    # Main ETL process
    active_tables_rows = get_active_tables(mstr_schema, app_name)
    # print(active_tables_rows)
    tables_to_extract = [(row[2], row[1], row[3], row[10], row[11])
                         for row in active_tables_rows]

    print(f"tables to extract are {tables_to_extract}")
    print(f'No of concurrent tasks:{concurrent_tasks}')
    # Delete audit entries for rerun on same day
    del_audit_entries_rerun(current_date)
    # Using ThreadPoolExecutor to run tasks concurrently
    with concurrent.futures.ThreadPoolExecutor(max_workers=concurrent_tasks) as executor:
        # Submit tasks to the executor
        future_to_table = {executor.submit(
            load_data_from_src_tgt, table[0], table[1], table[2], table[3], table[4]): table for table in tables_to_extract}

        # Wait for all tasks to complete
        concurrent.futures.wait(future_to_table)

        # Print results
        for future in future_to_table:
            table_name = future_to_table[future]
            try:
                # Get the result of the task, if any
                future.result()
            except Exception as e:
                # Handle exceptions that occurred during the task
                print(f"Error replicating {table_name}: {e}")
                audit_batch_status_insert(table_name[0], 'failed', str(e))

    # record end time
    end = time.time()
    OrcPool.close()
    PgresPool.close()

    print("ETL process completed successfully.")
    print(f"The time of execution of the program is: {(end - start)} secs")
