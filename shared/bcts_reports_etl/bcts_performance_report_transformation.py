#!/usr/bin/env python
# coding: utf-8

#Imports
import os, time
import psycopg2
import logging
import sys
import pandas as pd
from datetime import datetime
import pytz


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
        # logging.info(f"Executing the following query...")
        # logging.info(sql_statement)
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
        # logging.info(f"Executing the following query...")
        # logging.info(sql_statement)
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

def licence_issued_advertised_official_report_exists(start_date, end_date, report_frequency):
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


def refresh_mat_views():

    sql_statement = \
    """
    refresh materialized view bcts_staging.mv_licence_issued_advertised_lrm;
    refresh materialized view bcts_staging.mv_licence_issued_advertised_main;

    """

    try:
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()

def publish_datasets():

    sql_statement = \
    """
    
    DROP TABLE IF EXISTS BCTS_REPORTING.licence_issued_advertised_official;
    CREATE TABLE BCTS_REPORTING.licence_issued_advertised_official
    AS SELECT * 
    FROM BCTS_STAGING.licence_issued_advertised_official;

    DROP TABLE IF EXISTS BCTS_REPORTING.currently_in_market;
    CREATE TABLE BCTS_REPORTING.currently_in_market
    AS SELECT * 
    FROM BCTS_STAGING.currently_in_market;

    DROP TABLE IF EXISTS BCTS_REPORTING.licence_issued_advertised_lrm;
    CREATE TABLE BCTS_REPORTING.licence_issued_advertised_lrm
    AS SELECT * 
    FROM BCTS_STAGING.mv_licence_issued_advertised_lrm;

    DROP TABLE IF EXISTS BCTS_REPORTING.licence_issued_advertised_main;
    CREATE TABLE BCTS_REPORTING.licence_issued_advertised_main
    AS SELECT * 
    FROM BCTS_STAGING.mv_licence_issued_advertised_main;

    """

    try:
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()

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


if __name__ == "__main__":

    connection = get_connection()
    cursor = connection.cursor()

    # Fetch FTA tables from FTA_REPLICATION
    fetch_fta_tables()

    # Fetch the start and end dates for the report periods
    df = get_reporting_periods(connection, cursor)

    currently_in_market_executed = False
    for start_date, end_date, report_frequency in zip(df['start_date'], df['end_date'], df['report_frequency']):
        # Skip if report is already generated
        if licence_issued_advertised_official_report_exists(start_date, end_date, report_frequency):
            logging.info("Report already exists! Skipping...")
            continue
        else:
            # Run each report
            logging.info(f"Deleting rows for the selected time period if already exists!")
            truncate_licence_issued_advertised_official_report(connection, cursor, start_date, end_date, report_frequency)
            logging.info(f"Running license issued advertised official report {report_frequency} for the period of  {start_date} and {end_date}...")
            run_licence_issued_advertised_official_report(connection, cursor, start_date, end_date, report_frequency)

            if not currently_in_market_executed:
                # Get currently in Market if at least one report is updated and execute only once
                # Get the current date and time in UTC
                utc_now = datetime.now(pytz.utc)

                # Convert to Pacific Standard Time
                pst_timezone = pytz.timezone('US/Pacific')
                pst_now = utc_now.astimezone(pst_timezone)

                # Get the current date in PST
                current_date_pst = pst_now.date()
                run_get_currently_in_market(current_date_pst)

                currently_in_market_executed = True

    # Refresh materialized views for BCTS Performance Reports
    logging.info("Refreshing materialized views...")
    refresh_mat_views()
    logging.info("Materialized views have been refreshed!")

    # Publish reporting objects to the reporting layer
    logging.info("Updating datasets to the reporting layer...")
    publish_datasets()
    logging.info("Datasets in the reporting layer have been updated!")


    # Clean up
    cursor.close()
    connection.close()
        
