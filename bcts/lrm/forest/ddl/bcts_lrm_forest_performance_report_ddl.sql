CREATE TABLE IF NOT EXISTS lrm_replication.operating_area (
    opar_operating_area_id VARCHAR(10) NOT NULL,
    divi_div_nbr NUMERIC(2) NOT NULL,
    opar_operating_area_name VARCHAR(30) NULL,
    ozon_operating_zone_id VARCHAR(10) NOT NULL,
    opar_seq_nbr NUMERIC(15) NOT NULL,
    opar_m3_ha_factor NUMERIC(15, 6) NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(120) NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(120) NULL,
    PRIMARY KEY (opar_seq_nbr)
);

COMMENT ON TABLE lrm_replication.operating_area IS '';

CREATE TABLE IF NOT EXISTS lrm_replication.lrm_vt_commit_lic_type (
    code VARCHAR(2) NULL,
    description VARCHAR(50) NULL,
    activeflag NUMERIC(1) NULL,
    modifiedby VARCHAR(30) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(30) NULL
);


COMMENT ON TABLE lrm_replication.lrm_vt_commit_lic_type IS '';

CREATE TABLE IF NOT EXISTS lrm_replication.permit_allocation (
    peal_seq_nbr NUMERIC(15) NOT NULL,
    perm_seq_nbr NUMERIC(15) NOT NULL,
    manu_seq_nbr NUMERIC(15) NULL,
    divi_div_nbr NUMERIC(2) NOT NULL,
    licn_seq_nbr NUMERIC(15) NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(120) NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(120) NULL,
    PRIMARY KEY (peal_seq_nbr)
);


COMMENT ON TABLE lrm_replication.permit_allocation IS '';

CREATE TABLE IF NOT EXISTS lrm_replication.ctor_contractor_location (
    cloc_seq_nbr NUMERIC(15) NOT NULL,
    ctor_seq_nbr NUMERIC(15) NOT NULL,
    cloc_address_line1 VARCHAR(160) NULL,
    cloc_address_line2 VARCHAR(160) NULL,
    cloc_address_line3 VARCHAR(160) NULL,
    cloc_city VARCHAR(200) NULL,
    cloc_phone_number1 VARCHAR(40) NULL,
    cloc_phone_number2 VARCHAR(40) NULL,
    cloc_fax_number VARCHAR(40) NULL,
    ctry_country_code VARCHAR(40) NULL,
    prov_prov_state_code VARCHAR(40) NULL,
    cloc_postal_code VARCHAR(40) NULL,
    cloc_client_number VARCHAR(10) NULL,
    cloc_client_location_code VARCHAR(10) NULL,
    cloc_client_location_name VARCHAR(160) NULL,
    cloc_locn_expired_ind VARCHAR(4) NULL,
    cloc_returned_mail_date TIMESTAMP NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(120) NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(120) NULL,
    PRIMARY KEY (cloc_seq_nbr)
);


COMMENT ON TABLE lrm_replication.ctor_contractor_location IS '';

CREATE TABLE IF NOT EXISTS lrm_replication.cut_block_silv_regime (
    cbsr_seq_nbr NUMERIC(15) NOT NULL,
    cutb_seq_nbr NUMERIC(15) NOT NULL,
    treg_seq_nbr NUMERIC(15) NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(120) NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(120) NULL
);


COMMENT ON TABLE lrm_replication.cut_block_silv_regime IS '';

CREATE TABLE IF NOT EXISTS lrm_replication.v_res_vt_fdtm_team (
    colu_lookup_type VARCHAR(4) NOT NULL,
    colu_lookup_id VARCHAR(30) NOT NULL,
    divi_div_nbr NUMERIC(2) NOT NULL,
    colu_lookup_desc VARCHAR(150) NOT NULL,
    colu_user_defined_ind VARCHAR(4) NULL,
    colu_display_ind VARCHAR(1) NULL,
    colu_display_order NUMERIC(10) NULL
);


COMMENT ON TABLE lrm_replication.v_res_vt_fdtm_team IS '';

CREATE TABLE IF NOT EXISTS lrm_replication.commitment_partition (
    copa_seq_nbr NUMERIC(15) NOT NULL,
    copa_partition VARCHAR(30) NULL,
    copa_percent NUMERIC(7, 4) NULL,
    mark_seq_nbr INTEGER NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(120) NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(120) NULL,
    cutb_seq_nbr NUMERIC(15) NULL,
    copa_block_id VARCHAR(150) NULL,
    copa_cruise_m3_vol NUMERIC(9) NULL,
    copa_partition_type VARCHAR(150) NULL,
    copa_commit_m3_vol NUMERIC(9) NULL,
    copa_commit_part_percent NUMERIC(3) NULL,
    commit_seq_nbr NUMERIC(15) NULL,
    PRIMARY KEY (copa_seq_nbr)
);


COMMENT ON TABLE lrm_replication.commitment_partition IS '';

CREATE TABLE IF NOT EXISTS lrm_replication.block_seed_zone (
    blsz_seq_nbr NUMERIC(15) NOT NULL,
    cutb_seq_nbr NUMERIC(15) NOT NULL,
    blsz_class_id VARCHAR(80) NOT NULL,
    blsz_species_id VARCHAR(40) NOT NULL,
    blsz_zone_id VARCHAR(80) NOT NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(120) NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(120) NULL,
    silp_seq_nbr NUMERIC(15) NULL,
    PRIMARY KEY (blsz_seq_nbr)
);


COMMENT ON TABLE lrm_replication.block_seed_zone IS '';

CREATE TABLE IF NOT EXISTS lrm_replication.standard_unit (
    stun_seq_nbr NUMERIC(15) NOT NULL,
    silp_seq_nbr NUMERIC(15) NOT NULL,
    stun_id VARCHAR(10) NOT NULL,
    suty_type_id VARCHAR(10) NOT NULL,
    stun_description VARCHAR(4000) NULL,
    stun_gross_ha_area NUMERIC(11, 6) NULL,
    stun_digitised_ind VARCHAR(1) NOT NULL,
    spss_seq_nbr NUMERIC(15) NULL,
    stun_critical_site_conditions VARCHAR(4000) NULL,
    stun_soil_compaction VARCHAR(60) NULL,
    stun_soil_erosion VARCHAR(60) NULL,
    stun_soil_displacement VARCHAR(60) NULL,
    stun_depth_unfavourable_min NUMERIC(13, 4) NULL,
    stun_depth_unfavourable_max NUMERIC(13, 4) NULL,
    stun_type_unfavourable VARCHAR(60) NULL,
    stun_sediment_risk VARCHAR(60) NULL,
    stun_max_disturbance NUMERIC(7, 4) NULL,
    stun_regen_date_early NUMERIC(4) NULL,
    stun_freegrow_date_early NUMERIC(4) NULL,
    stun_freegrow_date_late NUMERIC(4) NULL,
    stun_silvicultural_system_comm VARCHAR(4000) NULL,
    stun_temp_access_max_disturb NUMERIC(7, 4) NULL,
    stun_ncbr_ha_area NUMERIC(11, 6) NULL,
    stun_ncbr_digitised_ind VARCHAR(4) NOT NULL,
    stun_temp_access_bank_height NUMERIC(13, 4) NULL,
    stun_temp_access_avg_bank_hgt NUMERIC(13, 4) NULL,
    stun_temp_access_equipment VARCHAR(800) NULL,
    stun_soil_puddling VARCHAR(60) NULL,
    stun_soil_frost_heave VARCHAR(60) NULL,
    stun_soil_windthrow VARCHAR(60) NULL,
    stun_veg_comp_severity VARCHAR(60) NULL,
    stty_original_standard_type VARCHAR(40) NULL,
    stun_original_std_declare_date TIMESTAMP NULL,
    stun_wet_low_density_ind VARCHAR(4) NOT NULL,
    stun_ms_decl_comment VARCHAR(1000) NULL,
    stun_formc_postharv_prn_date TIMESTAMP NULL,
    stun_formc_regen_prn_date TIMESTAMP NULL,
    stun_formc_freegrow_prn_date TIMESTAMP NULL,
    stds_seq_nbr NUMERIC(15) NULL,
    stun_site_index NUMERIC(5) NULL,
    stun_other_perf_standards VARCHAR(4000) NULL,
    stun_pathway VARCHAR(40) NULL,
    stun_si_species VARCHAR(60) NULL,
    stun_brush_hazard VARCHAR(120) NULL,
    stun_browse_hazard VARCHAR(120) NULL,
    stun_si_source VARCHAR(120) NULL,
    stun_non_mappable_area NUMERIC(11, 6) NULL,
    stun_designation_code VARCHAR(80) NULL,
    stun_declaration_area NUMERIC(11, 6) NULL,
    stun_declaration_area_lock_ind VARCHAR(4) NULL,
    stun_prev_postharv_prn_date TIMESTAMP NULL,
    stun_prev_regen_prn_date TIMESTAMP NULL,
    stun_prev_freegrow_prn_date TIMESTAMP NULL,
    stun_objective_type VARCHAR(4) NULL,
    stun_regen_obligation_ind VARCHAR(4) NOT NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(120) NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(120) NULL,
    PRIMARY KEY (stun_seq_nbr)
);


COMMENT ON TABLE lrm_replication.standard_unit IS 'A portion of a cutblock with similar site conditions, such as soil type, moisture levels, and vegetation. Standard units are used to define silviculture obligations and manage silviculture activities towards legal objectives.';

CREATE TABLE IF NOT EXISTS lrm_replication.apportionment (
    appo_seq_nbr NUMERIC(15) NOT NULL,
    manu_seq_nbr NUMERIC(15) NOT NULL,
    appo_tenure_type VARCHAR(120) NOT NULL,
    appo_date TIMESTAMP NOT NULL,
    appo_m3_vol NUMERIC(15, 6) NULL,
    pers_seq_nbr NUMERIC(15) NULL,
    corp_user_id VARCHAR(10) NULL,
    appo_comments VARCHAR(4000) NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(120) NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(120) NULL,
    fiyr NUMERIC(4) NULL,
    dispo_agreement VARCHAR(100) NULL,
    appo_end_date TIMESTAMP NULL,
    dispo_recv_lic_nmb VARCHAR(100) NULL,
    appo_m3_vol_prorated NUMERIC(15, 6) NULL,
    non_bcts_tenure_holder VARCHAR(100) NULL,
    fn_code VARCHAR(5) NULL,
    resources_data_ind NUMERIC(1) NULL,
    formula VARCHAR(150) NULL,
    PRIMARY KEY (appo_seq_nbr)
);


COMMENT ON TABLE lrm_replication.apportionment IS 'The resultant from the Chief Forester''s  determination of dividing and distributing the Allowable Annual Cut (AAC) of a Timber Supply Area (TSA)  among various types of forest tenures and providing BCTS with an allocated volume available to auction over the business cycle.';

CREATE TABLE IF NOT EXISTS lrm_replication.silv_treatment_regime (
    treg_seq_nbr NUMERIC(15) NOT NULL,
    pers_seq_nbr NUMERIC(15) NULL,
    divi_div_nbr NUMERIC(2) NOT NULL,
    treg_regime_id VARCHAR(40) NOT NULL,
    treg_regime_name VARCHAR(200) NOT NULL,
    treg_create_date TIMESTAMP NOT NULL,
    treg_active_ind VARCHAR(4) NOT NULL,
    treg_def_ind VARCHAR(4) NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(120) NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(120) NULL,
    PRIMARY KEY (treg_seq_nbr)
);


COMMENT ON TABLE lrm_replication.silv_treatment_regime IS 'Preset of silvicultural treatment activities , outlining common  sequences of activities for any given biogeoclimatic zone that offer an initiation for silvicultural  strategies to manage a standard unit towards legal obligations.';

CREATE TABLE IF NOT EXISTS lrm_replication.person (
    pers_seq_nbr NUMERIC(15) NOT NULL,
    divi_div_nbr NUMERIC(2) NOT NULL,
    pers_first_name VARCHAR(200) NULL,
    pers_last_name VARCHAR(200) NULL,
    pers_display_name VARCHAR(50) NULL,
    pers_person_number VARCHAR(20) NULL,
    pers_phone_number VARCHAR(20) NULL,
    pers_email VARCHAR(50) NULL,
    pers_fax VARCHAR(20) NULL,
    ctor_seq_nbr NUMERIC(15) NULL,
    tpct_category_id VARCHAR(40) NULL,
    tpdp_department_id VARCHAR(40) NULL,
    pers_comment VARCHAR(4000) NULL,
    pers_active_ind VARCHAR(1) NULL,
    pers_inactive_date TIMESTAMP NULL,
    pers_professional_number VARCHAR(20) NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(120) NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(120) NULL,
    PRIMARY KEY (pers_seq_nbr)
);


COMMENT ON TABLE lrm_replication.person IS '';

CREATE TABLE IF NOT EXISTS lrm_replication.bcts_harvest_history (
    bchh_seq_nbr NUMERIC(15) NOT NULL,
    mark_seq_nbr NUMERIC(15) NOT NULL,
    bchh_billing_year NUMERIC(4) NULL,
    bchh_billing_month NUMERIC(4) NULL,
    bchh_billing_period TIMESTAMP NULL,
    bchh_hdbs_tree_species VARCHAR(2) NULL,
    bchh_forest_product_code VARCHAR(8) NULL,
    bchh_log_grade VARCHAR(1) NULL,
    bchh_billing_type_code VARCHAR(8) NULL,
    bchh_volume_billed NUMERIC(9, 2) NULL,
    bchh_pieces_billed NUMERIC(10) NULL,
    bchh_royalty_amount NUMERIC(11, 2) NULL,
    bchh_reserve_stmpg_amt NUMERIC(9, 2) NULL,
    bchh_bonus_stumpage_amt NUMERIC(9, 2) NULL,
    bchh_silv_levy_amount NUMERIC(9, 2) NULL,
    bchh_dev_levy_amount NUMERIC(9, 2) NULL,
    bchh_update_timestamp TIMESTAMP NULL,
    bchh_update_userid VARCHAR(32) NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(120) NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(120) NULL,
    PRIMARY KEY (bchh_seq_nbr)
);


COMMENT ON TABLE lrm_replication.bcts_harvest_history IS '';

CREATE TABLE IF NOT EXISTS lrm_replication.commitments (
    licn_seq_nbr NUMERIC(15) NULL,
    commit_seq_nbr NUMERIC(15) NOT NULL,
    copa_partition VARCHAR(150) NULL,
    copa_commit_appo NUMERIC(15) NULL,
    modifiedby VARCHAR(30) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(30) NULL,
    createdby VARCHAR(30) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(30) NULL,
    manu_seq_nbr NUMERIC(15) NULL,
    copa_commit_lic_type VARCHAR(2) NULL,
    PRIMARY KEY (commit_seq_nbr)
);


COMMENT ON TABLE lrm_replication.commitments IS '';

CREATE TABLE IF NOT EXISTS lrm_replication.ecology_unit (
    ecou_seq_nbr NUMERIC(15) NOT NULL,
    cutb_seq_nbr NUMERIC(15) NOT NULL,
    ecou_name VARCHAR(50) NOT NULL,
    bioz_zone_id VARCHAR(10) NULL,
    bios_subzone_id VARCHAR(10) NULL,
    biov_variant_id VARCHAR(10) NULL,
    ecou_site_type_id VARCHAR(40) NULL,
    ecou_additional_info VARCHAR(160) NULL,
    ecou_ecosite_fit_code VARCHAR(4) NULL,
    ecou_ha_area NUMERIC(11, 6) NOT NULL,
    ecou_digitised_ind VARCHAR(4) NULL,
    mreg_edatopic_moisture_id VARCHAR(40) NULL,
    nreg_edatopic_nutrient_id VARCHAR(40) NULL,
    ecou_elevation_min NUMERIC(5) NULL,
    ecou_elevation_max NUMERIC(5) NULL,
    ecou_elevation_avg NUMERIC(5) NULL,
    ecou_aspect VARCHAR(60) NULL,
    ecou_slope_min NUMERIC(7, 4) NULL,
    ecou_slope_max NUMERIC(7, 4) NULL,
    ecou_slope_avg NUMERIC(7, 4) NULL,
    ecou_slope_position VARCHAR(60) NULL,
    ecou_terrain VARCHAR(60) NULL,
    ecou_parent_material VARCHAR(60) NULL,
    ecou_drainage VARCHAR(60) NULL,
    ecou_substrate_decaying_wood NUMERIC(7, 4) NULL,
    ecou_substrate_bedrock NUMERIC(7, 4) NULL,
    ecou_substrate_cobbles NUMERIC(7, 4) NULL,
    ecou_substrate_mineral_soil NUMERIC(7, 4) NULL,
    ecou_substrate_organic NUMERIC(7, 4) NULL,
    ecou_substrate_water NUMERIC(7, 4) NULL,
    ecou_organic_layer VARCHAR(60) NULL,
    ecou_humus_l_depth_min NUMERIC(10, 4) NULL,
    ecou_humus_l_depth_max NUMERIC(10, 4) NULL,
    ecou_humus_f_depth_min NUMERIC(10, 4) NULL,
    ecou_humus_f_depth_max NUMERIC(10, 4) NULL,
    ecou_humus_h_depth_min NUMERIC(10, 4) NULL,
    ecou_humus_h_depth_max NUMERIC(10, 4) NULL,
    ecou_humus_form VARCHAR(60) NULL,
    ecou_soil_order VARCHAR(60) NULL,
    ecou_soil_type VARCHAR(60) NULL,
    ecou_soil_depth_water NUMERIC(10, 4) NULL,
    ecou_soil_depth_water_max NUMERIC(10, 4) NULL,
    ecou_soil_depth_mottles NUMERIC(10, 4) NULL,
    ecou_soil_depth_mottles_max NUMERIC(10, 4) NULL,
    ecou_soil_depth_gleying NUMERIC(10, 4) NULL,
    ecou_soil_depth_gleying_max NUMERIC(10, 4) NULL,
    ecou_soil_depth_calcar NUMERIC(10, 4) NULL,
    ecou_soil_depth_calcar_max NUMERIC(10, 4) NULL,
    ecou_soil_depth_bedrock NUMERIC(10, 4) NULL,
    ecou_soil_depth_bedrock_max NUMERIC(10, 4) NULL,
    ecou_soil_depth_compact NUMERIC(10, 4) NULL,
    ecou_soil_depth_compact_max NUMERIC(10, 4) NULL,
    ecou_soil_rooting_depth NUMERIC(10, 4) NULL,
    ecou_soil_seepage_ind VARCHAR(4) NULL,
    ecou_soil_seepage_depth NUMERIC(10, 4) NULL,
    ecou_soil_pit_depth NUMERIC(10, 4) NULL,
    ecou_soil_acid_test VARCHAR(4) NULL,
    ecou_soil_acid_test_depth NUMERIC(10, 4) NULL,
    ecou_soil_acid_ph_test NUMERIC(9, 6) NULL,
    ecou_soil_comments VARCHAR(4000) NULL,
    ecou_field_guide VARCHAR(160) NULL,
    ecou_field_guide_year NUMERIC(4) NULL,
    ecou_surveyed_by VARCHAR(200) NULL,
    ecou_survey_date TIMESTAMP NULL,
    ecou_comments VARCHAR(4000) NULL,
    ecou_perched_ind VARCHAR(4) NOT NULL,
    ecou_soil_acid_ph VARCHAR(40) NULL,
    bgrg_region_code VARCHAR(10) NULL,
    ecou_soil_op VARCHAR(120) NULL,
    ecou_coarse_fragment VARCHAR(120) NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(120) NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(120) NULL,
    documentkey NUMERIC(9) NULL,
    PRIMARY KEY (ecou_seq_nbr)
);


COMMENT ON TABLE lrm_replication.ecology_unit IS 'A distinct area of a cutblock within common environmental characteristics, such as climate, soil, and vegetation types.';

CREATE TABLE IF NOT EXISTS lrm_replication.sub_operating_area (
    suop_subop_area_id VARCHAR(10) NOT NULL,
    suop_subop_area_name VARCHAR(120) NOT NULL,
    divi_div_nbr NUMERIC(2) NOT NULL,
    opar_operating_area_id VARCHAR(40) NOT NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(120) NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(120) NULL,
    PRIMARY KEY (suop_subop_area_id, divi_div_nbr, opar_operating_area_id)
);


COMMENT ON TABLE lrm_replication.sub_operating_area IS '';

CREATE TABLE IF NOT EXISTS lrm_replication.mark_allocation (
    mark_seq_nbr NUMERIC(15) NOT NULL,
    divi_div_nbr NUMERIC(2) NOT NULL,
    licn_seq_nbr NUMERIC(15) NULL,
    perm_seq_nbr NUMERIC(15) NULL,
    manu_seq_nbr NUMERIC(15) NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(120) NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(120) NULL,
    maal_seq_nbr NUMERIC(15) NULL
);


COMMENT ON TABLE lrm_replication.mark_allocation IS '';

CREATE TABLE IF NOT EXISTS lrm_replication.ctor_contractor (
    ctor_seq_nbr NUMERIC(15) NOT NULL,
    ctor_name VARCHAR(60) NOT NULL,
    ctor_email_address VARCHAR(200) NULL,
    ctor_status_code VARCHAR(8) NULL,
    ctor_internal_code VARCHAR(40) NULL,
    ctor_ems_ind VARCHAR(4) NULL,
    ctor_wcb_nbr NUMERIC(10) NULL,
    ctor_gst VARCHAR(80) NULL,
    ctor_wcb_clearance TIMESTAMP NULL,
    ctor_insurance_liability TIMESTAMP NULL,
    ctor_date_approved TIMESTAMP NULL,
    ctor_expiration_date TIMESTAMP NULL,
    ctor_approved_ind VARCHAR(4) NULL,
    ctor_comment VARCHAR(4000) NULL,
    ctor_id VARCHAR(200) NULL,
    ctor_password VARCHAR(320) NULL,
    ctor_vendor_nbr VARCHAR(40) NULL,
    ctor_post_ap_ind VARCHAR(4) NULL,
    ctor_gst_ind VARCHAR(4) NULL,
    ctor_legal_first_name VARCHAR(120) NULL,
    ctor_legal_middle_name VARCHAR(120) NULL,
    ctor_bcts_client_number VARCHAR(32) NULL,
    ctor_bcts_ocg_client_number VARCHAR(40) NULL,
    ctor_bcts_prime_mailing_locn VARCHAR(8) NULL,
    ctor_bcts_total_balance VARCHAR(56) NULL,
    ctor_birthdate TIMESTAMP NULL,
    ctor_drivers_license VARCHAR(28) NULL,
    ctor_sin VARCHAR(36) NULL,
    ctor_client_other_id VARCHAR(160) NULL,
    ctor_bcts_corp_regn_nmbr VARCHAR(36) NULL,
    ctor_bcts_corp_reporting_ind VARCHAR(4) NULL,
    ctor_risky_contractor VARCHAR(4) NULL,
    ctor_rate_benefit_ind VARCHAR(4) NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(120) NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(120) NULL,
    PRIMARY KEY (ctor_seq_nbr)
);


COMMENT ON TABLE lrm_replication.ctor_contractor IS '';

CREATE TABLE IF NOT EXISTS lrm_replication.licence_allocation (
    licn_seq_nbr NUMERIC(15) NOT NULL,
    divi_div_nbr NUMERIC(2) NOT NULL,
    manu_seq_nbr NUMERIC(15) NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(120) NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(120) NULL
);


COMMENT ON TABLE lrm_replication.licence_allocation IS '';

CREATE TABLE IF NOT EXISTS lrm_replication.silviculture_prescription (
    silp_seq_nbr NUMERIC(15) NOT NULL,
    divi_div_nbr NUMERIC(2) NOT NULL,
    cutb_seq_nbr NUMERIC(15) NOT NULL,
    silp_lterm_man_obj VARCHAR(4000) NULL,
    silp_wildlife VARCHAR(4000) NULL,
    silp_sensitive_areas VARCHAR(4000) NULL,
    silp_fisheries VARCHAR(4000) NULL,
    silp_watersheds VARCHAR(4000) NULL,
    silp_recreation VARCHAR(4000) NULL,
    silp_community_watershed_ind VARCHAR(4) NULL,
    silp_bio_diversity VARCHAR(4000) NULL,
    silp_wildlife_tree_credit_ha NUMERIC(7, 2) NULL,
    silp_visual_landscape VARCHAR(4000) NULL,
    silp_visual_assessment VARCHAR(4) NOT NULL,
    silp_cultural_heritage VARCHAR(4000) NULL,
    silp_range VARCHAR(4000) NULL,
    silp_range_tenure_holder VARCHAR(800) NULL,
    silp_other_resources VARCHAR(4000) NULL,
    silp_trapper_registration VARCHAR(200) NULL,
    silp_guide_registration VARCHAR(200) NULL,
    silp_na_conditions VARCHAR(4000) NULL,
    silp_riparian_assessment VARCHAR(4) NOT NULL,
    silp_gully_manage_strategy VARCHAR(4000) NULL,
    silp_gully_assessment VARCHAR(4) NOT NULL,
    silp_forest_health VARCHAR(4000) NULL,
    silp_pest_assessment VARCHAR(4) NOT NULL,
    silp_coarse_woody_debris VARCHAR(4000) NULL,
    silp_archaeological_sites VARCHAR(4000) NULL,
    silp_archaeology_assessment VARCHAR(4) NOT NULL,
    silp_vegetation_management VARCHAR(4000) NULL,
    silp_livestock_used VARCHAR(4) NULL,
    silp_slope_instability VARCHAR(4000) NULL,
    silp_slope_assessment VARCHAR(3) NOT NULL,
    silp_perm_access_max_pct NUMERIC(7, 4) NULL,
    silp_temp_access_max_rehab NUMERIC(10) NULL,
    silp_temp_access_max_disturb NUMERIC(7, 4) NULL,
    silp_temp_access_location VARCHAR(800) NULL,
    silp_temp_access_bank_height NUMERIC(13, 4) NULL,
    silp_temp_access_avg_bank_hgt NUMERIC(13, 4) NULL,
    silp_temp_access_equipment VARCHAR(800) NULL,
    silp_temp_access_ha_area NUMERIC(11, 6) NULL,
    silp_soil_cons_comments VARCHAR(4000) NULL,
    silp_stocking_req_comments VARCHAR(4000) NULL,
    pers_seq_nbr NUMERIC(15) NULL,
    silp_sp_report_format VARCHAR(40) NULL,
    silp_amendments_comments VARCHAR(4000) NULL,
    silp_temp_access_comments VARCHAR(4000) NULL,
    silp_riparian_comments VARCHAR(4000) NULL,
    silp_bio_diversity_calc_ind VARCHAR(4) NULL,
    silp_rpf_certify_comments VARCHAR(4000) NULL,
    silp_admin_assessment_comments VARCHAR(4000) NULL,
    silp_use_block_num_ind VARCHAR(4) NOT NULL,
    silp_coarse_woody_debris_m3_ha NUMERIC(7, 2) NULL,
    silp_bio_diversity_pct NUMERIC(3) NULL,
    silp_lichen_assessment VARCHAR(4) NULL,
    silp_roadside_disturb_max_pct NUMERIC(7, 4) NULL,
    silp_biodiv_perf_std_start_pct NUMERIC(7, 3) NULL,
    silp_bio_divers_block_tgt_pct NUMERIC(7, 3) NULL,
    silp_cwd_perf_std_pct NUMERIC(7, 3) NULL,
    silp_cwd_block_tgt_pct NUMERIC(7, 3) NULL,
    silp_perm_access_max_area NUMERIC(11, 6) NULL,
    silp_additional_comments VARCHAR(4000) NULL,
    silp_pest_required VARCHAR(4) NULL,
    silp_visual_required VARCHAR(4) NULL,
    silp_vegetation_required VARCHAR(4) NULL,
    silp_raiparian_required VARCHAR(4) NULL,
    silp_fhealth_required VARCHAR(4) NULL,
    silp_gully_required VARCHAR(4) NULL,
    silp_archeosite_required VARCHAR(4) NULL,
    silp_slope_required VARCHAR(3) NULL,
    silp_lichen_required VARCHAR(4) NULL,
    silp_forest_health_pest VARCHAR(4000) NULL,
    silp_biodiv_perf_std_end_pct NUMERIC(7, 3) NULL,
    slip_updated_by VARCHAR(200) NULL,
    slip_updated_date TIMESTAMP NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(120) NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(120) NULL,
    fspm_seq_nbr NUMERIC(15) NULL,
    PRIMARY KEY (silp_seq_nbr)
);

COMMENT ON TABLE lrm_replication.silviculture_prescription IS 'A detailed plan outlining  specific silviculture treatments and practices required to successfully regenerate a harvested area  based on factors such as site conditions, ecology units, legal requirements, and management objectives.';


CREATE TABLE IF NOT EXISTS lrm_replication.licensee (
    lsee_licensee_id VARCHAR(40) NOT NULL,
    lsee_licensee_name VARCHAR(120) NOT NULL,
    lsee_client_code VARCHAR(60) NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(120) NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(120) NULL,
    PRIMARY KEY (lsee_licensee_id)
);


COMMENT ON TABLE lrm_replication.licensee IS '';


CREATE TABLE IF NOT EXISTS lrm_replication.licence_shape_evw (
    objectid NUMERIC(38) NULL,
    transaction_id VARCHAR(8) NULL,
    licn_seq_nbr NUMERIC(16) NULL,
    feature_len NUMERIC(38, 8) NULL,
    feature_area NUMERIC(38, 8) NULL,
    shape_len NUMERIC(38, 8) NULL,
    shape_area NUMERIC(38, 8) NULL,
    shape GEOMETRY NULL,
    manu_seq_nbr NUMERIC(15) NULL,
    modifiedby VARCHAR(30) NULL,
    modifiedon TIMESTAMP(6) NULL,
    modifiedusing VARCHAR(30) NULL,
    createdby VARCHAR(30) NULL,
    createdon TIMESTAMP(6) NULL,
    createdusing VARCHAR(30) NULL,
    sde_state_id INTEGER NULL
);


COMMENT ON TABLE lrm_replication.licence_shape_evw IS '';


CREATE TABLE bcts_staging.licence_issued_advertised_lrm (
    business_area_region_category text, 
    business_area_region text, 
    business_area text, 
    licence_id character varying, 
    management_unit character varying, 
    district text, 
    category_id_lrm character varying, 
    lrm_total_volume numeric, 
    count_all_blocks_in_licence bigint, 
    lrm_total_volume_salvage_all_fire_years numeric, 
    count_blocks_salvage_any_fire_year bigint, 
    lrm_total_volume_salvage_2021_fire numeric, 
    count_blocks_salvage_21_fire bigint, 
    lrm_total_volume_salvage_2022_fire numeric, 
    count_blocks_salvage_22_fire bigint, 
    lrm_total_volume_salvage_2023_fire numeric, 
    count_blocks_salvage_23_fire bigint, 
    lrm_total_volume_salvage_2024_fire numeric, 
    count_blocks_salvage_24_fire bigint, 
    lrm_total_volume_salvage_2025_fire numeric, 
    count_blocks_salvage_25_fire bigint, 
    licn_seq_nbr numeric);


CREATE OR REPLACE VIEW bcts_staging.FOREST_OPERATING_AREA AS
SELECT * FROM lrm_replication.OPERATING_AREA;


CREATE OR REPLACE VIEW bcts_staging.FOREST_LRM_VT_COMMIT_LIC_TYPE AS
SELECT * FROM lrm_replication.LRM_VT_COMMIT_LIC_TYPE;


CREATE OR REPLACE VIEW bcts_staging.FOREST_PERMIT_ALLOCATION AS
SELECT * FROM lrm_replication.PERMIT_ALLOCATION;


CREATE OR REPLACE VIEW bcts_staging.FOREST_CTOR_CONTRACTOR_LOCATION AS
SELECT * FROM lrm_replication.CTOR_CONTRACTOR_LOCATION;


CREATE OR REPLACE VIEW bcts_staging.FOREST_CUT_BLOCK_SILV_REGIME AS
SELECT * FROM lrm_replication.CUT_BLOCK_SILV_REGIME;


CREATE OR REPLACE VIEW bcts_staging.FOREST_V_RES_VT_FDTM_TEAM AS
SELECT * FROM lrm_replication.V_RES_VT_FDTM_TEAM;


CREATE OR REPLACE VIEW bcts_staging.FOREST_COMMITMENT_PARTITION AS
SELECT * FROM lrm_replication.COMMITMENT_PARTITION;


CREATE OR REPLACE VIEW bcts_staging.FOREST_BLOCK_SEED_ZONE AS
SELECT * FROM lrm_replication.BLOCK_SEED_ZONE;


CREATE OR REPLACE VIEW bcts_staging.FOREST_STANDARD_UNIT AS
SELECT * FROM lrm_replication.STANDARD_UNIT;


CREATE OR REPLACE VIEW bcts_staging.FOREST_APPORTIONMENT AS
SELECT * FROM lrm_replication.APPORTIONMENT;


CREATE OR REPLACE VIEW bcts_staging.FOREST_SILV_TREATMENT_REGIME AS
SELECT * FROM lrm_replication.SILV_TREATMENT_REGIME;


CREATE OR REPLACE VIEW bcts_staging.FOREST_PERSON AS
SELECT * FROM lrm_replication.PERSON;


CREATE OR REPLACE VIEW bcts_staging.FOREST_BCTS_HARVEST_HISTORY AS
SELECT * FROM lrm_replication.BCTS_HARVEST_HISTORY;


CREATE OR REPLACE VIEW bcts_staging.FOREST_COMMITMENTS AS
SELECT * FROM lrm_replication.COMMITMENTS;


CREATE OR REPLACE VIEW bcts_staging.FOREST_ECOLOGY_UNIT AS
SELECT * FROM lrm_replication.ECOLOGY_UNIT;


CREATE OR REPLACE VIEW bcts_staging.FOREST_SUB_OPERATING_AREA AS
SELECT * FROM lrm_replication.SUB_OPERATING_AREA;


CREATE OR REPLACE VIEW bcts_staging.FOREST_MARK_ALLOCATION AS
SELECT * FROM lrm_replication.MARK_ALLOCATION;


CREATE OR REPLACE VIEW bcts_staging.FOREST_CTOR_CONTRACTOR AS
SELECT * FROM lrm_replication.CTOR_CONTRACTOR;


CREATE OR REPLACE VIEW bcts_staging.FOREST_LICENCE_ALLOCATION AS
SELECT * FROM lrm_replication.LICENCE_ALLOCATION;


CREATE OR REPLACE VIEW bcts_staging.FOREST_SILVICULTURE_PRESCRIPTION AS
SELECT * FROM lrm_replication.SILVICULTURE_PRESCRIPTION;


CREATE OR REPLACE VIEW bcts_staging.FOREST_LICENSEE AS
SELECT * FROM lrm_replication.LICENSEE;


CREATE OR REPLACE VIEW bcts_staging.FOREST_LICENCE_SHAPE_EVW AS
SELECT * FROM lrm_replication.LICENCE_SHAPE_EVW;
    
DROP VIEW IF EXISTS BCTS_STAGING.DIVISION CASCADE;
CREATE OR REPLACE VIEW bcts_staging.FOREST_DIVISION AS
SELECT * FROM lrm_replication.DIVISION;

DROP VIEW IF EXISTS BCTS_STAGING.BLOCK_ALLOCATION CASCADE;
CREATE OR REPLACE VIEW bcts_staging.FOREST_BLOCK_ALLOCATION AS
SELECT * FROM lrm_replication.BLOCK_ALLOCATION;

DROP VIEW IF EXISTS BCTS_STAGING.MANAGEMENT_UNIT CASCADE;
CREATE OR REPLACE VIEW bcts_staging.FOREST_MANAGEMENT_UNIT AS
SELECT * FROM lrm_replication.MANAGEMENT_UNIT;

DROP VIEW IF EXISTS BCTS_STAGING.LICENCE CASCADE;
CREATE OR REPLACE VIEW bcts_staging.FOREST_LICENCE AS
SELECT * FROM lrm_replication.LICENCE;

DROP VIEW IF EXISTS BCTS_STAGING.BLOCK_ADMIN_ZONE CASCADE;
CREATE OR REPLACE VIEW bcts_staging.FOREST_BLOCK_ADMIN_ZONE AS
SELECT * FROM lrm_replication.BLOCK_ADMIN_ZONE;

DROP VIEW IF EXISTS BCTS_STAGING.DIVISION_CODE_LOOKUP CASCADE;
CREATE OR REPLACE VIEW bcts_staging.FOREST_DIVISION_CODE_LOOKUP AS
SELECT * FROM lrm_replication.DIVISION_CODE_LOOKUP;

DROP VIEW IF EXISTS BCTS_STAGING.CODE_LOOKUP CASCADE;
CREATE OR REPLACE VIEW bcts_staging.FOREST_CODE_LOOKUP AS
SELECT * FROM lrm_replication.CODE_LOOKUP;

DROP VIEW IF EXISTS BCTS_STAGING.TENURE_TYPE CASCADE;
CREATE OR REPLACE VIEW bcts_staging.FOREST_TENURE_TYPE AS
SELECT * FROM lrm_replication.TENURE_TYPE;

DROP VIEW IF EXISTS BCTS_STAGING.CUT_PERMIT CASCADE;
CREATE OR REPLACE VIEW bcts_staging.FOREST_CUT_PERMIT AS
SELECT * FROM lrm_replication.CUT_PERMIT;

DROP VIEW IF EXISTS BCTS_STAGING.MARK CASCADE;
CREATE OR REPLACE VIEW bcts_staging.FOREST_MARK AS
SELECT * FROM lrm_replication.MARK;

DROP VIEW IF EXISTS BCTS_STAGING.DIVISION_CODE_LOOKUP CASCADE;
CREATE OR REPLACE VIEW bcts_staging.FOREST_DIVISION_CODE_LOOKUP AS
SELECT * FROM lrm_replication.DIVISION_CODE_LOOKUP;

DROP VIEW IF EXISTS BCTS_STAGING.CUT_BLOCK CASCADE;
CREATE OR REPLACE VIEW bcts_staging.FOREST_CUT_BLOCK AS
SELECT * FROM lrm_replication.CUT_BLOCK;

DROP VIEW IF EXISTS BCTS_STAGING.ACTIVITY_CLASS CASCADE;
CREATE OR REPLACE VIEW bcts_staging.FOREST_ACTIVITY_CLASS AS
SELECT * FROM lrm_replication.ACTIVITY_CLASS;

DROP VIEW IF EXISTS BCTS_STAGING.ACTIVITY_TYPE CASCADE;
CREATE OR REPLACE VIEW bcts_staging.FOREST_ACTIVITY_TYPE AS
SELECT * FROM lrm_replication.ACTIVITY_TYPE;

DROP VIEW IF EXISTS BCTS_STAGING.ACTIVITY CASCADE;
CREATE OR REPLACE VIEW bcts_staging.FOREST_ACTIVITY AS
SELECT * FROM lrm_replication.ACTIVITY;


CREATE OR REPLACE VIEW BCTS_STAGING.V_BLOCK AS
SELECT D.DIVI_DIV_NBR,
             D.DIVI_SHORT_CODE                         AS TSO_CODE,
             D.DIVI_DIVISION_NAME                      AS TSO_NAME,
             COLU.COLU_LOOKUP_DESC                     AS FIELD_TEAM_DESC,
             M.MANU_ID                                 AS NAV_NAME,
             TN.TENT_TENURE_ID                         AS TENURE,
             L.LICN_LICENCE_ID                         AS LICENCE_ID,
			 CASE 
				 WHEN UPPER(SUBSTRING(P.PERM_PERMIT_ID FROM 1 FOR 4)) = 'APR-' THEN NULL 
				 ELSE P.PERM_PERMIT_ID 
			 END AS PERMIT_ID,
             MK.MARK_MARK_ID                           AS MARK_ID,
             B.CUTB_BLOCK_ID                           AS BLOCK_ID,
             B.CUTB_BLOCK_NUMBER                       AS BLOCK_NBR,
             B.CUTB_SYSTEM_ID                          AS UBI,
             B.CUTB_OPENING                            AS OPENING,
             B.OPAR_OPERATING_AREA_ID                  AS OP_AREA,
             OA.OPAR_OPERATING_AREA_NAME,
             OA.OZON_OPERATING_ZONE_ID,
             B.SBLK_SUPPLY_BLOCK_ID                    AS SUPPLY_BLOCK,
             B.CUTB_EBM_IND                            AS EBM_INDICATOR,
             B.CUTB_PHOTOS                             AS PHOTO,
             TRIM (B.CUTB_LATITUDE)                    AS LATITUDE,
             TRIM (B.CUTB_LONGITUDE)                   AS LONGITUDE,
             B.CUTB_PROV_FOREST_CONFLICT               AS PROV_FRST_CONFLICT,
             B.CUTB_USER_MAPSHEET_ID                   AS MAPSHEET_ID,
             B.LSUN_LANDSCAPE_UNIT                     AS LANDSCAPE_UNIT,
             B.CUTB_SITE_PLAN_EXEMPT_IND               AS SP_EXEMPT,
             B.STTP_STAND_TYPE                         AS STAND_TYPE,
             B.TTAC_TIMBERTYPE_AGE_CLASS               AS AGE_CLASS,
             B.TTHC_TIMBERTYPE_HEIGHT_CLASS            AS HGT_CLASS,
             B.TTSC_TIMBERTYPE_STOCK_CLASS             AS STK_CLASS,
             SI.SITE_INDEX,
             --b.cutb_site_index site_index,
             B.SSSC_SOURCE_CODE                        AS source,
             B.FDPS_STATUS_ID                          AS FDP_STATUS,
             B.FUND_FUNDING_CODE                       AS FUNDING_CODE,
             B.CUTB_BLOCK_MEMO,
             BA.BLAL_GROSS_HA_AREA                     AS GROSS_AREA,
             BA.BLAL_ESTIMATED_AREA                    AS EST_AREA,
             BA.BLAL_MERCH_HA_AREA                     AS MERCH_AREA,
             BA.BLAL_HARVESTED_HA_AREA                 AS HARVEST_AREA,
             (  COALESCE (BA.BLAL_MERCH_HA_AREA, 0)
              - COALESCE (BA.BLAL_HARVESTED_HA_AREA, 0))    AS REMAINING_AREA,
             BA.BLAL_CRUISE_M3_VOL                     AS CRUISE_VOL,
             BA.BLAL_DATA_SOURCE                       AS DATA_SOURCE,
             BA.BLAL_HARVESTED_M3_VOL                  AS HARVEST_VOL,
             (  COALESCE (BA.BLAL_CRUISE_M3_VOL, 0)
              - COALESCE (BA.BLAL_HARVESTED_M3_VOL, 0))     AS REMAINING_VOL,
             BA.BLAL_USR_CRUISE_M3_VOL,
             BA.BLAL_RW_HA_AREA                        AS RW_AREA,
             BA.BLAL_RW_VOL,
             B.CUTB_FORMA_PRINT_DATE,
             B.CUTB_FORMA_PRINTED,
             B.CUTB_BLOCK_STATE,
             B.PMOD_MODIFIER_ID,
             B.CUTB_LOCATION,
             B.SUOP_SUBOP_AREA_ID,
             SUOP.SUOP_SUBOP_AREA_NAME,
             B.CUTB_OPENING_ID,
             l.LICN_LICENCE_STATE,
             SZ.SEED_ZONE,
             CUTB_FILE_ID,
             ELV.MIN_ELEVATION,
             ELV.MAX_ELEVATION,
             B.BCAT_CATEGORY_CODE,
             B.CUTB_ACCESS_RESTRICTION,
             per.PERS_DISPLAY_NAME                     AS REGIME_CREATED_BY,
             STR.TREG_REGIME_ID,
             STR.TREG_REGIME_NAME,
             STR.TREG_CREATE_DATE,
             STR.TREG_ACTIVE_IND,
             STR.TREG_DEF_IND,
             m.MANU_NAME                               AS NAV_ID,
             B.FINZ_FOREST_INVENTORY_ZONE_ID           AS FIZ,
             HV.HVS_STATUS,
             HV.HVS_TARGET_DATE,
             HV.HVS_STATUS_DATE,
             HV.HVC_STATUS,
             HV.HVC_TARGET_DATE,
             HV.HVC_STATUS_DATE,
             M.MANU_SEQ_NBR,
             L.LICN_SEQ_NBR,
             P.PERM_SEQ_NBR,
             MK.MARK_SEQ_NBR,
             B.CUTB_SEQ_NBR,
			 B.CUTB_CPRP_PROTECTION_IND,
			 B.CUTB_RC_RISK_RATING,
			 B.CUTB_RC_RISK_SOURCE
        FROM LRM_REPLICATION.CUT_BLOCK            B
		 INNER JOIN LRM_REPLICATION.DIVISION             D
		 ON B.DIVI_DIV_NBR = D.DIVI_DIV_NBR
		 LEFT JOIN LRM_REPLICATION.BLOCK_ALLOCATION     BA
		 ON B.CUTB_SEQ_NBR = BA.CUTB_SEQ_NBR
		 LEFT JOIN LRM_REPLICATION.MANAGEMENT_UNIT      M
		 ON BA.MANU_SEQ_NBR = M.MANU_SEQ_NBR
		 LEFT JOIN LRM_REPLICATION.LICENCE              L
		 ON BA.LICN_SEQ_NBR = L.LICN_SEQ_NBR
		 LEFT JOIN LRM_REPLICATION.TENURE_TYPE          TN
		 ON L.TENT_SEQ_NBR = TN.TENT_SEQ_NBR
		 LEFT JOIN LRM_REPLICATION.CUT_PERMIT           P
		 ON BA.PERM_SEQ_NBR = P.PERM_SEQ_NBR
		 LEFT JOIN LRM_REPLICATION.MARK                 MK
		 ON BA.MARK_SEQ_NBR = MK.MARK_SEQ_NBR
		 LEFT JOIN LRM_REPLICATION.OPERATING_AREA       OA
		 ON B.DIVI_DIV_NBR = OA.DIVI_DIV_NBR
		 LEFT JOIN LRM_REPLICATION.CUT_BLOCK_SILV_REGIME CBSR
		 ON B.CUTB_SEQ_NBR = CBSR.CUTB_SEQ_NBR
		 LEFT JOIN LRM_REPLICATION.SILV_TREATMENT_REGIME STR
		 ON CBSR.TREG_SEQ_NBR = STR.TREG_SEQ_NBR
		 LEFT JOIN LRM_REPLICATION.CODE_LOOKUP          COLU
		 ON L.LICN_FIELD_TEAM_ID = COLU.COLU_LOOKUP_ID
             AND COLU.COLU_LOOKUP_TYPE = 'FDTM'
		 LEFT JOIN LRM_REPLICATION.SUB_OPERATING_AREA   SUOP
		 ON B.SUOP_SUBOP_AREA_ID = SUOP.SUOP_SUBOP_AREA_ID
             AND B.DIVI_DIV_NBR = SUOP.DIVI_DIV_NBR
             AND B.OPAR_OPERATING_AREA_ID = SUOP.OPAR_OPERATING_AREA_ID
		 LEFT JOIN LRM_REPLICATION.PERSON               PER
		 ON STR.PERS_SEQ_NBR = PER.PERS_SEQ_NBR
		 LEFT JOIN 
		 (
			   /* Logging Started */
              SELECT A0.CUTB_SEQ_NBR,
				MAX (
				CASE 
					WHEN AT0.actt_key_ind = 'HVC' THEN A0.acti_status_ind
					ELSE NULL
				END) AS HVC_STATUS,
				
				MAX(
				CASE 
					WHEN AT0.actt_key_ind = 'HVC' THEN A0.acti_target_date
					ELSE NULL
				END
				) AS HVC_TARGET_DATE,
			
				MAX(
				CASE 
					WHEN AT0.actt_key_ind = 'HVC' THEN A0.acti_status_date
					ELSE NULL
				END
				) AS HVC_STATUS_DATE,
			
				MAX(
				CASE 
					WHEN AT0.actt_key_ind = 'HVS' THEN A0.acti_status_ind
					ELSE NULL
				END
				) AS HVS_STATUS,
			
				MAX(
				CASE 
					WHEN AT0.actt_key_ind = 'HVS' THEN A0.acti_target_date
					ELSE NULL
				END
				) AS HVS_TARGET_DATE,
			
				MAX(
				CASE 
					WHEN AT0.actt_key_ind = 'HVS' THEN A0.acti_status_date
					ELSE NULL
				END
				) AS HVS_STATUS_DATE
			
			FROM LRM_REPLICATION.activity_type AT0
            INNER JOIN LRM_REPLICATION.activity A0
			ON AT0.actt_seq_nbr = A0.actt_seq_nbr
				AND AT0.actt_key_ind IN ('HVC', 'HVS')
				AND A0.plan_seq_nbr IS NULL
			GROUP BY A0.CUTB_SEQ_NBR) HV
		 ON B.cutb_seq_nbr = HV.cutb_seq_nbr
		 LEFT JOIN 
		 /* Elevation */
			(  SELECT EU.CUTB_SEQ_NBR,
					MIN (EU.ECOU_ELEVATION_MIN)     AS MIN_ELEVATION,
					MAX (EU.ECOU_ELEVATION_MAX)     AS MAX_ELEVATION
			   FROM LRM_REPLICATION.ECOLOGY_UNIT EU
			GROUP BY EU.CUTB_SEQ_NBR) ELV
		 ON B.CUTB_SEQ_NBR = ELV.CUTB_SEQ_NBR
		 LEFT JOIN
		  /* Area weighted site index */
		(  SELECT 
			SILP.CUTB_SEQ_NBR,
			ROUND(
			CASE
				WHEN SUM(
						CASE 
							WHEN COALESCE(STUN.STUN_GROSS_HA_AREA, 0) = 0 THEN 0
							WHEN COALESCE(STUN.STUN_SITE_INDEX, 0) = 0 THEN 0
							ELSE STUN.STUN_GROSS_HA_AREA
						END
					) = 0 THEN 0
				ELSE 
					SUM(
						CASE 
							WHEN COALESCE(STUN.STUN_GROSS_HA_AREA, 0) = 0 THEN 0
							WHEN COALESCE(STUN.STUN_SITE_INDEX, 0) = 0 THEN 0
							ELSE STUN.STUN_GROSS_HA_AREA * STUN.STUN_SITE_INDEX
						END
					)
					/ 
					SUM(
						CASE 
							WHEN COALESCE(STUN.STUN_GROSS_HA_AREA, 0) = 0 THEN 0
							WHEN COALESCE(STUN.STUN_SITE_INDEX, 0) = 0 THEN 0
							ELSE STUN.STUN_GROSS_HA_AREA
						END
					)
			END, 
			1
			) AS SITE_INDEX
		FROM LRM_REPLICATION.SILVICULTURE_PRESCRIPTION SILP
		INNER JOIN LRM_REPLICATION.STANDARD_UNIT          STUN
		ON     SILP.SILP_SEQ_NBR = STUN.SILP_SEQ_NBR
			AND STUN.SUTY_TYPE_ID = 'PROD'
		GROUP BY SILP.CUTB_SEQ_NBR) SI
		 ON B.CUTB_SEQ_NBR = SI.CUTB_SEQ_NBR
		 LEFT JOIN
		 /* Seed Zone */
             (
		SELECT SP.CUTB_SEQ_NBR,
		STRING_AGG(SP.BLSZ_ZONE_ID || '(' || SP.SPECIES || ')', ' ' ORDER BY SP.BLSZ_ZONE_ID) AS SEED_ZONE
		FROM (  SELECT BSZ.CUTB_SEQ_NBR,
			  BSZ.BLSZ_ZONE_ID,
			  STRING_AGG(
				BSZ.BLSZ_CLASS_ID::TEXT || ':' || BSZ.BLSZ_SPECIES_ID::TEXT,
				', '
				ORDER BY BSZ.BLSZ_CLASS_ID, BSZ.BLSZ_SPECIES_ID
				) AS SPECIES
		
		 FROM LRM_REPLICATION.BLOCK_SEED_ZONE BSZ
		 GROUP BY BSZ.CUTB_SEQ_NBR, BSZ.BLSZ_ZONE_ID) SP
		GROUP BY SP.CUTB_SEQ_NBR
			 ) SZ
		ON B.CUTB_SEQ_NBR = SZ.CUTB_SEQ_NBR

ORDER BY B.CUTB_SEQ_NBR;


/* Formatted on 2025/01/08 12:01:36 PM (QP5 v5.417) */
CREATE OR REPLACE VIEW BCTS_STAGING.V_LRM_LICENCE_SHAPE
AS
    SELECT /*
                           V1.1     2018-05-30      JZHOU       SQ18387     Added V_TREEFIELD field
                           V2.0    MXIAN       2020-10-26      SQ19482     Add fields: created%, modified%, shape_area
                           V3.0    D.sabatino   2020-12-08      SQ19601    Pull Manu_seq_nbr from the allocation table.
                           */
           lcs.OBJECTID,
           la.MANU_SEQ_NBR,
           lcs.LICN_SEQ_NBR,
           lcs.SHAPE,
           lcs.SDE_STATE_ID,
           'Licence Shape - ' || l.LICN_LICENCE_ID,
           lcs.SHAPE_AREA,
           lcs.MODIFIEDBY,
           lcs.MODIFIEDON,
           lcs.MODIFIEDUSING,
           lcs.CREATEDBY,
           lcs.CREATEDON,
           lcs.CREATEDUSING
      FROM LRM_REPLICATION.LICENCE_ALLOCATION  la
           LEFT JOIN LRM_REPLICATION.LICENCE_SHAPE_EVW lcs
               ON la.licn_seq_nbr = lcs.licn_seq_nbr
           LEFT JOIN LRM_REPLICATION.LICENCE L ON LA.LICN_SEQ_NBR = L.LICN_SEQ_NBR;


CREATE OR REPLACE FUNCTION BCTS_STAGING.SF_CALC_LICENCE_HARV_AREA (
	a_licn_seq_nbr		NUMERIC,
    a_manu_seq_nbr		NUMERIC
)
RETURNS NUMERIC AS $$

DECLARE
    ln_result NUMERIC := 0;
    ls_merch_ha_area NUMERIC(21,6) := 0;
    ls_harvested_ha_area NUMERIC(21,6) := 0;
    ls_cruise_m3_vol NUMERIC(21,6) := 0;
    ls_harvested_m3_vol NUMERIC(21,6) := 0;

BEGIN

    SELECT
    SUM(COALESCE(blal_merch_ha_area, 0)) AS merch_ha_area,
    SUM(COALESCE(blal_harvested_ha_area, 0)) AS harvested_ha_area,
    SUM(COALESCE(blal_cruise_m3_vol, 0)) AS cruise_m3_vol,
    SUM(COALESCE(blal_harvested_m3_vol, 0)) AS harvested_m3_vol
    INTO ls_merch_ha_area, ls_harvested_ha_area, ls_cruise_m3_vol, ls_harvested_m3_vol
    FROM LRM_REPLICATION.block_allocation
    WHERE licn_seq_nbr = a_licn_seq_nbr;


    IF ls_harvested_ha_area > 0 THEN 
        ln_result := ls_harvested_ha_area;
    ELSIF ls_merch_ha_area > 0 AND ls_cruise_m3_vol > 0 THEN 
        ln_result := ls_harvested_m3_vol / (ls_cruise_m3_vol / ls_merch_ha_area);
    ELSE ln_result := 0;
    END IF;

	RETURN ln_result;

END;
$$ LANGUAGE plpgsql; 



CREATE OR REPLACE FUNCTION BCTS_STAGING.SF_CALC_LICENCE_STANDING_AREA(
    a_licn_seq_nbr NUMERIC,
    a_manu_seq_nbr NUMERIC
)
RETURNS NUMERIC AS $$

DECLARE
  ln_result NUMERIC := 0;
  ls_merch_ha_area NUMERIC(21,6) := 0;
  ls_harvested_ha_area NUMERIC(21,6) := 0;
  
BEGIN

  SELECT 
  SUM(COALESCE(blal_merch_ha_area, 0)),
  SUM(COALESCE(blal_harvested_ha_area, 0))
  INTO ls_merch_ha_area, ls_harvested_ha_area
  FROM LRM_REPLICATION.block_allocation
  WHERE block_allocation.licn_seq_nbr = a_licn_seq_nbr;
  
  IF ls_merch_ha_area = BCTS_STAGING.SF_CALC_LICENCE_HARV_AREA(a_licn_seq_nbr, a_manu_seq_nbr) THEN
    ln_result := 0;
  ELSIF BCTS_STAGING.SF_CALC_LICENCE_HARV_AREA(a_licn_seq_nbr, a_manu_seq_nbr) > 0 THEN
    ln_result := ls_merch_ha_area - BCTS_STAGING.SF_CALC_LICENCE_HARV_AREA(a_licn_seq_nbr, a_manu_seq_nbr);
  ELSE
    ln_result := ls_merch_ha_area;
  END IF;
  RETURN ln_result;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE VIEW BCTS_STAGING.V_LRM_LICENCE AS
SELECT                                                           --DISTINCT
	 LRM_REPLICATION.LICENCE_ALLOCATION.MANU_SEQ_NBR,
	  LRM_REPLICATION.LICENCE.DIVI_DIV_NBR,
	  LRM_REPLICATION.LICENCE.LICN_SEQ_NBR,
	  LRM_REPLICATION.LICENCE.LICN_DIGI_IND,
	  LRM_REPLICATION.LICENCE.LICN_LICENCE_ID,
	  LRM_REPLICATION.LICENCE.LICN_CATEGORY_ID,
	  CAST (LRM_REPLICATION.LICENCE.LICN_CROWN_LAND AS VARCHAR (3))
		 AS LICN_CROWN_LAND,
	  LRM_REPLICATION.LICENCE.LICN_CROWN_GRANTED_IND,
	  LRM_REPLICATION.LICENCE.BLAZ_ADMIN_ZONE_ID,
	  LRM_REPLICATION.LICENCE.LICL_LICENCE_CLASS,
	  LRM_REPLICATION.LICENCE.LICN_PARENT_LICENCE,
	  LRM_REPLICATION.LICENCE.LICN_LICENCE_DESC,
	  LRM_REPLICATION.LICENCE.LICN_LICENCE_TO_CUT_CODE,
	  LRM_REPLICATION.LICENCE.LICN_PERMIT_EXISTS_IND,
	  LRM_REPLICATION.LICENCE.LICN_LICENCE_STATE,
	  LRM_REPLICATION.LICENCE.LICN_ANNUAL_ALLOWABLE_CUT,
	  LRM_REPLICATION.LICENCE.LSEE_LICENSEE_ID,
	  LRM_REPLICATION.LICENSEE.LSEE_CLIENT_CODE,
	  --BLAL_CALC.GROSS_AREA,
	  --sq18542 get from cut_block
	  --(SELECT NVL (SUM (V.CUTB_GROSS_HA_AREA), 0)
	  --   FROM LRM_REPLICATION.V_LRM_CUT_BLOCK V
	  -- WHERE V.LICN_SEQ_NBR = LRM_REPLICATION.LICENCE.LICN_SEQ_NBR)
	  --   AS GROSS_AREA,
	  --sq18780 get from licence shape record
	  LS.GROSS_AREA,                    --Rounding added in 18901 fixes
	  CAST (LRM_REPLICATION.LICENCE.LICN_CLIENT_LOCATION_CODE AS VARCHAR (5))
		 AS LICN_CLIENT_LOCATION_CODE,
	  LRM_REPLICATION.LICENCE.LICN_SALVAGE_IND,
	  LRM_REPLICATION.LICENCE.LICN_APPORTION_TENURE_TYPE,
	  LRM_REPLICATION.LICENCE.CTOR_SEQ_NBR,
	  LRM_REPLICATION.LICENCE.TENT_SEQ_NBR,
	  LRM_REPLICATION.LICENCE.LINC_CERT_LEVEL_ID,
	  LRM_REPLICATION.LICENCE.LICN_FIELD_TEAM_ID,
	  LRM_REPLICATION.LICENCE.LICN_HAMMERMARK,
	  LRM_REPLICATION.LICENCE.MODIFIEDBY,
	  LRM_REPLICATION.LICENCE.MODIFIEDON,
	  LRM_REPLICATION.LICENCE.MODIFIEDUSING,
	  LRM_REPLICATION.LICENCE.CREATEDBY,
	  LRM_REPLICATION.LICENCE.CREATEDON,
	  LRM_REPLICATION.LICENCE.CREATEDUSING,
	  ROUND (BLAL_CALC.MERCHANTABLE_AREA, 1) AS MERCHANTABLE_AREA, --Rounding added in 18901 fixes
	  ROUND (
		 BCTS_STAGING.SF_CALC_LICENCE_HARV_AREA(
			LICENCE_ALLOCATION.LICN_SEQ_NBR,
			LICENCE_ALLOCATION.MANU_SEQ_NBR),
		 1)
		 AS HARVESTED_AREA,                --Rounding added in 18901 fixes
	  ROUND (
		 BCTS_STAGING.SF_CALC_LICENCE_STANDING_AREA (
			LICENCE_ALLOCATION.LICN_SEQ_NBR,
			LICENCE_ALLOCATION.MANU_SEQ_NBR),
		 1)
		 AS STANDING_AREA,                 --Rounding added in 18901 fixes
	  ROUND (BLAL_CALC.CRUISE_VOLUME, 0) AS CRUISE_VOLUME, --Rounding added in 18901 fixes
	  ROUND (BLAL_CALC.HARVESTED_VOLUME, 0) AS HARVESTED_VOLUME, --Rounding added in 18901 fixes
	  ROUND (BLAL_CALC.STANDING_VOLUME, 0) AS STANDING_VOLUME, --Rounding added in 18901 fixes
	  ROUND ( (BLAL_CALC.CRUISE_VOLUME - BLAL_CALC.HARVESTED_VOLUME), 0)
		 AS CRUISE_VARIANCE,               --Rounding added in 18901 fixes
	  CASE
        WHEN COUNT(LRM_REPLICATION.LICENCE_ALLOCATION.LICN_SEQ_NBR) OVER (PARTITION BY LRM_REPLICATION.LICENCE.LICN_SEQ_NBR) > 0 
        THEN 'Y'
        ELSE 'N'
    END AS V_LOCK_FIELD,
	  COALESCE(CS.NO_SHAPE, 1) AS NO_SHAPE,
	  LRM_REPLICATION.LICENCE.LICN_ARCHIVE_IND,
	  LRM_REPLICATION.LICENCE.LICN_ARCHIVE_DATE
 FROM LRM_REPLICATION.LICENSEE
	  RIGHT JOIN LRM_REPLICATION.LICENCE
		 ON (LRM_REPLICATION.LICENCE.LSEE_LICENSEE_ID =
				LRM_REPLICATION.LICENSEE.LSEE_LICENSEE_ID)
	  LEFT JOIN LRM_REPLICATION.LICENCE_ALLOCATION
		 ON (LRM_REPLICATION.LICENCE.LICN_SEQ_NBR =
				LRM_REPLICATION.LICENCE_ALLOCATION.LICN_SEQ_NBR)
	  LEFT JOIN
	  (  SELECT LICN_SEQ_NBR,
				SUM (COALESCE (BLAL_GROSS_HA_AREA, 0)) GROSS_AREA,
				SUM (COALESCE (BLAL_MERCH_HA_AREA, 0)) MERCHANTABLE_AREA,
				SUM (COALESCE (BLAL_CRUISE_M3_VOL, 0)) CRUISE_VOLUME,
				SUM (COALESCE (BLAL_HARVESTED_M3_VOL, 0)) HARVESTED_VOLUME,
				SUM (
				   CASE
					  WHEN BLAL_MERCH_HA_AREA = BLAL_HARVESTED_HA_AREA
					  THEN
						 0
					  ELSE
						   BLAL_CRUISE_M3_VOL
						 - COALESCE (BLAL_HARVESTED_M3_VOL, 0)
				   END)
				   STANDING_VOLUME
		   FROM LRM_REPLICATION.BLOCK_ALLOCATION
	   GROUP BY LICN_SEQ_NBR) BLAL_CALC
		 ON (BLAL_CALC.LICN_SEQ_NBR = LICENCE.LICN_SEQ_NBR)
	  LEFT JOIN
	  (  SELECT LICN_SEQ_NBR,
				SUM(COALESCE(ST_IsEmpty(SHAPE)::int, 1)) AS NO_SHAPE
		   FROM LRM_REPLICATION.LICENCE_SHAPE_EVW
	   GROUP BY LICN_SEQ_NBR) CS
		 ON (CS.LICN_SEQ_NBR = LRM_REPLICATION.LICENCE.LICN_SEQ_NBR)
		LEFT JOIN 
	(	SELECT LICN_SEQ_NBR,
		ROUND(CAST(COALESCE(SUM(ST_Area(V.SHAPE)) / 10000, 0) AS numeric), 1) AS GROSS_AREA
		FROM BCTS_STAGING.V_LRM_LICENCE_SHAPE V
		GROUP BY LICN_SEQ_NBR
	) LS
  		ON LS.LICN_SEQ_NBR = LRM_REPLICATION.LICENCE.LICN_SEQ_NBR
	WHERE LRM_REPLICATION.LICENCE_ALLOCATION.LICN_SEQ_NBR IS NOT NULL
		 
-- WHERE (   EXISTS
--              (SELECT 1
--                 FROM lrm.tfm_sys_user_data_priv
--                WHERE username = USER AND unitcode = LICENCE.divi_div_nbr)
--        OR NOT EXISTS
--              (SELECT 1
--                 FROM lrm.tfm_sys_user_data_priv
--                WHERE username = USER))

;




CREATE OR REPLACE VIEW BCTS_STAGING.V_LRM_COMMITMENTS AS

SELECT 
C.LICN_SEQ_NBR,
C.COMMIT_SEQ_NBR,
C.COPA_PARTITION,
C.COPA_COMMIT_APPO,
P.SUM_COPA_COMMIT_M3_VOL                AS V_COPA_COMMIT_M3_VOL,
ROUND (
	(BLAL_CALC.CRUISE_VOLUME
   + BLAL_CALC.REMAIN_VOLUME)
   - SL.SUM_LIC_COPA_COMMIT_M3_VOL)    AS V_REMAIN_COMMIT_M3_VOL,
C.MODIFIEDBY,
C.MODIFIEDON,
C.MODIFIEDUSING,
C.CREATEDBY,
C.CREATEDON,
C.CREATEDUSING,
C.MANU_SEQ_NBR,
C.COPA_COMMIT_LIC_TYPE
FROM LRM_REPLICATION.COMMITMENTS    C
INNER JOIN BCTS_STAGING.V_LRM_LICENCE  L
ON C.LICN_SEQ_NBR = L.LICN_SEQ_NBR
LEFT JOIN 
(  
SELECT 
SUM (COPA_COMMIT_M3_VOL)     SUM_COPA_COMMIT_M3_VOL,
COMMIT_SEQ_NBR               AS P_COMMIT_SEQ_NBR
FROM LRM_REPLICATION.COMMITMENT_PARTITION
GROUP BY COMMIT_SEQ_NBR 
) P
ON P.P_COMMIT_SEQ_NBR = C.COMMIT_SEQ_NBR
LEFT JOIN 
(
    SELECT 
    SUM (COALESCE (COPA_COMMIT_M3_VOL, 0)) AS SUM_LIC_COPA_COMMIT_M3_VOL,
    LICN_SEQ_NBR AS LICN_SEQ_NBR
    FROM LRM_REPLICATION.COMMITMENT_PARTITION CP
    INNER JOIN LRM_REPLICATION.COMMITMENTS C
    ON CP.COMMIT_SEQ_NBR = C.COMMIT_SEQ_NBR
    GROUP BY LICN_SEQ_NBR
) SL
ON SL.LICN_SEQ_NBR = L.LICN_SEQ_NBR
INNER JOIN 
(  
    SELECT SUM (COALESCE (BLAL_CRUISE_M3_VOL, 0))     CRUISE_VOLUME,
		 SUM (COALESCE (BLAL_RW_VOL, 0))            REMAIN_VOLUME,
		 LICN_SEQ_NBR
	FROM LRM_REPLICATION.BLOCK_ALLOCATION
GROUP BY LICN_SEQ_NBR
) BLAL_CALC
ON BLAL_CALC.LICN_SEQ_NBR = L.LICN_SEQ_NBR;





CREATE OR REPLACE VIEW BCTS_STAGING.V_LICENCE AS
SELECT 
DISTINCT
--MXIAN  2022-09-22 SQ19820 update logic of REMAIN_COMMIT_VOLUME
           L.LICN_SEQ_NBR,
           L.TENT_SEQ_NBR,
           L.CTOR_SEQ_NBR,
           L.CLOC_SEQ_NBR,
           D.DIVI_SHORT_CODE
               TSO_CODE,
           D.DIVI_DIVISION_NAME
               TSO_NAME,
           M.MANU_ID
               NAV_NAME,
           L.LICN_LICENCE_ID
               LICENCE_ID,
           LK.COLU_LOOKUP_DESC
               CATEGORY,
           TN.TENT_TENURE_ID
               TENURE,
           L.LSEE_LICENSEE_ID
               LICENSEE,
           CT.CTOR_NAME
               REGISTRANT,
           CL.CLOC_CITY
               REGISTRANT_CITY,
           LKF.COLU_LOOKUP_DESC
               FIELD_TEAM,
           P.DISTRICT_NAME,
           L.DIVI_DIV_NBR,
           L.LICN_CATEGORY_ID,
           L.BLAZ_ADMIN_ZONE_ID,
           BZ.BLAZ_ADMIN_ZONE_DESC,
           L.LICN_LICENCE_STATE,
           L.LICN_LICENCE_DESC,
           L.LICN_LICENCE_TO_CUT_CODE,
           L.LINC_CERT_LEVEL_ID,
           L.LICN_DIGI_IND,
           L.LICN_SALVAGE_IND,
           L.LICN_APPORTION_TENURE_TYPE,
            (
                SELECT CASE
                WHEN DISPO_AGREEMENT IS NOT NULL THEN
                APPO_TENURE_TYPE || '-' || DISPO_AGREEMENT
                ELSE
                APPO_TENURE_TYPE
                END AS result
                FROM LRM_REPLICATION.APPORTIONMENT
                WHERE CM.COPA_COMMIT_APPO = APPO_SEQ_NBR
			) AS APPORTION_TYPE,
           PRTN.COLU_LOOKUP_DESC
               AS PARTITION_TYPE,
           (SELECT DESCRIPTION
              FROM LRM_REPLICATION.LRM_VT_COMMIT_LIC_TYPE AS VT
             WHERE CM.COPA_COMMIT_LIC_TYPE = VT.CODE)
               AS COMMIT_LICENCE_TYPE,
           PP.SUM_COPA_COMMIT_M3_VOL
               AS COMMIT_VOLUME,
           ROUND (BLAL_CALC.CRUISE_VOLUME + BLAL_CALC.REMAIN_VOLUME - SL.SUM_LIC_COPA_COMMIT_M3_VOL)
               AS REMAIN_COMMIT_VOLUME,
           HH.BCHH_BILLING_YEAR  AS BCHH_BILLING_YEAR,
           M.MANU_SEQ_NBR
      FROM LRM_REPLICATION.DIVISION                  D
           INNER JOIN LRM_REPLICATION.LICENCE                   L
		   ON D.DIVI_DIV_NBR = L.DIVI_DIV_NBR
		   INNER JOIN  LRM_REPLICATION.LICENCE_ALLOCATION        LA
		   ON L.LICN_SEQ_NBR = LA.LICN_SEQ_NBR
		   LEFT OUTER JOIN LRM_REPLICATION.MANAGEMENT_UNIT           M
		   ON LA.MANU_SEQ_NBR = M.MANU_SEQ_NBR
		   LEFT OUTER JOIN LRM_REPLICATION.CODE_LOOKUP               LK
		   ON L.LICN_CATEGORY_ID = LK.COLU_LOOKUP_ID
		   AND LK.COLU_LOOKUP_TYPE = 'LICA'
		   LEFT OUTER JOIN LRM_REPLICATION.TENURE_TYPE               TN
		   ON L.TENT_SEQ_NBR = TN.TENT_SEQ_NBR
		   LEFT OUTER JOIN LRM_REPLICATION.CTOR_CONTRACTOR           CT
		   ON L.CTOR_SEQ_NBR = CT.CTOR_SEQ_NBR
		   LEFT OUTER JOIN LRM_REPLICATION.CTOR_CONTRACTOR_LOCATION  CL
		   ON L.CLOC_SEQ_NBR = CL.CTOR_SEQ_NBR
		   AND L.CTOR_SEQ_NBR = CL.CLOC_SEQ_NBR
		   LEFT OUTER JOIN LRM_REPLICATION.CODE_LOOKUP               LKF
		   ON L.LICN_FIELD_TEAM_ID = LKF.COLU_LOOKUP_ID
		   AND LKF.COLU_LOOKUP_TYPE = 'FDTM'
		   
		   LEFT OUTER JOIN
		   (
				SELECT B.LICN_SEQ_NBR,
				MAX (A.ADMIN_DSCT_DISTRICT_NAME)     AS DISTRICT_NAME
				FROM LRM_REPLICATION.CUT_PERMIT A
				INNER JOIN LRM_REPLICATION.PERMIT_ALLOCATION B
				ON A.PERM_SEQ_NBR = B.PERM_SEQ_NBR
				GROUP BY B.LICN_SEQ_NBR
		   ) P
		   ON LA.LICN_SEQ_NBR = P.LICN_SEQ_NBR
		   LEFT OUTER JOIN LRM_REPLICATION.BLOCK_ADMIN_ZONE          BZ
		   ON L.DIVI_DIV_NBR = BZ.DIVI_DIV_NBR
		   AND L.BLAZ_ADMIN_ZONE_ID = BZ.BLAZ_ADMIN_ZONE_ID
		   LEFT OUTER JOIN BCTS_STAGING.V_LRM_COMMITMENTS         CM
		   ON  L.LICN_SEQ_NBR = CM.LICN_SEQ_NBR
		   LEFT OUTER JOIN LRM_REPLICATION.CODE_LOOKUP               PRTN
		   ON CM.COPA_PARTITION = PRTN.COLU_LOOKUP_ID
		   AND PRTN.COLU_LOOKUP_TYPE = 'PRTN'
		   LEFT OUTER JOIN 
		   (
			SELECT  STRING_AGG( BHH.BCHH_BILLING_YEAR::TEXT,', ' ORDER BY MA.LICN_SEQ_NBR ) BCHH_BILLING_YEAR,
        	MA.LICN_SEQ_NBR                 AS LICN_SEQ_NBR
			FROM (SELECT DISTINCT BCHH_BILLING_YEAR, MARK_SEQ_NBR 
				FROM LRM_REPLICATION.BCTS_HARVEST_HISTORY) BHH
			INNER JOIN LRM_REPLICATION.MARK                M
			ON BHH.MARK_SEQ_NBR = M.MARK_SEQ_NBR
			INNER JOIN LRM_REPLICATION.MARK_ALLOCATION     MA
			ON M.MARK_SEQ_NBR = MA.MARK_SEQ_NBR
			GROUP BY MA.LICN_SEQ_NBR
		   ) HH
		   ON L.LICN_SEQ_NBR = HH.LICN_SEQ_NBR
		   LEFT OUTER JOIN 
		   (
			SELECT SUM (COPA_COMMIT_M3_VOL)     SUM_LIC_COPA_COMMIT_M3_VOL,
			       LICN_SEQ_NBR
			FROM LRM_REPLICATION.COMMITMENT_PARTITION CP
			INNER JOIN LRM_REPLICATION.COMMITMENTS C
			ON CP.COMMIT_SEQ_NBR = C.COMMIT_SEQ_NBR
			GROUP BY LICN_SEQ_NBR
		   ) SL
		   ON L.LICN_SEQ_NBR = SL.LICN_SEQ_NBR
		   LEFT OUTER JOIN 
		   (
			SELECT SUM (COALESCE(BLAL_CRUISE_M3_VOL, 0))     CRUISE_VOLUME,
			SUM (COALESCE(BLAL_RW_VOL,0)) REMAIN_VOLUME,
			LICN_SEQ_NBR
			FROM LRM_REPLICATION.BLOCK_ALLOCATION
			GROUP BY LICN_SEQ_NBR
		   ) BLAL_CALC
		   ON L.LICN_SEQ_NBR = BLAL_CALC.LICN_SEQ_NBR
		   LEFT OUTER JOIN 
		      (  SELECT SUM (COPA_COMMIT_M3_VOL)     SUM_COPA_COMMIT_M3_VOL,
                     COMMIT_SEQ_NBR
                FROM LRM_REPLICATION.COMMITMENT_PARTITION
            GROUP BY COMMIT_SEQ_NBR) PP
			ON CM.COMMIT_SEQ_NBR = PP.COMMIT_SEQ_NBR

           
    
		   

CREATE OR REPLACE VIEW BCTS_STAGING.V_BLOCK_ACTIVITY_ALL
AS SELECT
-- C Johnston - Dec 22 2017 - SQ 18066 - Added FIELD_TEAM_DESC
-- E Luo     -  Apr 12 2017 - SQ 18059 - Added feild uri, LICN_LICENCE_STATE
      d.divi_short_code tso_code,
       d.divi_division_name tso_name,
       m.manu_id nav_name,
       tn.tent_tenure_id tenure,
       l.licn_licence_id licence_id,
		CASE 
			WHEN UPPER(SUBSTRING(p.perm_permit_id FROM 1 FOR 4)) = 'APR-' THEN NULL 
			ELSE p.perm_permit_id 
		END AS permit_id,
       mk.mark_mark_id mark_id,
       b.cutb_block_id block_id,
       b.cutb_block_number block_nbr,
       a.cutb_seq_nbr,
       a.acti_seq_nbr,
       l.licn_seq_nbr,
       ap.actt_seq_nbr,
       ac.accl_description activity_class,
       ap.actt_description activity_type,
       ap.actt_key_ind,
       a.acti_status_date activity_date,
       a.acti_status_ind,
       ac.accl_object_type,
       a.acti_responsibility,
       c.ctor_name,
       a.acti_cost,
       a.acti_target_date,
       a.acti_target_cost,
       a.acti_comments,
       d.divi_div_nbr,
       ft_vt.COLU_LOOKUP_DESC,
        b.cutb_system_id ubi,
       l.licn_licence_state
  FROM lrm_replication.activity_class ac
  INNER JOIN lrm_replication.activity_type ap
	   ON ac.accl_seq_nbr = ap.accl_seq_nbr
       AND ac.divi_div_nbr = ap.divi_div_nbr
	    AND ac.accl_object_type = 'B'
       INNER JOIN lrm_replication.activity a
	     ON a.actt_seq_nbr = ap.actt_seq_nbr
		     AND a.plan_seq_nbr IS NULL
       LEFT JOIN lrm_replication.ctor_contractor c
	   ON a.ctor_seq_nbr = c.ctor_seq_nbr
	    INNER JOIN lrm_replication.cut_block b 
		 ON b.cutb_seq_nbr = a.cutb_seq_nbr
       INNER JOIN lrm_replication.division d
	   ON b.divi_div_nbr = d.divi_div_nbr
	   INNER JOIN lrm_replication.block_allocation ba  
	   ON b.cutb_seq_nbr = ba.cutb_seq_nbr
       LEFT JOIN lrm_replication.management_unit m
	    ON ba.manu_seq_nbr = m.manu_seq_nbr
       LEFT JOIN lrm_replication.licence l
	       ON ba.licn_seq_nbr = l.licn_seq_nbr
       LEFT JOIN lrm_replication.cut_permit p
	     ON ba.perm_seq_nbr = p.perm_seq_nbr
       LEFT JOIN lrm_replication.mark mk
	     ON ba.mark_seq_nbr = mk.mark_seq_nbr
       LEFT JOIN lrm_replication.tenure_type tn
	    ON l.tent_seq_nbr = tn.tent_seq_nbr                  
       LEFT JOIN lrm_replication.V_RES_VT_FDTM_TEAM ft_vt
	    ON l.licn_field_team_id = ft_vt.COLU_LOOKUP_ID
            
          
           
           
           
           
           
           
    
           


