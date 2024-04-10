INSERT INTO app_rrs1.cdc_master_table_list
(business, application_name, custodian, source_schema_name, source_table_name, target_schema_name, target_table_name, truncate_flag, cdc_flag, full_inc_flag, cdc_column, active_ind, replication_order)
VALUES(NULL, 'FTA', NULL, 'the', 'ORG_UNIT', 'fta_replication', 'ORG_UNIT', 'Y', NULL,NULL, 'UPDATE_DATE', 'Y', 1);

INSERT INTO app_rrs1.cdc_master_table_list
(business, application_name, custodian, source_schema_name, source_table_name, target_schema_name, target_table_name, truncate_flag, cdc_flag, full_inc_flag, cdc_column, active_ind, replication_order)
VALUES(NULL, 'FTA', NULL, 'the', 'CUT_BLOCK', 'fta_replication', 'CUT_BLOCK', 'Y', NULL,NULL, 'UPDATE_DATE', 'Y', 1);

INSERT INTO app_rrs1.cdc_master_table_list
(business, application_name, custodian, source_schema_name, source_table_name, target_schema_name, target_table_name, truncate_flag, cdc_flag, full_inc_flag, cdc_column, active_ind, replication_order)
VALUES(NULL, 'FTA', NULL, 'the', 'CLIENT_LOCATION', 'fta_replication', 'CLIENT_LOCATION', 'Y', NULL,NULL, 'UPDATE_DATE', 'Y', 1);

INSERT INTO app_rrs1.cdc_master_table_list
(business, application_name, custodian, source_schema_name, source_table_name, target_schema_name, target_table_name, truncate_flag, cdc_flag, full_inc_flag, cdc_column, active_ind, replication_order)
VALUES(NULL, 'FTA', NULL, 'the', 'TENURE_APPLICATION_PURP_CODE', 'fta_replication', 'TENURE_APPLICATION_PURP_CODE', 'Y', NULL,NULL, 'UPDATE_DATE', 'Y', 1);

INSERT INTO app_rrs1.cdc_master_table_list
(business, application_name, custodian, source_schema_name, source_table_name, target_schema_name, target_table_name, truncate_flag, cdc_flag, full_inc_flag, cdc_column, active_ind, replication_order)
VALUES(NULL, 'FTA', NULL, 'the', 'TENURE_FILE_STATUS_CODE', 'fta_replication', 'TENURE_FILE_STATUS_CODE', 'Y', NULL,NULL, 'UPDATE_DATE', 'Y', 2);

INSERT INTO app_rrs1.cdc_master_table_list
(business, application_name, custodian, source_schema_name, source_table_name, target_schema_name, target_table_name, truncate_flag, cdc_flag, full_inc_flag, cdc_column, active_ind, replication_order)
VALUES(NULL, 'FTA', NULL, 'the', 'TENURE_STATUS_CODE', 'fta_replication', 'TENURE_STATUS_CODE', 'Y', NULL,NULL, 'UPDATE_DATE', 'Y', 2);

INSERT INTO app_rrs1.cdc_master_table_list
(business, application_name, custodian, source_schema_name, source_table_name, target_schema_name, target_table_name, truncate_flag, cdc_flag, full_inc_flag, cdc_column, active_ind, replication_order)
VALUES(NULL, 'FTA', NULL, 'the', 'FOREST_CLIENT', 'fta_replication', 'FOREST_CLIENT', 'Y', NULL,NULL, 'UPDATE_DATE', 'Y', 2);

INSERT INTO app_rrs1.cdc_master_table_list
(business, application_name, custodian, source_schema_name, source_table_name, target_schema_name, target_table_name, truncate_flag, cdc_flag, full_inc_flag, cdc_column, active_ind, replication_order)
VALUES(NULL, 'FTA', NULL, 'the', 'FILE_CLIENT_TYPE_CODE', 'fta_replication', 'FILE_CLIENT_TYPE_CODE', 'Y', NULL,NULL, 'UPDATE_DATE', 'Y', 2);

INSERT INTO app_rrs1.cdc_master_table_list
(business, application_name, custodian, source_schema_name, source_table_name, target_schema_name, target_table_name, truncate_flag, cdc_flag, full_inc_flag, cdc_column, active_ind, replication_order)
VALUES(NULL, 'FTA', NULL, 'the', 'FILE_SOURCE_CODE', 'fta_replication', 'FILE_SOURCE_CODE', 'Y', NULL,NULL, 'UPDATE_DATE', 'Y', 2);

INSERT INTO app_rrs1.cdc_master_table_list
(business, application_name, custodian, source_schema_name, source_table_name, target_schema_name, target_table_name, truncate_flag, cdc_flag, full_inc_flag, cdc_column, active_ind, replication_order)
VALUES(NULL, 'FTA', NULL, 'the', 'FILE_STATUS_CODE', 'fta_replication', 'FILE_STATUS_CODE', 'Y', NULL,NULL, 'UPDATE_DATE', 'Y', 2);

INSERT INTO app_rrs1.cdc_master_table_list
(business, application_name, custodian, source_schema_name, source_table_name, target_schema_name, target_table_name, truncate_flag, cdc_flag, full_inc_flag, cdc_column, active_ind, replication_order)
VALUES(NULL, 'FTA', NULL, 'the', 'AAC_ALLOCATION_AMOUNT', 'fta_replication', 'AAC_ALLOCATION_AMOUNT', 'Y', NULL,NULL, 'UPDATE_DATE', 'Y', 2);

INSERT INTO ods_data_management.cdc_master_table_list (application_name,source_schema_name,source_table_name,target_schema_name,target_table_name,truncate_flag,cdc_column,active_ind,replication_order,where_clause,customsql_ind)
VALUES ('LEXIS','the','EXPORT_PERMIT_DETAIL','lexis_replication','EXPORT_PERMIT_DETAIL','Y','UPDATE_DATE','Y', 1,  '',  'N');