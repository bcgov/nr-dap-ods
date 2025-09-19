#!/usr/bin/env python
# coding: utf-8

#Imports
import os, time
import psycopg2
from psycopg2 import errorcodes
import logging
import sys
import pandas as pd
from datetime import datetime, timedelta, date
import pytz


from transformation_queries.licence_transfer.licence_transfer import get_licence_transfer_query

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

def run_licence_transfer_report(connection, cursor, start_date, end_date):

    # Run volume advertised official report
    sql_statement = get_licence_transfer_query(start_date, end_date)

    try:
        # logging.info(f"Executing the query...")
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"VLicence transfer script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)


def licence_transfer_report_exists(start_date, end_date):
    sql_statement = \
    f"""

    select exists (select * from bcts_reporting.licence_trasfer
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
        connection.rollback()
        if e.pgcode == errorcodes.UNDEFINED_TABLE:
            logging.warning("Table bcts_reporting.licence_transfer does not exist.")
            return False
        else:
            logging.error(f"Error executing the SQL script: {e}")

def publish_datasets():

    sql_statement = \
    """
    DROP TABLE IF EXISTS BCTS_STAGING.licence_transfer;
    CREATE TABLE BCTS_STAGING.licence_transfer
    AS SELECT * 
    FROM BCTS_STAGING.licence_transfer_hist
    WHERE report_end_date = (
        SELECT MAX(report_end_date)
        FROM BCTS_STAGING.licence_transfer_hist
	);

    DROP TABLE IF EXISTS BCTS_REPORTING.licence_transfer;
    CREATE TABLE BCTS_REPORTING.licence_transfer
    AS SELECT * 
    FROM BCTS_STAGING.licence_transfer;

    DROP TABLE IF EXISTS BCTS_REPORTING.licence_transfer_hist;
    CREATE TABLE BCTS_REPORTING.licence_transfer_hist
    AS SELECT * 
    FROM BCTS_STAGING.licence_transfer_hist;

    """

    try:
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)

def delete_licence_transfer_hist(connection, cursor, start_date, end_date):
    sql_statement = \
    f"""
    delete from bcts_staging.licence_transfer_hist
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
    if licence_transfer_report_exists(start_date, end_date):
        logging.info("Report already exists! Skipping...")
    else:

        # Delete data for the same period in bcts_staging.volume_advertised_main_hist if it is already present.
        # Check for existence is done on bcts_reporting.volume_advertised_main. So it is possible to insert dupliocate
        # values to the staging table if data is already present in staging and not in reporting or if data is manually removed from
        # reporting to force ETL and not from staging.
        delete_licence_transfer_hist(connection, cursor, start_date, end_date)

        logging.info(f"Running licence transfer report for the period of  {start_date} and {end_date}...")
        run_licence_transfer_report(connection, cursor, start_date, end_date)
        # Publish updated reporting objects to the reporting layer
        logging.info("Updating datasets to the reporting layer...")
        publish_datasets()
        logging.info("Datasets in the reporting layer have been updated!")


    # Clean up
    cursor.close()
    connection.close()
        
