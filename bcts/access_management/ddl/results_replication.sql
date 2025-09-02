-- Create new schema
CREATE SCHEMA results_replication;

-- Grant usage on the new schema
GRANT USAGE ON SCHEMA results_replication TO bcts_etl_user WITH GRANT OPTION;

-- Grant read and write access to all existing tables in the new schema
GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE ON ALL TABLES IN SCHEMA results_replication TO bcts_etl_user WITH GRANT OPTION;

-- Grant permission to create new objects in the new schema
GRANT CREATE ON SCHEMA results_replication TO bcts_etl_user;

-- Set default privileges for new tables in the new schema
ALTER DEFAULT PRIVILEGES IN SCHEMA results_replication GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO bcts_etl_user;

-- Grant usage on all sequences in the new schema
GRANT USAGE ON ALL SEQUENCES IN SCHEMA results_replication TO bcts_etl_user;

-- Set default privileges for sequences in the new schema
ALTER DEFAULT PRIVILEGES IN SCHEMA results_replication GRANT USAGE ON SEQUENCES TO bcts_etl_user;
