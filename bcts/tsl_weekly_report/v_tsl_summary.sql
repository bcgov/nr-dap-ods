-- Final view for reporting in Power BI
-- This view aggregates TSL data by business area region and summarizes various metrics related to TSLs (Timber Sale Licences).

create or replace view bcts_reporting.v_tsl_summary as
select business_area_region, 
sum(volume_advertised_m3) as "Volume Auctioned",
sum(case when no_bid_info='N' then volume_advertised_m3 else 0 end) as "Volume Awarded",
sum(case when readvertised_auction='N' then volume_advertised_m3 else 0 end) as "Volume that has been offered once",
count(case when no_bid='' then licence_number else null end) as "Number of TSLs that received a bid",
sum(case when no_bid_info='' then volume_advertised_m3 else 0 end) as "Volume of TSLs that did not receive a bid",
count(case when no_bid_info='' then licence_number else null end) as "Number of TSLs that did not receive a bid",
sum(case when auctioned_bcts_category_code='4' then volume_advertised_m3 else 0 end) as "Volume of value added (category 4) TSLs auctioned",
count(case when auctioned_bcts_category_code='4' then licence_number else null end) as "Number of value added (category 4) TSLs auctioned"
from bcts_reporting.tsl_summary_main
group by business_area_region;
