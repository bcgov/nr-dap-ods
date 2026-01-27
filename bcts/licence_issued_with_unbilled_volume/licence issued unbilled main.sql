CREATE OR REPLACE VIEW bcts_staging.licence_issued_with_unbilled_volume_main AS
SELECT
    official.Business_Area_Region_Category,
    official.Business_Area_Region,
    official.Business_Area,
    LRM.Field_Team,
    official.forest_file_id AS Licence_ID,
    official.File_Type_Code AS Tenure_Type_FTA,
    official.Cruise_Based_Ind,
    official.FTA_File_Status,
    official.Client_Number,
    official.Client,
    official.FTA_File_Status_Date,
    official.Legal_Effective_Date_FTA,
    official.Legal_Effective_Fiscal_FTA,
    LRM.Issued_Done_LRM,
    LRM.Issued_Done_Fiscal_LRM,
    official.Initial_Expiry_FTA,
    official.Current_Expiry_FTA,
    official.Expiry_FTA,
    LRM.Expire_Extend_LRM,
    official.Advertised_Licence_Term,
    official.Extension_Term,
    official.Total_Tenure_Term,
    official.Sale_Volume,
    official.Billed_Volume,
    official.Unbilled_Volume,
    official.Percent_Unbilled,
    LRM.licn_seq_nbr,
    LRM.Last_Logging_Started_Date,
    LRM.Last_Logging_Completed_Date,
    LRM.Harvesting_Status,
    official.report_date,
    official.effective_date_add_20_flag * official.Unbilled_Volume AS Unbilled_Volume_over_20_month,
    official.Unbilled_Volume * official.expire_date_minus_6_flag AS Unbilled_Volume_expire_in_6_month
FROM
    bcts_staging.licence_issued_with_unbilled_volume_Official AS official
    LEFT JOIN bcts_staging.licence_issued_with_unbilled_volume_lrm AS lrm ON official.forest_file_id = lrm.licence_id
WHERE
    lrm.Substantial_Completion_Done_LRM IS NULL
ORDER BY
    official.Business_Area_Region_Category DESC,
    official.Business_Area_Region,
    official.Business_Area,
    LRM.Field_Team,
    official.forest_file_id;
