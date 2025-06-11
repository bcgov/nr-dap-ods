create or replace view bcts_staging.currently_in_market_summary as

select business_area_region_category,
business_area_region,
business_area,
sum(lrm_total_volume) as "Currently in Market",
sum(lrm_total_volume_cat_2_4) as "Volume: Value Added",
count(licence_id) as "Number of Auctions",
count(lrm_total_volume_cat_2_4) as "Number of Auctions Value Added"
from bcts_staging.currently_in_market
group by business_area_region_category,
business_area_region,
business_area;
