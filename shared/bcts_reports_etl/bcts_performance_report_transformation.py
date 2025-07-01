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

    DROP TABLE IF EXISTS BCTS_REPORTING.currently_in_market_hist;
    CREATE TABLE BCTS_REPORTING.currently_in_market_hist
    AS SELECT * 
    FROM BCTS_STAGING.currently_in_market_hist;

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

    DROP TABLE IF EXISTS BCTS_REPORTING.licence_issued_advertised_main_hist;
    CREATE TABLE BCTS_REPORTING.licence_issued_advertised_main_hist
    AS SELECT * 
    FROM BCTS_STAGING.licence_issued_advertised_main_hist;

    DROP TABLE IF EXISTS bcts_staging.currently_in_market_summary;
    create table bcts_staging.currently_in_market_summary as
    select business_area_region_category,
    business_area_region,
    business_area,
    sum(lrm_total_volume) as "Currently in Market",
    sum(lrm_total_volume_cat_2_4) as "Volume: Value Added",
    count(licence_id) as "Number of Auctions",
    count(lrm_total_volume_cat_2_4) as "Number of Auctions Value Added"
    from bcts_staging.currently_in_market
    group by business_area_region_category,
    business_area_region,
    business_area;

    DROP TABLE IF EXISTS bcts_staging.ytd_auctioned_issued_not_awarded;
    create table bcts_staging.ytd_auctioned_issued_not_awarded as
    select business_area_region_category,
    business_area_region,
    business_area,
    sum(first_auction_volume_is_in_report_period) as "Auctioned (First Auction is in Report Period)",
    sum(issued_licence_volume) as "Licence Issued",
    sum(last_auction_no_sale_volume) as "Not Awarded (Last Auction in Report Period is No Sale)",
    sum(first_auction_category_2_and_4_volume_is_in_report_period) as "Auctioned (First Auction is in Report Period): Category 2/4",
    sum(category_2_and_4_issued_volume) as "Licence Issued: Cat 2/4",
    sum(last_auction_no_sale_category_2_4_volume) as "Not Awarded: Category 2/4"
    from bcts_staging.licence_issued_advertised_main
    group by business_area_region_category,
    business_area_region,
    business_area;

    DROP TABLE IF EXISTS bcts_staging.recent_auction_results;
    create table bcts_staging.recent_auction_results as
    with temp as (
    select 
        d.business_area_region_category,
        d.business_area_region,
        d.business_area,
        sum(coalesce(issued_licence_volume, 0)) as "Licence Issued",
        sum(coalesce(category_2_and_4_issued_volume, 0)) as "Licence Issued: Value Added",
        sum(coalesce(last_auction_no_sale_volume, 0)) as "Not Awarded",
        sum(coalesce(last_auction_no_sale_category_2_4_volume, 0)) as "Not Awarded: Value Added"
    from bcts_reporting.v_forest_division d
    left join bcts_staging.licence_issued_advertised_main m
    on m.business_area_region_category = d.business_area_region_category
    and m.business_area_region = d.business_area_region
    and m.business_area = d.business_area 
	and m.include_in_semi_monthly_report = 'Y'
    
    group by d.business_area_region_category,
            d.business_area_region,
            d.business_area
    )

    select *,
    greatest(
        "Licence Issued",
        "Licence Issued: Value Added",
        "Not Awarded",
        "Not Awarded: Value Added"
    ) * 1.1 as y_max_business_area,
    
    greatest(
        sum("Licence Issued") over (partition by business_area_region),
        sum("Licence Issued: Value Added") over (partition by business_area_region),
        sum("Not Awarded") over (partition by business_area_region),
        sum("Not Awarded: Value Added") over (partition by business_area_region)
    ) * 1.1 as y_max_region,

    case  
        when business_area_region = 'North Interior' then 1
        when business_area_region = 'South Interior' then 2
        else 3
    end as business_area_region_sort_order

    from temp;


    DROP TABLE IF EXISTS bcts_staging.bcts_performance_report_not_awarded_details;
    create table bcts_staging.bcts_performance_report_not_awarded_details as
    SELECT 
        business_area AS "Business Area", 
        business_area_region AS "Business Area Region",
        Licence, 
        CASE 
            WHEN Last_Auction_BCTS_Category_Code IN ('2', '4') THEN 'Value Added' 
            ELSE '-' 
        END AS "Value Added", 
        CASE 
            WHEN Total_Volume_Salvage_All_Fire_Year_LRM > 0 THEN 'Fire salvage' 
            ELSE '-' 
        END AS "Includes Fire Salvage", 
        Last_Auction_Date AS Auction, 
        TO_CHAR(Last_Auction_No_Sale_Volume, 'FM999,999,999') AS "Volume (cubic metres)", 
        Last_Auction_No_Sale_Rationale AS "No Sale Rationale",
        case  
        when business_area_region = 'North Interior' then 1
        when business_area_region = 'South Interior' then 2
        else 3
    end as business_area_region_sort_order
    FROM 
        bcts_staging.licence_issued_advertised_main
    WHERE 
        Advertised_in_Report_Period = 'Y'     
        AND Last_Auction_No_Sale_Rationale IS NOT NULL     
        AND Last_Auction_Date BETWEEN semi_monthly_report_start_date AND report_end_date;

    DROP TABLE IF EXISTS bcts_staging.bcts_performance_report_licence_issued_details;
    create table bcts_staging.bcts_performance_report_licence_issued_details as
    SELECT 
        business_area AS "Business Area",
        business_area_region AS "Business Area Region",
        Licence, 
        CASE 
            WHEN Issued_Licence_BCTS_Category_Code IN ('2', '4') THEN 'Value Added' 
            ELSE '-' 
        END AS "Value Added", 
        CASE 
            WHEN Total_Volume_Salvage_All_Fire_Year_LRM > 0 THEN 'Fire salvage' 
            ELSE '-' 
        END AS "Includes Fire Salvage",
        bidder_count AS "# of Bidders", 
        Issued_Licence_Legal_Effective_Date AS Issued, 
        TO_CHAR(Issued_licence_volume, 'FM999,999,999') AS "Volume (cubic metres)",
        TO_CHAR(Issued_licence_maximum_value, 'FM$999,999,999') AS "Max Value",
        Issued_licence_client_name AS Client,
        case  
        when business_area_region = 'North Interior' then 1
        when business_area_region = 'South Interior' then 2
        else 3
    end as business_area_region_sort_order
    FROM 
        bcts_staging.licence_issued_advertised_main
    WHERE 
        Issued_in_report_period = 'Y' 
        AND Issued_Licence_Legal_Effective_Date BETWEEN semi_monthly_report_start_date AND report_end_date;

    DROP TABLE IF EXISTS bcts_staging.recent_auctions_chart_2;
    create table bcts_staging.recent_auctions_chart_2 as
    select 
    'Licence Issued' as metric,
    coalesce(sum(issued_licence_volume), 0) - coalesce(sum(category_2_and_4_issued_volume), 0) as "Total Excluding Value Added",
    coalesce(sum(issued_licence_volume), 0) as "Total",
    coalesce(sum(category_2_and_4_issued_volume), 0)  as "Value Added"
    from bcts_staging.licence_issued_advertised_main
    where include_in_semi_monthly_report = 'Y'

    union all

    select 
    'Not Awarded' as metric,
    coalesce(sum(last_auction_no_sale_volume), 0) - coalesce(sum(last_auction_no_sale_category_2_4_volume), 0) as "Total Excluding Value Added",
    coalesce(sum(last_auction_no_sale_volume), 0) as "Total",
    coalesce(sum(last_auction_no_sale_category_2_4_volume), 0)  as "Value Added"
    from bcts_staging.licence_issued_advertised_main
    where include_in_semi_monthly_report = 'Y';

    
    DROP TABLE IF EXISTS bcts_staging.bcts_performance_report_ytd_all;
    create table bcts_staging.bcts_performance_report_ytd_all as
    with base as (
        select 
            st.business_area_region_category,
            st.business_area_region,
            st.business_area,

            COALESCE(st.Q1_YTD_Sales_Target_Volume, 0) as "Q1 Licence Issued Target",
            COALESCE(st.Q2_YTD_Sales_Target_Volume, 0) as "Q2 Licence Issued Target",
            COALESCE(st.Q3_YTD_Sales_Target_Volume, 0) as "Q3 Licence Issued Target",
            COALESCE(st.Total_Fiscal_Year_Sales_Target_Volume, 0) as "Fiscal Year Licence Issued Target",

            COALESCE(st.Q1_YTD_Sales_Target_Volume_Cat_4, 0) as "Q1 Licence Issued Target: Value Added",
            COALESCE(st.Q2_YTD_Sales_Target_Volume_Cat_4, 0) as "Q2 Licence Issued Target: Value Added",
            COALESCE(st.Q3_YTD_Sales_Target_Volume_Cat_4, 0) as "Q3 Licence Issued Target: Value Added",
            COALESCE(st.Total_Fiscal_Year_Sales_Target_Volume_Cat_4, 0) as "Fiscal Year Licence Issued Target: Value Added",

            COALESCE(cms."Currently in Market", 0) as "Currently in Market",
            COALESCE(ain."Auctioned (First Auction is in Report Period)", 0) as "Auctioned",
            COALESCE(ain."Licence Issued", 0) as "Licence Issued",
            COALESCE(ain."Not Awarded (Last Auction in Report Period is No Sale)", 0) as "Not Awarded",

            COALESCE(cms."Volume: Value Added", 0) as "Currently in Market: Value Added",
            COALESCE(ain."Auctioned (First Auction is in Report Period): Category 2/4", 0) as "Auctioned: Value Added",
            COALESCE(ain."Licence Issued: Cat 2/4", 0) as "Licence Issued: Value Added",
            COALESCE(ain."Not Awarded: Category 2/4", 0) as "Not Awarded: Value Added"

        from bcts_staging.bcts_sales_targets st
        left join bcts_staging.currently_in_market_summary cms
            on cms.business_area_region = st.business_area_region
            and cms.business_area = st.business_area
        left join bcts_staging.ytd_auctioned_issued_not_awarded ain
            on cms.business_area_region = ain.business_area_region
            and cms.business_area = ain.business_area
    )

    select 
        *,
        
        greatest(
            sum("Licence Issued") over (partition by business_area),
            sum("Licence Issued: Value Added") over (partition by business_area),
            sum("Not Awarded") over (partition by business_area),
            sum("Not Awarded: Value Added") over (partition by business_area),
            sum("Auctioned") over (partition by business_area),
            sum("Auctioned: Value Added") over (partition by business_area),
            -- dynamic target inclusion based on current quarter
            max(
                case 
                    when extract(month from (current_date - interval '15 days')) between 4 and 6 then "Q1 Licence Issued Target"
                    when extract(month from (current_date - interval '15 days')) between 7 and 9 then "Q2 Licence Issued Target"
                    when extract(month from (current_date - interval '15 days')) between 10 and 12 then "Q3 Licence Issued Target"
                    else "Fiscal Year Licence Issued Target"
                end
            ) over (partition by business_area)
        ) * 1.1 as y_max_business_area,

        greatest(
            sum("Licence Issued") over (partition by business_area_region),
            sum("Licence Issued: Value Added") over (partition by business_area_region),
            sum("Not Awarded") over (partition by business_area_region),
            sum("Not Awarded: Value Added") over (partition by business_area_region),
            sum("Auctioned") over (partition by business_area_region),
            sum("Auctioned: Value Added") over (partition by business_area_region),
            -- dynamic target inclusion based on current quarter
            sum(
                case 
                    when extract(month from (current_date - interval '15 days')) between 4 and 6 then "Q1 Licence Issued Target"
                    when extract(month from (current_date - interval '15 days')) between 7 and 9 then "Q2 Licence Issued Target"
                    when extract(month from (current_date - interval '15 days')) between 10 and 12 then "Q3 Licence Issued Target"
                    else "Fiscal Year Licence Issued Target"
                end
            ) over (partition by business_area_region)
        ) * 1.1 as y_max_region,

        greatest(
            sum("Licence Issued") over (),
            sum("Licence Issued: Value Added") over (),
            sum("Not Awarded") over (),
            sum("Not Awarded: Value Added") over (),
            sum("Auctioned") over (),
            sum("Auctioned: Value Added") over (),
            -- dynamic target inclusion based on current quarter
            sum(
                case 
                    when extract(month from (current_date - interval '15 days')) between 4 and 6 then "Q1 Licence Issued Target"
                    when extract(month from (current_date - interval '15 days')) between 7 and 9 then "Q2 Licence Issued Target"
                    when extract(month from (current_date - interval '15 days')) between 10 and 12 then "Q3 Licence Issued Target"
                    else "Fiscal Year Licence Issued Target"
                end
            ) over ()
        ) * 1.1 as y_max_province,

        case  
            when business_area_region = 'North Interior' then 1
            when business_area_region = 'South Interior' then 2
            else 3
        end as business_area_region_sort_order,

        case  
            when business_area_region_category = 'Interior' then 1
            else 2
        end as business_area_region_category_sort_order

    from base;



    DROP TABLE IF EXISTS bcts_staging.bcts_volume_summary_chart_2;
    create table bcts_staging.bcts_volume_summary_chart_2 as
    select 
    'Q1 Licence Issued Target' as metric,
    sum("Q1 Licence Issued Target") as "Total",
    sum("Q1 Licence Issued Target: Value Added") as "Value Added"
    from bcts_staging.bcts_performance_report_ytd_all

    union all

    select 
    'Q2 Licence Issued Target' as metric,
    sum("Q2 Licence Issued Target"),
    sum("Q2 Licence Issued Target: Value Added")
    from bcts_staging.bcts_performance_report_ytd_all

    union all

    select 
    'Q3 Licence Issued Target' as metric,
    sum("Q3 Licence Issued Target"),
    sum("Q3 Licence Issued Target: Value Added")
    from bcts_staging.bcts_performance_report_ytd_all

    union all

    select 
    'Fiscal Year Licence Issued Target' as metric,
    sum("Fiscal Year Licence Issued Target"),
    sum("Fiscal Year Licence Issued Target: Value Added")
    from bcts_staging.bcts_performance_report_ytd_all

    union all

    select 
    'Auctioned' as metric,
    sum("Auctioned"),
    sum("Auctioned: Value Added")
    from bcts_staging.bcts_performance_report_ytd_all

    union all

    select 
    'Currently in Market' as metric,
    sum("Currently in Market"),
    sum("Currently in Market: Value Added")
    from bcts_staging.bcts_performance_report_ytd_all

    union all

    select 
    'Licence Issued' as metric,
    sum("Licence Issued"),
    sum("Licence Issued: Value Added")
    from bcts_staging.bcts_performance_report_ytd_all

    union all

    select 
    'Not Awarded' as metric,
    sum("Not Awarded"),
    sum("Not Awarded: Value Added")
    from bcts_staging.bcts_performance_report_ytd_all;

    DROP TABLE IF EXISTS BCTS_REPORTING.bcts_performance_report_ytd_all;
    CREATE TABLE BCTS_REPORTING.bcts_performance_report_ytd_all
    AS SELECT * 
    FROM BCTS_STAGING.bcts_performance_report_ytd_all;

    DROP TABLE IF EXISTS BCTS_REPORTING.bcts_volume_summary_chart_2;
    CREATE TABLE BCTS_REPORTING.bcts_volume_summary_chart_2
    AS SELECT * 
    FROM BCTS_STAGING.bcts_volume_summary_chart_2;

    DROP TABLE IF EXISTS BCTS_REPORTING.recent_auctions_chart_2;
    CREATE TABLE BCTS_REPORTING.recent_auctions_chart_2
    AS SELECT * 
    FROM BCTS_STAGING.recent_auctions_chart_2;
   
    DROP TABLE IF EXISTS BCTS_REPORTING.recent_auction_results;
    CREATE TABLE BCTS_REPORTING.recent_auction_results
    AS SELECT * 
    FROM BCTS_STAGING.recent_auction_results;

    DROP TABLE IF EXISTS BCTS_REPORTING.bcts_performance_report_not_awarded_details;
    CREATE TABLE BCTS_REPORTING.bcts_performance_report_not_awarded_details
    AS SELECT * 
    FROM BCTS_STAGING.bcts_performance_report_not_awarded_details;

    DROP TABLE IF EXISTS BCTS_REPORTING.bcts_performance_report_licence_issued_details;
    CREATE TABLE BCTS_REPORTING.bcts_performance_report_licence_issued_details
    AS SELECT * 
    FROM BCTS_STAGING.bcts_performance_report_licence_issued_details;

    drop table if exists bcts_staging.bcts_performance_report_current_prev_ytd_issued_lic_volume;

    create table bcts_staging.bcts_performance_report_current_prev_ytd_issued_lic_volume as
    with current_ytd as
    (select 
    business_area_region_category,
    business_area_region,
    business_area,
    coalesce(sum(issued_licence_volume), 0) as "Current YTD Licence Issued",
    coalesce(sum(category_2_and_4_issued_volume), 0) as "Current YTD Licence Issued: Value Added"
    from bcts_reporting.licence_issued_advertised_main main
    group by business_area_region_category, business_area_region, business_area
    ),
    previous_ytd as
    (select 
    business_area_region_category,
    business_area_region,
    business_area,
    coalesce(sum(issued_licence_volume),0) as "Previous YTD Licence Issued",
    coalesce(sum(category_2_and_4_issued_volume), 0) as "Previous YTD Licence Issued: Value Added"
    from bcts_reporting.licence_issued_advertised_main_hist
    where report_start_date = (select max(report_start_date) - interval '1 year' from bcts_reporting.licence_issued_advertised_main)
    and report_end_date = (select max(report_end_date) - interval '1 year' from bcts_reporting.licence_issued_advertised_main)
    group by business_area_region_category, business_area_region, business_area
    ),
    base as
    (
    select current_ytd.business_area_region_category,
    current_ytd.business_area_region,
    current_ytd.business_area,
    current_ytd."Current YTD Licence Issued",
    current_ytd."Current YTD Licence Issued: Value Added",
    current_ytd."Current YTD Licence Issued" - current_ytd."Current YTD Licence Issued: Value Added" as "Current YTD Licence Issued: Other",
    previous_ytd."Previous YTD Licence Issued",
    previous_ytd."Previous YTD Licence Issued: Value Added",
    previous_ytd."Previous YTD Licence Issued" - previous_ytd."Previous YTD Licence Issued: Value Added" as "Previous YTD Licence Issued: Other",
	greatest(sum(current_ytd."Current YTD Licence Issued") over (partition by current_ytd.business_area), 
                sum(previous_ytd."Previous YTD Licence Issued")over (partition by current_ytd.business_area),
                sum(current_ytd."Current YTD Licence Issued: Value Added")over (partition by current_ytd.business_area),
                sum(previous_ytd."Previous YTD Licence Issued: Value Added")over (partition by current_ytd.business_area)
                )  as y_business_area

    from previous_ytd
    left join current_ytd
    on previous_ytd.business_area_region_category = current_ytd.business_area_region_category
    and previous_ytd.business_area_region = current_ytd.business_area_region
    and previous_ytd.business_area = current_ytd.business_area
    )
    select 
        business_area_region_category,
        business_area_region,
        business_area,
        "Current YTD Licence Issued",
        "Current YTD Licence Issued: Value Added",
        "Current YTD Licence Issued: Other",
        "Previous YTD Licence Issued",
        "Previous YTD Licence Issued: Value Added",
        "Previous YTD Licence Issued" - "Previous YTD Licence Issued: Value Added" as "Previous YTD Licence Issued: Other",
         y_business_area * 1.1 as y_max_business_area
    from base
    ;

    drop table if exists bcts_reporting.bcts_performance_report_current_prev_ytd_issued_lic_volume;

    create table bcts_reporting.bcts_performance_report_current_prev_ytd_issued_lic_volume as
    select *
    from bcts_staging.bcts_performance_report_current_prev_ytd_issued_lic_volume;

    """

    try:
        cursor.execute(sql_statement)
        connection.commit()
        logging.info(f"SQL script executed successfully.")
    except psycopg2.Error as e:
        logging.error(f"Error executing the SQL script: {e}")
        connection.rollback()
        sys.exit(1)

def delete_licence_issued_advertised__main_hist(connection, cursor, start_date, end_date):
    sql_statement = \
    f"""
    delete from bcts_staging.licence_issued_advertised_main_hist
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

def truncate_licence_issued_advertised_official(connection, cursor):
    # updated to delete from due to permission issues
    sql_statement = \
    f"""
    delete from bcts_staging.licence_issued_advertised_official;
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
    current_month_15 = today.replace(day=15)

    if today >= current_month_15:
        end_date = current_month_15
    else:
        end_date = last_month_end

    return fiscal_year_start, end_date

if __name__ == "__main__":

    connection = get_connection()
    cursor = connection.cursor()

    # Fetch the start and end dates for the report periods
    start_date, end_date = get_valid_report_period()

    # Skip if report is already generated
    if licence_issued_advertised_main_report_exists(start_date, end_date):
        logging.info("Report already exists! Skipping...")
    else:
        # Truncate bcts_staging.licence_issued_advertised_official clear data from previous run
        truncate_licence_issued_advertised_official(connection, cursor)

        # Delete data for the same period in bcts_staging.licence_issued_advertised_main_hist if it is already present.
        # Check for existence is done on bcts_reporting.licence_issued_advertised_main. So it is possible to insert dupliocate
        # values to the staging table if data is already present in staging and not in reporting or if data is manually removed from
        # reporting to force ETL and not from staging.
        delete_licence_issued_advertised__main_hist(connection, cursor, start_date, end_date)

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
        
