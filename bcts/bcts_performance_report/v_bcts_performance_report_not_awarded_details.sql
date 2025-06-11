
create or replace view bcts_staging.v_bcts_performance_report_not_awarded_details as
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
