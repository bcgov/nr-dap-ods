create or replace view bcts_staging.v_bcts_performance_report_licence_issued_details as
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
