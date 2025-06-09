create view bcts_reporting.v_recent_auction_results as

create view bcts_reporting.v_recent_auction_results as
with temp as (
  select 
    business_area_region_category,
    business_area_region,
    business_area,
    sum(issued_licence_volume) as "Licence Issued",
    sum(category_2_and_4_issued_volume) as "Licence Issued: Value Added",
    sum(last_auction_no_sale_volume) as "Not Awarded",
    sum(last_auction_no_sale_category_2_4_volume) as "Not Awarded: Value Added"
  from bcts_reporting.licence_issued_advertised_main
  where include_in_semi_monthly_report = 'Y'
  group by business_area_region_category,
           business_area_region,
           business_area
)

select *,
  greatest(
    "Licence Issued",
    "Licence Issued: Value Added",
    "Not Awarded",
    "Not Awarded: Value Added"
  ) as y_max_business_area,
  
  greatest(
    sum("Licence Issued") over (partition by business_area_region),
    sum("Licence Issued: Value Added") over (partition by business_area_region),
    sum("Not Awarded") over (partition by business_area_region),
    sum("Not Awarded: Value Added") over (partition by business_area_region)
  ) as y_max_region

from temp;
