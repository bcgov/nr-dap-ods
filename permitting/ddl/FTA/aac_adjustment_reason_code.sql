CREATE TABLE fta_replication.aac_adjustment_reason_code (
    aac_adjustment_reason_code VARCHAR(4) NOT NULL,
    description VARCHAR(120) NOT NULL,
    effective_date TIMESTAMP(0) NOT NULL,
    expiry_date TIMESTAMP(0) NOT NULL,
    update_timestamp TIMESTAMP(0) NOT NULL,
    CONSTRAINT aarc_pk PRIMARY KEY (aac_adjustment_reason_code)
);
