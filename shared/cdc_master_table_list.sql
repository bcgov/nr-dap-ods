CREATE TABLE IF NOT EXISTS ods_data_management.cdc_master_table_list
(
    business character varying(100) COLLATE pg_catalog."default",
    application_name character varying(100) COLLATE pg_catalog."default",
    custodian character varying(100) COLLATE pg_catalog."default",
    source_schema_name character varying(100) COLLATE pg_catalog."default",
    source_table_name character varying(100) COLLATE pg_catalog."default",
    target_schema_name character varying(100) COLLATE pg_catalog."default",
    target_table_name character varying(100) COLLATE pg_catalog."default",
    truncate_flag character varying(1) COLLATE pg_catalog."default",
    cdc_flag character varying(1) COLLATE pg_catalog."default",
    full_inc_flag character varying(1) COLLATE pg_catalog."default",
    cdc_column character varying(50) COLLATE pg_catalog."default",
    active_ind character varying(1) COLLATE pg_catalog."default",
    replication_order integer,
    where_clause character varying(1000) COLLATE pg_catalog."default",
    customsql_ind character varying(1) COLLATE pg_catalog."default",
    customsql_query character varying(64000) COLLATE pg_catalog."default",
    replication_source character varying(100) COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS ods_data_management.cdc_master_table_list
    OWNER to ods_admin_user;

COMMENT ON TABLE ods_data_management.cdc_master_table_list IS 'Table providing an overview/summary of all replication processes, change data capture (CDC), and custom SQL.';

COMMENT ON COLUMN ods_data_management.cdc_master_table_list.business IS 'Business domain associated with the data source.'; -- Note: Not in use currently.
COMMENT ON COLUMN ods_data_management.cdc_master_table_list.application_name IS 'Name of the application associated with the source system. This value should match the IRS/CMDB acronym. If there is no application, it is the name of the replication process.';
COMMENT ON COLUMN ods_data_management.cdc_master_table_list.custodian IS 'Data custodian responsible for the data source.'; -- Note: Not in use currently.
COMMENT ON COLUMN ods_data_management.cdc_master_table_list.source_schema_name IS 'Schema name of the source data.';
COMMENT ON COLUMN ods_data_management.cdc_master_table_list.source_table_name IS 'Table name of the source data.';
COMMENT ON COLUMN ods_data_management.cdc_master_table_list.target_schema_name IS 'Schema name of the target replication. This will follow the format: [source system acronym]_replication.';
COMMENT ON COLUMN ods_data_management.cdc_master_table_list.target_table_name IS 'Table name of the target replication. This will match the name of the source ';
COMMENT ON COLUMN ods_data_management.cdc_master_table_list.truncate_flag IS 'Flag indicating whether a truncate operation is occuring before loading (Y/N).';
COMMENT ON COLUMN ods_data_management.cdc_master_table_list.cdc_flag IS 'Flag indicating if CDC (Change Data Capture) is enabled (Y/N).'; -- Note: Not in use currently.
COMMENT ON COLUMN ods_data_management.cdc_master_table_list.full_inc_flag IS 'Flag indicating if full incremental load is enabled (Y/N).'; -- Note: Not in use currently.
COMMENT ON COLUMN ods_data_management.cdc_master_table_list.cdc_column IS 'Date column used for CDC tracking in the source table. '; -- Note: Not in use currently.
COMMENT ON COLUMN ods_data_management.cdc_master_table_list.active_ind IS 'Indicator of whether the entry is active (Y/N). If Y, the replication will run when the Airflow job is triggered.';
COMMENT ON COLUMN ods_data_management.cdc_master_table_list.replication_order IS 'Order of replication in processing sequences within a specific replication job.';
COMMENT ON COLUMN ods_data_management.cdc_master_table_list.where_clause IS 'Optional WHERE clause to filter data during replication.';
COMMENT ON COLUMN ods_data_management.cdc_master_table_list.customsql_ind IS 'Flag indicating if a custom SQL query is used (Y/N). If Y, then the customsql will be applied.';
COMMENT ON COLUMN ods_data_management.cdc_master_table_list.customsql_query IS 'Custom SQL query to use for replication, if applicable. This is required for geospatial conversion and keeping history tables.';
COMMENT ON COLUMN ods_data_management.cdc_master_table_list.replication_source IS 'Source system for replication data (e.g. Oracle, PostgreSQL)'; -- Note: Values should be standardized.
