-- DROP TABLE IF EXISTS bcts_staging.roads_planned_deactivation_hist;

CREATE TABLE IF NOT EXISTS bcts_staging.roads_planned_deactivation_hist
(
    business_area_region_category text COLLATE pg_catalog."default",
    business_area_region text COLLATE pg_catalog."default",
    business_area text COLLATE pg_catalog."default",
    business_area_code character varying(15) COLLATE pg_catalog."default",
    road_seq_nbr numeric(16,0),
    deac_seq_nbr numeric(15,0),
    uri character varying(30) COLLATE pg_catalog."default",
    road_road_name character varying(204) COLLATE pg_catalog."default",
    field_team_desc character varying(150) COLLATE pg_catalog."default",
    poc numeric,
    pot numeric,
    total_length numeric,
    effective_planned_cost numeric,
    deac_budgeted_cost numeric(15,2),
    deac_budgeted_item_cost numeric,
    rcls_accounting_type character varying(320) COLLATE pg_catalog."default",
    rdst_steward_name character varying(200) COLLATE pg_catalog."default",
    deac_planned_date date,
    deac_end_date timestamp without time zone,
    deac_method_type character varying(60) COLLATE pg_catalog."default",
    deac_level_type character varying(96) COLLATE pg_catalog."default",
    fiscal_year numeric,
    fiscal text COLLATE pg_catalog."default",
    report_end_date date,
    report_run_date date DEFAULT CURRENT_DATE,
    report_run_timestamp timestamp DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'PST')
)
