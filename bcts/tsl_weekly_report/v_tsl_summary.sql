-- Final view for reporting in Power BI
-- This view aggregates TSL data by business area region and summarizes various metrics related to TSLs (Timber Sale Licences).

create or replace view bcts_reporting.v_tsl_summary as
select business_area_region, 
sum(volume_advertised_m3) as "Total Volume Auctioned (Including Re-auctions)",
sum(case when readvertised_auction='N' then volume_advertised_m3 else 0 end) as "Volume Auctioned (First Auction Only)",
sum(case when readvertised_auction='Y' then volume_advertised_m3 else 0 end) as "Volume Re-auctioned",
sum(case when no_bid_info='N' then volume_advertised_m3 else 0 end) as "Licence Issued",
count(case when no_bid='' then licence_number else null end) as "Number of Licence that received a bid",
sum(case when no_bid_info='' then volume_advertised_m3 else 0 end) as "Volume Not Awarded",
count(case when no_bid_info='' then licence_number else null end) as "Number of Licence Not Awarded",
sum(case when auctioned_bcts_category_code='4' then volume_advertised_m3 else 0 end) as "Volume of Value Added (Category 4) Auctioned",
count(case when auctioned_bcts_category_code='4' then licence_number else null end) as "Number of Value Added (Category 4) Licence Auctioned"
from bcts_reporting.tsl_summary_main
group by business_area_region;
