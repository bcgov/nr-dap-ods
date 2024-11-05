CREATE TABLE lrm_replication.division_code_lookup (
    colu_lookup_type VARCHAR(4) NOT NULL,
    colu_lookup_id VARCHAR(120) NOT NULL,
    divi_div_nbr NUMERIC(2) NOT NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(120) NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(120) NULL,
    PRIMARY KEY (colu_lookup_type, colu_lookup_id, divi_div_nbr)
);

ALTER TABLE lrm_replication.division_code_lookup OWNER TO bcts_etl_user;
