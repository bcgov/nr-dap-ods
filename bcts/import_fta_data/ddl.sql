DROP TABLE IF EXISTS bcts_staging.fta_tenure_term;

CREATE TABLE IF NOT EXISTS bcts_staging.fta_tenure_term
(
    forest_file_id character varying(10) COLLATE pg_catalog."default",
    tenure_term integer,
    legal_effective_dt timestamp(0) without time zone,
    initial_expiry_dt timestamp(0) without time zone,
    current_expiry_dt timestamp(0) without time zone,
    tenure_extend_cnt bigint,
    tenr_extend_rsn_st character varying(1) COLLATE pg_catalog."default",
    entry_userid character varying(30) COLLATE pg_catalog."default",
    entry_timestamp timestamp without time zone,
    update_userid character varying(30) COLLATE pg_catalog."default",
    update_timestamp timestamp without time zone,
    revision_count integer
);

DROP TABLE IF EXISTS bcts_staging.fta_prov_forest_use;

CREATE TABLE IF NOT EXISTS bcts_staging.fta_prov_forest_use
(
    forest_file_id character varying(10) COLLATE pg_catalog."default",
    file_status_st character varying(3) COLLATE pg_catalog."default",
    file_status_date timestamp(0) without time zone,
    file_type_code character varying(3) COLLATE pg_catalog."default",
    forest_region bigint,
    bcts_org_unit bigint,
    sb_funded_ind character varying(1) COLLATE pg_catalog."default",
    district_admin_zone character varying(4) COLLATE pg_catalog."default",
    mgmt_unit_type character varying(1) COLLATE pg_catalog."default",
    mgmt_unit_id character varying(4) COLLATE pg_catalog."default",
    revision_count integer,
    entry_userid character varying(30) COLLATE pg_catalog."default",
    entry_timestamp timestamp(0) without time zone,
    update_userid character varying(30) COLLATE pg_catalog."default",
    update_timestamp timestamp(0) without time zone,
    forest_tenure_guid bytea
);

DROP TABLE IF EXISTS bcts_staging.fta_tenure_file_status_code;

CREATE TABLE IF NOT EXISTS bcts_staging.fta_tenure_file_status_code
(
    tenure_file_status_code character varying(3) COLLATE pg_catalog."default",
    description character varying(120) COLLATE pg_catalog."default",
    effective_date timestamp(0) without time zone,
    expiry_date timestamp(0) without time zone,
    update_timestamp timestamp without time zone
);

DROP TABLE IF EXISTS bcts_staging.fta_tfl_number_code;

CREATE TABLE IF NOT EXISTS bcts_staging.fta_tfl_number_code
(
    tfl_number character varying(2) COLLATE pg_catalog."default",
    description character varying(120) COLLATE pg_catalog."default",
    effective_date timestamp(0) without time zone,
    expiry_date timestamp(0) without time zone,
    update_timestamp timestamp(0) without time zone
);

DROP TABLE IF EXISTS bcts_staging.fta_sale_method_code;

CREATE TABLE IF NOT EXISTS bcts_staging.fta_sale_method_code
(
    sale_method_code character varying(1) COLLATE pg_catalog."default",
    description character varying(120) COLLATE pg_catalog."default",
    effective_date timestamp(0) without time zone,
    expiry_date timestamp(0) without time zone,
    update_timestamp timestamp(0) without time zone
);

DROP TABLE IF EXISTS bcts_staging.fta_org_unit;

CREATE TABLE IF NOT EXISTS bcts_staging.fta_org_unit
(
    org_unit_no bigint,
    org_unit_code character varying(6) COLLATE pg_catalog."default",
    org_unit_name character varying(100) COLLATE pg_catalog."default",
    location_code character varying(3) COLLATE pg_catalog."default",
    area_code character varying(3) COLLATE pg_catalog."default",
    telephone_no character varying(7) COLLATE pg_catalog."default",
    org_level_code character varying(1) COLLATE pg_catalog."default",
    office_name_code character varying(2) COLLATE pg_catalog."default",
    rollup_region_no bigint,
    rollup_region_code character varying(6) COLLATE pg_catalog."default",
    rollup_dist_no bigint,
    rollup_dist_code character varying(6) COLLATE pg_catalog."default",
    effective_date timestamp(0) without time zone,
    expiry_date timestamp(0) without time zone,
    update_timestamp timestamp(0) without time zone
);

DROP TABLE IF EXISTS bcts_staging.fta_sb_category_code;

CREATE TABLE IF NOT EXISTS bcts_staging.fta_sb_category_code
(
    sb_category_code character varying(1) COLLATE pg_catalog."default",
    description character varying(120) COLLATE pg_catalog."default",
    effective_date timestamp(0) without time zone,
    expiry_date timestamp(0) without time zone,
    update_timestamp timestamp(0) without time zone
);

DROP TABLE IF EXISTS bcts_staging.fta_harvest_sale;

CREATE TABLE IF NOT EXISTS bcts_staging.fta_harvest_sale
(
    forest_file_id character varying(10) COLLATE pg_catalog."default",
    sb_fund_ind character varying(1) COLLATE pg_catalog."default",
    sale_method_code character varying(1) COLLATE pg_catalog."default",
    sale_type_cd character varying(2) COLLATE pg_catalog."default",
    planned_sale_date timestamp(0) without time zone,
    tender_opening_dt timestamp(0) without time zone,
    plnd_sb_cat_code character varying(1) COLLATE pg_catalog."default",
    sold_sb_cat_code character varying(1) COLLATE pg_catalog."default",
    total_bidders numeric(5,0),
    lumpsum_bonus_amt numeric(11,2),
    cash_sale_est_vol numeric(13,2),
    cash_sale_tot_dol numeric(11,2),
    payment_method_cd character varying(1) COLLATE pg_catalog."default",
    salvage_ind character varying(1) COLLATE pg_catalog."default",
    sale_volume numeric(10,0),
    admin_area_ind character varying(1) COLLATE pg_catalog."default",
    minor_facility_ind character varying(1) COLLATE pg_catalog."default",
    bcts_org_unit numeric(10,0),
    fta_bonus_bid numeric(11,2),
    fta_bonus_offer numeric(11,2),
    revision_count numeric(5,0),
    entry_timestamp timestamp(0) without time zone,
    update_timestamp timestamp(0) without time zone
);

DROP TABLE IF EXISTS bcts_staging.fta_tsa_number_code;

CREATE TABLE IF NOT EXISTS bcts_staging.fta_tsa_number_code
(
    tsa_number character varying(2) COLLATE pg_catalog."default",
    description character varying(120) COLLATE pg_catalog."default",
    effective_date timestamp(0) without time zone,
    expiry_date timestamp(0) without time zone,
    update_timestamp timestamp(0) without time zone
);

DROP TABLE IF EXISTS bcts_staging.fta_forest_file_client;

CREATE TABLE IF NOT EXISTS bcts_staging.fta_forest_file_client
(
    forest_file_client_skey numeric(10,0),
    forest_file_id character varying(10) COLLATE pg_catalog."default",
    client_number character varying(8) COLLATE pg_catalog."default",
    client_locn_code character varying(2) COLLATE pg_catalog."default",
    forest_file_client_type_code character varying(1) COLLATE pg_catalog."default",
    licensee_start_date date,
    licensee_end_date date,
    revision_count numeric(5,0),
    entry_timestamp timestamp(0) without time zone,
    update_timestamp timestamp(0) without time zone
);


DROP TABLE IF EXISTS bcts_staging.fta_timber_mark;

CREATE TABLE IF NOT EXISTS bcts_staging.fta_timber_mark
(
    timber_mark character varying(6) COLLATE pg_catalog."default",
    forest_file_id character varying(10) COLLATE pg_catalog."default",
    cutting_permit_id character varying(3) COLLATE pg_catalog."default",
    forest_district integer,
    geographic_distrct integer,
    cascade_split_code character varying(1) COLLATE pg_catalog."default",
    quota_type_code character varying(1) COLLATE pg_catalog."default",
    deciduous_ind character(1) COLLATE pg_catalog."default",
    catastrophic_ind character(1) COLLATE pg_catalog."default",
    crown_granted_ind character(1) COLLATE pg_catalog."default",
    cruise_based_ind character(1) COLLATE pg_catalog."default",
    certificate character varying(6) COLLATE pg_catalog."default",
    hdbs_timber_mark character varying(7) COLLATE pg_catalog."default",
    vm_timber_mark character varying(6) COLLATE pg_catalog."default",
    tenure_term integer,
    bcaa_folio_number character varying(23) COLLATE pg_catalog."default",
    activated_userid character varying(30) COLLATE pg_catalog."default",
    amended_userid character varying(30) COLLATE pg_catalog."default",
    district_admn_zone character varying(4) COLLATE pg_catalog."default",
    granted_acqrd_date timestamp(0) without time zone,
    lands_region character varying(1) COLLATE pg_catalog."default",
    crown_granted_acq_desc character varying(240) COLLATE pg_catalog."default",
    mark_status_st character varying(3) COLLATE pg_catalog."default",
    mark_status_date timestamp(0) without time zone,
    mark_amend_date timestamp(0) without time zone,
    mark_appl_date timestamp(0) without time zone,
    mark_cancel_date timestamp(0) without time zone,
    mark_extend_date timestamp(0) without time zone,
    mark_extend_rsn_cd character varying(1) COLLATE pg_catalog."default",
    mark_extend_count integer,
    mark_issue_date timestamp(0) without time zone,
    mark_expiry_date timestamp(0) without time zone,
    markng_instrmnt_cd character varying(1) COLLATE pg_catalog."default",
    marking_method_cd character varying(1) COLLATE pg_catalog."default",
    entry_userid character varying(30) COLLATE pg_catalog."default",
    entry_timestamp timestamp without time zone,
    update_userid character varying(30) COLLATE pg_catalog."default",
    update_timestamp timestamp without time zone,
    revision_count integer,
    small_patch_salvage_ind character(1) COLLATE pg_catalog."default",
    salvage_type_code character varying(3) COLLATE pg_catalog."default"
);

DROP TABLE IF EXISTS bcts_staging.fta_mgmt_unit_type_code;

CREATE TABLE IF NOT EXISTS bcts_staging.fta_mgmt_unit_type_code
(
    mgmt_unit_type_code character varying(1) COLLATE pg_catalog."default",
    description character varying(120) COLLATE pg_catalog."default",
    effective_date timestamp(0) without time zone,
    expiry_date timestamp(0) without time zone,
    update_timestamp timestamp without time zone
);
