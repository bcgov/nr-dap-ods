create or replace view bcts_staging.replication_errors as
select * from ods_data_management.audit_batch_status
where application_name in ('lrm', 'bctsadmin', 'mof-client') 
and object_execution_status='failed' 
and batch_run_date=(select max(batch_run_date) from ods_data_management.audit_batch_status where application_name in ('lrm', 'bctsadmin', 'mof-client'));
