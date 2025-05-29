#!/usr/bin/env python
# coding: utf-8

#Imports
import os, time
import psycopg2
import logging
import sys
import pandas as pd
from datetime import datetime, timedelta, date
import pytz


from transformation_queries.licence_issued_advertised_official import get_licence_issued_advertised_official_query
from transformation_queries.licence_issued_advertised_main import get_licence_issued_advertised_main_query
from transformation_queries.CurrentlyInMarket import get_currently_in_market

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
        sys.exit(1)

    return df


def run_licence_issued_advertised_official_report(connection, cursor, start_date, end_date):

    # Run license issued advertised official report
    sql_statement = get_licence_issued_advertised_official_query(start_date, end_date)

    try:
        # logging.info(f"Executing the query...")
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")

        # Generate license issued advertised main report

    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)
    
def run_licence_issued_advertised_main_report(connection, cursor):

    # Run licence issued advertised main report
    sql_statement = get_licence_issued_advertised_main_query()

    try:
        # logging.info(f"Executing the query...")
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")

        # Generate license issued advertised main report
        
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)


def run_currently_in_market_report(connection, cursor, start_date, end_date, report_frequency):

    sql_statement = get_currently_in_market(end_date)

    try:
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)

def licence_issued_advertised_main_report_exists(start_date, end_date):
    sql_statement = \
    f"""

    select exists (select * from bcts_reporting.licence_issued_advertised_main
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
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()

def run_get_currently_in_market(current_date_pst):
    sql_statement = get_currently_in_market(current_date_pst)

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
    DROP TABLE IF EXISTS BCTS_STAGING.currently_in_market;
    CREATE TABLE BCTS_STAGING.currently_in_market
    AS SELECT * 
    FROM BCTS_STAGING.currently_in_market_hist
    WHERE report_end_date = (
	SELECT MAX(report_end_date)
	FROM BCTS_STAGING.currently_in_market_hist
    );

    DROP TABLE IF EXISTS BCTS_REPORTING.currently_in_market;
    CREATE TABLE BCTS_REPORTING.currently_in_market
    AS SELECT * 
    FROM BCTS_STAGING.currently_in_market;

    DROP TABLE IF EXISTS BCTS_STAGING.licence_issued_advertised_main;
    CREATE TABLE BCTS_STAGING.licence_issued_advertised_main
    AS SELECT * 
    FROM BCTS_STAGING.licence_issued_advertised_main_hist
    WHERE report_end_date = (
        SELECT MAX(report_end_date)
        FROM BCTS_STAGING.licence_issued_advertised_main_hist
	);

    DROP TABLE IF EXISTS BCTS_REPORTING.licence_issued_advertised_main;
    CREATE TABLE BCTS_REPORTING.licence_issued_advertised_main
    AS SELECT * 
    FROM BCTS_STAGING.licence_issued_advertised_main;
    
    """

    try:
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)

def fetch_fta_tables():

    sql_statement = \
    """
    TRUNCATE TABLE bcts_staging.fta_tenure_term;

    INSERT INTO bcts_staging.fta_tenure_term(
	forest_file_id, tenure_term, legal_effective_dt, initial_expiry_dt, current_expiry_dt, tenure_extend_cnt, tenr_extend_rsn_st, entry_timestamp, update_timestamp, revision_count)
    SELECT forest_file_id, tenure_term, legal_effective_dt, initial_expiry_dt, current_expiry_dt, tenure_extend_cnt, tenr_extend_rsn_st, entry_timestamp, update_timestamp, revision_count 
    FROM fta_replication.pmt_tenure_term_vw;

    TRUNCATE TABLE bcts_staging.fta_prov_forest_use;

    INSERT INTO bcts_staging.fta_prov_forest_use(
	forest_file_id, file_type_code, forest_region, file_status_st, file_status_date, bcts_org_unit, sb_funded_ind, district_admin_zone, mgmt_unit_type, mgmt_unit_id, revision_count, entry_timestamp, update_timestamp, forest_tenure_guid)
	SELECT forest_file_id, file_type_code, forest_region, file_status_st, file_status_date, bcts_org_unit, sb_funded_ind, district_admin_zone, mgmt_unit_type, mgmt_unit_id, revision_count, entry_timestamp, update_timestamp, forest_tenure_guid
    FROM fta_replication.pmt_prov_forest_use_vw;

    TRUNCATE TABLE bcts_staging.fta_tenure_file_status_code;

    INSERT INTO bcts_staging.fta_tenure_file_status_code(
	tenure_file_status_code, description, effective_date, expiry_date, update_timestamp)
    SELECT tenure_file_status_code, description, effective_date, expiry_date, update_timestamp
    FROM fta_replication.pmt_tenure_file_status_code_vw;

    """

    try:
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)

def truncate_licence_issued_advertised_official(connection, cursor):

    sql_statement = \
    f"""
    truncate bcts_staging.licence_issued_advertised_official;
    """

    try:
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)

def get_valid_report_period():
    today = date.today()
    fiscal_year_start = date(today.year, 4, 1) if today.month >= 4 else date(today.year - 1, 4, 1)

    last_month_end = (today.replace(day=1) - timedelta(days=1))
    current_month_16 = today.replace(day=16)

    end_date = max(last_month_end, current_month_16)

    return fiscal_year_start, end_date

if __name__ == "__main__":

    connection = get_connection()
    cursor = connection.cursor()

    # Fetch FTA tables from FTA_REPLICATION
    fetch_fta_tables()

    # Fetch the start and end dates for the report periods
    start_date, end_date = get_valid_report_period()

    # Skip if report is already generated
    if licence_issued_advertised_main_report_exists(start_date, end_date):
        logging.info("Report already exists! Skipping...")
    else:
        # Truncate bcts_staging.licence_issued_advertised_official clear data from previous run
        truncate_licence_issued_advertised_official()
        
        logging.info(f"Running license issued advertised official report for the period of  {start_date} and {end_date}...")
        run_licence_issued_advertised_official_report(connection, cursor, start_date, end_date)

        # Get the current date and time in UTC
        utc_now = datetime.now(pytz.utc)

        # Convert to Pacific Standard Time
        pst_timezone = pytz.timezone('US/Pacific')
        pst_now = utc_now.astimezone(pst_timezone)

        # Get the current date in PST
        current_date_pst = pst_now.date()
        run_get_currently_in_market(current_date_pst)

        run_licence_issued_advertised_main_report(connection, cursor)

        # Publish updated reporting objects to the reporting layer
        logging.info("Updating datasets to the reporting layer...")
        publish_datasets()
        logging.info("Datasets in the reporting layer have been updated!")


    # Clean up
    cursor.close()
    connection.close()
        
