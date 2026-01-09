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

-- DROP TABLE IF EXISTS bcts_staging.licence_sold_to_out_of_province_registrants_hist;

CREATE TABLE IF NOT EXISTS bcts_staging.licence_sold_to_out_of_province_registrants_hist
(
    management_unit character varying(120) COLLATE pg_catalog."default",
    forest_file_id character varying(10) COLLATE pg_catalog."default",
    bcts_category_code character varying(1) COLLATE pg_catalog."default",
    legal_effective_date date,
    auction_date timestamp without time zone,
    sale_volume numeric(13,1),
    client_number character varying(8) COLLATE pg_catalog."default",
    licensee_name character varying COLLATE pg_catalog."default",
    licensee_address text COLLATE pg_catalog."default",
    postal_code character varying(10) COLLATE pg_catalog."default",
    city character varying(30) COLLATE pg_catalog."default",
    province character varying(50) COLLATE pg_catalog."default",
    country character varying(50) COLLATE pg_catalog."default",
    client_locn_code character varying(2) COLLATE pg_catalog."default",
    forest_file_client_type_code character varying(1) COLLATE pg_catalog."default",
    registry_company_type_code text COLLATE pg_catalog."default",
    registrant_expiry_date timestamp without time zone,
    client_comment text COLLATE pg_catalog."default",
    org_unit_code character varying(6) COLLATE pg_catalog."default",
    mgmt_unit_type character varying(1) COLLATE pg_catalog."default",
    mgmt_unit_id character varying(4) COLLATE pg_catalog."default",
    category character varying(120) COLLATE pg_catalog."default",
    file_status_st character varying(3) COLLATE pg_catalog."default",
    fiscal_issued numeric,
    upset_rate numeric(8,2),
    total_upset_value numeric(9,2),
    bonus_bid numeric(8,2),
    bonus_offer numeric(9,2),
    report_start_date date,
    report_end_date date,
    report_run_date date DEFAULT CURRENT_DATE
)

