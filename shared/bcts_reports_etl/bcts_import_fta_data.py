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


def fetch_fta_tables():

    sql_statement = \
    """
    DROP TABLE IF EXISTS bcts_staging.fta_tenure_term;
    CREATE TABLE bcts_staging.fta_tenure_term AS
    SELECT *
    FROM fta_replication.pmt_tenure_term_vw;

    DROP TABLE IF EXISTS bcts_staging.fta_prov_forest_use;
    CREATE TABLE bcts_staging.fta_prov_forest_use AS
	SELECT *
    FROM fta_replication.pmt_prov_forest_use_vw;

    DROP TABLE IF EXISTS bcts_staging.fta_tenure_file_status_code;
    CREATE TABLE bcts_staging.fta_tenure_file_status_code AS
	SELECT *
    FROM fta_replication.pmt_tenure_file_status_code_vw;

    DROP TABLE IF EXISTS bcts_staging.fta_tfl_number_code;
    CREATE TABLE bcts_staging.fta_tfl_number_code AS
    SELECT *
    FROM fta_replication.tfl_number_code;

    DROP TABLE IF EXISTS bcts_staging.fta_sale_method_code;
    CREATE TABLE bcts_staging.fta_sale_method_code AS
    SELECT *
    FROM fta_replication.sale_method_code;

    DROP TABLE IF EXISTS bcts_staging.fta_org_unit;
    CREATE TABLE bcts_staging.fta_org_unit AS
    SELECT *
    FROM fta_replication.org_unit;

    DROP TABLE IF EXISTS bcts_staging.fta_sb_category_code;
    CREATE TABLE bcts_staging.fta_sb_category_code AS
    SELECT *
    FROM fta_replication.sb_category_code;

    DROP TABLE IF EXISTS bcts_staging.fta_harvest_sale;
    CREATE TABLE bcts_staging.fta_harvest_sale AS
    SELECT *
    FROM fta_replication.harvest_sale;

    DROP TABLE IF EXISTS bcts_staging.fta_tsa_number_code;
    CREATE TABLE bcts_staging.fta_tsa_number_code AS
    SELECT *
    FROM fta_replication.tsa_number_code;

    DROP TABLE IF EXISTS bcts_staging.fta_forest_file_client;
    CREATE TABLE bcts_staging.fta_forest_file_client AS
    SELECT *
    FROM fta_replication.forest_file_client;

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

    # Fetch FTA tables from FTA_REPLICATION
    fetch_fta_tables()

    # Clean up
    cursor.close()
    connection.close()
        
