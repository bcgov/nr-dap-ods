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
    BEGIN;

    ------------------------------------------------------------
    -- fta_tenure_term
    ------------------------------------------------------------
    TRUNCATE TABLE bcts_staging.fta_tenure_term;

    INSERT INTO bcts_staging.fta_tenure_term (
        forest_file_id, tenure_term, legal_effective_dt, initial_expiry_dt, current_expiry_dt,
        tenure_extend_cnt, tenr_extend_rsn_st, entry_userid, entry_timestamp, update_userid,
        update_timestamp, revision_count
    )
    SELECT
        forest_file_id, tenure_term, legal_effective_dt, initial_expiry_dt, current_expiry_dt,
        tenure_extend_cnt, tenr_extend_rsn_st, entry_userid, entry_timestamp, update_userid,
        update_timestamp, revision_count
    FROM fta_replication.tenure_term;

    ------------------------------------------------------------
    -- fta_prov_forest_use
    ------------------------------------------------------------
    TRUNCATE TABLE bcts_staging.fta_prov_forest_use;

    INSERT INTO bcts_staging.fta_prov_forest_use (
        forest_file_id, file_status_st, file_status_date, file_type_code, forest_region, bcts_org_unit,
        sb_funded_ind, district_admin_zone, mgmt_unit_type, mgmt_unit_id, revision_count,
        entry_userid, entry_timestamp, update_userid, update_timestamp, forest_tenure_guid
    )
    SELECT
        forest_file_id, file_status_st, file_status_date, file_type_code, forest_region, bcts_org_unit,
        sb_funded_ind, district_admin_zone, mgmt_unit_type, mgmt_unit_id, revision_count,
        entry_userid, entry_timestamp, update_userid, update_timestamp, forest_tenure_guid
    FROM fta_replication.prov_forest_use;

    ------------------------------------------------------------
    -- fta_tenure_file_status_code
    ------------------------------------------------------------
    TRUNCATE TABLE bcts_staging.fta_tenure_file_status_code;

    INSERT INTO bcts_staging.fta_tenure_file_status_code (
        tenure_file_status_code, description, effective_date, expiry_date, update_timestamp
    )
    SELECT
        tenure_file_status_code, description, effective_date, expiry_date, update_timestamp
    FROM fta_replication.tenure_file_status_code;

    ------------------------------------------------------------
    -- fta_tfl_number_code
    ------------------------------------------------------------
    TRUNCATE TABLE bcts_staging.fta_tfl_number_code;

    INSERT INTO bcts_staging.fta_tfl_number_code (
        tfl_number, description, effective_date, expiry_date, update_timestamp
    )
    SELECT
        tfl_number, description, effective_date, expiry_date, update_timestamp
    FROM fta_replication.tfl_number_code;

    ------------------------------------------------------------
    -- fta_sale_method_code
    ------------------------------------------------------------
    TRUNCATE TABLE bcts_staging.fta_sale_method_code;

    INSERT INTO bcts_staging.fta_sale_method_code (
        sale_method_code, description, effective_date, expiry_date, update_timestamp
    )
    SELECT
        sale_method_code, description, effective_date, expiry_date, update_timestamp
    FROM fta_replication.sale_method_code;

    ------------------------------------------------------------
    -- fta_org_unit
    ------------------------------------------------------------
    TRUNCATE TABLE bcts_staging.fta_org_unit;

    INSERT INTO bcts_staging.fta_org_unit (
        org_unit_no, org_unit_code, org_unit_name, location_code, area_code, telephone_no,
        org_level_code, office_name_code, rollup_region_no, rollup_region_code, rollup_dist_no,
        rollup_dist_code, effective_date, expiry_date, update_timestamp
    )
    SELECT
        org_unit_no, org_unit_code, org_unit_name, location_code, area_code, telephone_no,
        org_level_code, office_name_code, rollup_region_no, rollup_region_code, rollup_dist_no,
        rollup_dist_code, effective_date, expiry_date, update_timestamp
    FROM fta_replication.org_unit;

    ------------------------------------------------------------
    -- fta_sb_category_code
    ------------------------------------------------------------
    TRUNCATE TABLE bcts_staging.fta_sb_category_code;

    INSERT INTO bcts_staging.fta_sb_category_code (
        sb_category_code, description, effective_date, expiry_date, update_timestamp
    )
    SELECT
        sb_category_code, description, effective_date, expiry_date, update_timestamp
    FROM fta_replication.sb_category_code;

    ------------------------------------------------------------
    -- fta_harvest_sale
    ------------------------------------------------------------
    TRUNCATE TABLE bcts_staging.fta_harvest_sale;

    INSERT INTO bcts_staging.fta_harvest_sale (
        forest_file_id, sb_fund_ind, sale_method_code, sale_type_cd, planned_sale_date,
        tender_opening_dt, plnd_sb_cat_code, sold_sb_cat_code, total_bidders, lumpsum_bonus_amt,
        cash_sale_est_vol, cash_sale_tot_dol, payment_method_cd, salvage_ind, sale_volume,
        admin_area_ind, minor_facility_ind, bcts_org_unit, fta_bonus_bid, fta_bonus_offer,
        revision_count, entry_timestamp, update_timestamp
    )
    SELECT
        forest_file_id, sb_fund_ind, sale_method_code, sale_type_cd, planned_sale_date,
        tender_opening_dt, plnd_sb_cat_code, sold_sb_cat_code, total_bidders, lumpsum_bonus_amt,
        cash_sale_est_vol, cash_sale_tot_dol, payment_method_cd, salvage_ind, sale_volume,
        admin_area_ind, minor_facility_ind, bcts_org_unit, fta_bonus_bid, fta_bonus_offer,
        revision_count, entry_timestamp, update_timestamp
    FROM fta_replication.harvest_sale;

    ------------------------------------------------------------
    -- fta_tsa_number_code
    ------------------------------------------------------------
    TRUNCATE TABLE bcts_staging.fta_tsa_number_code;

    INSERT INTO bcts_staging.fta_tsa_number_code (
        tsa_number, description, effective_date, expiry_date, update_timestamp
    )
    SELECT
        tsa_number, description, effective_date, expiry_date, update_timestamp
    FROM fta_replication.tsa_number_code;

    ------------------------------------------------------------
    -- fta_forest_file_client
    ------------------------------------------------------------
    TRUNCATE TABLE bcts_staging.fta_forest_file_client;

    INSERT INTO bcts_staging.fta_forest_file_client (
        forest_file_client_skey, forest_file_id, client_number, client_locn_code,
        forest_file_client_type_code, licensee_start_date, licensee_end_date, revision_count,
        entry_timestamp, update_timestamp
    )
    SELECT
        forest_file_client_skey, forest_file_id, client_number, client_locn_code,
        forest_file_client_type_code, licensee_start_date, licensee_end_date, revision_count,
        entry_timestamp, update_timestamp
    FROM fta_replication.forest_file_client;

    ------------------------------------------------------------
    -- fta_timber_mark
    ------------------------------------------------------------
    TRUNCATE TABLE bcts_staging.fta_timber_mark;

    INSERT INTO bcts_staging.fta_timber_mark (
        timber_mark, forest_file_id, cutting_permit_id, forest_district, geographic_distrct,
        cascade_split_code, quota_type_code, deciduous_ind, catastrophic_ind, crown_granted_ind,
        cruise_based_ind, certificate, hdbs_timber_mark, vm_timber_mark, tenure_term,
        bcaa_folio_number, activated_userid, amended_userid, district_admn_zone, granted_acqrd_date,
        lands_region, crown_granted_acq_desc, mark_status_st, mark_status_date, mark_amend_date,
        mark_appl_date, mark_cancel_date, mark_extend_date, mark_extend_rsn_cd, mark_extend_count,
        mark_issue_date, mark_expiry_date, markng_instrmnt_cd, marking_method_cd, entry_userid,
        entry_timestamp, update_userid, update_timestamp, revision_count, small_patch_salvage_ind,
        salvage_type_code
    )
    SELECT
        timber_mark, forest_file_id, cutting_permit_id, forest_district, geographic_distrct,
        cascade_split_code, quota_type_code, deciduous_ind, catastrophic_ind, crown_granted_ind,
        cruise_based_ind, certificate, hdbs_timber_mark, vm_timber_mark, tenure_term,
        bcaa_folio_number, activated_userid, amended_userid, district_admn_zone, granted_acqrd_date,
        lands_region, crown_granted_acq_desc, mark_status_st, mark_status_date, mark_amend_date,
        mark_appl_date, mark_cancel_date, mark_extend_date, mark_extend_rsn_cd, mark_extend_count,
        mark_issue_date, mark_expiry_date, markng_instrmnt_cd, marking_method_cd, entry_userid,
        entry_timestamp, update_userid, update_timestamp, revision_count, small_patch_salvage_ind,
        salvage_type_code
    FROM fta_replication.timber_mark;

    ------------------------------------------------------------
    -- fta_mgmt_unit_type_code
    ------------------------------------------------------------
    TRUNCATE TABLE bcts_staging.fta_mgmt_unit_type_code;

    INSERT INTO bcts_staging.fta_mgmt_unit_type_code (
        mgmt_unit_type_code, description, effective_date, expiry_date, update_timestamp
    )
    SELECT
        mgmt_unit_type_code, description, effective_date, expiry_date, update_timestamp
    FROM fta_replication.mgmt_unit_type_code;

    COMMIT;

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
        
