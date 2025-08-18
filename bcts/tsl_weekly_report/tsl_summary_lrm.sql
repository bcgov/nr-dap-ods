
-- DROP TABLE IF EXISTS bcts_staging.tsl_summary_lrm;

CREATE TABLE IF NOT EXISTS bcts_staging.tsl_summary_lrm
(
    licence_id character varying(15) COLLATE pg_catalog."default",
    geographic_location character varying(4000) COLLATE pg_catalog."default",
    field_team character varying(150) COLLATE pg_catalog."default",
    species text COLLATE pg_catalog."default",
    report_run_date DATE DEFAULT CURRENT_DATE
)
