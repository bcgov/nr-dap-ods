-- Create BCTS ETL executor role. Password should be available only to the DBA
-- 1. Create the etl superuser
CREATE USER bcts_etl_user WITH PASSWORD '<place_holder>';

CREATE SCHEMA lrm_replication;
CREATE SCHEMA bcts_staging;
CREATE SCHEMA bcts_reporting;

-- Create roles for ETL and data consumption
CREATE ROLE BCTS_ETL_ROLE;
CREATE ROLE BCTS_DEV_ROLE;
CREATE ROLE BCTS_STAGE_ANALYST_ROLE;
CREATE ROLE BCTS_STAGE_ANALYST_PI_ROLE;
CREATE ROLE BCTS_ANALYST_ROLE;
CREATE ROLE BCTS_ANALYST_PI_ROLE;

-- 2. Grant access to schemas lrm_replication, bcts_staging, and bcts_reporting
GRANT USAGE ON SCHEMA lrm_replication TO bcts_etl_user WITH GRANT OPTION;
GRANT USAGE ON SCHEMA bcts_staging TO bcts_etl_user WITH GRANT OPTION;
GRANT USAGE ON SCHEMA bcts_reporting TO bcts_etl_user WITH GRANT OPTION;

-- 3. Grant read and write access to existing tables in schemas lrm_replication, bcts_staging, and bcts_reporting
GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE ON ALL TABLES IN SCHEMA lrm_replication TO bcts_etl_user WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE ON ALL TABLES IN SCHEMA bcts_staging TO bcts_etl_user WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE ON ALL TABLES IN SCHEMA bcts_reporting TO bcts_etl_user WITH GRANT OPTION;

GRANT USAGE ON SCHEMA ods_data_management TO bcts_etl_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ods_data_management.cdc_master_table_list TO bcts_etl_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ods_data_management.audit_batch_status TO bcts_etl_user;

-- 4. Grant permission to create new tables, functions, etc., in schemas lrm_replication, bcts_staging, and bcts_reporting
GRANT CREATE ON SCHEMA lrm_replication TO bcts_etl_user;
GRANT CREATE ON SCHEMA bcts_staging TO bcts_etl_user;
GRANT CREATE ON SCHEMA bcts_reporting TO bcts_etl_user;

-- 5. Grant privileges to automatically apply on any new tables created in schemas lrm_replication, bcts_staging, and bcts_reporting
ALTER DEFAULT PRIVILEGES IN SCHEMA lrm_replication GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO bcts_etl_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA bcts_staging GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO bcts_etl_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA bcts_reporting GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO bcts_etl_user;

-- Grant usage on sequences if needed for ID generation or other purposes
GRANT USAGE ON ALL SEQUENCES IN SCHEMA lrm_replication TO bcts_etl_user;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA bcts_staging TO bcts_etl_user;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA bcts_reporting TO bcts_etl_user;

-- Set default privileges for sequences
ALTER DEFAULT PRIVILEGES IN SCHEMA lrm_replication GRANT USAGE ON SEQUENCES TO bcts_etl_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA bcts_staging GRANT USAGE ON SEQUENCES TO bcts_etl_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA bcts_reporting GRANT USAGE ON SEQUENCES TO bcts_etl_user;
