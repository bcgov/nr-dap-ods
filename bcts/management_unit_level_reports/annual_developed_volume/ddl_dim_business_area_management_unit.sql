-- drop table if exists bcts_staging.dim_business_area_management_unit;
-- create table bcts_staging.dim_business_area_management_unit as
-- select business_area_region_category, business_area_region, 
-- CASE
--         WHEN business_area IN ('Prince George (TPG)', 'Stuart-Nechako (TSN)')
--             THEN 'Omineca (TPG-TSN)'
-- 			when business_area = 'Seaward-tlasta (TST)' then 'Seaward-Tlasta (TST)'
--         ELSE business_area
--     END AS business_area,
-- case when business_area = 'Seaward-tlasta (TST)' then 'Seaward-Tlasta (TST)' else business_area end AS business_area_reporting_unit,
-- case when business_area = 'Seaward-tlasta (TST)' then 'Seaward-Tlasta (TST)' else business_area end || '-' || trim(manu_id) as management_unit,
-- CASE
--         WHEN business_area_region = 'North Interior' THEN 1
--         WHEN business_area_region = 'South Interior' THEN 2
--         WHEN business_area_region = 'Coast' THEN 3
--     END AS business_area_region_sort_order,

--     CASE
--         WHEN business_area_region_category = 'Interior' THEN 1
--         ELSE 2
--     END AS business_area_region_cat_sort_order
-- from bcts_staging.annual_developed_volume_hist
-- group by business_area_region_category, business_area_region,
-- CASE
--         WHEN business_area IN ('Prince George (TPG)', 'Stuart-Nechako (TSN)')
--             THEN 'Omineca (TPG-TSN)'
-- 			when business_area = 'Seaward-tlasta (TST)' then 'Seaward-Tlasta (TST)'
--         ELSE business_area end,
-- 		business_area,
-- 		trim(manu_id)
-- order by business_area;

-- GRANT SELECT ON bcts_staging.dim_business_area_management_unit TO BCTS_DEV_ROLE;

-- GRANT SELECT ON bcts_staging.dim_business_area_management_unit TO proxy_bcts_bi;

-- GRANT SELECT ON bcts_staging.dim_business_area_management_unit TO BCTS_ANALYST_ROLE;





create or replace view bcts_staging.dim_business_area_management_unit as
with src as (
    select
        business_area_region_category,
        business_area_region,
        case
            when business_area in ('Prince George (TPG)', 'Stuart-Nechako (TSN)')
                then 'Omineca (TPG-TSN)'
            when business_area = 'Seaward-tlasta (TST)'
                then 'Seaward-Tlasta (TST)'
            else business_area
        end as business_area,
        case
            when business_area = 'Seaward-tlasta (TST)'
                then 'Seaward-Tlasta (TST)'
            else business_area
        end as business_area_reporting_unit,
        case
            when business_area = 'Seaward-tlasta (TST)'
                then 'Seaward-Tlasta (TST)'
            else business_area
        end || '-' || trim(manu_id) as management_unit,
        case
            when business_area_region = 'North Interior' then 1
            when business_area_region = 'South Interior' then 2
            when business_area_region = 'Coast' then 3
        end as business_area_region_sort_order,
        case
            when business_area_region_category = 'Interior' then 1
            else 2
        end as business_area_region_cat_sort_order
    from bcts_staging.annual_developed_volume_hist
)
select
    business_area_region_category,
    business_area_region,
    business_area,
    business_area_reporting_unit,
    management_unit,
    business_area_region_sort_order,
    business_area_region_cat_sort_order
from (
    select
        src.*,
        row_number() over (
            partition by management_unit
            order by management_unit
        ) rn
    from src
) d
where rn = 1;

GRANT SELECT ON bcts_staging.dim_business_area_management_unit TO BCTS_DEV_ROLE;

GRANT SELECT ON bcts_staging.dim_business_area_management_unit TO proxy_bcts_bi;

GRANT SELECT ON bcts_staging.dim_business_area_management_unit TO BCTS_ANALYST_ROLE;
