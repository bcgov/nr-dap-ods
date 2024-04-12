#!/usr/bin/env python
# coding: utf-8

# In[1]: Imports
# refer if block at line 38, some imports are conditional
import psycopg2
import psycopg2.pool
import psycopg2.extras
from psycopg2.extras import execute_batch
import configparser
import time
import json
import concurrent.futures
from datetime import datetime
import sys
import os
import argparse


start = time.time()

# In[3]: Retrieve Oracle database configuration
src_postgres_username = os.environ['DB_USERNAME']
src_postgres_password = os.environ['DB_PASSWORD']
src_postgres_host = os.environ['DB_HOST']
src_postgres_port = os.environ['DB_PORT']
src_postgres_database = os.environ['DATABASE']
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

#concurrent_tasks = int(concurrent_tasks)    
#In[5]: Concurrent tasks - number of tables to be replicated in parallel
#concurrent_tasks = 5

# In[6]: Set up Oracle connection pool
# In[7]: Setup Postgres Pool 
SrcPgresPool = psycopg2.pool.ThreadedConnectionPool(
    minconn = concurrent_tasks, maxconn = concurrent_tasks,host=src_postgres_host, port=src_postgres_port, dbname=src_postgres_database, user=src_postgres_username, password=src_postgres_password
)
print('Source Postgres Connection Successful')

# In[7]: Setup Postgres Pool 
PgresPool = psycopg2.pool.ThreadedConnectionPool(
    minconn = concurrent_tasks, maxconn = concurrent_tasks,host=postgres_host, port=postgres_port, dbname=postgres_database, user=postgres_username, password=postgres_password
)
print('Target Postgres Connection Successful')

def del_audit_entries_rerun(current_date):
  postgres_connection  = PgresPool.getconn()  
  postgres_cursor = postgres_connection.cursor()
  del_sql = f"""
  DELETE FROM {mstr_schema}.{audit_table} c
  where application_name='{app_name}' and batch_run_date='{current_date}'
  """
  postgres_cursor.execute(del_sql)
  postgres_connection.commit()
  postgres_cursor.close()
  PgresPool.putconn(postgres_connection)
  return print(del_sql)

# Function to insert the audit batch status entry
def audit_batch_status_insert(table_name,status):
  postgres_connection  = PgresPool.getconn()  
  postgres_cursor = postgres_connection.cursor()
  try:
    audit_batch_status_query = f"""INSERT INTO {mstr_schema}.{audit_table} VALUES ('{table_name}','{app_name}','replication','{status}',current_date)"""
    print(audit_batch_status_query)
    postgres_cursor.execute(audit_batch_status_query)
    postgres_connection.commit()
    print(f"Record inserted into audit batch status table")
    return None
  except Exception as e:
      print(f"Error inserting record into to audit batch status table: {str(e)}")
      return None
  finally:
        # Return the connection to the pool
        if postgres_connection:
            postgres_cursor.close()
            PgresPool.putconn(postgres_connection)

# In[8]: Function to get active rows from master table
def get_active_tables(mstr_schema,app_name):
  postgres_connection  = PgresPool.getconn()  
  postgres_cursor = postgres_connection.cursor()
  list_sql = f"""
  SELECT application_name,source_schema_name,source_table_name,target_schema_name,target_table_name,truncate_flag,cdc_flag,full_inc_flag,cdc_column,replication_order,customsql_ind,customsql_query
  from {mstr_schema}.cdc_master_table_list c
  where  active_ind = 'Y' and application_name='{app_name}'
  order by replication_order, source_table_name
  """
  with postgres_connection.cursor() as curs:
            curs.execute(list_sql)
            rows = curs.fetchall()
  postgres_connection.commit()
  postgres_cursor.close()
  PgresPool.putconn(postgres_connection)
  return rows

# In[9]: Function to extract data from Oracle
def extract_from_srcpg(table_name,source_schema,customsql_ind,customsql_query):
    # Acquire a connection from the pool
    srcpostgres_connection = SrcPgresPool.getconn()
    srcpostgres_cursor = srcpostgres_connection.cursor()   
    try:
        if customsql_ind == "Y":
            # Use placeholders in the query and bind the table name as a parameter
            sql_query=customsql_query
            print(sql_query)
            srcpostgres_cursor.execute(sql_query)
            rows = srcpostgres_cursor.fetchall()
            #OrcPool.release(oracle_connection)
            return rows  
        else:
            sql_query = f'SELECT * FROM {source_schema}.{table_name}'
            print(sql_query)
            srcpostgres_cursor.execute(sql_query)
            rows = srcpostgres_cursor.fetchall()
            #OrcPool.release(oracle_connection)
            return rows
        
    except Exception as e:
        audit_batch_status_insert(table_name,'failed')
        print(f"Error extracting data from SrcPostgres: {str(e)}")
        #OrcPool.release(oracle_connection)  #Temporary change
        return []
    
    finally:
        # Return the connection to the pool
        if srcpostgres_connection:
            srcpostgres_cursor.close()
            SrcPgresPool.putconn(srcpostgres_connection)
# In[10]: Function to load data into Target PostgreSQL using data from Source Oracle
def load_into_postgres(table_name, data,target_schema):
    postgres_connection = PgresPool.getconn()
    postgres_cursor = postgres_connection.cursor()
    try:
        # Delete existing data in the target table
        delete_query = f'TRUNCATE TABLE {target_schema}.{table_name}'
        postgres_cursor.execute(delete_query)
        
        # Build the INSERT query with placeholders
        insert_query = f'INSERT INTO {target_schema}.{table_name} VALUES ({", ".join(["%s"] * len(data[0]))})'
        #insert_query = f'INSERT INTO {target_schema}.{table_name} VALUES %s'

        # Use execute_batch for efficient batch insert
        with postgres_connection.cursor() as cursor:
            # Prepare the data as a list of tuples
            data_to_insert = [(tuple(row)) for row in data]
            execute_batch(cursor, insert_query, data_to_insert)
            postgres_connection.commit()
            # Insert record to audit batch table        
            audit_batch_status_insert(table_name,'success')
            
        
    except Exception as e:
        print(f"Error loading data into PostgreSQL: {str(e)}")
        audit_batch_status_insert(table_name,'failed')
    finally:
        # Return the connection to the pool
        if postgres_connection:
            postgres_cursor.close()
            PgresPool.putconn(postgres_connection)

# In[11]: Function to call both extract and load functions
def load_data_from_src_tgt(table_name,source_schema,target_schema,customsql_ind,customsql_query):
        # Extract data from Oracle
        print(f'Source: Thread {table_name} started at ' + datetime.now().strftime("%H:%M:%S"))
        srcpg_data = extract_from_srcpg(table_name,source_schema,customsql_ind,customsql_query)  # Ensure table name is in uppercase
        print(f'Source: Extraction for {table_name} completed at ' + datetime.now().strftime("%H:%M:%S"))
        
        if srcpg_data:
            # Load data into PostgreSQL
            load_into_postgres(table_name, srcpg_data, target_schema)
            print(f"Target: Data loaded into table: {table_name}")
            print(f'Target: Thread {table_name} ended at ' + datetime.now().strftime("%H:%M:%S"))

# In[12]: Initializing concurrency
if __name__ == '__main__':
    # Main ETL process
    active_tables_rows =get_active_tables(mstr_schema,app_name) 
    #print(active_tables_rows)
    tables_to_extract = [(row[2],row[1],row[3],row[10],row[11]) for row in active_tables_rows]
    
    print(f"tables to extract are {tables_to_extract}")
    print(f'No of concurrent tasks:{concurrent_tasks}')
     #Delete audit entries for rerun on same day
    del_audit_entries_rerun(current_date)
    # Using ThreadPoolExecutor to run tasks concurrently
    with concurrent.futures.ThreadPoolExecutor(max_workers=concurrent_tasks) as executor:
        # Submit tasks to the executor
        future_to_table = {executor.submit(load_data_from_src_tgt, table[0],table[1],table[2],table[3],table[4]): table for table in tables_to_extract}
        
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
                audit_batch_status_insert(table_name[0],'failed')
    
    # record end time
    end = time.time()
    SrcPgresPool.closeall()
    PgresPool.closeall()
    
    print("ETL process completed successfully.")
    print("The time of execution of the program is:", (end - start) , "secs")

