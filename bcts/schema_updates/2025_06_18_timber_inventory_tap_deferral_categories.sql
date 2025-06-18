delete from bcts_staging.old_growth_tap_deferral_categories;

-- Upload the updated tap deferral categories data


-- Add the new columns
alter table bcts_staging.timber_inventory_ready_to_sell_hist
add column ancient text,
add column    remnant text,
add column    big_treed text,
add column    ancient_volume numeric,
add column    remnant_volume numeric,
add column    big_treed_volume numeric;

-- Remove latest data to force trigger ETL
delete
from bcts_staging.timber_inventory_ready_to_sell_hist
where report_end_date = '2025-05-31';

