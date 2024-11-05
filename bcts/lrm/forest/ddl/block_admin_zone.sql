CREATE TABLE lrm_replication.block_admin_zone (
    blaz_admin_zone_id VARCHAR(40) NOT NULL,
    divi_div_nbr NUMERIC(2) NOT NULL,
    blaz_admin_zone_desc VARCHAR(200) NULL,
    blaz_active_ind VARCHAR(1) NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(120) NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(120) NULL,
    PRIMARY KEY (blaz_admin_zone_id, divi_div_nbr)
);

ALTER TABLE lrm_replication.block_admin_zone OWNER TO bcts_etl_user;
