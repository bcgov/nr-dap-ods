CREATE TABLE lrm_replication.code_lookup (
    colu_lookup_type VARCHAR(4) NOT NULL,
    colu_lookup_id VARCHAR(30) NOT NULL,
    colu_lookup_desc VARCHAR(150) NOT NULL,
    colu_user_defined_ind VARCHAR(4) NULL,
    colu_display_ind VARCHAR(1) NULL,
    colu_display_order NUMERIC(10) NULL,
    colu_comment VARCHAR(4000) NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(120) NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(120) NULL,
    hq_display_ind VARCHAR(1) NULL,
    PRIMARY KEY (colu_lookup_type, colu_lookup_id)
);

ALTER TABLE lrm_replication.code_lookup OWNER TO bcts_etl_user;
