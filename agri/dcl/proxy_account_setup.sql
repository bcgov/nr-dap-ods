CREATE SCHEMA cirras_replication AUTHORIZATION ods_admin_user;
CREATE SCHEMA cirras_reporting AUTHORIZATION ods_admin_user;
CREATE SCHEMA farm_replication AUTHORIZATION ods_admin_user;
CREATE SCHEMA farm_reporting AUTHORIZATION ods_admin_user;

GRANT USAGE, CREATE ON SCHEMA cirras_replication TO agri_brm_dev_role;
GRANT USAGE, CREATE ON SCHEMA farm_replication TO agri_brm_dev_role;
GRANT USAGE, CREATE ON SCHEMA cirras_reporting TO agri_brm_dev_role;
GRANT USAGE, CREATE ON SCHEMA farm_reporting TO agri_brm_dev_role;
GRANT USAGE ON SCHEMA ods_data_management TO agri_brm_dev_role;

GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE ON ALL TABLES IN SCHEMA cirras_replication TO agri_brm_dev_role;
GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE ON ALL TABLES IN SCHEMA farm_replication TO agri_brm_dev_role;

GRANT SELECT, INSERT, UPDATE, DELETE ON ods_data_management.cdc_master_table_list TO agri_brm_dev_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON ods_data_management.audit_batch_status TO agri_brm_dev_role;

GRANT USAGE ON SCHEMA cirras_replication TO agri_brm_analyst_role;
GRANT USAGE ON SCHEMA cirras_reporting TO agri_brm_analyst_role;
GRANT USAGE ON SCHEMA farm_replication TO agri_brm_analyst_role;
GRANT USAGE ON SCHEMA farm_reporting TO agri_brm_analyst_role;

ALTER DEFAULT PRIVILEGES IN SCHEMA cirras_replication GRANT SELECT ON ALL TABLES IN SCHEMA cirras_replication TO ods_admin_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA farm_replication GRANT SELECT ON ALL TABLES IN SCHEMA farm_replication TO ods_admin_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA cirras_reporting GRANT SELECT ON ALL TABLES IN SCHEMA cirras_reporting TO ods_admin_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA farm_reporting GRANT SELECT ON ALL TABLES IN SCHEMA farm_reporting TO ods_admin_user;

ALTER DEFAULT PRIVILEGES IN SCHEMA cirras_replication GRANT SELECT ON ALL TABLES IN SCHEMA cirras_replication TO agri_brm_analyst_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA cirras_reporting  GRANT SELECT ON ALL TABLES IN SCHEMA cirras_reporting TO agri_brm_analyst_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA farm_replication GRANT SELECT ON ALL TABLES IN SCHEMA farm_replication TO agri_brm_analyst_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA farm_reporting GRANT SELECT ON ALL TABLES IN SCHEMA farm_reporting TO agri_brm_analyst_role;