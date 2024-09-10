CREATE TABLE IF NOT EXISTS lexis_replication.export_permit_status_code (
	export_permit_status_code CHARACTER VARYING(3) COLLATE pg_catalog. "default" NOT NULL,
	description CHARACTER VARYING(120) COLLATE pg_catalog. "default" NOT NULL,
	effective_date TIMESTAMP(0) without TIME ZONE NOT NULL,
	expiry_date TIMESTAMP(0) without TIME ZONE NOT NULL,
	update_timestamp TIMESTAMP(0) without TIME ZONE NOT NULL
) CREATE UNIQUE INDEX IF NOT EXISTS epsc_pk ON lexis_replication.export_permit_status_code USING btree (
	export_permit_status_code COLLATE pg_catalog. "default" ASC NULLS LAST
) TABLESPACE pg_default;
