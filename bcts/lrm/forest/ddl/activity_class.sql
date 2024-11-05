CREATE TABLE lrm_replication.activity_class (
    accl_seq_nbr NUMERIC(15) NOT NULL,
    accl_description VARCHAR(40) NULL,
    accl_object_type VARCHAR(1) NULL,
    accl_display_order NUMERIC(3) NULL,
    divi_div_nbr NUMERIC(2) NULL,
    accl_key_ind VARCHAR(12) NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(120) NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(120) NULL,
    PRIMARY KEY (accl_seq_nbr)
);

ALTER TABLE lrm_replication.activity_class OWNER TO bcts_etl_user;
