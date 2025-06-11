create or replace view bcts_staging.recent_auctions_chart_2 as

select 
  'Licence Issued' as metric,
  sum(issued_licence_volume) - sum(category_2_and_4_issued_volume) as "Total Excluding Value Added",
  sum(issued_licence_volume) as "Total",
  sum(category_2_and_4_issued_volume)  as "Value Added"
from bcts_staging.licence_issued_advertised_main
where include_in_semi_monthly_report = 'Y'

union all

select 
  'Not Awarded' as metric,
  sum(last_auction_no_sale_volume) - sum(last_auction_no_sale_category_2_4_volume) as "Total Excluding Value Added",
  sum(last_auction_no_sale_volume) as "Total",
  sum(last_auction_no_sale_category_2_4_volume)  as "Value Added"
from bcts_staging.licence_issued_advertised_main
where include_in_semi_monthly_report = 'Y'

