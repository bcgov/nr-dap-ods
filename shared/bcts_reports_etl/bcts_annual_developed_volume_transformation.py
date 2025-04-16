#!/usr/bin/env python
# coding: utf-8

#Imports
import os, time
import psycopg2
import logging
import sys
import pandas as pd
from datetime import datetime, date, timedelta
import pytz


from annual_developed_volume import get_annual_developed_volume_query

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

def get_last_day_of_month():
    current_year = datetime.today().year
    current_month = datetime.today().month 
    if current_month < 5:
        fiscal_year_start = date(current_year - 1, 4, 1)
    else:
        fiscal_year_start = date(current_year, 4, 1)

    return(fiscal_year_start, date(current_year, current_month, 1) - timedelta (days=1))

def get_existing_dates():
    sql_statement = \
    f"""
    select max(report_end_date) as max_report_end_date
    from bcts_staging.annual_developed_volume_hist;

    """

    try:
        cursor.execute(sql_statement)
        connection.commit()
        # Fetch the result and load into a DataFrame
        existing_date = cursor.fetchall()[0][0]
        logging.info(f"SQL script executed successfully.")
        logging.info(f"report_exists for {existing_date}")
        return existing_date
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)


def run_report(connection, cursor, start_date, end_date):

    sql_statement = get_annual_developed_volume_query(start_date, end_date)

    try:
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)


def publish_datasets():
    """
    Publish the latest report from the historic records
    """

    sql_statement = \
    """
    DROP TABLE IF EXISTS BCTS_STAGING.annual_developed_volume;
    CREATE TABLE BCTS_STAGING.annual_developed_volume
    AS SELECT * 
    FROM BCTS_STAGING.annual_developed_volume_hist
    WHERE report_end_date = (
	    SELECT MAX(report_end_date)
	    FROM BCTS_STAGING.annual_developed_volume_hist
    );

    DROP TABLE IF EXISTS BCTS_REPORTING.annual_developed_volume_hist;
    CREATE TABLE BCTS_REPORTING.annual_developed_volume_hist
    AS SELECT * 
    FROM BCTS_STAGING.annual_developed_volume_hist;

    DROP TABLE IF EXISTS BCTS_REPORTING.annual_developed_volume;
    CREATE TABLE BCTS_REPORTING.annual_developed_volume
    AS SELECT * 
    FROM BCTS_STAGING.annual_developed_volume;

    """

    try:
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)

if __name__ == "__main__":

    connection = get_connection()
    cursor = connection.cursor()

    # Fetch the start and end dates for the report periods
    start_date, end_date = get_last_day_of_month()
    max_report_exist_date = get_existing_dates()

    if max_report_exist_date is not None:
        if max_report_exist_date == end_date:
            logging.info("BCTS annual developed volume report is already up-to-date! ")
            # Publish reporting objects to the reporting layer
            logging.info("Updating datasets to the reporting layer...")
            publish_datasets()
            logging.info("Datasets in the reporting layer have been updated!")
            sys.exit(0)
        elif max_report_exist_date > end_date:
            logging.error(f"Current valid end date is {end_date} but report exists for end date {max_report_exist_date}!")
            sys.exit(1)
        else:
            # Run each report
            logging.info(f"Running BCTS annual developed volume report for the reporting start_date {start_date} and end date {end_date}...")
            run_report(connection, cursor, start_date, end_date)
    else:
        # Run each report
        logging.info(f"Running BCTS annual developed volume report for the reporting start_date {start_date} and end date {end_date}...")
        run_report(connection, cursor, start_date, end_date)

    # Publish reporting objects to the reporting layer
    logging.info("Updating datasets to the reporting layer...")
    publish_datasets()
    logging.info("Datasets in the reporting layer have been updated!")


    # Clean up
    cursor.close()
    connection.close()
        
