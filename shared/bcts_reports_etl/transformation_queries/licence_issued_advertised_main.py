
def get_licence_issued_advertised_main_query():
    return \
    f"""

    /* qLicenceIssuedAdvertised_main */
    INSERT INTO BCTS_STAGING.licence_issued_advertised_main_hist (
    	business_area_region_category, business_area_region, business_area, management_unit, district, x_axis_date, x_axis_fiscal, x_axis_quarter, licence, file_type_code, auction_count_all_time_to_report_period_end, first_auction_date, first_auction_fiscal, first_auction_quarter, first_bcts_category_code, first_auction_volume, first_auction_category_a_and_1_volume, first_auction_category_2_and_4_volume, first_auction_volume_is_in_report_period, first_auction_category_a_and_1_volume_is_in_report_period, first_auction_category_2_and_4_volume_is_in_report_period, last_auction_date, last_auction_fiscal, last_auction_quarter, last_auction_bcts_category_code, last_auction_volume, last_auction_category_a_and_1_volume, last_auction_category_2_and_4_volume, original_cat_2_and_4_readvertised_cat_a_and_1_volume, original_cat_a_and_1_readvertised_cat_2_and_4_volume, last_auction_no_sale_rationale, last_auction_no_sale_volume, last_auction_no_sale_category_a_1_volume, last_auction_no_sale_category_2_4_volume, last_auction_no_sale, last_auction_no_sale_cat_a, last_auction_no_sale_cat_2_4, issued_licence_legal_effective_date, issued_licence_legal_effective_fiscal, issued_licence_legal_effective_quarter, issued_licence_bcts_category_code, issued_licence_volume, category_a_and_1_issued_volume, category_2_and_4_issued_volume, issued_licence_maximum_value, issued_licence_maximum_value_cat_a, issued_licence_maximum_value_cat_2_4, issued_licence_client_number, issued_licence_client_name, issued_in_report_period, issued_in_report_period_cat_a, issued_in_report_period_cat_2_4, advertised_in_report_period, total_volume_salvage_all_fire_year_lrm, fta_file_status, fta_file_status_date, report_start_date, report_end_date, fiscal_year, semi_monthly_report_start_date, include_in_semi_monthly_report
    )
    SELECT
        official.Business_Area_Region_Category,
        official.Business_Area_Region,
        official.Business_Area,
        lrm.Management_Unit,
        lrm.District,
        Official.X_Axis_Date,
        Official.X_Axis_Fiscal,
        Official.X_Axis_Quarter,
        official.forest_file_id AS Licence,
        official.File_Type_Code,
        Official.Auction_Count_All_Time_to_Report_Period_End,
        Official.First_Auction_Date,
        Official.First_Auction_Fiscal,
        Official.First_Auction_Quarter,
        Official.First_BCTS_Category_Code,
        Official.First_Auction_Volume,
        Official.First_Auction_Category_A_and_1_Volume,
        Official.First_Auction_Category_2_and_4_Volume,
        Official.First_Auction_Volume_is_in_Report_Period,
        Official.First_Auction_Category_A_and_1_Volume_is_in_Report_Period,
        Official.First_Auction_Category_2_and_4_Volume_is_in_Report_Period,
        Official.Last_Auction_Date,
        Official.Last_Auction_Fiscal,
        Official.Last_Auction_Quarter,
        Official.Last_Auction_BCTS_Category_Code,
        Official.Last_Auction_Volume,
        Official.Last_Auction_Category_A_and_1_Volume,
        Official.Last_Auction_Category_2_and_4_Volume,
        Official.Original_Cat_2_and_4_Readvertised_Cat_A_and_1_Volume,
        Official.Original_Cat_A_and_1_Readvertised_Cat_2_and_4_Volume,
        Official.Last_Auction_No_Sale_Rationale,
        Official.Last_Auction_No_Sale_Volume,
        Official.Last_Auction_No_Sale_Category_A_1_Volume,
        Official.Last_Auction_No_Sale_Category_2_4_Volume,
        Official.Last_Auction_No_Sale,
        Official.Last_Auction_No_Sale_Cat_A,
        Official.Last_Auction_No_Sale_Cat_2_4,
        Official.Issued_Licence_Legal_Effective_Date,
        Official.Issued_Licence_Legal_Effective_Fiscal,
        Official.Issued_Licence_Legal_Effective_Quarter,
        Official.Issued_Licence_BCTS_Category_Code,
        Official.Issued_Licence_Volume,
        Official.Category_A_and_1_Issued_Volume,
        Official.Category_2_and_4_Issued_Volume,
        Official.Issued_Licence_Maximum_Value,
        Official.Issued_licence_maximum_value_Cat_A,
        Official.Issued_licence_maximum_value_Cat_2_4,
        Official.Issued_Licence_Client_Number,
        Official.Issued_Licence_Client_Name,
        official.Issued_in_Report_Period,
        Official.Issued_in_Report_Period_Cat_A,
        Official.Issued_in_Report_Period_Cat_2_4,
        official.Advertised_in_Report_Period,
        round(lrm.LRM_Total_Volume_Salvage_All_Fire_Years) AS Total_Volume_Salvage_All_Fire_Year_LRM,
        Official.FTA_File_Status,
        Official.FTA_File_Status_Date,
        Official.bidder_COUNT
        Official.report_start_date,
        Official.report_end_date,
        Official.fiscal_year,
        CASE 
            WHEN EXTRACT(DAY FROM report_end_date) = 15 THEN 
                (report_end_date - INTERVAL '14 days')::date
            ELSE 
                (date_trunc('month', report_end_date) + INTERVAL '15 days')::date
        END AS semi_monthly_report_start_date,
        CASE 
            WHEN x_axis_date >= (CASE 
                                    WHEN EXTRACT(DAY FROM report_end_date) = 15 THEN 
                                        (report_end_date - INTERVAL '14 days')::date
                                    ELSE 
                                        (date_trunc('month', report_end_date) + INTERVAL '15 days')::date
                                END) THEN 'Y'
            ELSE 'N'
        END AS include_in_semi_monthly_report

    FROM
        bcts_staging.licence_issued_advertised_official AS official
        LEFT JOIN bcts_staging.v_licence_issued_advertised_lrm AS lrm
        ON official.forest_file_id = lrm.licence_id
    ;
"""
