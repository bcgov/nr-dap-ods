#!/usr/bin/env python
# coding: utf-8

#Imports
import os, time
import psycopg2
from psycopg2 import errorcodes
import logging
import sys
import pandas as pd
from datetime import datetime, date, timedelta
import pytz


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



def publish_datasets():

    sql_statement = \
    """
    
    INSERT INTO bcts_staging.silviliability_main_hist SELECT * FROM bcts_staging.silviliability_main;

    DROP TABLE IF EXISTS bcts_reporting.silviliability_main;
    CREATE TABLE bcts_reporting.silviliability_main AS SELECT * FROM bcts_staging.silviliability_main;

    """

    try:
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)

def silviliability_report_exists(current_date):
    report_date = date(current_date.year, current_date.month, 1)
    sql_statement = \
    f"""

    select exists (select * from bcts_reporting.silviliability_main
    where date_trunc('month', report_run_date) = date '{report_date}'
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
            logging.warning("Table bcts_reporting.volume_advertised_main does not exist.")
            return False
        else:
            logging.error(f"Error executing the SQL script: {e}")

if __name__ == "__main__":

    connection = get_connection()
    cursor = connection.cursor()
    current_date = date.today()
     # Skip if report is already generated
    if silviliability_report_exists(current_date):
        logging.info("Report already exists! Skipping...")
    else:
        # Publish reporting objects to the reporting layer from views in the staging layer
        logging.info("Updating silviliability datasets to the reporting layer...")
        publish_datasets()
        logging.info("Silviliability datasets in the reporting layer have been updated!")


    # Clean up
    cursor.close()
    connection.close()
        
