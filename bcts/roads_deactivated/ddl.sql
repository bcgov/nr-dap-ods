-- Table: bcts_staging.roads_deactivated_hist

-- DROP TABLE IF EXISTS bcts_staging.roads_deactivated_hist;

CREATE TABLE IF NOT EXISTS bcts_staging.roads_deactivated_hist
(
    business_area_region_category text COLLATE pg_catalog."default",
    business_area_region text COLLATE pg_catalog."default",
    business_area text COLLATE pg_catalog."default",
    business_area_code character varying(15) COLLATE pg_catalog."default",
    field_team_desc character varying(150) COLLATE pg_catalog."default",
    road_seq_nbr numeric(16,0),
    road_road_name character varying(204) COLLATE pg_catalog."default",
    uri character varying(30) COLLATE pg_catalog."default",
    poc numeric,
    pot numeric,
    length numeric,
    rcls_accounting_type character varying(320) COLLATE pg_catalog."default",
    rdst_steward_name character varying(200) COLLATE pg_catalog."default",
    deac_end_date timestamp without time zone,
    deac_level_type character varying(96) COLLATE pg_catalog."default",
    deac_method_type character varying(60) COLLATE pg_catalog."default",
    fiscal_year_start_date date,
    report_end_date date,
    report_run_date DATE DEFAULT CURRENT_DATE
);
