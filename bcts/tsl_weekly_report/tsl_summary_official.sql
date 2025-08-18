-- DROP TABLE IF EXISTS bcts_staging.tsl_summary_official;

CREATE TABLE IF NOT EXISTS bcts_staging.tsl_summary_official
(
    business_area_region_category text COLLATE pg_catalog."default",
    business_area_region text COLLATE pg_catalog."default",
    business_area text COLLATE pg_catalog."default",
    business_area_code character varying(6) COLLATE pg_catalog."default",
    forest_file_id character varying(10) COLLATE pg_catalog."default",
    status text COLLATE pg_catalog."default",
    volume_advertised_m3 numeric,
    volume_readvertised_m3 numeric,
    last_auction_date timestamp without time zone,
    last_auction_bcts_category_code character varying(1) COLLATE pg_catalog."default",
    last_auction_volume numeric(13,1),
    auction_count_all_time_to_report_period_end bigint,
    bidder_count text COLLATE pg_catalog."default",
    readvertised_auction text COLLATE pg_catalog."default",
    no_bid text COLLATE pg_catalog."default",
    no_bid_info text COLLATE pg_catalog."default",
    upset_rate_value numeric,
    bonus_bid_offer numeric,
    report_start_date date,
    report_end_date date,
    report_run_date DATE DEFAULT CURRENT_DATE
)
