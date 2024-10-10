COMMENT ON SCHEMA ods_data_management IS 'Schema containing metadata, audit tables, and data management information for the Operational Data Store (ODS).';

COMMENT ON VIEW ods_data_management.size_of_schemas IS 'View summarizing the total size of each ODS schema in human-readable format.';

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

COMMENT ON TABLE ods_data_management.audit_batch_status IS 'Table to track the execution status of ELT process by batch.';

COMMENT ON COLUMN ods_data_management.audit_batch_status.object_name IS 'Name of the object, usually a table or view, being processed in batch.';
COMMENT ON COLUMN ods_data_management.audit_batch_status.application_name IS 'Name of the application associated with the object. This value should match the IRS/CMDB acronym.';
COMMENT ON COLUMN ods_data_management.audit_batch_status.etl_layer IS 'Layer of the ELT process (e.g., replication, transformation).';
COMMENT ON COLUMN ods_data_management.audit_batch_status.object_execution_status IS 'Status of the ELT execution (e.g., success, failure).';
COMMENT ON COLUMN ods_data_management.audit_batch_status.batch_run_date IS 'Most recent date that the batch ELT process took place.';

COMMENT ON TABLE ods_data_management.audit_batch_id IS 'Table to store additional metadata related to directed acyclic graph (DAG) execution.'; -- Note: In current architecture, this is only populated when the 'permitting_pipeline_etl_batch_id_creation/update' DAGs run.

COMMENT ON COLUMN ods_data_management.audit_batch_id.etl_batch_id IS 'Date of the DAG execution.'; -- Note: This column should be renamed. _id is misleading.
COMMENT ON COLUMN ods_data_management.audit_batch_id.etl_batch_name IS 'Name of the DAG being executed.';
COMMENT ON COLUMN ods_data_management.audit_batch_id.etl_batch_status IS 'Current status of the ETL batch execution (e.g., started, success, failed).';
COMMENT ON COLUMN ods_data_management.audit_batch_id.etl_batch_start_time IS 'Start time of the DAG execution.';
COMMENT ON COLUMN ods_data_management.audit_batch_id.etl_batch_end_time IS 'End time of the DAG execution.';
