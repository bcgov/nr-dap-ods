#!/usr/bin/env python
# coding: utf-8

#Imports
import os, time
import psycopg2
import logging
import sys
import pandas as pd

from licence_issued_advertised_official import get_licence_issued_advertised_official_query
from CurrentlyInMarket import get_currently_in_market

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
        return

def get_reporting_periods(connection, cursor):
    sql_statement = \
    """
    select *
    from bcts_staging.report_date_ranges
    where is_report_valid = 'Y';

    """

    try:
        cursor.execute(sql_statement)
        connection.commit()
        # Fetch the result and load into a DataFrame
        result = cursor.fetchall()
        columns = [desc[0] for desc in cursor.description]  # Get column names
        df = pd.DataFrame(result, columns=columns)
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()

    return df


def run_licence_issued_advertised_official_report(connection, cursor, start_date, end_date, report_frequency):

    sql_statement = get_licence_issued_advertised_official_query(start_date, end_date, report_frequency)

    try:
        logging.info(f"Executing the following query...")
        logging.info(sql_statement)
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()

def truncate_licence_issued_advertised_official_report(connection, cursor, start_date, end_date, report_frequency):

    sql_statement = \
    f"""
    delete from bcts_staging.licence_issued_advertised_official
    where report_start_date = '{start_date}'
    and report_end_date = '{end_date}'
    and report_frequency = '{report_frequency}';
    """

    try:
        logging.info(f"Executing the following query...")
        logging.info(sql_statement)
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()


def run_currently_in_market_report(connection, cursor, start_date, end_date, report_frequency):

    sql_statement = get_currently_in_market(end_date)

    try:
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()

def report_exists(start_date, end_date, report_frequency):
    sql_statement = \
    f"""

    select exists (select * from bcts_staging.licence_issued_advertised_official
    where report_start_date = '{start_date}'
    and report_end_date = '{end_date}'
    and report_frequency = '{report_frequency}') as report_exists;

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
        return df['report_exists']
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()


if __name__ == "__main__":

    connection = get_connection()
    cursor = connection.cursor()

    # Fetch the start and end dates for the report periods
    df = get_reporting_periods(connection, cursor)

    for start_date, end_date, report_frequency in zip(df['start_date'], df['end_date'], df['report_frequency']):
        # Skip if report is already generated
        if report_exists(start_date, end_date, report_frequency):
            logging.info("Report already exists! Skipping...")
            continue
        else:
            # Run each report
            logging.info(f"Deleting rows for the selected time period if already exists!")
            truncate_licence_issued_advertised_official_report(connection, cursor, start_date, end_date, report_frequency)
            logging.info(f"Running license issued advertised official report {report_frequency} for the period of  {start_date} and {end_date}...")
            run_licence_issued_advertised_official_report(connection, cursor, start_date, end_date, report_frequency)



    # Clean up
    cursor.close()
    connection.close()
        
