CREATE TABLE IF NOT EXISTS ods_data_management.audit_batch_status
(
    object_name character varying(100) COLLATE pg_catalog."default",
    application_name character varying(100) COLLATE pg_catalog."default",
    etl_layer character varying(100) COLLATE pg_catalog."default",
    object_execution_status character varying(100) COLLATE pg_catalog."default",
    batch_run_date character varying(100) COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS ods_data_management.audit_batch_status
    OWNER to ods_admin_user;

COMMENT ON TABLE ods_data_management.audit_batch_status IS 'Table to track the execution status of ELT process by batch.';

COMMENT ON COLUMN ods_data_management.audit_batch_status.object_name IS 'Name of the object, usually a table or view, being processed in batch.';
COMMENT ON COLUMN ods_data_management.audit_batch_status.application_name IS 'Name of the application associated with the object. This value should match the IRS/CMDB acronym.';
COMMENT ON COLUMN ods_data_management.audit_batch_status.etl_layer IS 'Layer of the ELT process (e.g., replication, transformation).';
COMMENT ON COLUMN ods_data_management.audit_batch_status.object_execution_status IS 'Status of the ELT execution (e.g., success, failure).';
COMMENT ON COLUMN ods_data_management.audit_batch_status.batch_run_date IS 'Most recent date that the batch ELT process took place.';

-- Update 2025-03-25 Added a new column to log the errors
ALTER TABLE ods_data_management.audit_batch_status
ADD COLUMN error_message text NULL;
