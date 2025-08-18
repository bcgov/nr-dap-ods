-- DROP TABLE IF EXISTS bcts_staging.tsl_summary_main_hist;

CREATE TABLE IF NOT EXISTS bcts_staging.tsl_summary_main_hist
(
    business_area_region_category text COLLATE pg_catalog."default",
    business_area_region text COLLATE pg_catalog."default",
    business_area_code character varying(6) COLLATE pg_catalog."default",
    business_area text COLLATE pg_catalog."default",
    licence_number character varying(15) COLLATE pg_catalog."default",
    geographic_location character varying(4000) COLLATE pg_catalog."default",
    field_team character varying(150) COLLATE pg_catalog."default",
    species text COLLATE pg_catalog."default",
    volume_advertised_m3 numeric,
    volume_readvertised_m3 numeric,
    auctioned_bcts_category_code character varying(1) COLLATE pg_catalog."default",
    total_auction_count bigint,
    readvertised_auction text COLLATE pg_catalog."default",
    auction_closing_date timestamp without time zone,
    number_of_bidders text COLLATE pg_catalog."default",
    no_bid text COLLATE pg_catalog."default",
    upset_rate_or_upset_value numeric,
    bonus_bid_or_bonus_value numeric,
    total_stumpage_or_total_stumpage_value numeric,
    no_bid_info text COLLATE pg_catalog."default",
    report_start_date date,
    report_end_date date,
    report_run_date DATE DEFAULT CURRENT_DATE
)
