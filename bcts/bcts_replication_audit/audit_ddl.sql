
create or replace view bcts_staging.replication_errors_bcts as
select * from ods_data_management.audit_batch_status
where application_name in ('lrm', 'bctsadmin', 'mof-client') 
and batch_run_date::date = CURRENT_DATE

union all

select * from ods_data_management.audit_batch_status
where application_name = 'FTA' and batch_run_date::date = CURRENT_DATE
and lower(object_name) in ('tenure_term', 'prov_forest_use', 'tenure_file_status_code', 'tfl_number_code', 'sale_method_code', 'org_unit', 'sb_category_code', 'harvest_sale', 'tsa_number_code', 'forest_file_client', 'TIMBER_MARK')
order by object_execution_status;
