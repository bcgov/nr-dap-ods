CREATE SCHEMA bctsadmin_replication;

-- Grant access to schemas lrm_replication, bcts_staging, and bcts_reporting
GRANT USAGE ON SCHEMA bctsadmin_replication TO bcts_etl_user WITH GRANT OPTION;

-- Grant read and write access to existing tables in schemas lrm_replication, bcts_staging, and bcts_reporting
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA bctsadmin_replication TO bcts_etl_user WITH GRANT OPTION;

-- Grant permission to create new tables, functions, etc., in schemas lrm_replication, bcts_staging, and bcts_reporting
GRANT CREATE ON SCHEMA bctsadmin_replication TO bcts_etl_user;


-- Grant privileges to automatically apply on any new tables created in schemas lrm_replication, bcts_staging, and bcts_reporting
ALTER DEFAULT PRIVILEGES IN SCHEMA bctsadmin_replication GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO bcts_etl_user;


-- Grant usage on sequences if needed for ID generation or other purposes
GRANT USAGE ON ALL SEQUENCES IN SCHEMA bctsadmin_replication TO bcts_etl_user;

GRANT USAGE ON ALL SEQUENCES IN SCHEMA bcts_reporting TO bcts_etl_user;

-- Set default privileges for sequences
ALTER DEFAULT PRIVILEGES IN SCHEMA bctsadmin_replication GRANT USAGE ON SEQUENCES TO bcts_etl_user;

