create or replace view bcts_staging.bcts_performance_report_ytd_all as
with bcts_performance_report_ytd_all as (
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
  GREATEST(
    "Q1 Licence Issued Target",
    "Q2 Licence Issued Target",
    "Q3 Licence Issued Target",
    "Currently in Market",
    "Auctioned",
    "Licence Issued"
  ) as y_max,
   greatest(
    sum("Q1 Licence Issued Target") over (partition by business_area_region),
    sum("Q2 Licence Issued Target") over (partition by business_area_region),
    sum("Q3 Licence Issued Target") over (partition by business_area_region),
    sum("Licence Issued") over (partition by business_area_region),
    sum("Licence Issued: Value Added") over (partition by business_area_region),
    sum("Not Awarded") over (partition by business_area_region),
    sum("Not Awarded: Value Added") over (partition by business_area_region),
    sum("Auctioned") over (partition by business_area_region),
    sum("Auctioned: Value Added") over (partition by business_area_region)
  ) as y_max_region
from bcts_performance_report_ytd_all;
