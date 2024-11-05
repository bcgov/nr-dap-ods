CREATE TABLE lrm_replication.tenure_type (
    tent_seq_nbr NUMERIC(15) NOT NULL,
    divi_div_nbr NUMERIC(2) NOT NULL,
    tent_tenure_id VARCHAR(40) NOT NULL,
    tent_tenure_name VARCHAR(160) NULL,
    tety_tenure_type VARCHAR(40) NULL,
    tent_active_ind VARCHAR(4) NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(120) NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(120) NULL,
    PRIMARY KEY (tent_seq_nbr)
);

ALTER TABLE lrm_replication.tenure_type OWNER TO bcts_etl_user;
