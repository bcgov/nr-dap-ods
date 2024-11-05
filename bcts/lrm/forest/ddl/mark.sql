CREATE TABLE lrm_replication.mark (
    mark_seq_nbr NUMERIC(15) NOT NULL,
    mark_mark_id VARCHAR(15) NULL,
    divi_div_nbr NUMERIC(2) NOT NULL,
    mark_mark_desc VARCHAR(160) NULL,
    mark_mark_state VARCHAR(80) NULL,
    mark_crown_granted_ind VARCHAR(4) NULL,
    mark_aac_partition VARCHAR(40) NULL,
    mark_apportionment VARCHAR(40) NULL,
    mark_endemic_percent NUMERIC(4, 2) NULL,
    mark_species_type VARCHAR(8) NULL,
    mark_all_log_grades_ind VARCHAR(4) NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(120) NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(120) NULL,
    PRIMARY KEY (mark_seq_nbr)
);

ALTER TABLE lrm_replication.mark OWNER TO bcts_etl_user;
