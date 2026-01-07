-- BCTSADMIN DBP01 THE. bcts_registrant 
CREATE TABLE bctsadmin_replication.bcts_registrant (
    client_number VARCHAR(8),
    client_locn_code VARCHAR(2),
    org_unit_no NUMERIC(10),
    original_registration_date TIMESTAMP,
    registrant_expiry_date TIMESTAMP,
    registrant_deactivation_date TIMESTAMP,
    bcts_category_code VARCHAR(1),
    bcts_category_change_date TIMESTAMP,
    bcts_mill_type_code VARCHAR(1),
    bcts_previous_category_code VARCHAR(1),
    debarker_chipper_ind VARCHAR(1),
    debarker_chipper_exemptto_date TIMESTAMP,
    debarker_chipper_exemption_ind VARCHAR(1),
    registrant_comments VARCHAR(1000),
    disqualification_start_date TIMESTAMP,
    disqualification_end_date TIMESTAMP,
    disqualification_comments VARCHAR(1000),
    update_userid VARCHAR(30),
    update_timestamp TIMESTAMP
);

CREATE OR REPLACE VIEW bcts_staging.THE_BCTS_REGISTRANT AS
SELECT * FROM bctsadmin_replication.bcts_registrant;

-- FOREST CLIENT DBP01 THE. client_location  
CREATE TABLE mofclient_replication.client_location (
    client_number VARCHAR(8),
    client_locn_code VARCHAR(2),
    client_locn_name VARCHAR(40),
    hdbs_company_code VARCHAR(5),
    address_1 VARCHAR(40),
    address_2 VARCHAR(40),
    address_3 VARCHAR(40),
    city VARCHAR(30),
    province VARCHAR(50),
    postal_code VARCHAR(10),
    country VARCHAR(50),
    business_phone VARCHAR(10),
    home_phone VARCHAR(10),
    cell_phone VARCHAR(10),
    fax_number VARCHAR(10),
    email_address VARCHAR(128),
    locn_expired_ind VARCHAR(1),
    returned_mail_date TIMESTAMP,
    trust_location_ind VARCHAR(1),
    cli_locn_comment VARCHAR(4000),
    update_timestamp TIMESTAMP,
    update_userid VARCHAR(30),
    update_org_unit NUMERIC(10),
    add_timestamp TIMESTAMP,
    add_userid VARCHAR(30),
    add_org_unit NUMERIC(10),
    revision_count NUMERIC(5)
);


CREATE OR REPLACE VIEW bcts_staging.THE_CLIENT_LOCATION AS
SELECT * FROM mofclient_replication.client_location;
