-- Table: bcts_staging.annual_development_ready

-- DROP TABLE IF EXISTS bcts_staging.annual_development_ready_hist;

CREATE TABLE IF NOT EXISTS bcts_staging.annual_development_ready_hist
(
    business_area_region_category text COLLATE pg_catalog."default",
    business_area_region text COLLATE pg_catalog."default",
    business_area text COLLATE pg_catalog."default",
    business_area_code character varying(15) COLLATE pg_catalog."default",
    field_team character varying(150) COLLATE pg_catalog."default",
    manu_id character varying(60) COLLATE pg_catalog."default",
    licence character varying(15) COLLATE pg_catalog."default",
    tenure character varying(40) COLLATE pg_catalog."default",
    perm character varying(40) COLLATE pg_catalog."default",
    mark character varying(15) COLLATE pg_catalog."default",
    block_id character varying(20) COLLATE pg_catalog."default",
    ubi character varying(15) COLLATE pg_catalog."default",
    block_state character varying(20) COLLATE pg_catalog."default",
    cruise_volume numeric(15,6),
    rw_volume numeric(15,6),
    dr_done date,
    rc_status text COLLATE pg_catalog."default",
    rc_status_date date,
    dvs_status text COLLATE pg_catalog."default",
    dvs_status_date date,
    dvc_status text COLLATE pg_catalog."default",
    dvc_status_date date,
    licn_seq_nbr numeric(15,0),
    cutb_seq_nbr numeric(15,0),
    fiscal_year_start_date date,
    report_end_date date
)

