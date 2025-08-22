#!/usr/bin/env python
# coding: utf-8

#Imports
import os, time
import psycopg2
from psycopg2 import errorcodes
import logging
import sys
import pandas as pd
from datetime import datetime, timedelta, date
import pytz


from transformation_queries.tsl_weekly_report.tsl_summary_official import get_tsl_summary_official_query
from transformation_queries.tsl_weekly_report.tsl_summary_lrm import get_tsl_summary_lrm_query
from transformation_queries.tsl_weekly_report.tsl_summary_main import get_tsl_summary_main_query

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

def run_tsl_summary_official_report(connection, cursor, start_date, end_date):

    # Run volume advertised official report
    sql_statement = get_tsl_summary_official_query(start_date, end_date)

    try:
        # logging.info(f"Executing the query...")
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"tsl summary official script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)

def run_tsl_summary_lrm_report(connection, cursor, licence_ids):
    # Run volume advertised main report
    sql_statement = get_tsl_summary_lrm_query(licence_ids)

    try:
        # logging.info(f"Executing the query...")
        print(sql_statement)
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"tsl summary lrm script executed successfully.")
        
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)
    
def run_tsl_summary_main_report(connection, cursor):
    # Run volume advertised main report
    sql_statement = get_tsl_summary_main_query()

    try:
        # logging.info(f"Executing the query...")
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"tsl summary main script executed successfully.")
        
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)


def tsl_summary_main_report_exists(start_date, end_date):
    sql_statement = \
    f"""

    select exists (select * from bcts_reporting.tsl_summary_main
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
        connection.rollback()
        if e.pgcode == errorcodes.UNDEFINED_TABLE:
            logging.warning("Table bcts_reporting.tsl_summary_main does not exist.")
            return False
        else:
            logging.error(f"Error executing the SQL script: {e}")

def publish_datasets():

    sql_statement = \
    """
    DROP TABLE IF EXISTS BCTS_STAGING.tsl_summary_main;
    CREATE TABLE BCTS_STAGING.tsl_summary_main
    AS SELECT * 
    FROM BCTS_STAGING.tsl_summary_main_hist
    WHERE report_end_date = (
        SELECT MAX(report_end_date)
        FROM BCTS_STAGING.tsl_summary_main_hist
	);

    DROP TABLE IF EXISTS BCTS_REPORTING.tsl_summary_main cascade;
    CREATE TABLE BCTS_REPORTING.tsl_summary_main
    AS SELECT * 
    FROM BCTS_STAGING.tsl_summary_main;

    create or replace view bcts_reporting.v_tsl_summary as
    with tsl_summary as
    (
    select business_area_region_category,
    business_area_region,
    business_area,
    sum(volume_advertised_m3) as "Total Volume Auctioned (Including Re-auctions)",
    sum(case when readvertised_auction='N' then volume_advertised_m3 else 0 end) as "Volume Auctioned (First Auction Only)",
    sum(case when readvertised_auction='Y' then volume_advertised_m3 else 0 end) as "Volume Re-auctioned",
    sum(case when no_bid_info='N' then volume_advertised_m3 else 0 end) as "Licence Issued",
    count(case when no_bid='' then licence_number else null end) as "Number of Licence Issued",
    sum(case when no_bid_info='' then volume_advertised_m3 else 0 end) as "Volume Not Awarded",
    count(case when no_bid_info='' then licence_number else null end) as "Number of Licence Not Awarded",
    sum(case when auctioned_bcts_category_code='4' then volume_advertised_m3 else 0 end) as "Volume of Value Added (Category 4) Auctioned",
    count(case when auctioned_bcts_category_code='4' then licence_number else null end) as "Number of Value Added (Category 4) Licence Auctioned"
    from bcts_reporting.tsl_summary_main
    group by business_area_region_category, business_area_region, business_area
    )
    select 
        business_area_region_category,
        business_area_region,
        business_area,
        "Total Volume Auctioned (Including Re-auctions)",
        "Volume Auctioned (First Auction Only)",
        "Volume Re-auctioned",
        "Licence Issued",
        "Number of Licence Issued",
        "Volume Not Awarded",
        "Number of Licence Not Awarded",
        "Volume of Value Added (Category 4) Auctioned",
        "Number of Value Added (Category 4) Licence Auctioned",
        case when business_area_region = 'North Interior' then 1
            when business_area_region = 'South Interior' then 2
            when business_area_region = 'Coast' then 3
        end as business_area_region_sort_order
    from tsl_summary;

    DROP TABLE IF EXISTS BCTS_REPORTING.tsl_summary_main_hist;
    CREATE TABLE BCTS_REPORTING.tsl_summary_main_hist
    AS SELECT * 
    FROM BCTS_STAGING.tsl_summary_main_hist;

    """

    try:
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)

def delete_tsl_summary_main_hist(connection, cursor, start_date, end_date):
    sql_statement = \
    f"""
    delete from bcts_staging.tsl_summary_main_hist
    where report_start_date = '{start_date}'
    and report_end_date = '{end_date}';
    """

    try:
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)

def truncate_tsl_summary_official(connection, cursor):
    # updated to delete from due to permission issues
    sql_statement = \
    f"""
    delete from bcts_staging.tsl_summary_official;
    """

    try:
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)

def truncate_tsl_summary_lrm(connection, cursor):
    # updated to delete from due to permission issues
    sql_statement = \
    f"""
    delete from bcts_staging.tsl_summary_lrm;
    """

    try:
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)

def get_report_interval():
    """
    Get the start and end dates for the report period.
    The report period is the previous week from Monday to Sunday.
    """
    # Calculate the previous week's Monday and Sunday
    today = datetime.today()
    days_since_monday = (today.weekday() - 0) % 7
    prev_monday = today - timedelta(days=days_since_monday + 7)
    prev_sunday = prev_monday + timedelta(days=6)
    start_date = prev_monday.strftime('%Y-%m-%d')
    end_date = prev_sunday.strftime('%Y-%m-%d')
    return (start_date, end_date)

def get_licence_ids_bcbids():
    """
    Fetch licence IDs from the bcbids scrapped data.
    """
    sql_statement = \
    f"""
    SELECT string_agg(DISTINCT LEFT("Opportunity ID", 6), ', ')
    FROM bcts_staging.bcbids_tsl_weekly_report;

    """

    try:
        cursor.execute(sql_statement)
        connection.commit()
        # Fetch the result and load into a DataFrame
        licence_ids = cursor.fetchall()[0][0]
        if ',' in licence_ids:
            licence_ids = licence_ids.split(',')
        licence_ids = [x.strip() for x in licence_ids]
        licence_ids = ["'" + x + "'" for x in licence_ids]
        logging.info(f"SQL script executed successfully.")
        logging.info(f"Licence ids {licence_ids}")
        if len(licence_ids) == 0:
            logging.warning("No licence IDs found in bcbids scrapped data.")
            return None
        return ','.join(licence_ids) if len(licence_ids) > 1 else licence_ids[0]
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)    


if __name__ == "__main__":

    connection = get_connection()
    cursor = connection.cursor()

    # Fetch the start and end dates for the report periods
    start_date, end_date = get_report_interval()

    # Skip if report is already generated
    if tsl_summary_main_report_exists(start_date, end_date):
        logging.info("Report already exists! Skipping...")
    else:
        logging.info("Truncating bcts_staging.tsl_summary_official...")
        # Truncate bcts_staging.tsl_summary_official clear data from previous run
        truncate_tsl_summary_official(connection, cursor)
        logging.info("Truncating bcts_staging.tsl_summary_lrm...")
        # Truncate bcts_staging.tsl_summary_lrm clear data from previous run
        truncate_tsl_summary_lrm(connection, cursor)

        # Delete data for the same period in bcts_staging.tsl_summary_main_hist if it is already present.
        # Check for existence is done on bcts_reporting.tsl_summary_main. So it is possible to insert duplicate
        # values to the staging table if data is already present in staging and not in reporting or if data is manually removed from
        # reporting to force ETL and not from staging.
        delete_tsl_summary_main_hist(connection, cursor, start_date, end_date)

        # Get licence ids from bcbids scrapped data
        logging.info(f"Getting licence ids...")
        licence_ids = get_licence_ids_bcbids()
        if licence_ids is None:
            logging.warning("No licence IDs found. Skipping LRM report generation.")
            sys.exit(0)

        logging.info(f"Running tsl summary lrm report for the licence ids {licence_ids}...")
        run_tsl_summary_lrm_report(connection, cursor, licence_ids)


        logging.info(f"Running tsl summary official report for the period of  {start_date} and {end_date}...")
        run_tsl_summary_official_report(connection, cursor, start_date, end_date)

        
        logging.info(f"Running tsl summary main report for the licence ids {licence_ids} and period of {start_date} and {end_date}...")
        run_tsl_summary_main_report(connection, cursor)

        # Publish updated reporting objects to the reporting layer
        logging.info("Updating datasets to the reporting layer...")
        publish_datasets()
        logging.info("Datasets in the reporting layer have been updated!")


    # Clean up
    cursor.close()
    connection.close()
        
