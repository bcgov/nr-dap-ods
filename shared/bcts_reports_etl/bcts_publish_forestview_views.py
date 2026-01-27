#!/usr/bin/env python
# coding: utf-8

#Imports
import os, time
import psycopg2
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
    
    TRUNCATE TABLE bcts_reporting.forestview_v_activity_cost;
    INSERT INTO bcts_reporting.forestview_v_activity_cost SELECT * FROM lrm_replication.v_activity_cost;


    TRUNCATE TABLE bcts_reporting.forestview_v_apportionment;
    INSERT INTO bcts_reporting.forestview_v_apportionment SELECT * FROM lrm_replication.v_apportionment;


    TRUNCATE TABLE bcts_reporting.forestview_v_appr_bridge_tab_cost;
    INSERT INTO bcts_reporting.forestview_v_appr_bridge_tab_cost SELECT * FROM lrm_replication.v_appr_bridge_tab_cost;


    TRUNCATE TABLE bcts_reporting.forestview_v_appr_culvert_tab_cost;
    INSERT INTO bcts_reporting.forestview_v_appr_culvert_tab_cost SELECT * FROM lrm_replication.v_appr_culvert_tab_cost;


    TRUNCATE TABLE bcts_reporting.forestview_v_appr_internal_rate;
    INSERT INTO bcts_reporting.forestview_v_appr_internal_rate SELECT * FROM lrm_replication.v_appr_internal_rate;


    TRUNCATE TABLE bcts_reporting.forestview_v_appr_ministry_rate;
    INSERT INTO bcts_reporting.forestview_v_appr_ministry_rate SELECT * FROM lrm_replication.v_appr_ministry_rate;


    TRUNCATE TABLE bcts_reporting.forestview_v_appr_road_tab_cost;
    INSERT INTO bcts_reporting.forestview_v_appr_road_tab_cost SELECT * FROM lrm_replication.v_appr_road_tab_cost;


    TRUNCATE TABLE bcts_reporting.forestview_v_attachment;
    INSERT INTO bcts_reporting.forestview_v_attachment SELECT * FROM lrm_replication.v_attachment;


    TRUNCATE TABLE bcts_reporting.forestview_v_block;
    INSERT INTO bcts_reporting.forestview_v_block SELECT * FROM lrm_replication.v_block;


    TRUNCATE TABLE bcts_reporting.forestview_v_block_activity_all;
    INSERT INTO bcts_reporting.forestview_v_block_activity_all SELECT * FROM lrm_replication.v_block_activity_all;


    TRUNCATE TABLE bcts_reporting.forestview_v_block_area;
    INSERT INTO bcts_reporting.forestview_v_block_area SELECT * FROM lrm_replication.v_block_area;


    TRUNCATE TABLE bcts_reporting.forestview_v_block_cruise;
    INSERT INTO bcts_reporting.forestview_v_block_cruise SELECT * FROM lrm_replication.v_block_cruise;


    TRUNCATE TABLE bcts_reporting.forestview_v_block_cruise_all_coni_deci;
    INSERT INTO bcts_reporting.forestview_v_block_cruise_all_coni_deci SELECT * FROM lrm_replication.v_block_cruise_all_coni_deci;


    TRUNCATE TABLE bcts_reporting.forestview_v_block_depletion_stage;
    INSERT INTO bcts_reporting.forestview_v_block_depletion_stage SELECT * FROM lrm_replication.v_block_depletion_stage;


    TRUNCATE TABLE bcts_reporting.forestview_v_block_harvest_method;
    INSERT INTO bcts_reporting.forestview_v_block_harvest_method SELECT * FROM lrm_replication.v_block_harvest_method;


    TRUNCATE TABLE bcts_reporting.forestview_v_block_harvest_strategy;
    INSERT INTO bcts_reporting.forestview_v_block_harvest_strategy SELECT * FROM lrm_replication.v_block_harvest_strategy;


    TRUNCATE TABLE bcts_reporting.forestview_v_block_nmar;
    INSERT INTO bcts_reporting.forestview_v_block_nmar SELECT * FROM lrm_replication.v_block_nmar;


    TRUNCATE TABLE bcts_reporting.forestview_v_block_old;
    INSERT INTO bcts_reporting.forestview_v_block_old SELECT * FROM lrm_replication.v_block_old;


    TRUNCATE TABLE bcts_reporting.forestview_v_block_spatial;
    INSERT INTO bcts_reporting.forestview_v_block_spatial SELECT * FROM lrm_replication.v_block_spatial;


    TRUNCATE TABLE bcts_reporting.forestview_v_block_tasks_issue;
    INSERT INTO bcts_reporting.forestview_v_block_tasks_issue SELECT * FROM lrm_replication.v_block_tasks_issue;


    TRUNCATE TABLE bcts_reporting.forestview_v_block_timber;
    INSERT INTO bcts_reporting.forestview_v_block_timber SELECT * FROM lrm_replication.v_block_timber;


    TRUNCATE TABLE bcts_reporting.forestview_v_coastal_cost_survey_bh;
    INSERT INTO bcts_reporting.forestview_v_coastal_cost_survey_bh SELECT * FROM lrm_replication.v_coastal_cost_survey_bh;


    TRUNCATE TABLE bcts_reporting.forestview_v_coastal_cost_survey_roads;
    INSERT INTO bcts_reporting.forestview_v_coastal_cost_survey_roads SELECT * FROM lrm_replication.v_coastal_cost_survey_roads;


    TRUNCATE TABLE bcts_reporting.forestview_v_commitments;
    INSERT INTO bcts_reporting.forestview_v_commitments SELECT * FROM lrm_replication.v_commitments;


    TRUNCATE TABLE bcts_reporting.forestview_v_commit_tracking_sale_info;
    INSERT INTO bcts_reporting.forestview_v_commit_tracking_sale_info SELECT * FROM lrm_replication.v_commit_tracking_sale_info;


    TRUNCATE TABLE bcts_reporting.forestview_v_cost_survey_bridges;
    INSERT INTO bcts_reporting.forestview_v_cost_survey_bridges SELECT * FROM lrm_replication.v_cost_survey_bridges;


    TRUNCATE TABLE bcts_reporting.forestview_v_cp;
    INSERT INTO bcts_reporting.forestview_v_cp SELECT * FROM lrm_replication.v_cp;


    TRUNCATE TABLE bcts_reporting.forestview_v_detailed_site_assessment;
    INSERT INTO bcts_reporting.forestview_v_detailed_site_assessment SELECT * FROM lrm_replication.v_detailed_site_assessment;


    TRUNCATE TABLE bcts_reporting.forestview_v_ecology;
    INSERT INTO bcts_reporting.forestview_v_ecology SELECT * FROM lrm_replication.v_ecology;


    TRUNCATE TABLE bcts_reporting.forestview_v_ecology_site_series;
    INSERT INTO bcts_reporting.forestview_v_ecology_site_series SELECT * FROM lrm_replication.v_ecology_site_series;


    TRUNCATE TABLE bcts_reporting.forestview_v_ems_action_plan;
    INSERT INTO bcts_reporting.forestview_v_ems_action_plan SELECT * FROM lrm_replication.v_ems_action_plan;


    TRUNCATE TABLE bcts_reporting.forestview_v_ems_action_plan_descr;
    INSERT INTO bcts_reporting.forestview_v_ems_action_plan_descr SELECT * FROM lrm_replication.v_ems_action_plan_descr;


    TRUNCATE TABLE bcts_reporting.forestview_v_ems_contract;
    INSERT INTO bcts_reporting.forestview_v_ems_contract SELECT * FROM lrm_replication.v_ems_contract;


    TRUNCATE TABLE bcts_reporting.forestview_v_ems_inspection;
    INSERT INTO bcts_reporting.forestview_v_ems_inspection SELECT * FROM lrm_replication.v_ems_inspection;


    TRUNCATE TABLE bcts_reporting.forestview_v_ems_inspection_frequency;
    INSERT INTO bcts_reporting.forestview_v_ems_inspection_frequency SELECT * FROM lrm_replication.v_ems_inspection_frequency;


    TRUNCATE TABLE bcts_reporting.forestview_v_ems_inspection_test_drill;
    INSERT INTO bcts_reporting.forestview_v_ems_inspection_test_drill SELECT * FROM lrm_replication.v_ems_inspection_test_drill;


    TRUNCATE TABLE bcts_reporting.forestview_v_ems_issue;
    INSERT INTO bcts_reporting.forestview_v_ems_issue SELECT * FROM lrm_replication.v_ems_issue;


    TRUNCATE TABLE bcts_reporting.forestview_v_ems_issue_government;
    INSERT INTO bcts_reporting.forestview_v_ems_issue_government SELECT * FROM lrm_replication.v_ems_issue_government;


    TRUNCATE TABLE bcts_reporting.forestview_v_ems_issue_investigation;
    INSERT INTO bcts_reporting.forestview_v_ems_issue_investigation SELECT * FROM lrm_replication.v_ems_issue_investigation;


    TRUNCATE TABLE bcts_reporting.forestview_v_ems_plan_vs_complete_insp;
    INSERT INTO bcts_reporting.forestview_v_ems_plan_vs_complete_insp SELECT * FROM lrm_replication.v_ems_plan_vs_complete_insp;


    TRUNCATE TABLE bcts_reporting.forestview_v_ems_plan_vs_compl_prework;
    INSERT INTO bcts_reporting.forestview_v_ems_plan_vs_compl_prework SELECT * FROM lrm_replication.v_ems_plan_vs_compl_prework;


    TRUNCATE TABLE bcts_reporting.forestview_v_ems_requirement;
    INSERT INTO bcts_reporting.forestview_v_ems_requirement SELECT * FROM lrm_replication.v_ems_requirement;


    TRUNCATE TABLE bcts_reporting.forestview_v_fdu;
    INSERT INTO bcts_reporting.forestview_v_fdu SELECT * FROM lrm_replication.v_fdu;


    TRUNCATE TABLE bcts_reporting.forestview_v_forest_comment;
    INSERT INTO bcts_reporting.forestview_v_forest_comment SELECT * FROM lrm_replication.v_forest_comment;


    TRUNCATE TABLE bcts_reporting.forestview_v_frpa_results_strategies;
    INSERT INTO bcts_reporting.forestview_v_frpa_results_strategies SELECT * FROM lrm_replication.v_frpa_results_strategies;


    TRUNCATE TABLE bcts_reporting.forestview_v_gis_actd;
    INSERT INTO bcts_reporting.forestview_v_gis_actd SELECT * FROM lrm_replication.v_gis_actd;


    TRUNCATE TABLE bcts_reporting.forestview_v_gis_actd_dates;
    INSERT INTO bcts_reporting.forestview_v_gis_actd_dates SELECT * FROM lrm_replication.v_gis_actd_dates;


    TRUNCATE TABLE bcts_reporting.forestview_v_gis_acts;
    INSERT INTO bcts_reporting.forestview_v_gis_acts SELECT * FROM lrm_replication.v_gis_acts;


    TRUNCATE TABLE bcts_reporting.forestview_v_gis_acts_status;
    INSERT INTO bcts_reporting.forestview_v_gis_acts_status SELECT * FROM lrm_replication.v_gis_acts_status;


    TRUNCATE TABLE bcts_reporting.forestview_v_harvested_block_status;
    INSERT INTO bcts_reporting.forestview_v_harvested_block_status SELECT * FROM lrm_replication.v_harvested_block_status;


    TRUNCATE TABLE bcts_reporting.forestview_v_harvest_history;
    INSERT INTO bcts_reporting.forestview_v_harvest_history SELECT * FROM lrm_replication.v_harvest_history;


    TRUNCATE TABLE bcts_reporting.forestview_v_harvest_unit;
    INSERT INTO bcts_reporting.forestview_v_harvest_unit SELECT * FROM lrm_replication.v_harvest_unit;


    TRUNCATE TABLE bcts_reporting.forestview_v_interior_cost_survey_culv;
    INSERT INTO bcts_reporting.forestview_v_interior_cost_survey_culv SELECT * FROM lrm_replication.v_interior_cost_survey_culv;


    TRUNCATE TABLE bcts_reporting.forestview_v_interior_cost_survey_roads;
    INSERT INTO bcts_reporting.forestview_v_interior_cost_survey_roads SELECT * FROM lrm_replication.v_interior_cost_survey_roads;


    TRUNCATE TABLE bcts_reporting.forestview_v_licence;
    INSERT INTO bcts_reporting.forestview_v_licence SELECT * FROM lrm_replication.v_licence;


    TRUNCATE TABLE bcts_reporting.forestview_v_licence_activity_all;
    INSERT INTO bcts_reporting.forestview_v_licence_activity_all SELECT * FROM lrm_replication.v_licence_activity_all;


    TRUNCATE TABLE bcts_reporting.forestview_v_mark;
    INSERT INTO bcts_reporting.forestview_v_mark SELECT * FROM lrm_replication.v_mark;


    TRUNCATE TABLE bcts_reporting.forestview_v_mark_activity;
    INSERT INTO bcts_reporting.forestview_v_mark_activity SELECT * FROM lrm_replication.v_mark_activity;


    TRUNCATE TABLE bcts_reporting.forestview_v_non_frpa_results_strategies;
    INSERT INTO bcts_reporting.forestview_v_non_frpa_results_strategies SELECT * FROM lrm_replication.v_non_frpa_results_strategies;


    TRUNCATE TABLE bcts_reporting.forestview_v_pest_infestation;
    INSERT INTO bcts_reporting.forestview_v_pest_infestation SELECT * FROM lrm_replication.v_pest_infestation;


    TRUNCATE TABLE bcts_reporting.forestview_v_planting;
    INSERT INTO bcts_reporting.forestview_v_planting SELECT * FROM lrm_replication.v_planting;


    TRUNCATE TABLE bcts_reporting.forestview_v_planting_species;
    INSERT INTO bcts_reporting.forestview_v_planting_species SELECT * FROM lrm_replication.v_planting_species;


    TRUNCATE TABLE bcts_reporting.forestview_v_qb_valuation;
    INSERT INTO bcts_reporting.forestview_v_qb_valuation SELECT * FROM lrm_replication.v_qb_valuation;


    TRUNCATE TABLE bcts_reporting.forestview_v_riparian_zone;
    INSERT INTO bcts_reporting.forestview_v_riparian_zone SELECT * FROM lrm_replication.v_riparian_zone;


    TRUNCATE TABLE bcts_reporting.forestview_v_road;
    INSERT INTO bcts_reporting.forestview_v_road SELECT * FROM lrm_replication.v_road;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_activity;
    INSERT INTO bcts_reporting.forestview_v_road_activity SELECT * FROM lrm_replication.v_road_activity;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_activity_cost;
    INSERT INTO bcts_reporting.forestview_v_road_activity_cost SELECT * FROM lrm_replication.v_road_activity_cost;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_activity_cost_row;
    INSERT INTO bcts_reporting.forestview_v_road_activity_cost_row SELECT * FROM lrm_replication.v_road_activity_cost_row;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_activity_row;
    INSERT INTO bcts_reporting.forestview_v_road_activity_row SELECT * FROM lrm_replication.v_road_activity_row;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_agri_land_reserve;
    INSERT INTO bcts_reporting.forestview_v_road_agri_land_reserve SELECT * FROM lrm_replication.v_road_agri_land_reserve;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_assessment;
    INSERT INTO bcts_reporting.forestview_v_road_assessment SELECT * FROM lrm_replication.v_road_assessment;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_class;
    INSERT INTO bcts_reporting.forestview_v_road_class SELECT * FROM lrm_replication.v_road_class;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_completion;
    INSERT INTO bcts_reporting.forestview_v_road_completion SELECT * FROM lrm_replication.v_road_completion;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_cut_block;
    INSERT INTO bcts_reporting.forestview_v_road_cut_block SELECT * FROM lrm_replication.v_road_cut_block;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_deactivation;
    INSERT INTO bcts_reporting.forestview_v_road_deactivation SELECT * FROM lrm_replication.v_road_deactivation;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_event_mapping;
    INSERT INTO bcts_reporting.forestview_v_road_event_mapping SELECT * FROM lrm_replication.v_road_event_mapping;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_gap_analysis;
    INSERT INTO bcts_reporting.forestview_v_road_gap_analysis SELECT * FROM lrm_replication.v_road_gap_analysis;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_inspection;
    INSERT INTO bcts_reporting.forestview_v_road_inspection SELECT * FROM lrm_replication.v_road_inspection;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_linear_struct;
    INSERT INTO bcts_reporting.forestview_v_road_linear_struct SELECT * FROM lrm_replication.v_road_linear_struct;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_maintenance;
    INSERT INTO bcts_reporting.forestview_v_road_maintenance SELECT * FROM lrm_replication.v_road_maintenance;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_management_unit;
    INSERT INTO bcts_reporting.forestview_v_road_management_unit SELECT * FROM lrm_replication.v_road_management_unit;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_mapsheet;
    INSERT INTO bcts_reporting.forestview_v_road_mapsheet SELECT * FROM lrm_replication.v_road_mapsheet;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_on_block;
    INSERT INTO bcts_reporting.forestview_v_road_on_block SELECT * FROM lrm_replication.v_road_on_block;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_op_area;
    INSERT INTO bcts_reporting.forestview_v_road_op_area SELECT * FROM lrm_replication.v_road_op_area;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_organic_mat;
    INSERT INTO bcts_reporting.forestview_v_road_organic_mat SELECT * FROM lrm_replication.v_road_organic_mat;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_permit;
    INSERT INTO bcts_reporting.forestview_v_road_permit SELECT * FROM lrm_replication.v_road_permit;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_prov_forest;
    INSERT INTO bcts_reporting.forestview_v_road_prov_forest SELECT * FROM lrm_replication.v_road_prov_forest;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_radio;
    INSERT INTO bcts_reporting.forestview_v_road_radio SELECT * FROM lrm_replication.v_road_radio;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_risk;
    INSERT INTO bcts_reporting.forestview_v_road_risk SELECT * FROM lrm_replication.v_road_risk;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_section;
    INSERT INTO bcts_reporting.forestview_v_road_section SELECT * FROM lrm_replication.v_road_section;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_spatial_meta;
    INSERT INTO bcts_reporting.forestview_v_road_spatial_meta SELECT * FROM lrm_replication.v_road_spatial_meta;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_status;
    INSERT INTO bcts_reporting.forestview_v_road_status SELECT * FROM lrm_replication.v_road_status;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_steward;
    INSERT INTO bcts_reporting.forestview_v_road_steward SELECT * FROM lrm_replication.v_road_steward;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_structure;
    INSERT INTO bcts_reporting.forestview_v_road_structure SELECT * FROM lrm_replication.v_road_structure;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_structure_attr;
    INSERT INTO bcts_reporting.forestview_v_road_structure_attr SELECT * FROM lrm_replication.v_road_structure_attr;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_structure_culvert;
    INSERT INTO bcts_reporting.forestview_v_road_structure_culvert SELECT * FROM lrm_replication.v_road_structure_culvert;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_structure_inspection;
    INSERT INTO bcts_reporting.forestview_v_road_structure_inspection SELECT * FROM lrm_replication.v_road_structure_inspection;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_structure_maintenance;
    INSERT INTO bcts_reporting.forestview_v_road_structure_maintenance SELECT * FROM lrm_replication.v_road_structure_maintenance;


    TRUNCATE TABLE bcts_reporting.forestview_v_road_use_permit;
    INSERT INTO bcts_reporting.forestview_v_road_use_permit SELECT * FROM lrm_replication.v_road_use_permit;


    TRUNCATE TABLE bcts_reporting.forestview_v_sale_forecast_tka_temp;
    INSERT INTO bcts_reporting.forestview_v_sale_forecast_tka_temp SELECT * FROM lrm_replication.v_sale_forecast_tka_temp;


    TRUNCATE TABLE bcts_reporting.forestview_v_silvicultural_system;
    INSERT INTO bcts_reporting.forestview_v_silvicultural_system SELECT * FROM lrm_replication.v_silvicultural_system;


    TRUNCATE TABLE bcts_reporting.forestview_v_silviculture_activity;
    INSERT INTO bcts_reporting.forestview_v_silviculture_activity SELECT * FROM lrm_replication.v_silviculture_activity;


    TRUNCATE TABLE bcts_reporting.forestview_v_silviculture_activity_test1;
    INSERT INTO bcts_reporting.forestview_v_silviculture_activity_test1 SELECT * FROM lrm_replication.v_silviculture_activity_test1;


    TRUNCATE TABLE bcts_reporting.forestview_v_silviculture_amendment;
    INSERT INTO bcts_reporting.forestview_v_silviculture_amendment SELECT * FROM lrm_replication.v_silviculture_amendment;


    TRUNCATE TABLE bcts_reporting.forestview_v_silviculture_overlay_xref;
    INSERT INTO bcts_reporting.forestview_v_silviculture_overlay_xref SELECT * FROM lrm_replication.v_silviculture_overlay_xref;


    TRUNCATE TABLE bcts_reporting.forestview_v_silviculture_prescription;
    INSERT INTO bcts_reporting.forestview_v_silviculture_prescription SELECT * FROM lrm_replication.v_silviculture_prescription;


    TRUNCATE TABLE bcts_reporting.forestview_v_silviculture_stocking_status;
    INSERT INTO bcts_reporting.forestview_v_silviculture_stocking_status SELECT * FROM lrm_replication.v_silviculture_stocking_status;


    TRUNCATE TABLE bcts_reporting.forestview_v_silviculture_stratum_history;
    INSERT INTO bcts_reporting.forestview_v_silviculture_stratum_history SELECT * FROM lrm_replication.v_silviculture_stratum_history;


    TRUNCATE TABLE bcts_reporting.forestview_v_silv_project;
    INSERT INTO bcts_reporting.forestview_v_silv_project SELECT * FROM lrm_replication.v_silv_project;


    TRUNCATE TABLE bcts_reporting.forestview_v_silv_project_block;
    INSERT INTO bcts_reporting.forestview_v_silv_project_block SELECT * FROM lrm_replication.v_silv_project_block;


    TRUNCATE TABLE bcts_reporting.forestview_v_silv_stockstat_history;
    INSERT INTO bcts_reporting.forestview_v_silv_stockstat_history SELECT * FROM lrm_replication.v_silv_stockstat_history;


    TRUNCATE TABLE bcts_reporting.forestview_v_species_composition;
    INSERT INTO bcts_reporting.forestview_v_species_composition SELECT * FROM lrm_replication.v_species_composition;


    TRUNCATE TABLE bcts_reporting.forestview_v_species_composition_hist;
    INSERT INTO bcts_reporting.forestview_v_species_composition_hist SELECT * FROM lrm_replication.v_species_composition_hist;


    TRUNCATE TABLE bcts_reporting.forestview_v_stocking_standard;
    INSERT INTO bcts_reporting.forestview_v_stocking_standard SELECT * FROM lrm_replication.v_stocking_standard;


    TRUNCATE TABLE bcts_reporting.forestview_v_stratum_status;
    INSERT INTO bcts_reporting.forestview_v_stratum_status SELECT * FROM lrm_replication.v_stratum_status;


    TRUNCATE TABLE bcts_reporting.forestview_v_su;
    INSERT INTO bcts_reporting.forestview_v_su SELECT * FROM lrm_replication.v_su;


    TRUNCATE TABLE bcts_reporting.forestview_v_su_eco_allocation;
    INSERT INTO bcts_reporting.forestview_v_su_eco_allocation SELECT * FROM lrm_replication.v_su_eco_allocation;


    TRUNCATE TABLE bcts_reporting.forestview_v_su_layer;
    INSERT INTO bcts_reporting.forestview_v_su_layer SELECT * FROM lrm_replication.v_su_layer;


    TRUNCATE TABLE bcts_reporting.forestview_v_su_stratum_allocation;
    INSERT INTO bcts_reporting.forestview_v_su_stratum_allocation SELECT * FROM lrm_replication.v_su_stratum_allocation;


    TRUNCATE TABLE bcts_reporting.forestview_v_third_party_interest;
    INSERT INTO bcts_reporting.forestview_v_third_party_interest SELECT * FROM lrm_replication.v_third_party_interest;


    TRUNCATE TABLE bcts_reporting.forestview_v_timber_inventory_dip;
    INSERT INTO bcts_reporting.forestview_v_timber_inventory_dip SELECT * FROM lrm_replication.v_timber_inventory_dip;

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

    # Publish reporting objects to the reporting layer
    logging.info("Updating datasets to the reporting layer...")
    publish_datasets()
    logging.info("Datasets in the reporting layer have been updated!")


    # Clean up
    cursor.close()
    connection.close()
        
