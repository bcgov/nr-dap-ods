-- Create new schemas
CREATE SCHEMA bctsadmin_replication;
CREATE SCHEMA mofclient_replication;

-- Grant usage on new schemas
GRANT USAGE ON SCHEMA bctsadmin_replication TO bcts_etl_user WITH GRANT OPTION;
GRANT USAGE ON SCHEMA mofclient_replication TO bcts_etl_user WITH GRANT OPTION;

-- Grant read and write access to all existing tables in the new schemas
GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE ON ALL TABLES IN SCHEMA bctsadmin_replication TO bcts_etl_user WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE ON ALL TABLES IN SCHEMA mofclient_replication TO bcts_etl_user WITH GRANT OPTION;

-- Grant permission to create new objects in the new schemas
GRANT CREATE ON SCHEMA bctsadmin_replication TO bcts_etl_user;
GRANT CREATE ON SCHEMA mofclient_replication TO bcts_etl_user;

-- Set default privileges for new tables in the new schemas
ALTER DEFAULT PRIVILEGES IN SCHEMA bctsadmin_replication GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO bcts_etl_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA mofclient_replication GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO bcts_etl_user;

-- Grant usage on all sequences in the new schemas
GRANT USAGE ON ALL SEQUENCES IN SCHEMA bctsadmin_replication TO bcts_etl_user;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA mofclient_replication TO bcts_etl_user;

-- Set default privileges for sequences in the new schemas
ALTER DEFAULT PRIVILEGES IN SCHEMA bctsadmin_replication GRANT USAGE ON SEQUENCES TO bcts_etl_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA mofclient_replication GRANT USAGE ON SEQUENCES TO bcts_etl_user;
