-- Create the ADV targets table
CREATE TABLE IF NOT EXISTS bcts_staging.bcts_adv_targets (
    business_area_region   text        NOT NULL,  -- e.g., North | South | Coast
    business_area          text        NOT NULL,  -- e.g., "Babine (TBA)"
    adv_target_m3             numeric(12,0) NOT NULL, -- volume in m3; whole numbers
    fiscal_year            text        NOT NULL  -- e.g., "2025-26"
);

-- Updates 2025-12-22
ALTER TABLE bcts_staging.bcts_adv_targets
ADD business_area_region_category VARCHAR(50);

UPDATE bcts_staging.bcts_adv_targets
SET business_area_region_category =
    CASE
        WHEN business_area_region IN ('North Interior', 'South Interior') THEN 'Interior'
        WHEN business_area_region = 'Coast' THEN 'Coast'
        ELSE NULL
    END;


create or replace view bcts_staging.dim_business_area as
select distinct on (business_area_region_category, business_area_region, business_area) business_area_region_category, business_area_region, business_area,
        case when business_area_region = 'North Interior' then 1
            when business_area_region = 'South Interior' then 2
            when business_area_region = 'Coast' then 3
        end as business_area_region_sort_order,
		        case when business_area_region_category in ('North Interior', 'South Interior') then 1
				else 2
        end as business_area_region_cat_sort_order
from bcts_staging.bcts_adv_targets;

GRANT SELECT ON bcts_staging.dim_business_area TO BCTS_DEV_ROLE;
GRANT SELECT ON bcts_staging.dim_business_area TO proxy_bcts_bi;
