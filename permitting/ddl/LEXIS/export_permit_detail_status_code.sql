CREATE TABLE IF NOT EXISTS lexis_replication.export_permit_status_code
(
    export_permit_status_code character varying(3) COLLATE pg_catalog."default" NOT NULL,
    description character varying(120) COLLATE pg_catalog."default" NOT NULL,
    effective_date timestamp(0) without time zone NOT NULL,
    expiry_date timestamp(0) without time zone NOT NULL,
    update_timestamp timestamp(0) without time zone NOT NULL
)

CREATE UNIQUE INDEX IF NOT EXISTS epsc_pk
    ON lexis_replication.export_permit_status_code USING btree
    (export_permit_status_code COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
