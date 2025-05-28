
def get_licence_issued_advertised_main_query():
    return \
    f"""

    /* qLicenceIssuedAdvertised_main */
    INSERT INTO BCTS_STAGING.licence_issued_advertised_main_hist (TODO: FILL COLUMNS HERE)
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
        Official.report_frequency,
        Official.report_start_date,
        Official.report_end_date,
        Official.fiscal_year
    FROM
        bcts_staging.licence_issued_advertised_official AS official
        LEFT JOIN bcts_staging.v_licence_issued_advertised_lrm AS lrm
        ON official.forest_file_id = lrm.licence_id
    ;
"""
