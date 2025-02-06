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



-- FOREST.V_LRM_CUT_BLOCK
CREATE TABLE bcts_staging.forest_v_lrm_cut_block (
    manu_seq_nbr NUMERIC(15) NULL,
    licn_seq_nbr NUMERIC(15) NULL,
    perm_seq_nbr NUMERIC(15) NULL,
    mark_seq_nbr NUMERIC(15) NULL,
    cutb_seq_nbr NUMERIC(15) NOT NULL,
    cutb_block_id VARCHAR(20) NOT NULL,
    divi_div_nbr NUMERIC(2) NULL,
    cutb_gross_ha_area NUMERIC(11, 6) NULL,
    c_cutb_latitude VARCHAR(46) NULL,
    c_cutb_longitude VARCHAR(46) NULL,
    cutb_opening VARCHAR(15) NULL,
    cutb_photos VARCHAR(800) NULL,
    sblk_supply_block_id VARCHAR(10) NULL,
    opar_operating_area_id VARCHAR(10) NULL,
    finz_forest_inventory_zone_id VARCHAR(40) NULL,
    cutb_cell_number VARCHAR(60) NULL,
    cutb_user_mapsheet_id VARCHAR(120) NULL,
    cutb_greenup_date TIMESTAMP NULL,
    grns_greenup_source VARCHAR(40) NULL,
    pmpo_operating_zone VARCHAR(40) NULL,
    lsun_landscape_unit VARCHAR(40) NULL,
    cutb_prov_forest_conflict VARCHAR(40) NULL,
    cutb_digi_ind VARCHAR(4) NULL,
    cutb_block_number VARCHAR(15) NULL,
    cutb_opening_id NUMERIC(10) NULL,
    min_elevation INTEGER NULL,
    max_elevation INTEGER NULL,
    cutb_latitude VARCHAR(40) NULL,
    cutb_longitude VARCHAR(40) NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(120) NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(120) NULL,
    cutb_cpi_slope_pct NUMERIC(7, 4) NULL,
    cutb_system_id VARCHAR(15) NULL,
    cutb_block_state VARCHAR(20) NULL,
    cutb_file_id VARCHAR(72) NULL,
    cutb_row_ind VARCHAR(4) NOT NULL,
    suop_subop_area_id VARCHAR(40) NULL,
    licn_licence_id VARCHAR(15) NOT NULL,
    generate_system_id CHAR NULL,
    cutb_location VARCHAR(800) NULL,
    cutb_latitude_dd NUMERIC(9, 6) NULL,
    cutb_longitude_dd NUMERIC(9, 6) NULL,
    no_shape INTEGER NULL,
    cutb_archive_reason VARCHAR(4) NULL,
    cutb_archive_date TIMESTAMP NULL
);
-- FOREST.V_LRM_LICENCE_SHAPE
CREATE TABLE bcts_staging.forest_v_lrm_licence_shape (
    objectid NUMERIC(38) NULL,
    manu_seq_nbr NUMERIC(15) NULL,
    licn_seq_nbr NUMERIC(16) NULL,
    shape GEOMETRY NULL,
    sde_state_id INTEGER NULL,
    v_treefield VARCHAR(31) NULL,
    shape_area NUMERIC(38, 8) NULL,
    modifiedby VARCHAR(30) NULL,
    modifiedon TIMESTAMP(6) NULL,
    modifiedusing VARCHAR(30) NULL,
    createdby VARCHAR(30) NULL,
    createdon TIMESTAMP(6) NULL,
    createdusing VARCHAR(30) NULL
);
-- FOREST.V_LRM_LICENCE
CREATE TABLE bcts_staging.forest_v_lrm_licence (
    manu_seq_nbr NUMERIC(15) NULL,
    divi_div_nbr NUMERIC(2) NOT NULL,
    licn_seq_nbr NUMERIC(15) NOT NULL,
    licn_digi_ind VARCHAR(1) NULL,
    licn_licence_id VARCHAR(15) NOT NULL,
    licn_category_id VARCHAR(10) NULL,
    licn_crown_land VARCHAR(3) NULL,
    licn_crown_granted_ind VARCHAR(4) NULL,
    blaz_admin_zone_id VARCHAR(10) NULL,
    licl_licence_class VARCHAR(10) NULL,
    licn_parent_licence NUMERIC(15) NULL,
    licn_licence_desc VARCHAR(53) NULL,
    licn_licence_to_cut_code VARCHAR(10) NULL,
    licn_permit_exists_ind VARCHAR(4) NULL,
    licn_licence_state VARCHAR(20) NULL,
    licn_annual_allowable_cut NUMERIC(9) NULL,
    lsee_licensee_id VARCHAR(10) NULL,
    lsee_client_code VARCHAR(60) NULL,
    gross_area INTEGER NULL,
    licn_client_location_code VARCHAR(5) NULL,
    licn_salvage_ind VARCHAR(1) NULL,
    licn_apportion_tenure_type VARCHAR(30) NULL,
    ctor_seq_nbr NUMERIC(15) NULL,
    tent_seq_nbr NUMERIC(15) NULL,
    linc_cert_level_id VARCHAR(10) NULL,
    licn_field_team_id VARCHAR(10) NULL,
    licn_hammermark VARCHAR(60) NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(120) NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(120) NULL,
    merchantable_area INTEGER NULL,
    harvested_area INTEGER NULL,
    standing_area INTEGER NULL,
    cruise_volume INTEGER NULL,
    harvested_volume INTEGER NULL,
    standing_volume INTEGER NULL,
    cruise_variance INTEGER NULL,
    v_lock_field CHAR NULL,
    no_shape INTEGER NULL,
    licn_archive_ind VARCHAR(3) NULL,
    licn_archive_date TIMESTAMP NULL
);

-- FOREST.V_LRM_COMMITMENTS
CREATE TABLE bcts_staging.forest_v_lrm_commitments (
    licn_seq_nbr NUMERIC(15) NULL,
    commit_seq_nbr NUMERIC(15) NOT NULL,
    copa_partition VARCHAR(150) NULL,
    copa_commit_appo NUMERIC(15) NULL,
    v_copa_commit_m3_vol INTEGER NULL,
    v_remain_commit_m3_vol INTEGER NULL,
    modifiedby VARCHAR(30) NULL,
    modifiedon TIMESTAMP NULL,
    modifiedusing VARCHAR(30) NULL,
    createdby VARCHAR(30) NULL,
    createdon TIMESTAMP NULL,
    createdusing VARCHAR(30) NULL,
    manu_seq_nbr NUMERIC(15) NULL,
    copa_commit_lic_type VARCHAR(2) NULL
);
-- FOREST.CUT_BLOCK_SHAPE_EVW

-- FOREST.CUT_BLOCK_SHAPE_EVW
CREATE TABLE bcts_staging.forest_cut_block_shape_evw (
    objectid NUMERIC(38) NULL,
    transaction_id VARCHAR(4) NULL,
    cutb_seq_nbr NUMERIC(16) NULL,
    bufferdist NUMERIC(38, 8) NULL,
    objectid_1 NUMERIC(10) NULL,
    transactio VARCHAR(4) NULL,
    objectid_2 NUMERIC(10) NULL,
    hectares NUMERIC(38, 8) NULL,
    feature_len NUMERIC(38, 8) NULL,
    feature_area NUMERIC(38, 8) NULL,
    shape_len NUMERIC(38, 8) NULL,
    shape_area NUMERIC(38, 8) NULL,
    shape GEOMETRY NULL,
    licn_seq_nbr NUMERIC(16) NULL,
    manu_seq_nbr NUMERIC(16) NULL,
    mark_seq_nbr NUMERIC(16) NULL,
    perm_seq_nbr NUMERIC(16) NULL,
    modifiedby VARCHAR(30) NULL,
    modifiedon TIMESTAMP(6) NULL,
    modifiedusing VARCHAR(30) NULL,
    createdby VARCHAR(30) NULL,
    createdon TIMESTAMP(6) NULL,
    createdusing VARCHAR(30) NULL,
    sde_state_id INTEGER NULL
);
-- FOREST.V_LRM_COMMITMENT_PARTITION
CREATE TABLE bcts_staging.forest_v_lrm_commitment_partition (
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
    copa_cruise_m3_vol INTEGER NULL,
    copa_partition_type VARCHAR(150) NULL,
    copa_commit_m3_vol NUMERIC(9) NULL,
    copa_commit_part_percent NUMERIC(3) NULL,
    v_copa_commit_part_percent INTEGER NULL,
    commit_seq_nbr NUMERIC(15) NULL,
    v_copa_commit_lic_type VARCHAR(2) NULL,
    v_copa_commit_appo NUMERIC(15) NULL,
    licn_seq_nbr NUMERIC(15) NULL,
    v_blal_rw_vol NUMERIC(15, 6) NULL
);
-- FORESTVIEW.V_LICENCE
CREATE TABLE bcts_staging.forestview_v_licence (
    licn_seq_nbr NUMERIC(15) NOT NULL,
    tent_seq_nbr NUMERIC(15) NULL,
    ctor_seq_nbr NUMERIC(15) NULL,
    cloc_seq_nbr NUMERIC(15) NULL,
    tso_code VARCHAR(15) NULL,
    tso_name VARCHAR(50) NOT NULL,
    nav_name VARCHAR(60) NULL,
    licence_id VARCHAR(15) NOT NULL,
    category VARCHAR(150) NULL,
    tenure VARCHAR(40) NULL,
    licensee VARCHAR(10) NULL,
    registrant VARCHAR(60) NULL,
    registrant_city VARCHAR(200) NULL,
    field_team VARCHAR(150) NULL,
    district_name VARCHAR(60) NULL,
    divi_div_nbr NUMERIC(2) NOT NULL,
    licn_category_id VARCHAR(10) NULL,
    blaz_admin_zone_id VARCHAR(10) NULL,
    blaz_admin_zone_desc VARCHAR(200) NULL,
    licn_licence_state VARCHAR(20) NULL,
    licn_licence_desc VARCHAR(53) NULL,
    licn_licence_to_cut_code VARCHAR(10) NULL,
    linc_cert_level_id VARCHAR(10) NULL,
    licn_digi_ind VARCHAR(1) NULL,
    licn_salvage_ind VARCHAR(1) NULL,
    licn_apportion_tenure_type VARCHAR(30) NULL,
    apportion_type VARCHAR(221) NULL,
    partition_type VARCHAR(150) NULL,
    commit_licence_type VARCHAR(50) NULL,
    commit_volume INTEGER NULL,
    remain_commit_volume INTEGER NULL,
    bchh_billing_year VARCHAR(4000) NULL,
    manu_seq_nbr NUMERIC(15) NULL
);


-- FORESTVIEW.V_BLOCK
CREATE TABLE forestview_v_block (
    divi_div_nbr NUMERIC(2) NOT NULL,
    tso_code VARCHAR(15) NULL,
    tso_name VARCHAR(50) NOT NULL,
    field_team_desc VARCHAR(150) NULL,
    nav_name VARCHAR(60) NULL,
    tenure VARCHAR(40) NULL,
    licence_id VARCHAR(15) NULL,
    permit_id VARCHAR(40) NULL,
    mark_id VARCHAR(15) NULL,
    block_id VARCHAR(20) NOT NULL,
    block_nbr VARCHAR(15) NULL,
    ubi VARCHAR(15) NULL,
    opening VARCHAR(15) NULL,
    op_area VARCHAR(10) NULL,
    opar_operating_area_name VARCHAR(30) NULL,
    ozon_operating_zone_id VARCHAR(10) NULL,
    supply_block VARCHAR(10) NULL,
    ebm_indicator VARCHAR(4) NULL,
    photo VARCHAR(800) NULL,
    latitude VARCHAR(40) NULL,
    longitude VARCHAR(40) NULL,
    prov_frst_conflict VARCHAR(40) NULL,
    mapsheet_id VARCHAR(120) NULL,
    landscape_unit VARCHAR(40) NULL,
    sp_exempt VARCHAR(4) NULL,
    stand_type VARCHAR(40) NULL,
    age_class VARCHAR(40) NULL,
    hgt_class VARCHAR(40) NULL,
    stk_class VARCHAR(40) NULL,
    site_index INTEGER NULL,
    source VARCHAR(40) NULL,
    fdp_status VARCHAR(10) NULL,
    funding_code VARCHAR(15) NULL,
    cutb_block_memo VARCHAR(4000) NULL,
    gross_area NUMERIC(11, 6) NULL,
    est_area NUMERIC(7, 2) NULL,
    merch_area NUMERIC(11, 6) NULL,
    harvest_area NUMERIC(11, 6) NULL,
    remaining_area INTEGER NULL,
    cruise_vol NUMERIC(15, 6) NULL,
    data_source VARCHAR(120) NULL,
    harvest_vol NUMERIC(15, 6) NULL,
    remaining_vol INTEGER NULL,
    blal_usr_cruise_m3_vol NUMERIC(15, 6) NULL,
    rw_area NUMERIC(11, 6) NULL,
    blal_rw_vol NUMERIC(15, 6) NULL,
    cutb_forma_print_date TIMESTAMP NULL,
    cutb_forma_printed VARCHAR(4) NULL,
    cutb_block_state VARCHAR(20) NULL,
    pmod_modifier_id VARCHAR(40) NULL,
    cutb_location VARCHAR(800) NULL,
    suop_subop_area_id VARCHAR(40) NULL,
    suop_subop_area_name VARCHAR(120) NULL,
    cutb_opening_id NUMERIC(10) NULL,
    licn_licence_state VARCHAR(20) NULL,
    seed_zone VARCHAR(4000) NULL,
    cutb_file_id VARCHAR(72) NULL,
    min_elevation INTEGER NULL,
    max_elevation INTEGER NULL,
    bcat_category_code VARCHAR(40) NULL,
    cutb_access_restriction VARCHAR(4000) NULL,
    regime_created_by VARCHAR(50) NULL,
    treg_regime_id VARCHAR(40) NULL,
    treg_regime_name VARCHAR(200) NULL,
    treg_create_date TIMESTAMP NULL,
    treg_active_ind VARCHAR(4) NULL,
    treg_def_ind VARCHAR(4) NULL,
    nav_id VARCHAR(200) NULL,
    fiz VARCHAR(40) NULL,
    hvs_status VARCHAR(30) NULL,
    hvs_target_date TIMESTAMP NULL,
    hvs_status_date TIMESTAMP NULL,
    hvc_status VARCHAR(30) NULL,
    hvc_target_date TIMESTAMP NULL,
    hvc_status_date TIMESTAMP NULL,
    manu_seq_nbr NUMERIC(15) NULL,
    licn_seq_nbr NUMERIC(15) NULL,
    perm_seq_nbr NUMERIC(15) NULL,
    mark_seq_nbr NUMERIC(15) NULL,
    cutb_seq_nbr NUMERIC(15) NOT NULL,
    cutb_cprp_protection_ind VARCHAR(1) NULL,
    cutb_rc_risk_rating VARCHAR(1) NULL,
    cutb_rc_risk_source VARCHAR(5) NULL
);


-- FORESTVIEW.V_BLOCK_ACTIVITY_ALL
CREATE TABLE bcts_staging.forestview_v_block_activity_all (
    tso_code VARCHAR(15) NULL,
    tso_name VARCHAR(50) NOT NULL,
    nav_name VARCHAR(60) NULL,
    tenure VARCHAR(40) NULL,
    licence_id VARCHAR(15) NULL,
    permit_id VARCHAR(40) NULL,
    mark_id VARCHAR(15) NULL,
    block_id VARCHAR(20) NOT NULL,
    block_nbr VARCHAR(15) NULL,
    cutb_seq_nbr NUMERIC(15) NULL,
    acti_seq_nbr NUMERIC(15) NOT NULL,
    licn_seq_nbr NUMERIC(15) NULL,
    actt_seq_nbr NUMERIC(15) NOT NULL,
    activity_class VARCHAR(40) NULL,
    activity_type VARCHAR(200) NULL,
    actt_key_ind VARCHAR(10) NULL,
    activity_date TIMESTAMP NULL,
    acti_status_ind VARCHAR(30) NULL,
    accl_object_type VARCHAR(1) NULL,
    acti_responsibility VARCHAR(160) NULL,
    ctor_name VARCHAR(60) NULL,
    acti_cost NUMERIC(15, 2) NULL,
    acti_target_date TIMESTAMP NULL,
    acti_target_cost NUMERIC(15, 2) NULL,
    acti_comments VARCHAR(2000) NULL,
    divi_div_nbr NUMERIC(2) NOT NULL,
    field_team_desc VARCHAR(150) NULL,
    ubi VARCHAR(15) NULL,
    licn_licence_state VARCHAR(20) NULL
);
-- FORESTVIEW.V_BLOCK_SPATIAL
CREATE TABLE bcts_staging.forestview_v_block_spatial (
    tso_code VARCHAR(15) NULL,
    nav_name VARCHAR(60) NULL,
    licence_id VARCHAR(15) NULL,
    permit_id VARCHAR(40) NULL,
    mark_id VARCHAR(15) NULL,
    block_id VARCHAR(20) NOT NULL,
    cutb_seq_nbr NUMERIC(15) NOT NULL,
    spatial_flag VARCHAR(3) NULL
);



-- FORESTVIEW.V_LICENCE_ACTIVITY_ALL
CREATE TABLE bcts_staging.forestview_v_licence_activity_all (
    divi_div_nbr NUMERIC(2) NOT NULL,
    tso_code VARCHAR(15) NULL,
    field_team_desc VARCHAR(150) NULL,
    nav_name VARCHAR(60) NULL,
    tenure VARCHAR(40) NULL,
    licence_id VARCHAR(15) NOT NULL,
    licn_licence_state VARCHAR(20) NULL,
    activity_class VARCHAR(40) NULL,
    activity_type VARCHAR(200) NULL,
    actt_key_ind VARCHAR(10) NULL,
    accl_object_type VARCHAR(1) NULL,
    acti_responsibility VARCHAR(160) NULL,
    acti_status_ind VARCHAR(30) NULL,
    acti_target_date TIMESTAMP NULL,
    acti_target_cost NUMERIC(15, 2) NULL,
    activity_date TIMESTAMP NULL,
    acti_status_date TIMESTAMP NULL,
    acti_cost NUMERIC(15, 2) NULL,
    acti_comments VARCHAR(2000) NULL,
    licensee VARCHAR(60) NULL,
    acti_seq_nbr NUMERIC(15) NOT NULL,
    licn_seq_nbr NUMERIC(15) NULL,
    modifiedby VARCHAR(120) NULL,
    modifiedon TIMESTAMP NULL,
    createdby VARCHAR(120) NULL,
    createdon TIMESTAMP NULL
);


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



           
           
           
           
           
    
           


