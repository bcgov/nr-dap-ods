CREATE SCHEMA mofclient_replication;

-- Grant access to schema
GRANT USAGE ON SCHEMA mofclient_replication TO bcts_etl_user WITH GRANT OPTION;

-- Grant read and write access to existing tables
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA mofclient_replication TO bcts_etl_user WITH GRANT OPTION;

-- Grant permission to create new tables, functions, etc.
GRANT CREATE ON SCHEMA mofclient_replication TO bcts_etl_user;


-- Grant privileges to automatically apply on any new tables created 
ALTER DEFAULT PRIVILEGES IN SCHEMA mofclient_replication GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO bcts_etl_user;


-- Grant usage on sequences if needed for ID generation or other purposes
GRANT USAGE ON ALL SEQUENCES IN SCHEMA mofclient_replication TO bcts_etl_user;


-- Set default privileges for sequences
ALTER DEFAULT PRIVILEGES IN SCHEMA mofclient_replication GRANT USAGE ON SEQUENCES TO bcts_etl_user;

