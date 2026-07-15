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


CREATE OR REPLACE VIEW bcts_staging.dim_business_area AS

SELECT DISTINCT
    business_area_region_category,
    business_area_region,

    CASE
        WHEN business_area IN ('Prince George (TPG)', 'Stuart-Nechako (TSN)')
            THEN 'Omineca (TPG-TSN)'
        ELSE business_area
    END AS business_area,

    business_area AS business_area_reporting_unit,

    CASE
        WHEN business_area_region = 'North Interior' THEN 1
        WHEN business_area_region = 'South Interior' THEN 2
        WHEN business_area_region = 'Coast' THEN 3
    END AS business_area_region_sort_order,

    CASE
        WHEN business_area_region_category = 'Interior' THEN 1
        ELSE 2
    END AS business_area_region_cat_sort_order

FROM bcts_staging.bcts_adv_targets;

GRANT SELECT ON bcts_staging.dim_business_area TO BCTS_DEV_ROLE;
GRANT SELECT ON bcts_staging.dim_business_area TO proxy_bcts_bi;
