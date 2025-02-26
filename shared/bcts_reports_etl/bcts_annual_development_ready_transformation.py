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


from annual_development_ready import get_annual_development_ready_query

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

def get_last_days_of_months(start_year = 2025):
    current_year = datetime.today().year
    current_month = datetime.today().month 
    dates = []
    for year in range(start_year, current_year + 1):
        for month in range(1, 13):
            if year == current_year and month > current_month:
                return dates
            else:
                if month < 4:
                    fiscal_year_start = datetime(year - 1, 4, 1)
                else:
                    fiscal_year_start = datetime(year, 4, 1)

                dates.append((fiscal_year_start, date(year, month, 1) - timedelta (days=1)))

def get_existing_dates():
    sql_statement = \
    f"""
    select distinct report_end_date
    from bcts_staging.annual_evelopment_ready;

    """

    try:
        cursor.execute(sql_statement)
        connection.commit()
        # Fetch the result and load into a DataFrame
        existing_dates = [row[0] for row in cursor.fetchall()]
        logging.info(f"SQL script executed successfully.")
        logging.info(f"report_exists for {existing_dates}")
        return existing_dates
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)


def run_report(connection, cursor, start_date, end_date):

    sql_statement = get_annual_development_ready_query(start_date, end_date)

    try:
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)


def publish_datasets():

    sql_statement = \
    """
    
    DROP TABLE IF EXISTS BCTS_REPORTING.annual_evelopment_ready;
    CREATE TABLE BCTS_REPORTING.annual_evelopment_ready
    AS SELECT * 
    FROM BCTS_STAGING.annual_evelopment_ready;

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
    end_dates = get_last_days_of_months()
    report_exists_dates = get_existing_dates()
    report_required_dates = [dt for dt in end_dates if dt[1] not in report_exists_dates]

    if len(report_required_dates) == 0:
        logging.info("BCTS timber inventory ready to develop report is already up-to-date! ")
        # Publish reporting objects to the reporting layer
        logging.info("Updating datasets to the reporting layer...")
        publish_datasets()
        logging.info("Datasets in the reporting layer have been updated!")
        sys.exit(0)

    for start_date, end_date in report_required_dates:
       
        # Run each report
        logging.info(f"Running BCTS timber inventory ready to develop report for the reporting start_date {start_date} and end date {end_date}...")
        run_report(connection, cursor, start_date, end_date)

    # Publish reporting objects to the reporting layer
    logging.info("Updating datasets to the reporting layer...")
    publish_datasets()
    logging.info("Datasets in the reporting layer have been updated!")


    # Clean up
    cursor.close()
    connection.close()
        
