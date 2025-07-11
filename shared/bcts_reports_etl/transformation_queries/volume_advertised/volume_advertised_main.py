
def get_volume_advertised_main_query():
    return \
    f"""

    /* qAdvertised_Official */
    INSERT INTO BCTS_STAGING.volume_advertised_main_hist (
	business_area_region_category, business_area_region, business_area, business_area_code, mgmt_unit_type, mgmt_unit_id, nav_name, district_name, 
    field_team, geographiclocation, operatingarea, description, forest_file_id, bcts_category_code, category, auction_date, auction_date_fiscal, 
    auction_date_quarter, lrm_auction_date, lrm_auction_status, sale_volume, fta_volume, lrm_total_volume, lrm_cruise_volume, lrm_rw_volume, 
    lrm_total_volume_salvage_all_fire_years, lrm_total_volume_salvage_2021_fire, lrm_total_volume_salvage_2022_fire, lrm_total_volume_salvage_2023_fire, 
    lrm_total_volume_salvage_2024_fire, lrm_total_volume_salvage_2025_fire, client_count, eligible_client_count, ineligible_client_count, client_count_eligibility_indicator_missing, file_status_st, awarded_ind, no_sale_rationale_code, no_sale_rationale, lrm_auc_fiscal, lrm_auc_quarter, first_auction_date, last_auction_date, auction_count, first_auction, last_auction, last_auction_no_sale, report_start_date, report_end_date, fiscal_year
    )
    SELECT
        AD.BUSINESS_AREA_REGION_CATEGORY,
        AD.BUSINESS_AREA_REGION,
        AD.BUSINESS_AREA,
        AD.Business_Area_Code,
        AD.MGMT_UNIT_TYPE,
        AD.MGMT_UNIT_ID,
        LRM.NAV_NAME,
        LRM.DISTRICT_NAME,
        LRM.FIELD_TEAM,
        LRM.GEOGRAPHICLOCATION,
        LRM.OperatingArea,
        AD.DESCRIPTION,
        AD.FOREST_FILE_ID,
        AD.BCTS_CATEGORY_CODE,
        AD.CATEGORY,
        AD.AUCTION_DATE,
        AD.Auction_Date_Fiscal,
        AD.Auction_Date_Quarter,
        LRM.LRM_AUCTION_DATE,
        LRM.LRM_AUCTION_STATUS,
        AD.SALE_VOLUME,
        AD.FTA_VOLUME,
        -- ECAS data is not replicated in ODS as on 2025-07-11. These fields are not currently used in any of the BCTS reports.
        # null as ECAS_Total_Volume,
        # null as ECAS_Cruise_Volume,
        # null as ECAS_Deciduous_Volume,
        # null as ECAS_Decked_Volume,
        # null as ECAS_RW_Volume,
        LRM.LRM_TOTAL_VOLUME,
        LRM.LRM_CRUISE_VOLUME,
        LRM.LRM_RW_VOLUME,
        LRM.LRM_TOTAL_VOLUME_SALVAGE_ALL_FIRE_YEARS,
        LRM.LRM_TOTAL_VOLUME_SALVAGE_2021_FIRE,
        LRM.LRM_TOTAL_VOLUME_SALVAGE_2022_FIRE,
        LRM.LRM_TOTAL_VOLUME_SALVAGE_2023_FIRE,
        LRM.LRM_TOTAL_VOLUME_SALVAGE_2024_FIRE,
        LRM.LRM_TOTAL_VOLUME_SALVAGE_2025_FIRE,
        AD.Client_Count,
        Ad.Eligible_Client_Count,
        Ad.Ineligible_Client_Count,
        Ad.Client_Count_Eligibility_Indicator_Missing,
        AD.FILE_STATUS_ST,
        AD.awarded_ind,
        AD.NO_SALE_RATIONALE_CODE,
        ad.no_sale_rationale,
        -- Fiscal year: if month >= 4, use year of date; else, subtract 1
        EXTRACT(YEAR FROM (LRM.LRM_AUCTION_DATE + INTERVAL '9 months')) AS lrm_auc_fiscal,
        -- Fiscal quarter: if fiscal year starts in April, shift date by -3 months and calculate quarter
        'Q' || CEIL(EXTRACT(MONTH FROM (LRM.LRM_AUCTION_DATE + INTERVAL '-3 months')) / 3.0) AS lrm_auc_quarter,
        ad.first_auction_date,
        ad.last_auction_date,
        AD.AUCTION_COUNT,
        ad.first_auction,
        ad.last_auction,
        ad.last_auction_no_sale,
        ad.report_start_date,
        ad.report_end_date,
        ad.fiscal_year,
        ad.report_run_date

        # null as ECAS_ID,
        # null as appraisal_effective_date,
        # null as ECAS_Status,
        # null as haul_distance,
        # null as weighted_haul_distance,
        # null as truck_haul_primary_cycle_time,
        # null as truck_haul_second_cycle_time,
        # null as total_non_scenario_appraisals_same_effective_date
    FROM
        bcts_staging.volume_advertised_official AS AD
        LEFT JOIN bcts_staging.v_volume_advertised_lrm AS LRM ON AD.FOREST_FILE_ID = LRM.LICENCE_ID
    ORDER BY
        -- len(business_area_region) DESC,
        business_area_region,
        business_area,
        nav_name,
        field_team,
        forest_file_id,
        auction_date;
    
"""
