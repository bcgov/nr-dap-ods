-- DROP TABLE IF EXISTS bcts_staging.weighted_sale_term_hist;

CREATE TABLE IF NOT EXISTS bcts_staging.weighted_sale_term_hist
(
    business_area_region_category text COLLATE pg_catalog."default",
    business_area_region text COLLATE pg_catalog."default",
    business_area text COLLATE pg_catalog."default",
    auction_fiscal numeric,
    awarded_licence_volume_class text COLLATE pg_catalog."default",
    sum_awarded_licence_volume numeric,
    sum_awarded_licence_volume_x_tenure_term numeric,
    weighted_tenure_term numeric,
    count_awarded_licences bigint,
    report_start_date date,
    report_end_date date,
    report_run_date date,
    report_run_timestamp timestamp without time zone
)

TABLESPACE pg_default;
