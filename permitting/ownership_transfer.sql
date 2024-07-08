-- Steps to transfer ownership of tables (using 'ats_replication' schema as an example)

-- 1, as amichel
SELECT administration.create_proxy_account('ats_replication','');
GRANT usage, create ON schema ats_replication TO ats_replication;
 
-- 2, as <app>_replication user
GRANT ats_replication TO ods_admin_user;

-- 3, as ods_admin_user
DO $$DECLARE
    table_name TEXT;
BEGIN
    FOR table_name IN 
        SELECT tablename 
        FROM pg_tables 
        WHERE schemaname = 'ats_replication'
    LOOP
        EXECUTE 'ALTER TABLE ats_replication.' || quote_ident(table_name) || ' OWNER TO ats_replication';
    END LOOP;
END$$;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA ods_data_management TO ats_replication;
