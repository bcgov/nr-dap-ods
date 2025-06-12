CREATE TABLE mofclient_replication.v_client_public (
    client_number VARCHAR(8) NOT NULL,
    client_name VARCHAR(60) NOT NULL,
    legal_first_name VARCHAR(30) NULL,
    legal_middle_name VARCHAR(30) NULL,
    client_status_code VARCHAR(3) NOT NULL,
    client_type_code VARCHAR(1) NOT NULL
);

CREATE TABLE mofclient_replication.org_unit (
    org_unit_no NUMERIC(10) NOT NULL,
    org_unit_code VARCHAR(6) NOT NULL,
    org_unit_name VARCHAR(100) NOT NULL,
    location_code VARCHAR(3) NOT NULL,
    area_code VARCHAR(3) NOT NULL,
    telephone_no VARCHAR(7) NOT NULL,
    org_level_code VARCHAR(1) NOT NULL,
    office_name_code VARCHAR(2) NOT NULL,
    rollup_region_no NUMERIC(10) NOT NULL,
    rollup_region_code VARCHAR(6) NOT NULL,
    rollup_dist_no NUMERIC(10) NOT NULL,
    rollup_dist_code VARCHAR(6) NOT NULL,
    effective_date TIMESTAMP NOT NULL,
    expiry_date TIMESTAMP NOT NULL,
    update_timestamp TIMESTAMP NULL,
    PRIMARY KEY (org_unit_no)
);

CREATE OR REPLACE VIEW bcts_staging.THE_V_CLIENT_PUBLIC AS
SELECT * FROM mofclient_replication.V_CLIENT_PUBLIC;


CREATE OR REPLACE VIEW bcts_staging.THE_ORG_UNIT AS
SELECT * FROM mofclient_replication.ORG_UNIT;

