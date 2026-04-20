
def get_stumpage_rate_main_query():
    return \
    f"""
    INSERT INTO BCTS_STAGING.stumpage_rate_main_hist (
    	licence_id, tso_name, acti_variable_cost_upset, acti_total_cost_upset, acti_mps70, business_area_region_category, business_area_region, business_area, business_area_code, forest_file_id, bcts_category_code, auction_date, legal_effective_dt, sale_volume, upset_rate, total_upset_value, bonus_bid, bonus_offer, client_count, file_status_st, total_stumpage_m3, total_stumpage_value, report_start_date, report_end_date, report_run_date)
   )
    SELECT
        lrm.*,
        official.*
    FROM bcts_staging.stumpage_rate_official AS official
    LEFT JOIN bcts_staging.stumpage_rate_lrm AS lrm 
        ON official.forest_file_id = lrm.LICENCE_ID
    ORDER BY
        official.auction_date DESC;
        
    """
