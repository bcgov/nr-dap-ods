#!/usr/bin/env python
# coding: utf-8

#Imports
import os, time
import psycopg2
import logging
import sys
import pandas as pd
from datetime import datetime, timedelta, date
import pytz


from transformation_queries.volume_advertised.volume_advertised_official import get_volume_advertised_official_query
from transformation_queries.volume_advertised.volume_advertised_main import get_volume_advertised_main_query

start = time.time()

# Retrieve Postgres database configuration
postgres_username = os.environ['ODS_USERNAME']
postgres_password = os.environ['ODS_PASSWORD']
postgres_host = os.environ['ODS_HOST']
postgres_port = os.environ['ODS_PORT']
postgres_database = os.environ['ODS_DATABASE']

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler()
    ]
)

def get_connection():
    # Establish database connection
    try:
        connection = psycopg2.connect(
            dbname=postgres_database,
            user=postgres_username,
            password=postgres_password,
            host=postgres_host,
            port=postgres_port
        )
        cursor = connection.cursor()
        logging.info("Database connection established.")
        return connection
    except psycopg2.Error as e:
        logging.error(f"Error connecting to the database: {e}")
        sys.exit(1)

def run_volume_advertised_official_report(connection, cursor, start_date, end_date):

    # Run volume advertised official report
    sql_statement = get_volume_advertised_official_query(start_date, end_date)

    try:
        # logging.info(f"Executing the query...")
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)
    
def run_volume_advertised_main_report(connection, cursor):
    # Run volume advertised main report
    sql_statement = get_volume_advertised_main_query()

    try:
        # logging.info(f"Executing the query...")
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")

        # Generate volume advertised main report
        
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)


def volume_advertised_main_report_exists(start_date, end_date):
    sql_statement = \
    f"""

    select exists (select * from bcts_reporting.volume_advertised_main
    where report_start_date = '{start_date}'
    and report_end_date = '{end_date}'
    ) as report_exists;

    """

    try:
        cursor.execute(sql_statement)
        connection.commit()
        # Fetch the result and load into a DataFrame
        result = cursor.fetchall()
        columns = [desc[0] for desc in cursor.description]  # Get column names
        df = pd.DataFrame(result, columns=columns)
        logging.info(f"SQL script executed successfully.")
        logging.info(f"report_exists: {df['report_exists']}")
        return df['report_exists'][0]
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()

def publish_datasets():

    sql_statement = \
    """
    DROP TABLE IF EXISTS BCTS_STAGING.volume_advertised_main;
    CREATE TABLE BCTS_STAGING.volume_advertised_main
    AS SELECT * 
    FROM BCTS_STAGING.volume_advertised_main_hist
    WHERE report_end_date = (
        SELECT MAX(report_end_date)
        FROM BCTS_STAGING.volume_advertised_main_hist
	);

    DROP TABLE IF EXISTS BCTS_REPORTING.volume_advertised_main;
    CREATE TABLE BCTS_REPORTING.volume_advertised_main
    AS SELECT * 
    FROM BCTS_STAGING.volume_advertised_main;

    DROP TABLE IF EXISTS BCTS_REPORTING.volume_advertised_main_hist;
    CREATE TABLE BCTS_REPORTING.volume_advertised_main_hist
    AS SELECT * 
    FROM BCTS_STAGING.volume_advertised_main_hist;

    """

    try:
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)

def delete_volume_advertised_main_hist(connection, cursor, start_date, end_date):
    sql_statement = \
    f"""
    delete from bcts_staging.volume_advertised_main_hist
    where report_start_date = '{start_date}'
    and report_end_date = '{end_date}';
    """

    try:
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)

def truncate_volume_advertised_official(connection, cursor):
    # updated to delete from due to permission issues
    sql_statement = \
    f"""
    delete from bcts_staging.volume_advertised_official;
    """

    try:
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)

def get_report_interval():
    current_year = datetime.today().year
    current_month = datetime.today().month 
    if current_month < 5:
        fiscal_year_start = date(current_year - 1, 4, 1)
    else:
        fiscal_year_start = date(current_year, 4, 1)

    return(fiscal_year_start, date(current_year, current_month, 1) - timedelta (days=1))

if __name__ == "__main__":

    connection = get_connection()
    cursor = connection.cursor()

    # Fetch the start and end dates for the report periods
    start_date, end_date = get_report_interval()

    # Skip if report is already generated
    if volume_advertised_main_report_exists(start_date, end_date):
        logging.info("Report already exists! Skipping...")
    else:
        # Truncate bcts_staging.volume_advertised_official clear data from previous run
        truncate_volume_advertised_official(connection, cursor)

        # Delete data for the same period in bcts_staging.volume_advertised_main_hist if it is already present.
        # Check for existence is done on bcts_reporting.volume_advertised_main. So it is possible to insert dupliocate
        # values to the staging table if data is already present in staging and not in reporting or if data is manually removed from
        # reporting to force ETL and not from staging.
        delete_volume_advertised_main_hist(connection, cursor, start_date, end_date)

        logging.info(f"Running Volume advertised official report for the period of  {start_date} and {end_date}...")
        run_volume_advertised_official_report(connection, cursor, start_date, end_date)

        run_volume_advertised_main_report(connection, cursor)

        # Publish updated reporting objects to the reporting layer
        logging.info("Updating datasets to the reporting layer...")
        publish_datasets()
        logging.info("Datasets in the reporting layer have been updated!")


    # Clean up
    cursor.close()
    connection.close()
        
