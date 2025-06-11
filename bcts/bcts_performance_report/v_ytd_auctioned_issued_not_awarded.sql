create or replace view bcts_staging.ytd_auctioned_issued_not_awarded as

select business_area_region_category,
business_area_region,
business_area,
sum(first_auction_volume_is_in_report_period) as "Auctioned (First Auction is in Report Period)",
sum(issued_licence_volume) as "Licence Issued",
sum(last_auction_no_sale_volume) as "Not Awarded (Last Auction in Report Period is No Sale)",
sum(first_auction_category_2_and_4_volume_is_in_report_period) as "Auctioned (First Auction is in Report Period): Category 2/4",
sum(category_2_and_4_issued_volume) as "Licence Issued: Cat 2/4",
sum(last_auction_no_sale_category_2_4_volume) as "Not Awarded: Category 2/4"
from bcts_staging.licence_issued_advertised_main
group by business_area_region_category,
business_area_region,
business_area;
