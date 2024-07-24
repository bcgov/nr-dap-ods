-- Steps to transfer ownership of tables 

-- 1, as AMICHEL

SELECT administration.create_proxy_account('ats_replication','');
 
SELECT administration.create_proxy_account('fta_replication','');

SELECT administration.create_proxy_account('lexis_replication','');

SELECT administration.create_proxy_account('rrs_replication','');

-- 2, as each <app>_replication user

GRANT ats_replication TO ods_admin_user;

GRANT fta_replication TO ods_admin_user;

GRANT lexis_replication TO ods_admin_user;

GRANT rrs_replication TO ods_admin_user;

-- 3, as ods_admin_user

GRANT USAGE, CREATE ON SCHEMA ats_replication TO ats_replication;

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

GRANT USAGE ON SCHEMA ods_data_management TO ats_replication;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA ods_data_management TO ats_replication;

GRANT USAGE, CREATE ON SCHEMA rrs_replication TO rrs_replication;

DO $$DECLARE
    table_name TEXT;
BEGIN
    FOR table_name IN
        SELECT tablename
        FROM pg_tables
        WHERE schemaname = 'rrs_replication'
    LOOP
        EXECUTE 'ALTER TABLE rrs_replication.' || quote_ident(table_name) || ' OWNER TO rrs_replication';
    END LOOP;
END$$;

GRANT USAGE ON SCHEMA ods_data_management TO rrs_replication;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA ods_data_management TO rrs_replication;

GRANT USAGE, CREATE ON SCHEMA lexis_replication TO lexis_replication;

DO $$DECLARE
    table_name TEXT;
BEGIN
    FOR table_name IN
        SELECT tablename
        FROM pg_tables
        WHERE schemaname = 'lexis_replication'
    LOOP
        EXECUTE 'ALTER TABLE lexis_replication.' || quote_ident(table_name) || ' OWNER TO lexis_replication';
    END LOOP;
END$$;

GRANT USAGE ON SCHEMA ods_data_management TO lexis_replication;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA ods_data_management TO lexis_replication;

GRANT USAGE, CREATE ON SCHEMA fta_replication TO fta_replication;

DO $$DECLARE
    table_name TEXT;
BEGIN
    FOR table_name IN
        SELECT tablename
        FROM pg_tables
        WHERE schemaname = 'fta_replication'
    LOOP
        EXECUTE 'ALTER TABLE fta_replication.' || quote_ident(table_name) || ' OWNER TO fta_replication';
    END LOOP;
END$$;

GRANT USAGE ON SCHEMA ods_data_management TO fta_replication;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA ods_data_management TO fta_replication;
