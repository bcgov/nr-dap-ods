#!/usr/bin/env python
# coding: utf-8

#Imports
import os, time
import psycopg2
import logging
import sys
from datetime import datetime, date, timedelta


from transformation_queries.timber_inventory_development_in_progress import get_timber_inventory_development_in_progress_query

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
    return date(current_year, current_month, 1) - timedelta (days=1)

def get_existing_dates():
    sql_statement = \
    f"""
    select max(report_end_date) as max_report_end_date
    from bcts_staging.timber_inventory_development_in_progress_hist;

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


def run_timber_inventory_ready_to_develop_report(connection, cursor, end_date):

    sql_statement = get_timber_inventory_development_in_progress_query(end_date)

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
    
    DROP TABLE IF EXISTS BCTS_STAGING.timber_inventory_development_in_progress;
    CREATE TABLE BCTS_STAGING.timber_inventory_development_in_progress
    AS SELECT * 
    FROM BCTS_STAGING.timber_inventory_development_in_progress_hist
    WHERE report_end_date = (
	SELECT MAX(report_end_date)
	FROM BCTS_STAGING.timber_inventory_development_in_progress_hist
    );

    DROP TABLE IF EXISTS BCTS_REPORTING.timber_inventory_development_in_progress_hist;
    CREATE TABLE BCTS_REPORTING.timber_inventory_development_in_progress_hist
    AS SELECT * 
    FROM BCTS_STAGING.timber_inventory_development_in_progress_hist;

    DROP TABLE IF EXISTS BCTS_REPORTING.timber_inventory_development_in_progress;
    CREATE TABLE BCTS_REPORTING.timber_inventory_development_in_progress
    AS SELECT * 
    FROM BCTS_STAGING.timber_inventory_development_in_progress;

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
    end_date = get_last_day_of_month()
    max_report_exist_date = get_existing_dates()

    if max_report_exist_date is not None:
        if max_report_exist_date == end_date:
            logging.info("BCTS timber inventory development in progress report is already up-to-date! ")
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
            logging.info(f"Running BCTS timber inventory development in progress report for the reporting end date {end_date}...")
            run_timber_inventory_ready_to_develop_report(connection, cursor, end_date)
    else:
        # Run each report
        logging.info(f"Running BCTS timber inventory development in progress report for the reporting end date {end_date}...")
        run_timber_inventory_ready_to_develop_report(connection, cursor, end_date)


    # Publish reporting objects to the reporting layer
    logging.info("Updating datasets to the reporting layer...")
    publish_datasets()
    logging.info("Datasets in the reporting layer have been updated!")


    # Clean up
    cursor.close()
    connection.close()
        
