CREATE TABLE bcts_staging.fta_tenure_term (
    forest_file_id character varying(10), 
    tenure_term numeric, 
    legal_effective_dt date, 
    initial_expiry_dt date, 
    current_expiry_dt date, 
    tenure_extend_cnt numeric, 
    tenr_extend_rsn_st character varying(10),
     entry_timestamp timestamp without time zone, 
     update_timestamp timestamp without time zone, 
     revision_count numeric
     );

CREATE TABLE bcts_staging.fta_prov_forest_use (
    forest_file_id character varying(10), 
    file_type_code character varying(10), 
    forest_region numeric, 
    file_status_st character varying(10), 
    file_status_date date, 
    bcts_org_unit numeric, 
    sb_funded_ind character varying(10),
    district_admin_zone character varying(4), 
    mgmt_unit_type character varying(10), 
    mgmt_unit_id character varying(4), 
    revision_count numeric, 
    entry_timestamp timestamp without time zone, 
    update_timestamp timestamp without time zone, 
    forest_tenure_guid bytea
    );


CREATE TABLE bcts_staging.fta_tenure_file_status_code (
    tenure_file_status_code character varying(10), 
    description character varying(120), 
    effective_date date, expiry_date date, 
    update_timestamp timestamp without time zone
    );
