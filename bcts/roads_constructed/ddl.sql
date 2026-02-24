-- Table: bcts_staging.roads_constructed_hist

-- DROP TABLE IF EXISTS bcts_staging.roads_constructed_hist;

CREATE TABLE IF NOT EXISTS bcts_staging.roads_constructed_hist
(
    business_area_region_category text COLLATE pg_catalog."default",
    business_area_region text COLLATE pg_catalog."default",
    business_area text COLLATE pg_catalog."default",
    business_area_code character varying(15) COLLATE pg_catalog."default",
    road_seq_nbr numeric(16,0),
    uri character varying(30) COLLATE pg_catalog."default",
    road_road_name character varying(204) COLLATE pg_catalog."default",
    rcls_accounting_type character varying(320) COLLATE pg_catalog."default",
    poc numeric(13,4),
    pot numeric,
    length numeric,
    rcom_completion_date timestamp without time zone,
    const_method_type character varying(60) COLLATE pg_catalog."default",
    rcom_method character varying(60) COLLATE pg_catalog."default",
    rdst_steward_name character varying(200) COLLATE pg_catalog."default",
    fiscal_year_start_date date,
    report_end_date date,
    report_run_date DATE DEFAULT CURRENT_DATE,
    report_run_timestamp timestamp DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'PST')
);
