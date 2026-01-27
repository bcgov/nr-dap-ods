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



from transformation_queries.licence_sold_out_of_province_registrants.licence_sold_out_of_province import get_licence_sold_out_of_province_query

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

def run_licence_sold_out_of_province_report(connection, cursor, start_date, end_date):

    # Run licence sold_out_of_province report
    sql_statement = get_licence_sold_out_of_province_query(start_date, end_date)

    try:
        # logging.info(f"Executing the query...")
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"licence_sold_out_of_province script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)


def licence_sold_out_of_province_report_exists(start_date, end_date):
    sql_statement = \
    f"""

    select exists (select * from bcts_reporting.licence_sold_to_out_of_province_registrants
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
    DROP TABLE IF EXISTS BCTS_STAGING.licence_sold_to_out_of_province_registrants;
    CREATE TABLE BCTS_STAGING.licence_sold_to_out_of_province_registrants
    AS SELECT * 
    FROM BCTS_STAGING.licence_sold_to_out_of_province_registrants_hist
    WHERE report_end_date = (
        SELECT MAX(report_end_date)
        FROM BCTS_STAGING.licence_sold_to_out_of_province_registrants_hist
	);

    DROP TABLE IF EXISTS BCTS_REPORTING.licence_sold_to_out_of_province_registrants;
    CREATE TABLE BCTS_REPORTING.licence_sold_to_out_of_province_registrants
    AS SELECT * 
    FROM BCTS_STAGING.licence_sold_to_out_of_province_registrants;

    DROP TABLE IF EXISTS BCTS_REPORTING.licence_sold_to_out_of_province_registrants_hist;
    CREATE TABLE BCTS_REPORTING.licence_sold_to_out_of_province_registrants_hist
    AS SELECT * 
    FROM BCTS_STAGING.licence_sold_to_out_of_province_registrants_hist;

    """

    try:
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)

def delete_licence_sold_out_of_province_hist(connection, cursor, start_date, end_date):
    sql_statement = \
    f"""
    delete from bcts_staging.licence_sold_to_out_of_province_registrants_hist
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
    if licence_sold_out_of_province_report_exists(start_date, end_date):
        logging.info("Report already exists! Skipping...")
    else:

        # Delete data for the same period in bcts_staging.licence_sold_to_out_of_province_registrants_hist if it is already present.
        # Check for existence is done on bcts_reporting.licence_sold_to_out_of_province_registrants. So it is possible to insert dupliocate
        # values to the staging table if data is already present in staging and not in reporting or if data is manually removed from
        # reporting to force ETL and not from staging.
        delete_licence_sold_out_of_province_hist(connection, cursor, start_date, end_date)
        logging.info(f"Running licence sold out of province report for the period of  {start_date} and {end_date}...")
        run_licence_sold_out_of_province_report(connection, cursor, start_date, end_date)
        # Publish updated reporting objects to the reporting layer
        logging.info("Updating datasets to the reporting layer...")
        publish_datasets()
        logging.info("Datasets in the reporting layer have been updated!")


    # Clean up
    cursor.close()
    connection.close()
        
