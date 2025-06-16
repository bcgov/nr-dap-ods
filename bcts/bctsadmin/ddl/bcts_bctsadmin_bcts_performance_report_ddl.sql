CREATE TABLE bctsadmin_replication.bcts_tenure_bidder (
    client_number VARCHAR(8) NOT NULL,
    forest_file_id VARCHAR(10) NOT NULL,
    auction_date TIMESTAMP NOT NULL,
    bonus_bid NUMERIC(8, 2) NULL,
    bonus_offer NUMERIC(9, 2) NULL,
    deposit_amount NUMERIC(8, 2) NULL,
    bid_deposit_type_code VARCHAR(1) NULL,
    ineligible_ind VARCHAR(1) NULL,
    ineligibility_comments VARCHAR(500) NULL,
    sale_awarded_ind VARCHAR(1) NULL,
    deposit_returned_ind VARCHAR(1) NULL,
    nmbr_months_of_registration NUMERIC(3) NULL,
    completed_forest_file_id VARCHAR(10) NULL,
    completed_file_status_date TIMESTAMP NULL,
    completed_file_type_code VARCHAR(3) NULL,
    completed_file_status_code VARCHAR(3) NULL,
    issued_forest_file_id VARCHAR(10) NULL,
    issued_file_status_date TIMESTAMP NULL,
    issued_file_type_code VARCHAR(3) NULL,
    deposit_level_code VARCHAR(1) NULL,
    primary_rqmt_met_ind VARCHAR(1) NULL,
    financial_rqmt_met_ind VARCHAR(1) NULL,
    primary_rqmt_met_comment VARCHAR(500) NULL,
    financial_rqmt_met_comment VARCHAR(500) NULL,
    deposit_level_comment VARCHAR(500) NULL,
    electronic_bid_ind VARCHAR(1) NOT NULL,
    update_timestamp TIMESTAMP NOT NULL,
    update_userid VARCHAR(30) NOT NULL,
    PRIMARY KEY (client_number, forest_file_id, auction_date)
);

CREATE TABLE bctsadmin_replication.bcts_timber_sale (
    forest_file_id VARCHAR(10) NOT NULL,
    auction_date TIMESTAMP NOT NULL,
    bcts_category_code VARCHAR(1) NOT NULL,
    bcts_rate_code VARCHAR(6) NOT NULL,
    bcts_silv_obligation_code VARCHAR(3) NOT NULL,
    lump_sum_category_code VARCHAR(4) NULL,
    no_sale_rationale_code VARCHAR(2) NULL,
    sale_location VARCHAR(100) NULL,
    sale_volume NUMERIC(13, 1) NOT NULL,
    upset_rate NUMERIC(8, 2) NULL,
    total_upset_value NUMERIC(9, 2) NULL,
    deposit_amount NUMERIC(8, 2) NOT NULL,
    sale_time VARCHAR(8) NOT NULL,
    decked_timber_ind VARCHAR(1) NOT NULL,
    lump_sum_ind VARCHAR(1) NOT NULL,
    timber_sale_comment VARCHAR(1000) NULL,
    approved_by VARCHAR(40) NULL,
    date_approved TIMESTAMP NULL,
    legal_effective_date TIMESTAMP NULL,
    update_userid VARCHAR(30) NOT NULL,
    update_timestamp TIMESTAMP NOT NULL,
    third_party_deposit_name VARCHAR(140) NULL,
    third_party_deposit_ind VARCHAR(140) NULL,
    PRIMARY KEY (forest_file_id, auction_date)
);

CREATE TABLE bctsadmin_replication.no_sale_rationale_code (
    no_sale_rationale_code VARCHAR(2) NOT NULL,
    description VARCHAR(120) NOT NULL,
    effective_date TIMESTAMP NOT NULL,
    expiry_date TIMESTAMP NOT NULL,
    update_timestamp TIMESTAMP NOT NULL,
    PRIMARY KEY (no_sale_rationale_code)
);

CREATE OR REPLACE VIEW bcts_staging.THE_BCTS_TENURE_BIDDER AS
SELECT * FROM bctsadmin_replication.BCTS_TENURE_BIDDER;


CREATE OR REPLACE VIEW bcts_staging.THE_BCTS_TIMBER_SALE AS
SELECT * FROM bctsadmin_replication.BCTS_TIMBER_SALE;


CREATE OR REPLACE VIEW bcts_staging.THE_NO_SALE_RATIONALE_CODE AS
SELECT * FROM bctsadmin_replication.NO_SALE_RATIONALE_CODE;
