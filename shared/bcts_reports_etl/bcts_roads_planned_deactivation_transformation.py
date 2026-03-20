#!/usr/bin/env python
# coding: utf-8

#Imports
import os, time
import psycopg2
import logging
import sys
import pandas as pd
from datetime import datetime, date, timedelta



from transformation_queries.roads_planned_deactivation import get_roads_planned_deactivation_query

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
    from bcts_staging.roads_planned_deactivation_hist;

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


def run_report(connection, cursor, end_date):

    sql_statement = get_roads_planned_deactivation_query(end_date)

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
    DROP TABLE IF EXISTS BCTS_STAGING.roads_planned_deactivation;
    CREATE TABLE BCTS_STAGING.roads_planned_deactivation
    AS SELECT * 
    FROM BCTS_STAGING.roads_planned_deactivation_hist
    WHERE report_end_date = (
	    SELECT MAX(report_end_date)
	    FROM BCTS_STAGING.roads_planned_deactivation_hist
    );

    DROP TABLE IF EXISTS BCTS_REPORTING.roads_planned_deactivation_hist;
    CREATE TABLE BCTS_REPORTING.roads_planned_deactivation_hist
    AS SELECT * 
    FROM BCTS_STAGING.roads_planned_deactivation_hist;

    DROP TABLE IF EXISTS BCTS_REPORTING.roads_planned_deactivation;
    CREATE TABLE BCTS_REPORTING.roads_planned_deactivation
    AS SELECT * 
    FROM BCTS_STAGING.roads_planned_deactivation;

    GRANT SELECT ON BCTS_REPORTING.roads_planned_deactivation TO BCTS_DEV_ROLE;
    GRANT SELECT ON BCTS_REPORTING.roads_planned_deactivation TO proxy_bcts_bi;

    GRANT SELECT ON BCTS_REPORTING.roads_planned_deactivation_hist TO BCTS_DEV_ROLE;
    GRANT SELECT ON BCTS_REPORTING.roads_planned_deactivation_hist TO proxy_bcts_bi;
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
            logging.info("BCTS roads planned for deactivation report is already up-to-date! ")
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
            logging.info(f"Running BCTS roads planned for deactivation report for the reporting end date {end_date}...")
            run_report(connection, cursor, end_date)
    else:
        # Run each report
        logging.info(f"Running BCTS roads planned for deactivation report for the reporting end date {end_date}...")
        run_report(connection, cursor, end_date)
    # Publish reporting objects to the reporting layer
    logging.info("Updating datasets to the reporting layer...")
    publish_datasets()
    logging.info("Datasets in the reporting layer have been updated!")


    # Clean up
    cursor.close()
    connection.close()
        
