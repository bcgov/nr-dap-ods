CREATE TABLE lrm_replication.licence (
    licn_seq_nbr NUMERIC(15) NOT NULL,
    licn_licence_id VARCHAR(15) NOT NULL,
    licn_licence_desc VARCHAR(53) NULL,
    divi_div_nbr NUMERIC(2) NOT NULL,
    licn_crown_land CHAR NULL,
    licn_annual_allowable_cut NUMERIC(9) NULL,
    lsee_licensee_id VARCHAR(10) NULL,
    tent_seq_nbr NUMERIC(15) NULL,
    licn_licence_state VARCHAR(20) NULL,
    licn_permit_exists_ind VARCHAR(4) NULL,
    licn_salvage_ind VARCHAR(1) NULL,
    licn_category_id VARCHAR(10) NULL,
    licn_field_team_id VARCHAR(10) NULL,
    ctor_seq_nbr NUMERIC(15) NULL,
    cloc_seq_nbr NUMERIC(15) NULL,
    blaz_admin_zone_id VARCHAR(10) NULL,
    licn_digi_ind VARCHAR(1) NULL,
    licl_licence_class VARCHAR(10) NULL,
    licn_parent_licence NUMERIC(15) NULL,
    licn_crown_granted_ind VARCHAR(4) NULL,
    licn_client_loc_code VARCHAR(20) NULL,
    licn_category_type VARCHAR(16) NULL,
    licn_licence_to_cut_code VARCHAR(10) NULL,
    linc_cert_level_id VARCHAR(10) NULL,
    licn_mgr_seq_nbr NUMERIC(15) NULL,
    licn_fst_seq_nbr NUMERIC(15) NULL,
    licn_gross_area NUMERIC(11, 6) NULL,
    licn_net_area NUMERIC(11, 6) NULL,
    licn_comment VARCHAR(4000) NULL,
    licn_apportion_tenure_type VARCHAR(30) NULL,
    team_seq_nbr NUMERIC(15) NULL,
    licn_hammermark VARCHAR(60) NULL,
    licn_client_location_code VARCHAR(40) NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(120) NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(120) NULL,
    licn_archive_ind VARCHAR(3) NULL,
    licn_archive_date TIMESTAMP NULL,
    PRIMARY KEY (licn_seq_nbr)
);