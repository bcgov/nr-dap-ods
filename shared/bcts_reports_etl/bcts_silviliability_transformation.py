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

    DROP TABLE IF EXISTS bcts_reporting.silviliability_main cascade;
    CREATE TABLE bcts_reporting.silviliability_main AS SELECT * FROM bcts_staging.silviliability_main;

    CREATE OR REPLACE VIEW BCTS_REPORTING.VW_SILVILIABILITY_MAIN AS
    WITH TEMP AS
    (SELECT *,
    CASE
            WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= 4 
            THEN DATE_TRUNC('year', CURRENT_DATE) + INTERVAL '3 months'
            ELSE DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '9 months'
    END AS fiscal_year_start_date
    FROM bcts_reporting.silviliability_main
    )
    select *
    from TEMP
    WHERE fg_done >= 
        CASE
            WHEN EXTRACT(MONTH FROM CURRENT_DATE) >= 4 
            THEN DATE_TRUNC('year', CURRENT_DATE) + INTERVAL '3 months'
            ELSE DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '9 months'
    END;

    create or replace view bcts_reporting.VW_SILVILIABILITY_MAIN_PBI as

    with ubis as 
    (
    SELECT business_area_region_category, business_area_region, business_area,ubi,
    max(EXTRACT(DAY from (fg_done - hvc_date))) as days_to_free_growing,
    max(EXTRACT(epoch from (fg_done - hvc_date))/(365.25*24*60*60)) as years_to_free_growing,
    max(hvc_date::Date - hvs_date::Date) as duration_of_harvesting,
    sum(planned_total_cost) as planned_total_cost,
    sum(actual_total_cost) as actual_total_cost,
    max(nar_area) as nar_area,
    sum(total_trees) as total_trees
    FROM BCTS_REPORTING.VW_SILVILIABILITY_MAIN
    group by business_area_region_category, business_area_region, business_area, ubi
    )
    select business_area_region_category, business_area_region, business_area,
    count(ubi) as "Number of Blocks",
    round(sum(nar_area), 0) as "Total Net Area to be Reforested",
    sum(total_trees) as "Total Trees Planted",
    round(sum(total_trees)/sum(nar_area), 0) as "Total trees planted per ha of NAR",
    round(avg(years_to_free_growing), 1) as "Average years to free growing",
    round(avg(days_to_free_growing/nar_area), 0) as "Average days to free growing per ha of NAR",
    round(avg(duration_of_harvesting), 0) as "Average duration of harvesting in days",
    round(sum(planned_total_cost), 0) as "Average planned total cost",
    round(sum(actual_total_cost), 0) as "Average actual total cost",
    round((sum(planned_total_cost)/sum(nar_area)), 0) as "Average planned total cost per ha of NAR",
    round((sum(actual_total_cost))/sum(nar_area), 0) as "Average actual total cost per ha of NAR"

    from ubis 
    group by business_area_region_category, business_area_region, business_area;


    """

    try:
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)

def silviliability_report_exists(report_date):
    
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
            logging.warning("Table bcts_reporting.silviliability_main does not exist.")
            return False
        else:
            logging.error(f"Error executing the SQL script: {e}")

def truncate_silviability_main_hist(report_date):
    
    sql_statement = \
    f"""
    delete from bcts_staging.silviliability_main_hist 
    where date_trunc('month', report_run_date) = date '{report_date}';

    """

    try:
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        connection.rollback()
        logging.error(f"Error executing the SQL script: {e}")

if __name__ == "__main__":

    connection = get_connection()
    cursor = connection.cursor()
    current_date = date.today()
    report_date = date(current_date.year, current_date.month, 1)
     # Skip if report is already generated
    if silviliability_report_exists(report_date):
        logging.info("Report already exists! Skipping...")
    else:
        # Publish reporting objects to the reporting layer from views in the staging layer
        # Remove existing entries if any in the _hist table 
        logging.info("Deleting existing entries in the silviliability_main_hist table for the report month if any...")
        truncate_silviability_main_hist(report_date)
        logging.info("Updating silviliability datasets to the reporting layer...")
        publish_datasets()
        logging.info("Silviliability datasets in the reporting layer have been updated!")


    # Clean up
    cursor.close()
    connection.close()
        
