-- DROP TABLE IF EXISTS bcts_staging.currently_in_market_hist;

CREATE TABLE IF NOT EXISTS bcts_staging.currently_in_market_hist
(
    business_area_region_category text COLLATE pg_catalog."default",
    business_area_region text COLLATE pg_catalog."default",
    business_area text COLLATE pg_catalog."default",
    business_area_code character varying(15) COLLATE pg_catalog."default",
    nav_name character varying COLLATE pg_catalog."default",
    field_team character varying COLLATE pg_catalog."default",
    licence_id character varying COLLATE pg_catalog."default",
    tenure character varying COLLATE pg_catalog."default",
    lrm_category_code character varying COLLATE pg_catalog."default",
    lrm_category_description character varying COLLATE pg_catalog."default",
    lrm_category text COLLATE pg_catalog."default",
    lrm_tender_posted_done_status text COLLATE pg_catalog."default",
    lrm_tender_posted_done_date timestamp without time zone,
    lrm_licence_awarded_done_date timestamp without time zone,
    lrm_auction_done_date timestamp without time zone,
    lrm_total_volume numeric,
    lrm_total_volume_cat_a numeric,
    lrm_total_volume_cat_2_4 numeric,
    licn_seq_nbr numeric,
    include_in_currently_in_market_report text COLLATE pg_catalog."default",
    in_currentlyinmarket_query text COLLATE pg_catalog."default",
    on_bc_bid text COLLATE pg_catalog."default",
    data_error text COLLATE pg_catalog."default",
    report_end_date date,
    report_run_date DATE DEFAULT CURRENT_DATE,
    report_run_timestamp timestamp DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'PST')
);

