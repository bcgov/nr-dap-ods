-- Final view for reporting in Power BI
-- This view aggregates TSL data by business area region and summarizes various metrics related to TSLs (Timber Sale Licences).

create or replace view bcts_reporting.v_tsl_summary as
with tsl_summary as
(
select business_area_region_category,
business_area_region,
business_area,
sum(volume_advertised_m3) as "Total Volume Auctioned (Including Re-auctions)",
sum(case when readvertised_auction='N' then volume_advertised_m3 else 0 end) as "Volume Auctioned (First Auction Only)",
sum(case when readvertised_auction='Y' then volume_advertised_m3 else 0 end) as "Volume Re-auctioned",
sum(case when no_bid_info='N' then volume_advertised_m3 else 0 end) as "Licence Issued",
count(case when no_bid='' then licence_number else null end) as "Number of Licence Issued",
sum(case when no_bid_info='' then volume_advertised_m3 else 0 end) as "Volume Not Awarded",
count(case when no_bid_info='' then licence_number else null end) as "Number of Licence Not Awarded",
sum(case when auctioned_bcts_category_code='4' then volume_advertised_m3 else 0 end) as "Volume of Value Added (Category 4) Auctioned",
count(case when auctioned_bcts_category_code='4' then licence_number else null end) as "Number of Value Added (Category 4) Licence Auctioned"
from bcts_reporting.tsl_summary_main
group by business_area_region_category, business_area_region, business_area
)
select 
    business_area_region_category,
    business_area_region,
    business_area,
    "Total Volume Auctioned (Including Re-auctions)",
    "Volume Auctioned (First Auction Only)",
    "Volume Re-auctioned",
    "Licence Issued",
    "Number of Licence Issued",
    "Volume Not Awarded",
    "Number of Licence Not Awarded",
    "Volume of Value Added (Category 4) Auctioned",
    "Number of Value Added (Category 4) Licence Auctioned",
    case when business_area_region = 'North Interior' then 1
         when business_area_region = 'South Interior' then 2
         when business_area_region = 'Coast' then 3
    end as business_area_region_sort_order
from tsl_summary;
