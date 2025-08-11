#!/usr/bin/env python
# coding: utf-8

#Imports
import os, time
import psycopg2
import logging
import sys


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


def audit_bcts_replication():

    sql_statement = \
    """
    select exists
    (select * from bcts_staging.replication_errors)
    ;

    """

    try:
        cursor.execute(sql_statement)
        result = cursor.fetchone()[0]  # Gets the boolean result from EXISTS
        if result:
            logging.error("Replication errors found in bcts_staging.replication_errors.")
            time.sleep(10)  # Wait for 10 seconds before exiting
            sys.exit(1)
        else:
            logging.info("No replication errors found.")
            return  # Clean exit from function
        connection.commit()
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        sys.exit(1)


if __name__ == "__main__":

    connection = get_connection()
    cursor = connection.cursor()

    # Fetch FTA tables from FTA_REPLICATION
    audit_bcts_replication()

    # Clean up
    cursor.close()
    connection.close()
        
