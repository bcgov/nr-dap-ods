CREATE TABLE lrm_replication.v_activity_cost (
    actc_seq_nbr bigint,
    acti_seq_nbr bigint,
    actc_item_cost double precision,
    csti_cost_item_id text,
    divi_div_nbr bigint,
    csti_cost_item_description text,
    csti_cost_item_account_code text,
    actc_series text
);

CREATE TABLE bcts_reporting.forestview_v_activity_cost AS SELECT * FROM lrm_replication.v_activity_cost;

CREATE TABLE lrm_replication.v_apportionment (
    tso_code text,
    tso_name text,
    nav_name text,
    management_type text,
    appo_date timestamp without time zone,
    apportionment_tenure text,
    appo_m3_vol double precision,
    authorized_by text,
    entered_by text,
    apportionment_partition text,
    appp_partition_m3_vol double precision,
    commitment_m3_vol double precision,
    actual_m3_volume double precision,
    variance bigint,
    manu_seq_nbr bigint,
    divi_div_nbr bigint,
    appo_seq_nbr bigint,
    fiscal_year bigint

);

CREATE TABLE bcts_reporting.forestview_v_apportionment AS SELECT * FROM lrm_replication.v_apportionment;

CREATE TABLE lrm_replication.v_appr_bridge_tab_cost (
    divi_div_nbr bigint,
    btab_road_name text,
    btab_crib_height_nbr double precision,
    btab_span_length_nbr bigint,
    optn_least_cost_option_code text,
    btab_identifier_desc text,
    btab_applicable_vol bigint,
    btab_station_nbr text,
    btab_crown_portion_pct double precision,
    btab_appraisal_year bigint,
    btab_comment text,
    btab_section_built_ind text,
    btab_start_metre_nbr double precision,
    btab_end_metre_nbr double precision,
    btab_bridge_type text,
    btab_inspection_date timestamp without time zone,
    btab_bridge_status text,
    proj_seq_nbr text,
    prjv_version_nbr text,
    pver_version_nbr bigint,
    cutb_seq_nbr bigint,
    btab_seq_nbr bigint,
    btab_seq_nbr_lng bigint

);

CREATE TABLE bcts_reporting.forestview_v_appr_bridge_tab_cost AS SELECT * FROM lrm_replication.v_appr_bridge_tab_cost;

CREATE TABLE lrm_replication.v_appr_culvert_tab_cost (
    culs_status_id bigint,
    proj_seq_nbr text,
    prjv_version_nbr double precision,
    pver_version_nbr text,
    cutb_seq_nbr text,
    ctab_seq_nbr text,
    road_seq_nbr text,
    ctab_seq_nbr_lng text,
    divi_div_nbr double precision,
    ctab_road_name text,
    ctab_station_nbr double precision,
    ctab_end_station_nbr bigint,
    rctp_construction_type_id double precision,
    ctab_identifier_desc bigint,
    optn_least_cost_option_code text,
    ctab_wooden_ind text,
    ctab_culvert_diameter_nbr text,
    ctab_culvert_cnt text,
    ctab_length_nbr bigint,
    ctab_applicable_vol bigint,
    ctab_crown_portion_pct bigint,
    ctab_appraisal_year bigint,
    ctab_comment bigint

);

CREATE TABLE bcts_reporting.forestview_v_appr_culvert_tab_cost AS SELECT * FROM lrm_replication.v_appr_culvert_tab_cost;

CREATE TABLE lrm_replication.v_appr_internal_rate (
    divi_div_nbr bigint,
    intr_start_date timestamp without time zone,
    intr_end_date timestamp without time zone,
    intr_lumber_sp double precision,
    intr_chip_sp double precision,
    intr_stud_log_pct double precision,
    intr_selling_price double precision,
    intr_logging_cost double precision,
    intr_manu_cost double precision,
    intr_silv_cost double precision,
    intr_operating_cost double precision,
    intr_base_rate text,
    intr_value_index text,
    intr_mean_value_index text,
    intr_indicated_rate double precision,
    intr_stumpage_rate double precision,
    mand_eff_date timestamp without time zone,
    adjd_eff_date timestamp without time zone,
    perm_seq_nbr bigint

);

CREATE TABLE bcts_reporting.forestview_v_appr_internal_rate AS SELECT * FROM lrm_replication.v_appr_internal_rate;

CREATE TABLE lrm_replication.v_appr_ministry_rate (
    divi_div_nbr bigint,
    minr_start_date timestamp without time zone,
    minr_end_date timestamp without time zone,
    minr_lumber_sp double precision,
    minr_chip_sp double precision,
    minr_stud_log_pct double precision,
    minr_selling_price double precision,
    minr_logging_cost double precision,
    minr_manu_cost double precision,
    minr_silv_cost double precision,
    minr_operating_cost double precision,
    minr_base_rate text,
    minr_value_index text,
    minr_mean_value_index text,
    minr_indicated_rate double precision,
    minr_stumpage_rate double precision,
    mand_eff_date timestamp without time zone,
    adjd_eff_date timestamp without time zone,
    perm_seq_nbr bigint

);

CREATE TABLE bcts_reporting.forestview_v_appr_ministry_rate AS SELECT * FROM lrm_replication.v_appr_ministry_rate;

CREATE TABLE lrm_replication.v_appr_road_tab_cost (
    divi_div_nbr bigint,
    road_road_name text,
    rtab_road_name text,
    rtab_road_type text,
    rtab_start_metre_nbr text,
    rtab_end_metre_nbr text,
    rtab_length_nbr double precision,
    rtab_soil_moisture_type text,
    rtab_rock_pct double precision,
    rtab_biogeo_zone text,
    rtab_side_slope_pct double precision,
    rtab_haul_distance_nbr text,
    rtab_stabilizing_material_type text,
    pver_version_nbr bigint,
    cutb_seq_nbr bigint,
    rtab_seq_nbr bigint,
    road_seq_nbr text,
    rtab_seq_nbr_lng bigint

);

CREATE TABLE bcts_reporting.forestview_v_appr_road_tab_cost AS SELECT * FROM lrm_replication.v_appr_road_tab_cost;

CREATE TABLE lrm_replication.v_attachment (
    bsto_table_name text,
    seq_nbr_type text,
    seq_nbr_value bigint,
    bsto_file_name text,
    bsto_file_description text,
    bsto_seq_nbr bigint

);

CREATE TABLE bcts_reporting.forestview_v_attachment AS SELECT * FROM lrm_replication.v_attachment;

CREATE TABLE lrm_replication.v_block (
    hvc_status bigint,
    hvc_target_date text,
    hvc_status_date text,
    manu_seq_nbr text,
    licn_seq_nbr text,
    perm_seq_nbr text,
    mark_seq_nbr text,
    cutb_seq_nbr text,
    cutb_cprp_protection_ind text,
    cutb_rc_risk_rating text,
    cutb_rc_risk_source text,
    divi_div_nbr text,
    tso_code text,
    tso_name text,
    field_team_desc text,
    nav_name text,
    tenure text,
    licence_id text,
    permit_id text,
    mark_id text,
    block_id text,
    block_nbr text,
    ubi text,
    opening text,
    op_area text,
    opar_operating_area_name text,
    ozon_operating_zone_id text,
    supply_block text,
    ebm_indicator text,
    photo double precision,
    latitude text,
    longitude text,
    prov_frst_conflict text,
    mapsheet_id text,
    landscape_unit double precision,
    sp_exempt double precision,
    stand_type double precision,
    age_class double precision,
    hgt_class bigint,
    stk_class text,
    site_index text,
    source text,
    fdp_status bigint,
    funding_code text,
    cutb_block_memo text,
    gross_area text,
    est_area timestamp without time zone,
    merch_area text,
    harvest_area text,
    remaining_area text,
    cruise_vol text,
    data_source text,
    harvest_vol text,
    remaining_vol text,
    blal_usr_cruise_m3_vol text,
    rw_area text,
    blal_rw_vol text,
    cutb_forma_print_date double precision,
    cutb_forma_printed double precision,
    cutb_block_state text,
    pmod_modifier_id text,
    cutb_location text,
    suop_subop_area_id text,
    suop_subop_area_name text,
    cutb_opening_id text,
    licn_licence_state text,
    seed_zone text,
    cutb_file_id text,
    min_elevation text,
    max_elevation text,
    bcat_category_code timestamp without time zone,
    cutb_access_restriction timestamp without time zone,
    regime_created_by text,
    treg_regime_id timestamp without time zone,
    treg_regime_name timestamp without time zone,
    treg_create_date bigint,
    treg_active_ind bigint,
    treg_def_ind bigint,
    nav_id bigint,
    fiz bigint,
    hvs_status text,
    hvs_target_date text,
    hvs_status_date text

);

CREATE TABLE bcts_reporting.forestview_v_block AS SELECT * FROM lrm_replication.v_block;

CREATE TABLE lrm_replication.v_block_activity_all (
    licn_seq_nbr text,
    actt_seq_nbr text,
    activity_class text,
    activity_type text,
    actt_key_ind text,
    activity_date text,
    acti_status_ind text,
    accl_object_type text,
    acti_responsibility text,
    ctor_name bigint,
    acti_cost bigint,
    acti_target_date bigint,
    acti_target_cost bigint,
    acti_comments text,
    divi_div_nbr text,
    field_team_desc text,
    ubi timestamp without time zone,
    licn_licence_state text,
    tso_code text,
    tso_name text,
    nav_name text,
    tenure text,
    licence_id timestamp without time zone,
    permit_id text,
    mark_id text,
    block_id bigint,
    block_nbr text,
    cutb_seq_nbr text,
    acti_seq_nbr text

);

CREATE TABLE bcts_reporting.forestview_v_block_activity_all AS SELECT * FROM lrm_replication.v_block_activity_all;

CREATE TABLE lrm_replication.v_block_area (
    cutb_seq_nbr bigint,
    total_area double precision,
    gross_area double precision,
    intres_area bigint,
    extres_area bigint,
    resrv_area double precision,
    npnat_area double precision,
    npunn_area double precision,
    nar_area double precision

);

CREATE TABLE bcts_reporting.forestview_v_block_area AS SELECT * FROM lrm_replication.v_block_area;

CREATE TABLE lrm_replication.v_block_cruise (
    blkc_pulp_m3_per_ha bigint,
    blkc_sawlog_m3_per_ha bigint,
    blkc_sawlog_m3_per_tree double precision,
    blkc_pulp_net_m3_per_tree double precision,
    blkc_burn_damage_pct text,
    specie_pct text,
    finz_forest_inventory_zone_id text,
    divi_div_nbr text,
    blkc_seq_nbr double precision,
    cutb_seq_nbr double precision,
    perm_seq_nbr double precision,
    blkc_system_nbr double precision,
    blkc_plot_nbr double precision,
    cruise_source double precision,
    species_id double precision,
    species double precision,
    gross_merch_m3 double precision,
    net_merch_m3 double precision,
    net_merch_per_ha double precision,
    gross_vol_per_tree double precision,
    net_vol_per_tree double precision,
    decay double precision,
    waste double precision,
    breakage double precision,
    gross_dwb double precision,
    stems double precision,
    avg_dbh double precision,
    snags double precision,
    distribution double precision,
    dead_potential bigint,
    avg_weight_merch_ht bigint,
    basal_area bigint,
    sampling_error double precision,
    old_growth double precision,
    second_growth double precision,
    blowdown double precision,
    blkc_area_ha double precision,
    blkc_insect_damage_green_pct double precision,
    blkc_insect_damage_red_pct double precision,
    blkc_insect_damage_grey_pct double precision,
    blkc_stud_pct double precision,
    blkc_small_log_pct double precision,
    blkc_large_log_pct bigint,
    blkc_lrf_bdft_per_m3 double precision,
    blkc_m3_per_lineal_m text,
    blkc_gross_m3_per_ha bigint

);

CREATE TABLE bcts_reporting.forestview_v_block_cruise AS SELECT * FROM lrm_replication.v_block_cruise;

CREATE TABLE lrm_replication.v_block_cruise_all_coni_deci (
    c_avg_merch_ht_m bigint,
    c_basal_area double precision,
    c_sampling_error_pct text,
    c_blowdown_pct double precision,
    c_stud_pct double precision,
    c_small_log_pct double precision,
    c_large_log_pct double precision,
    c_lrf_bdft_per_m3 double precision,
    c_insect_damage_green_pct double precision,
    c_insect_damage_red_pct double precision,
    c_insect_damage_grey_pct double precision,
    c_burn_damage_pct double precision,
    c_m3_per_lineal_m double precision,
    d_spec_species_id double precision,
    d_gross_merch_m3 double precision,
    d_net_merch_m3 double precision,
    d_net_merch_m3_per_ha double precision,
    d_dp_m3_per_ha double precision,
    d_distrib_pct double precision,
    d_gross_decay_pct double precision,
    d_gross_waste_pct double precision,
    d_gross_breakage_pct double precision,
    d_gross_dwb_pct double precision,
    d_stems_per_ha double precision,
    d_avg_dbh_cm double precision,
    d_snags_per_ha double precision,
    d_gross_vol_per_tree_m3 double precision,
    d_net_vol_per_tree_m3 double precision,
    d_avg_merch_ht_m bigint,
    d_basal_area double precision,
    d_sampling_error_pct text,
    d_blowdown_pct double precision,
    d_stud_pct double precision,
    d_small_log_pct double precision,
    d_large_log_pct double precision,
    d_lrf_bdft_per_m3 double precision,
    d_insect_damage_green_pct double precision,
    d_insect_damage_red_pct double precision,
    d_insect_damage_grey_pct double precision,
    d_burn_damage_pct double precision,
    d_m3_per_lineal_m double precision,
    cutb_seq_nbr double precision,
    a_blkc_area_ha double precision,
    a_spec_species_id double precision,
    a_gross_merch_m3 double precision,
    a_net_merch_m3 double precision,
    a_net_merch_m3_per_ha double precision,
    a_dp_m3_per_ha double precision,
    a_distrib_pct double precision,
    a_gross_decay_pct double precision,
    a_gross_waste_pct double precision,
    a_gross_breakage_pct double precision,
    a_gross_dwb_pct double precision,
    a_stems_per_ha double precision,
    a_avg_dbh_cm double precision,
    a_snags_per_ha double precision,
    a_gross_vol_per_tree_m3 bigint,
    a_net_vol_per_tree_m3 double precision,
    a_avg_merch_ht_m text,
    a_basal_area double precision,
    a_sampling_error_pct double precision,
    a_blowdown_pct double precision,
    a_stud_pct double precision,
    a_small_log_pct double precision,
    a_large_log_pct double precision,
    a_lrf_bdft_per_m3 double precision,
    a_insect_damage_green_pct double precision,
    a_insect_damage_red_pct double precision,
    a_insect_damage_grey_pct double precision,
    a_burn_damage_pct double precision,
    a_m3_per_lineal_m double precision,
    c_spec_species_id double precision,
    c_gross_merch_m3 double precision,
    c_net_merch_m3 double precision,
    c_net_merch_m3_per_ha bigint,
    c_dp_m3_per_ha bigint,
    c_distrib_pct bigint,
    c_gross_decay_pct bigint,
    c_gross_waste_pct double precision,
    c_gross_breakage_pct double precision,
    c_gross_dwb_pct double precision,
    c_stems_per_ha bigint,
    c_avg_dbh_cm bigint,
    c_snags_per_ha bigint,
    c_gross_vol_per_tree_m3 bigint,
    c_net_vol_per_tree_m3 bigint

);

CREATE TABLE bcts_reporting.forestview_v_block_cruise_all_coni_deci AS SELECT * FROM lrm_replication.v_block_cruise_all_coni_deci;

CREATE TABLE lrm_replication.v_block_depletion_stage (
    dpst_seq_nbr bigint,
    acti_seq_nbr bigint,
    cutb_seq_nbr bigint,
    dpst_start_date timestamp without time zone,
    dpst_comp_date timestamp without time zone,
    dpst_area double precision,
    dpst_depletion_vol text,
    dpst_digi_ind text,
    dpst_phase_id text,
    dpst_depletion_vol_decid text,
    dpst_depletion_vol_conif text

);

CREATE TABLE bcts_reporting.forestview_v_block_depletion_stage AS SELECT * FROM lrm_replication.v_block_depletion_stage;

CREATE TABLE lrm_replication.v_block_harvest_method (
    cbhm_seq_nbr bigint,
    cutb_seq_nbr bigint,
    divi_div_nbr bigint,
    hame_method_id text,
    cbhm_area double precision,
    cbhm_harvest_vol text,
    cbhm_digi_ind text

);

CREATE TABLE bcts_reporting.forestview_v_block_harvest_method AS SELECT * FROM lrm_replication.v_block_harvest_method;

CREATE TABLE lrm_replication.v_block_harvest_strategy (
    cbst_seq_nbr bigint,
    cutb_seq_nbr bigint,
    divi_div_nbr bigint,
    stgy_strategy_id text,
    cbst_area double precision,
    cbst_harvest_vol double precision,
    cbst_digi_ind text

);

CREATE TABLE bcts_reporting.forestview_v_block_harvest_strategy AS SELECT * FROM lrm_replication.v_block_harvest_strategy;

CREATE TABLE lrm_replication.v_block_nmar (
    nmar_seq_nbr bigint,
    cutb_seq_nbr bigint,
    nmcl_class_id text,
    nmtp_type_id text,
    nmar_label text,
    divi_div_nbr bigint

);

CREATE TABLE bcts_reporting.forestview_v_block_nmar AS SELECT * FROM lrm_replication.v_block_nmar;

CREATE TABLE lrm_replication.v_block_old (
    site_index text,
    source text,
    fdp_status text,
    funding_code text,
    cutb_block_memo text,
    gross_area text,
    est_area text,
    merch_area text,
    harvest_area text,
    remaining_area text,
    cruise_vol text,
    harvest_vol text,
    remaining_vol text,
    cutb_forma_print_date text,
    cutb_forma_printed text,
    cutb_block_state text,
    pmod_modifier_id text,
    harvest_started text,
    harvest_completed text,
    cutb_location text,
    divi_div_nbr text,
    licn_seq_nbr text,
    perm_seq_nbr text,
    mark_seq_nbr text,
    cutb_seq_nbr double precision,
    tso_code text,
    tso_name text,
    nav_name text,
    tenure text,
    licence_id double precision,
    permit_id double precision,
    mark_id double precision,
    block_id double precision,
    block_nbr bigint,
    ubi text,
    opening text,
    op_area text,
    supply_block timestamp without time zone,
    photo text,
    latitude text,
    longitude text,
    prov_frst_conflict text,
    mapsheet_id text,
    landscape_unit text,
    sp_exempt bigint,
    stand_type bigint,
    age_class bigint,
    hgt_class bigint,
    stk_class bigint

);

CREATE TABLE bcts_reporting.forestview_v_block_old AS SELECT * FROM lrm_replication.v_block_old;

CREATE TABLE lrm_replication.v_block_spatial (
    tso_code text,
    nav_name text,
    licence_id text,
    permit_id text,
    mark_id text,
    block_id text,
    cutb_seq_nbr bigint,
    spatial_flag text

);

CREATE TABLE bcts_reporting.forestview_v_block_spatial AS SELECT * FROM lrm_replication.v_block_spatial;

CREATE TABLE lrm_replication.v_block_tasks_issue (
    tso_code text,
    nav_name text,
    licence_id text,
    permit_id text,
    mark_id text,
    block_id text,
    issue text,
    task_description text,
    responsibility text,
    target_date timestamp without time zone,
    completion_date timestamp without time zone,
    provincial_env_comments text,
    government_public_comments text,
    licencee_comments text,
    forester_comments text,
    recommended_requirements text,
    divi_div_nbr bigint,
    tso_name text,
    isst_issue_id text,
    actp_seq_nbr bigint,
    cutb_seq_nbr bigint,
    field_team_desc text,
    ubi text,
    licn_licence_state text

);

CREATE TABLE bcts_reporting.forestview_v_block_tasks_issue AS SELECT * FROM lrm_replication.v_block_tasks_issue;

CREATE TABLE lrm_replication.v_block_timber (
    cutb_seq_nbr bigint,
    timber_type text,
    timber_order bigint

);

CREATE TABLE bcts_reporting.forestview_v_block_timber AS SELECT * FROM lrm_replication.v_block_timber;

CREATE TABLE lrm_replication.v_coastal_cost_survey_bh (
    bhct_id text,
    csud_soft_med_rock_cost_per_m double precision,
    csud_hard_rock_cost_per_m double precision,
    csud_soft_med_rock_const_m double precision,
    csud_hard_rock_const_m double precision,
    csud_ballast_haul_km double precision,
    csur_seq_nbr bigint

);

CREATE TABLE bcts_reporting.forestview_v_coastal_cost_survey_bh AS SELECT * FROM lrm_replication.v_coastal_cost_survey_bh;

CREATE TABLE lrm_replication.v_coastal_cost_survey_roads (
    tso_code text,
    construction_fiscal bigint,
    manu_id text,
    manu_type_id text,
    manu_name text,
    road_name text,
    uri text,
    rcom_start_metre_nbr double precision,
    rcom_end_metre_nbr double precision,
    rcom_planned_date timestamp without time zone,
    rcom_completion_date timestamp without time zone,
    csur_start_metre_nbr double precision,
    csur_end_metre_nbr double precision,
    csur_report_date timestamp without time zone,
    csur_project_id text,
    csur_bid_type text,
    porg_point_of_origin_id text,
    csur_operation_specifics text,
    prepared_by text,
    csur_comment text,
    csur_seq_nbr bigint,
    road_seq_nbr bigint,
    csur_seq_nbr_lng bigint

);

CREATE TABLE bcts_reporting.forestview_v_coastal_cost_survey_roads AS SELECT * FROM lrm_replication.v_coastal_cost_survey_roads;

CREATE TABLE lrm_replication.v_commitments (
    tso_code text,
    tso_name text,
    nav_name text,
    licence_id text,
    permit_id text,
    mark_id text,
    apportionment_type text,
    partition_type text,
    copa_percent text,
    commitment_partition_area text,
    pred_committed_volume text,
    actual_partition_volume text,
    licence_issued_date timestamp without time zone,
    fiscal_year bigint,
    divi_div_nbr bigint,
    manu_seq_nbr bigint,
    mark_seq_nbr bigint,
    perm_seq_nbr bigint,
    licn_seq_nbr bigint,
    copa_seq_nbr text

);

CREATE TABLE bcts_reporting.forestview_v_commitments AS SELECT * FROM lrm_replication.v_commitments;

CREATE TABLE lrm_replication.v_commit_tracking_sale_info (
    tso_code text,
    tso_name text,
    nav_name text,
    licence_id text,
    mark_id text,
    ctor_name text,
    licn_licence_desc text,
    apportionment_type text,
    partition_type text,
    fiscal_year bigint,
    licence_issued_date timestamp without time zone,
    licence_state text,
    appraisal_vol double precision,
    billed_volume text,
    outstanding_volume double precision,
    cut_cruise_ratio double precision,
    licn_seq_nbr bigint,
    manu_seq_nbr bigint,
    divi_div_nbr bigint,
    actual_commit_vol double precision

);

CREATE TABLE bcts_reporting.forestview_v_commit_tracking_sale_info AS SELECT * FROM lrm_replication.v_commit_tracking_sale_info;

CREATE TABLE lrm_replication.v_cost_survey_bridges (
    bridge_station double precision,
    bridge_name text,
    footings text,
    constcategory text,
    cribheight text,
    decklength text,
    deckmaterial text,
    deckwidth text,
    footingsmaterial text,
    loadcapacity text,
    loadrating text,
    maxdptpiledrn text,
    spanmaterial text,
    csus_comment text,
    csus_bridge_cost double precision,
    csus_bridge_approach_work_cost double precision,
    csus_bridge_barging_cost double precision,
    total_cost bigint,
    csur_last_update_mode text,
    csur_seq_nbr bigint,
    csur_seq_nbr_lng bigint

);

CREATE TABLE bcts_reporting.forestview_v_cost_survey_bridges AS SELECT * FROM lrm_replication.v_cost_survey_bridges;

CREATE TABLE lrm_replication.v_cp (
    tso_code text,
    tso_name text,
    nav_name text,
    tenure text,
    licence_id text,
    permit_id text,
    perm_application_description text,
    divi_div_nbr bigint,
    licn_seq_nbr bigint,
    perm_seq_nbr bigint

);

CREATE TABLE bcts_reporting.forestview_v_cp AS SELECT * FROM lrm_replication.v_cp;

CREATE TABLE lrm_replication.v_detailed_site_assessment (
    dsa_stock_species bigint,
    dsa_site_series bigint,
    cutb_seq_nbr text,
    sila_seq_nbr double precision,
    dsas_chemical text,
    dsas_active text,
    dsas_apply_rate text,
    pmpl_pmp_nbr text,
    dsas_pfz_width text,
    dsas_stratum_name text,
    potr_purpose_of_treatment text,
    dsas_buffer_size text,
    dsas_approval_ind text,
    dsas_referal_ind text,
    dsas_water_bodies text,
    dsas_fish_habitat text,
    dsas_community_watershed text,
    dsas_wildlife_habitat text

);

CREATE TABLE bcts_reporting.forestview_v_detailed_site_assessment AS SELECT * FROM lrm_replication.v_detailed_site_assessment;

CREATE TABLE lrm_replication.v_ecology (
    cutb_seq_nbr bigint,
    ecou_seq_nbr bigint,
    eco_unit text,
    gross_area double precision,
    site_series_complex text,
    bioz_zone_id text,
    bios_subzone_id text,
    biov_variant_id text,
    site_series_percent text,
    eco_prod_area bigint,
    reserve_area bigint,
    npnat bigint,
    npunn bigint,
    ncbr bigint,
    divi_div_nbr bigint,
    ecou_elevation_min bigint,
    ecou_elevation_max bigint,
    ecou_elevation_avg bigint,
    ecou_aspect text,
    ecou_slope_min double precision,
    ecou_slope_max double precision,
    ecou_slope_avg double precision,
    ecou_slope_position text

);

CREATE TABLE bcts_reporting.forestview_v_ecology AS SELECT * FROM lrm_replication.v_ecology;

CREATE TABLE lrm_replication.v_ecology_site_series (
    ecou_seq_nbr bigint,
    cutb_seq_nbr bigint,
    ecou_name text,
    bioz_zone_id text,
    bios_subzone_id text,
    biov_variant_id text,
    bgrg_region_code text,
    biss_site_series_id text,
    euss_percent_cover double precision

);

CREATE TABLE bcts_reporting.forestview_v_ecology_site_series AS SELECT * FROM lrm_replication.v_ecology_site_series;

CREATE TABLE lrm_replication.v_ems_action_plan (
    divi_div_nbr bigint,
    tso_code text,
    tso_name text,
    field_team text,
    licence_id text,
    entered_date timestamp without time zone,
    completion_date timestamp without time zone,
    target_completion_date timestamp without time zone,
    action_plan_id text,
    action_status text,
    assigned_to text,
    inspection_type text,
    inspection_sub_type text,
    project_id text,
    project_name text,
    emsa_seq_nbr bigint,
    emsi_seq_nbr double precision,
    eins_seq_nbr text,
    emsp_seq_nbr double precision,
    licn_seq_nbr text,
    lems_seq_nbr double precision

);

CREATE TABLE bcts_reporting.forestview_v_ems_action_plan AS SELECT * FROM lrm_replication.v_ems_action_plan;

CREATE TABLE lrm_replication.v_ems_action_plan_descr (
    divi_div_nbr bigint,
    tso_code text,
    tso_name text,
    licence_id text,
    item_nbr bigint,
    responsibility text,
    cause_description text,
    action_status text,
    description text,
    action text,
    target_date timestamp without time zone,
    completion_date timestamp without time zone,
    emsa_seq_nbr bigint,
    licn_seq_nbr bigint

);

CREATE TABLE bcts_reporting.forestview_v_ems_action_plan_descr AS SELECT * FROM lrm_replication.v_ems_action_plan_descr;

CREATE TABLE lrm_replication.v_ems_contract (
    divi_div_nbr bigint,
    tso_code text,
    tso_name text,
    contract_id text,
    ctor_name text,
    contract_coordinator text,
    contract_location text,
    start_date timestamp without time zone,
    start_status text,
    end_date timestamp without time zone,
    end_status text,
    viewing_date timestamp without time zone,
    internal_ind text,
    emsc_seq_nbr bigint

);

CREATE TABLE bcts_reporting.forestview_v_ems_contract AS SELECT * FROM lrm_replication.v_ems_contract;

CREATE TABLE lrm_replication.v_ems_inspection (
    divi_div_nbr bigint,
    tso_code text,
    tso_name text,
    field_team text,
    class text,
    type text,
    sub_type text,
    inspection_date timestamp without time zone,
    projectid_licence text,
    project_name text,
    road_tenure text,
    log_permit_id text,
    agent text,
    contractor text,
    inspection_status text,
    supervisor text,
    geo_location text,
    data_source text,
    functional_area text,
    lems_epea_status text,
    contract_location text,
    emsp_seq_nbr bigint,
    licn_seq_nbr text,
    eins_seq_nbr bigint,
    epea_seq_nbr bigint,
    lems_seq_nbr text,
    ctor_seq_nbr double precision

);

CREATE TABLE bcts_reporting.forestview_v_ems_inspection AS SELECT * FROM lrm_replication.v_ems_inspection;

CREATE TABLE lrm_replication.v_ems_inspection_frequency (
    divi_div_nbr bigint,
    tso_code text,
    tso_name text,
    field_team text,
    projectid_licence text,
    road_permit text,
    log_dump_permit text,
    inspection_date timestamp without time zone,
    status text,
    inspector text,
    eifr_type text,
    eins_number bigint,
    frequency text,
    data_source text,
    inspection_type text,
    functional_area text,
    project_name text,
    contract_location text,
    contractor text,
    licn_seq_nbr bigint,
    emsc_seq_nbr text,
    lems_seq_nbr bigint,
    epea_seq_nbr text,
    emsp_seq_nbr text,
    eins_seq_nbr bigint

);

CREATE TABLE bcts_reporting.forestview_v_ems_inspection_frequency AS SELECT * FROM lrm_replication.v_ems_inspection_frequency;

CREATE TABLE lrm_replication.v_ems_inspection_test_drill (
    road_permit double precision,
    log_dump_permit text,
    inspection_date text,
    status text,
    test_drill text,
    eins_type text,
    due_date text,
    completion_date timestamp without time zone,
    data_source text,
    inspection_type text,
    functional_area text,
    project_name timestamp without time zone,
    geo_location timestamp without time zone,
    contractor text,
    licn_seq_nbr text,
    emsc_seq_nbr text,
    lems_seq_nbr text,
    epea_seq_nbr text,
    emsp_seq_nbr text,
    eins_seq_nbr double precision,
    divi_div_nbr text,
    tso_code bigint,
    tso_name text,
    field_team text,
    projectid_licence bigint

);

CREATE TABLE bcts_reporting.forestview_v_ems_inspection_test_drill AS SELECT * FROM lrm_replication.v_ems_inspection_test_drill;

CREATE TABLE lrm_replication.v_ems_issue (
    issue_project_name bigint,
    issue_id text,
    entered_by text,
    entered_date text,
    issue_source text,
    issue_type text,
    sub_type text,
    issue_event timestamp without time zone,
    issue_supervisor text,
    issue_investigator text,
    issue_client text,
    rdpm_permit_id text,
    issue_status text,
    occurrence_date text,
    reported_date text,
    licn_licence_id text,
    funct_area text,
    funct_area_activity timestamp without time zone,
    issue_description timestamp without time zone,
    general_location text,
    detailed_description text,
    root_cause text,
    environmental_impact text,
    licn_seq_nbr text,
    sdom_seq_nbr text,
    emsi_seq_nbr text,
    divi_div_nbr text,
    tso bigint,
    business_area bigint,
    field_team bigint

);

CREATE TABLE bcts_reporting.forestview_v_ems_issue AS SELECT * FROM lrm_replication.v_ems_issue;

CREATE TABLE lrm_replication.v_ems_issue_government (
    govt_agency text,
    govt_date timestamp without time zone,
    govt_details text,
    govt_contact text,
    govt_determiniation text,
    emsi_seq_nbr bigint

);

CREATE TABLE bcts_reporting.forestview_v_ems_issue_government AS SELECT * FROM lrm_replication.v_ems_issue_government;

CREATE TABLE lrm_replication.v_ems_issue_investigation (
    investigation_date timestamp without time zone,
    investigation_details text,
    emsi_seq_nbr bigint

);

CREATE TABLE bcts_reporting.forestview_v_ems_issue_investigation AS SELECT * FROM lrm_replication.v_ems_issue_investigation;

CREATE TABLE lrm_replication.v_ems_plan_vs_complete_insp (
    ems_subtype bigint,
    contractor text,
    project_risk_ranking text,
    ems_risk_rating text,
    inspector text,
    inspection_type text,
    inspection_number text,
    frequency text,
    calcemsinsp text,
    compemsinsp text,
    percemsinspcomp text,
    data_source text,
    licn_inspection_type text,
    inspection_date text,
    inspection_status text,
    functional_area text,
    field_team_id bigint,
    emsp_project_name text,
    emsc_ctor_location text,
    eifr_seq_nbr text,
    eins_seq_nbr text,
    licn_seq_nbr text,
    emsc_seq_nbr text,
    manu_seq_nbr text,
    lems_seq_nbr text,
    epea_seq_nbr text,
    ctor_seq_nbr text,
    emsp_seq_nbr text,
    divi_div_nbr bigint,
    tso text,
    division bigint,
    project_licence_id text,
    licence_state text,
    ems_class text,
    ems_type text

);

CREATE TABLE bcts_reporting.forestview_v_ems_plan_vs_complete_insp AS SELECT * FROM lrm_replication.v_ems_plan_vs_complete_insp;

CREATE TABLE lrm_replication.v_ems_plan_vs_compl_prework (
    divi_div_nbr bigint,
    tso text,
    business_area text,
    field_team text,
    project_licence_id text,
    licence_state text,
    licence_activity text,
    planned_date timestamp without time zone,
    planned_status text,
    done_date timestamp without time zone,
    done_status text,
    prework_present text,
    ems_class text,
    ems_type text,
    ems_subtype text,
    prework_date text,
    prework_status text,
    data_source text,
    inspection_type text,
    inspection_date text,
    inspection_status text,
    functional_area text,
    project_name text,
    project_location text,
    contractor text,
    licn_seq_nbr bigint,
    emsc_seq_nbr text,
    manu_seq_nbr bigint,
    lems_seq_nbr text,
    epea_seq_nbr text,
    ctor_seq_nbr double precision,
    emsp_seq_nbr text

);

CREATE TABLE bcts_reporting.forestview_v_ems_plan_vs_compl_prework AS SELECT * FROM lrm_replication.v_ems_plan_vs_compl_prework;

CREATE TABLE lrm_replication.v_ems_requirement (
    divi_div_nbr bigint,
    tso text,
    business_area text,
    field_team text,
    licence_project_id text,
    road_tenure text,
    log_dump_permit text,
    licence_inspection_date timestamp without time zone,
    licence_inspection_status text,
    requirement_type text,
    requirement_desc text,
    requirement_status text,
    data_source text,
    project_inspection_type text,
    project_inspection_date timestamp without time zone,
    project_inspection_status text,
    functional_area text,
    project_name text,
    project_location text,
    contractor text,
    eins_seq_nbr bigint,
    licn_seq_nbr bigint,
    emsc_seq_nbr text,
    lems_seq_nbr bigint,
    epea_seq_nbr text,
    emsp_seq_nbr text

);

CREATE TABLE bcts_reporting.forestview_v_ems_requirement AS SELECT * FROM lrm_replication.v_ems_requirement;

CREATE TABLE lrm_replication.v_fdu (
    tso_code text,
    fsfd_name text,
    fspm_seq_nbr bigint,
    fsfd_seq_nbr bigint

);

CREATE TABLE bcts_reporting.forestview_v_fdu AS SELECT * FROM lrm_replication.v_fdu;

CREATE TABLE lrm_replication.v_forest_comment (
    seq_nbr_type text,
    seq_nbr_value bigint,
    comm_comment_date timestamp without time zone,
    comm_comment text,
    comm_agency text,
    comm_agent text,
    comm_response_date text,
    comm_respondant text,
    comm_response text,
    comm_action_required text,
    comm_action_item text,
    comm_comment_type text,
    comm_fdp_id text

);

CREATE TABLE bcts_reporting.forestview_v_forest_comment AS SELECT * FROM lrm_replication.v_forest_comment;

CREATE TABLE lrm_replication.v_frpa_results_strategies (
    actt_seq_nbr bigint,
    asses_desc text,
    fsrl_comment text,
    fsrc_comment_rs text,
    cutb_seq_nbr text,
    fdu_seq_nbr text,
    plan_seq_nbr text,
    divi_div_nbr text,
    tso_code text,
    tso_name text,
    parent_plan_name text,
    parent_effective_date timestamp without time zone,
    parent_expiry_date timestamp without time zone,
    parent_plan_status timestamp without time zone,
    plan_type text,
    plan_name text,
    plan_description text,
    plan_status text,
    plan_effective_date double precision,
    plan_expiry_date text,
    plan_approval_date text,
    plan_comment text,
    fspm_submission_date text,
    fspm_ts_num text,
    fdu_name text,
    fdu_area text,
    fdu_selected text,
    fdu_comments text,
    fdu_block_area text,
    fdu_road_length double precision,
    documentkey text,
    sde_state_id text,
    licence_id text,
    permit text,
    block_id text,
    ubi text,
    block_area text,
    block_plan_status text,
    landscape_unit bigint,
    mapsheet text,
    fsob_id text,
    fsrs_id text,
    applies double precision,
    fsrs_description double precision,
    fsrs_comment bigint

);

CREATE TABLE bcts_reporting.forestview_v_frpa_results_strategies AS SELECT * FROM lrm_replication.v_frpa_results_strategies;

CREATE TABLE lrm_replication.v_gis_actd (
    divi_div_nbr bigint,
    manu_seq_nbr bigint,
    perm_seq_nbr bigint,
    mark_seq_nbr bigint,
    licn_seq_nbr bigint,
    cutb_seq_nbr bigint,
    blal_merch_ha_area double precision,
    blal_harvested_ha_area double precision,
    blal_cruise_m3_vol double precision,
    blal_rw_vol text,
    blal_harvested_m3_vol double precision,
    auction_date_compare timestamp without time zone,
    auction_date timestamp without time zone

);

CREATE TABLE bcts_reporting.forestview_v_gis_actd AS SELECT * FROM lrm_replication.v_gis_actd;

CREATE TABLE lrm_replication.v_gis_actd_dates (
    divi_div_nbr bigint,
    manu_seq_nbr bigint,
    perm_seq_nbr bigint,
    mark_seq_nbr bigint,
    licn_seq_nbr bigint,
    cutb_seq_nbr bigint,
    blal_merch_ha_area double precision,
    blal_harvested_ha_area double precision,
    blal_cruise_m3_vol text,
    blal_rw_vol text,
    blal_harvested_m3_vol text,
    actt_key_ind text,
    status_date timestamp without time zone,
    auction_date_compare timestamp without time zone

);

CREATE TABLE bcts_reporting.forestview_v_gis_actd_dates AS SELECT * FROM lrm_replication.v_gis_actd_dates;

CREATE TABLE lrm_replication.v_gis_acts (
    licn_seq_nbr bigint,
    cutb_seq_nbr bigint,
    auction_status text

);

CREATE TABLE bcts_reporting.forestview_v_gis_acts AS SELECT * FROM lrm_replication.v_gis_acts;

CREATE TABLE lrm_replication.v_gis_acts_status (
    cutb_seq_nbr text,
    actt_key_ind bigint,
    status_ind text,
    licn_seq_nbr text

);

CREATE TABLE bcts_reporting.forestview_v_gis_acts_status AS SELECT * FROM lrm_replication.v_gis_acts_status;

CREATE TABLE lrm_replication.v_harvested_block_status (
    tso_code text,
    nav_name text,
    licence_id text,
    permit_id text,
    mark_id text,
    block_id text,
    block_nbr text,
    op_area text,
    gross_area double precision,
    acti_status_ind text,
    acti_status_date timestamp without time zone,
    block_rg_status text,
    block_fg_status text,
    block_gu_status text,
    block_status text,
    divi_div_nbr bigint,
    licn_seq_nbr bigint,
    perm_seq_nbr bigint,
    mark_seq_nbr bigint,
    cutb_seq_nbr bigint

);

CREATE TABLE bcts_reporting.forestview_v_harvested_block_status AS SELECT * FROM lrm_replication.v_harvested_block_status;

CREATE TABLE lrm_replication.v_harvest_history (
    bchh_update_timestamp text,
    site_name text,
    site_location text,
    licn_seq_nbr timestamp without time zone,
    mark_seq_nbr text,
    tso_code text,
    licn_licence_id text,
    mark_mark_id text,
    bchh_billing_period double precision,
    bchh_hdbs_tree_species bigint,
    bchh_forest_product_code double precision,
    bchh_log_grade double precision,
    bchh_billing_type_code double precision,
    bchh_volume_billed double precision,
    bchh_pieces_billed double precision,
    bchh_royalty_amount timestamp without time zone,
    bchh_reserve_stmpg_amt text,
    bchh_bonus_stumpage_amt text,
    bchh_silv_levy_amount bigint,
    bchh_dev_levy_amount bigint

);

CREATE TABLE bcts_reporting.forestview_v_harvest_history AS SELECT * FROM lrm_replication.v_harvest_history;

CREATE TABLE lrm_replication.v_harvest_unit (
    cbin_seq_nbr bigint,
    cutb_seq_nbr bigint,
    harvest_unit_id text,
    season text,
    method text,
    strategy text,
    total_area double precision,
    total_vol double precision,
    depleted_area text,
    depleted_vol text,
    digitized text,
    cbin_comments text,
    season_id text,
    method_id text,
    strategy_id text,
    silv_strategy_id text

);

CREATE TABLE bcts_reporting.forestview_v_harvest_unit AS SELECT * FROM lrm_replication.v_harvest_unit;

CREATE TABLE lrm_replication.v_interior_cost_survey_culv (
    culvert_station double precision,
    diameter text,
    length text,
    ctype text,
    xrise text,
    csus_comment text,
    csus_culvert_material_cost double precision,
    csus_culvert_install_cost double precision,
    total_cost double precision,
    csur_seq_nbr bigint,
    csur_seq_nbr_lng bigint

);

CREATE TABLE bcts_reporting.forestview_v_interior_cost_survey_culv AS SELECT * FROM lrm_replication.v_interior_cost_survey_culv;

CREATE TABLE lrm_replication.v_interior_cost_survey_roads (
    csur_sg_overland_cost text,
    csur_sg_other_eng_cost bigint,
    csur_end_haul_distance_m text,
    csur_end_haul_volume_m3 text,
    csur_overland_distance_m text,
    csur_overland_volume_m3 text,
    csur_seq_nbr text,
    road_seq_nbr double precision,
    csur_seq_nbr_lng double precision,
    tso_code timestamp without time zone,
    construction_fiscal timestamp without time zone,
    manu_id double precision,
    manu_type_id double precision,
    manu_name timestamp without time zone,
    road_name text,
    uri text,
    rcom_start_metre_nbr text,
    rcom_end_metre_nbr text,
    rcom_planned_date double precision,
    rcom_completion_date double precision,
    csur_start_metre_nbr text,
    csur_end_metre_nbr text,
    csur_report_date double precision,
    csur_project_id double precision,
    csur_road_type double precision,
    csur_moisture_code double precision,
    bioz_zone_id double precision,
    csur_side_slope_perc bigint,
    csur_boulder_area_perc text,
    prepared_by double precision,
    csur_comment double precision,
    csur_mt_hard_rock_perc text,
    csur_mt_rippable_rock_perc double precision,
    csur_mt_coarse_perc double precision,
    csur_mt_fine_perc double precision,
    csur_mt_organic_perc double precision,
    total_pct double precision,
    csur_as_code bigint,
    csur_as_length_km double precision,
    csur_as_surface_width_m double precision,
    csur_as_type double precision,
    csur_as_depth_m double precision,
    csur_as_distance_to_source_km double precision,
    csur_as_actual_cost double precision,
    csur_as_ttt_transfer_cost double precision,
    csur_as_other_transfer_cost double precision,
    addl_stab_cost double precision,
    addl_stab_cost_per_km double precision,
    csur_sg_length_km double precision,
    csur_sg_surface_width_m double precision,
    csur_sg_actual_cost double precision,
    csur_sg_ttt_transfer_cost double precision,
    csur_sg_other_transfer_cost double precision,
    sub_grade_cost bigint,
    csur_sg_landing_cost bigint,
    csur_sg_end_haul_cost bigint

);

CREATE TABLE bcts_reporting.forestview_v_interior_cost_survey_roads AS SELECT * FROM lrm_replication.v_interior_cost_survey_roads;

CREATE TABLE lrm_replication.v_licence (
    licn_seq_nbr bigint,
    tent_seq_nbr bigint,
    ctor_seq_nbr bigint,
    cloc_seq_nbr bigint,
    tso_code text,
    tso_name text,
    nav_name text,
    licence_id text,
    category text,
    tenure text,
    licensee text,
    registrant text,
    registrant_city text,
    field_team text,
    district_name text,
    divi_div_nbr bigint,
    licn_category_id text,
    blaz_admin_zone_id text,
    blaz_admin_zone_desc text,
    licn_licence_state text,
    licn_licence_desc text,
    licn_licence_to_cut_code text,
    linc_cert_level_id text,
    licn_digi_ind text,
    licn_salvage_ind text,
    licn_apportion_tenure_type text,
    apportion_type text,
    partition_type text,
    commit_licence_type text,
    commit_volume text,
    remain_commit_volume text,
    bchh_billing_year text,
    manu_seq_nbr bigint

);

CREATE TABLE bcts_reporting.forestview_v_licence AS SELECT * FROM lrm_replication.v_licence;

CREATE TABLE lrm_replication.v_licence_activity_all (
    divi_div_nbr bigint,
    tso_code text,
    field_team_desc text,
    nav_name text,
    tenure text,
    licence_id text,
    licn_licence_state text,
    activity_class text,
    activity_type text,
    actt_key_ind text,
    accl_object_type text,
    acti_responsibility text,
    acti_status_ind text,
    acti_target_date timestamp without time zone,
    acti_target_cost text,
    activity_date timestamp without time zone,
    acti_status_date timestamp without time zone,
    acti_cost text,
    acti_comments text,
    licensee text,
    acti_seq_nbr bigint,
    licn_seq_nbr bigint,
    modifiedby text,
    modifiedon timestamp without time zone,
    createdby text,
    createdon text

);

CREATE TABLE bcts_reporting.forestview_v_licence_activity_all AS SELECT * FROM lrm_replication.v_licence_activity_all;

CREATE TABLE lrm_replication.v_mark (
    hbs_update_timestamp bigint,
    mark_rw_volume_m3 bigint,
    appraisal_volume bigint,
    field_team_desc text,
    licn_licence_state text,
    licn_seq_nbr text,
    perm_seq_nbr text,
    mark_seq_nbr text,
    tso_code text,
    tso_name text,
    nav_name bigint,
    tenure double precision,
    licence_id double precision,
    permit_id text,
    mark_id text,
    divi_div_nbr timestamp without time zone,
    mark_cruise_volume_m3 double precision,
    hbs_volume_billed double precision,
    mark_state text,
    mark_description text

);

CREATE TABLE bcts_reporting.forestview_v_mark AS SELECT * FROM lrm_replication.v_mark;

CREATE TABLE lrm_replication.v_mark_activity (
    mark_seq_nbr bigint,
    acti_seq_nbr bigint,
    activity_class text,
    activity_type text,
    activity_date timestamp without time zone,
    status_ind text

);

CREATE TABLE bcts_reporting.forestview_v_mark_activity AS SELECT * FROM lrm_replication.v_mark_activity;

CREATE TABLE lrm_replication.v_non_frpa_results_strategies (
    cmcm_seq_nbr bigint,
    divi_div_nbr bigint,
    silp_seq_nbr bigint,
    cmtg_content text,
    cmcm_text text

);

CREATE TABLE bcts_reporting.forestview_v_non_frpa_results_strategies AS SELECT * FROM lrm_replication.v_non_frpa_results_strategies;

CREATE TABLE lrm_replication.v_pest_infestation (
    slay_layer text,
    sist_seq_nbr bigint,
    spst_pest_desc text,
    spst_pest_code text,
    pein_percent double precision

);

CREATE TABLE bcts_reporting.forestview_v_pest_infestation AS SELECT * FROM lrm_replication.v_pest_infestation;

CREATE TABLE lrm_replication.v_planting (
    cutb_seq_nbr bigint,
    sila_seq_nbr bigint,
    plun_seq_nbr text,
    licence_id text,
    permit_id text,
    block_id text,
    plant_id text,
    base text,
    technique text,
    method text,
    act_name text,
    fund_funding_code text,
    sila_gross_ha_area double precision,
    start_date timestamp without time zone,
    complete_date timestamp without time zone,
    status text,
    plun_ha_area text,
    contractor text,
    density text,
    plant_species text,
    plant_species_and_pct text,
    comments text,
    divi_div_nbr bigint,
    sipr_seq_nbr text,
    sipr_project_id text,
    plun_quality_percent text,
    trees text,
    plun_contract_max_spacing text,
    plun_contract_min_spacing text,
    plun_contract_target_spacing text

);

CREATE TABLE bcts_reporting.forestview_v_planting AS SELECT * FROM lrm_replication.v_planting;

CREATE TABLE lrm_replication.v_planting_species (
    sisl_comments bigint,
    sisl_viability_pct text,
    ssuc_seed_use_code bigint,
    sisl_active_ind text,
    bioz_zone_id text,
    plun_seq_nbr text,
    sisp_species_id double precision,
    plsp_number_trees bigint,
    sisl_seed_lot_number text,
    sirk_request_key bigint,
    plsp_seed_weight text,
    plsp_price_per_tree text,
    cutb_seq_nbr text,
    sirk_stock_type text,
    cc_percentage text,
    plsp_trees_outside_zone text,
    plsp_comment text,
    sirk_years_original_container text,
    sirk_years_transplanted text,
    sisl_seed_zone text,
    sisl_genetic_class text,
    sisl_genetic_worth text,
    sisl_elevation_min text,
    sisl_elevation_max text,
    sisl_elevation_mean text,
    sisl_latitude_min text,
    sisl_latitude_max text,
    sisl_latitude_mean text,
    sisl_longitude text,
    sisl_number_trees text,
    sisl_kilograms text,
    sisl_owner_name text

);

CREATE TABLE bcts_reporting.forestview_v_planting_species AS SELECT * FROM lrm_replication.v_planting_species;

CREATE TABLE lrm_replication.v_qb_valuation (
    mark_seq_nbr text,
    cutb_seq_nbr text,
    user_id text,
    estim_date text,
    lcst_seq_nbr text,
    lcst_item6_source text,
    block_avg_cost text,
    coastal_appr_rate text,
    profit_risk_pct timestamp without time zone,
    block_cruise_vol text,
    appr_road_bridge_cost bigint,
    appr_road_culvert_cost text,
    appr_road_road_cost bigint,
    appr_road_land_use_cost text,
    appr_road_sp_op_cost bigint,
    appr_road_eng_proj_cost text,
    appr_road_cost bigint,
    est_bonus_bid_coeff text,
    road_cost_acti_construction bigint,
    road_cost_acti_inspection text,
    road_cost_acti_maintenance bigint,
    road_cost_acti_deactivation text,
    road_cost_acti_access_control bigint,
    road_cost_acti_assessment text,
    road_cost_stru_general double precision,
    road_cost_stru_inspection text,
    road_cost_stru_maintenance bigint,
    road_cost_stru_replacement text,
    road_cost_total bigint,
    silviculture_cost_pl_total text,
    silviculture_cost_su_total bigint,
    silviculture_cost_br_total text,
    silviculture_cost_sp_total double precision,
    silviculture_cost_gen_total text,
    silviculture_cost_total bigint,
    indirect_cost_total text,
    hauling_comment_cnt bigint,
    stumpage_comment_cnt text,
    indirect_comment_cnt bigint,
    ttt_comment_cnt text,
    silviculture_comment_cnt bigint,
    roads_comment_cnt text,
    item1_comment_cnt text,
    item2_comment_cnt text,
    item3_comment_cnt timestamp without time zone,
    item4_comment_cnt bigint,
    item5_comment_cnt text,
    item6_comment_cnt double precision,
    item7_comment_cnt bigint,
    item8_comment_cnt bigint,
    item9_comment_cnt double precision,
    item10_comment_cnt bigint,
    licn_seq_nbr bigint,
    perm_seq_nbr bigint,
    tso_code bigint,
    nav_name bigint,
    tenure bigint,
    licence_id bigint,
    permit_id bigint,
    mark_id bigint,
    block_id bigint,
    block_nbr bigint,
    sppr_effective_date double precision,
    hauling_source bigint,
    hauling_cost bigint,
    silviculture_source bigint,
    silviculture_cost bigint,
    stumpage_source bigint,
    stumpage_cost bigint,
    indirect_source double precision,
    indirect_cost double precision,
    roads_source double precision,
    roads_cost bigint,
    tree_to_truck_source bigint,
    tree_to_truck_cost bigint,
    item1_source double precision,
    item1 double precision,
    item2_source bigint,
    item2 bigint,
    item3_source bigint,
    item3 bigint,
    item4_source bigint,
    item4 bigint,
    item5_source bigint,
    item5 bigint,
    item6_source bigint,
    item6 bigint,
    item7_source bigint,
    item7 bigint,
    item8_source bigint,
    item8 bigint,
    item9_source bigint,
    item9 bigint,
    item10_source bigint,
    item10 bigint,
    mill_mill_id bigint,
    mill_id bigint

);

CREATE TABLE bcts_reporting.forestview_v_qb_valuation AS SELECT * FROM lrm_replication.v_qb_valuation;

CREATE TABLE lrm_replication.v_riparian_zone (
    cutb_seq_nbr bigint,
    silp_seq_nbr bigint,
    divi_div_nbr bigint,
    ripz_lake_id text,
    ripz_class text,
    rimz_zone_id text,
    rizd_buffer_width double precision,
    rizd_basal_area_min double precision,
    rizd_basal_area_max text,
    rizd_density double precision,
    rizd_harvesting_ind text,
    rizd_su_cross_reference text,
    rizd_comments text,
    rizd_area text,
    rizd_digitised_ind text,
    rizd_seq_nbr double precision

);

CREATE TABLE bcts_reporting.forestview_v_riparian_zone AS SELECT * FROM lrm_replication.v_riparian_zone;

CREATE TABLE lrm_replication.v_road (
    road_seq_nbr bigint,
    divi_div_nbr bigint,
    division text,
    division_name text,
    tso_code text,
    tso_name text,
    nav_name text,
    field_team_desc text,
    road_name text,
    road_type text,
    road_desc text,
    uri text,
    rdst_steward_name text,
    state text,
    start_station double precision,
    end_station double precision,
    length double precision,
    modified_date timestamp without time zone,
    modifiedby text,
    modifiedusing text,
    createdby text,
    createdon text,
    createdusing text,
    station_source text,
    adj_valid text,
    spatial_title text,
    owner text,
    valid_mark text,
    within_alr text,
    road_seq_nbr_lng bigint,
    field_team text,
    rcls_accounting_type text,
    modifiedon timestamp without time zone

);

CREATE TABLE bcts_reporting.forestview_v_road AS SELECT * FROM lrm_replication.v_road;

CREATE TABLE lrm_replication.v_road_activity (
    road_road_name bigint,
    road_road_desc text,
    uri text,
    rcom_start_metre_nbr text,
    rcom_end_metre_nbr text,
    rcom_planned_date text,
    rcom_completion_date text,
    rcom_constr_type double precision,
    rins_start_metre_nbr double precision,
    rins_end_metre_nbr timestamp without time zone,
    rins_planned_date timestamp without time zone,
    rins_inspection_date text,
    rins_condition_desc double precision,
    rins_insp_type double precision,
    mtce_start_metre_nbr timestamp without time zone,
    mtce_end_metre_nbr timestamp without time zone,
    mtce_planned_date text,
    mtce_completion_date text,
    mtce_method double precision,
    deac_start_metre_nbr double precision,
    deac_end_metre_nbr timestamp without time zone,
    deac_planned_date text,
    deac_start_date text,
    deac_end_date text,
    deac_level_type text,
    deac_access_type text,
    deac_method text,
    acon_start_metre_nbr text,
    acon_end_metre_nbr text,
    acon_planned_date text,
    acon_start_date text,
    acon_end_date text,
    acon_access_type text,
    acon_method text,
    rass_start_metre_nbr text,
    rass_end_metre_nbr text,
    rass_planned_date text,
    rass_completion_date text,
    rass_type double precision,
    road_seq_nbr double precision,
    divi_div_nbr timestamp without time zone,
    tso_code text,
    tso_name text,
    field_team_desc bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_activity AS SELECT * FROM lrm_replication.v_road_activity;

CREATE TABLE lrm_replication.v_road_activity_cost (
    repl_seq_nbr bigint,
    rstr_seq_nbr text,
    divi_div_nbr text,
    racm_activity_type text,
    csti_cost_item_id double precision,
    csti_cost_item_description text,
    raco_item_cost timestamp without time zone,
    raco_cost_type text,
    raco_cost_date double precision,
    raco_comment double precision,
    rcom_seq_nbr text,
    rins_seq_nbr double precision,
    mtce_seq_nbr text,
    deac_seq_nbr text,
    acon_seq_nbr text,
    rass_seq_nbr text,
    insp_seq_nbr text,
    main_seq_nbr text

);

CREATE TABLE bcts_reporting.forestview_v_road_activity_cost AS SELECT * FROM lrm_replication.v_road_activity_cost;

CREATE TABLE lrm_replication.v_road_activity_cost_row (
    ract_seq_nbr bigint,
    divi_div_nbr text,
    racm_activity_type text,
    csti_cost_item_id text,
    csti_cost_item_description double precision,
    raco_item_cost text,
    raco_cost_type timestamp without time zone,
    raco_cost_date text,
    raco_comment bigint,
    raco_seq_nbr bigint,
    racm_seq_nbr text,
    ract_seq_id bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_activity_cost_row AS SELECT * FROM lrm_replication.v_road_activity_cost_row;

CREATE TABLE lrm_replication.v_road_activity_row (
    divi_div_nbr bigint,
    tso_code text,
    tso_name text,
    field_team_desc text,
    road_road_name text,
    uri text,
    meth_activity_type text,
    meth_method_type text,
    pers_display_name text,
    ctor_name text,
    start_station double precision,
    end_station double precision,
    planned_date timestamp without time zone,
    start_date timestamp without time zone,
    completion_date timestamp without time zone,
    budgeted_cost text,
    actual_cost text,
    memo text,
    rstr_at_metre_nbr text,
    structure_id text,
    structure_file_id text,
    inspect_frequency text,
    ract_seq_id text,
    ract_seq_nbr bigint,
    road_seq_nbr bigint,
    modifiedby text,
    modifiedon timestamp without time zone,
    modifiedusing text,
    createdby text,
    createdon text,
    createdusing text

);

CREATE TABLE bcts_reporting.forestview_v_road_activity_row AS SELECT * FROM lrm_replication.v_road_activity_row;

CREATE TABLE lrm_replication.v_road_agri_land_reserve (
    divi_div_nbr bigint,
    tso_code text,
    tso_name text,
    field_team_desc text,
    manu_id text,
    road_road_name text,
    uri text,
    ralr_start_metre_nbr double precision,
    ralr_end_metre_nbr double precision,
    ralr_length bigint,
    ralr_within_alr_ind text,
    modifiedby text,
    modifiedon text,
    modifiedusing text,
    createdby text,
    createdon text,
    createdusing text,
    road_seq_nbr bigint,
    ralr_seq_nbr bigint,
    ralr_seq_nbr_lng bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_agri_land_reserve AS SELECT * FROM lrm_replication.v_road_agri_land_reserve;

CREATE TABLE lrm_replication.v_road_assessment (
    divi_div_nbr bigint,
    tso_code text,
    tso_name text,
    nav_name text,
    field_team_desc text,
    road_road_name text,
    uri text,
    meth_activity_type text,
    rass_start_metre_nbr double precision,
    rass_end_metre_nbr double precision,
    rass_planned_date timestamp without time zone,
    rass_completion_date timestamp without time zone,
    meth_method_type text,
    rass_status text,
    rass_responsibility text,
    rass_contractor text,
    rass_activity_memo text,
    rass_budgeted_cost double precision,
    rass_actual_cost double precision,
    modifiedby text,
    modifiedon text,
    modifiedusing text,
    createdby text,
    createdon text,
    createdusing text,
    road_seq_nbr bigint,
    rass_seq_nbr_lng bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_assessment AS SELECT * FROM lrm_replication.v_road_assessment;

CREATE TABLE lrm_replication.v_road_class (
    divi_div_nbr bigint,
    tso_code text,
    tso_name text,
    nav_name text,
    field_team_desc text,
    road_road_name text,
    uri text,
    rcls_start_metre_nbr double precision,
    rcls_end_metre_nbr double precision,
    rcls_length bigint,
    rcls_class_type text,
    rcls_road_type text,
    rcls_accounting_type text,
    rcls_comments text,
    modifiedby text,
    modifiedon text,
    modifiedusing text,
    createdby text,
    createdon text,
    createdusing text,
    road_seq_nbr bigint,
    rcls_seq_nbr bigint,
    rcls_seq_nbr_lng bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_class AS SELECT * FROM lrm_replication.v_road_class;

CREATE TABLE lrm_replication.v_road_completion (
    divi_div_nbr bigint,
    tso_code text,
    tso_name text,
    nav_name text,
    field_team_desc text,
    road_road_name text,
    uri text,
    rcom_start_metre_nbr double precision,
    rcom_end_metre_nbr double precision,
    rcom_length bigint,
    rcom_planned_date timestamp without time zone,
    rcom_completion_date timestamp without time zone,
    rcom_stage_type text,
    rcom_surface_type text,
    rcom_actual_cost text,
    rcom_budgeted_cost text,
    rcom_method text,
    rcom_option_type text,
    rcom_fdp_critical text,
    rcom_joint_approval text,
    rcom_construction_type text,
    rcom_contractor text,
    rcom_accounting_type text,
    meth_activity_type text,
    meth_method_type text,
    rcom_responsibility text,
    rcom_abr_reported_ind text,
    rcom_actual_start_date text,
    rcom_actual_completion_date text,
    rcom_grade_percent text,
    ctor_name text,
    pers_display_name text,
    modifiedby text,
    modifiedon timestamp without time zone,
    modifiedusing text,
    createdby text,
    createdon timestamp without time zone,
    createdusing text,
    road_seq_nbr bigint,
    rcom_seq_nbr bigint,
    rcom_seq_nbr_lng bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_completion AS SELECT * FROM lrm_replication.v_road_completion;

CREATE TABLE lrm_replication.v_road_cut_block (
    divi_div_nbr bigint,
    tso_code text,
    tso_name text,
    nav_name text,
    field_team_desc text,
    road_road_name text,
    uri text,
    rcut_start_metre_nbr double precision,
    rcut_end_metre_nbr double precision,
    modifiedby text,
    modifiedon timestamp without time zone,
    modifiedusing text,
    createdby text,
    createdon timestamp without time zone,
    createdusing text,
    road_seq_nbr bigint,
    rcut_seq_nbr bigint,
    cutb_seq_nbr bigint,
    rcut_seq_nbr_lng bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_cut_block AS SELECT * FROM lrm_replication.v_road_cut_block;

CREATE TABLE lrm_replication.v_road_deactivation (
    deac_seq_nbr_lng bigint,
    divi_div_nbr text,
    tso_code text,
    tso_name text,
    nav_name text,
    field_team_desc text,
    road_road_name text,
    uri double precision,
    deac_start_metre_nbr double precision,
    deac_end_metre_nbr bigint,
    deac_length timestamp without time zone,
    deac_planned_date text,
    deac_start_date timestamp without time zone,
    deac_end_date text,
    meth_activity_type text,
    meth_method_type text,
    deac_level_type text,
    deac_access_type text,
    deac_activity_memo text,
    deac_method_option_type text,
    deac_method_attribute_desc text,
    deac_fdp_critical text,
    deac_contractor text,
    deac_responsibility text,
    ctor_seq_nbr double precision,
    pers_seq_nbr text,
    cloc_seq_nbr double precision,
    deac_budgeted_cost double precision,
    deac_actual_cost text,
    deac_abr_reported_ind text,
    deac_actual_start_date text,
    deac_actual_completion_date text,
    deac_completion_date text,
    ctor_name text,
    pers_display_name text,
    modifiedby timestamp without time zone,
    modifiedon text,
    modifiedusing text,
    createdby timestamp without time zone,
    createdon text,
    createdusing bigint,
    road_seq_nbr bigint,
    deac_seq_nbr bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_deactivation AS SELECT * FROM lrm_replication.v_road_deactivation;

CREATE TABLE lrm_replication.v_road_event_mapping (
    divi_div_nbr bigint,
    tso_code text,
    divi_division_name text,
    field_team_desc text,
    road_seq_nbr bigint,
    road_road_name text,
    uri text,
    poc double precision,
    pot bigint,
    prime_road_seq_nbr bigint,
    rdpm_permit_type text,
    rdpm_permit_id text,
    ruse_section_id text,
    rdst_steward_name text,
    rsta_status_code text,
    rsta_road_state text,
    rcls_class_type text,
    rcls_road_type text

);

CREATE TABLE bcts_reporting.forestview_v_road_event_mapping AS SELECT * FROM lrm_replication.v_road_event_mapping;

CREATE TABLE lrm_replication.v_road_gap_analysis (
    deac_planned_date bigint,
    deac_end_date text,
    deac_method_type text,
    deac_level_type bigint,
    deac_budgeted_cost text,
    divi_div_nbr text,
    tso_code text,
    divi_division_name text,
    road_seq_nbr double precision,
    uri double precision,
    road_road_name bigint,
    road_road_desc bigint,
    field_team_desc bigint,
    road_end_metre_nbr text,
    poc bigint,
    pot text,
    prime_road_seq_nbr text,
    rdst_seq_nbr double precision,
    rdst_steward_name text,
    rcls_seq_nbr text,
    rcls_class_type double precision,
    rcls_accounting_type text,
    rsta_seq_nbr text,
    rsta_status_code text,
    rsta_road_state text,
    ruse_seq_nbr text,
    rdpm_permit_id text,
    ruse_section_id double precision,
    rdpm_permit_type text,
    rdpm_start_date timestamp without time zone,
    rdpm_expiry_date timestamp without time zone,
    rdpm_amendment_nbr text,
    rcom_seq_nbr text,
    const_method_type double precision,
    rcom_planned_date timestamp without time zone,
    rcom_completion_date timestamp without time zone,
    rcom_budgeted_cost text,
    rcom_method text,
    deac_seq_nbr text

);

CREATE TABLE bcts_reporting.forestview_v_road_gap_analysis AS SELECT * FROM lrm_replication.v_road_gap_analysis;

CREATE TABLE lrm_replication.v_road_inspection (
    divi_div_nbr bigint,
    tso_code text,
    tso_name text,
    nav_name text,
    field_team_desc text,
    road_road_name text,
    uri text,
    rins_start_metre_nbr double precision,
    rins_end_metre_nbr double precision,
    rins_length bigint,
    rins_planned_date timestamp without time zone,
    rins_inspection_date timestamp without time zone,
    rins_condition_desc text,
    rins_performed_by_name text,
    rins_activity_memo text,
    rins_inspection_type text,
    rins_option_type text,
    rins_inspection_file_id text,
    meth_activity_type text,
    meth_method_type text,
    rins_responsibility text,
    inspected_by_person text,
    rins_inspector_type text,
    rins_budgeted_cost text,
    rins_actual_cost text,
    rins_actual_start_date text,
    rins_actual_completion_date text,
    rins_integrity_ok text,
    rins_drainage_ok text,
    rins_industrial_use_ok text,
    rins_revegetated text,
    ctor_name text,
    pers_display_name text,
    modifiedby text,
    modifiedon timestamp without time zone,
    modifiedusing text,
    createdby text,
    createdon text,
    createdusing text,
    road_seq_nbr bigint,
    rins_seq_nbr bigint,
    rins_seq_nbr_lng bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_inspection AS SELECT * FROM lrm_replication.v_road_inspection;

CREATE TABLE lrm_replication.v_road_linear_struct (
    divi_div_nbr bigint,
    tso_code text,
    tso_name text,
    field_team_desc text,
    road_road_name text,
    uri text,
    rlst_start_metre_nbr double precision,
    rlst_end_metre_nbr double precision,
    abre_struct_class text,
    abrf_struct_type_fd text,
    abrw_struct_type_wall text,
    rlst_eng_ind text,
    rlst_offset_nbr double precision,
    rlst_road_side text,
    rlst_reported_ind text,
    road_seq_nbr bigint,
    rlst_seq_nbr bigint,
    rlst_seq_nbr_lng bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_linear_struct AS SELECT * FROM lrm_replication.v_road_linear_struct;

CREATE TABLE lrm_replication.v_road_maintenance (
    divi_div_nbr bigint,
    tso_code text,
    tso_name text,
    nav_name text,
    field_team_desc text,
    road_road_name text,
    uri text,
    meth_activity_type text,
    meth_method_type text,
    mtce_start_metre_nbr double precision,
    mtce_end_metre_nbr double precision,
    mtce_length bigint,
    mtce_planned_date timestamp without time zone,
    mtce_completion_date timestamp without time zone,
    mtce_activity_memo text,
    mtce_method_option_type text,
    mtce_method_attribute_desc text,
    mtce_contractor text,
    rins_seq_nbr text,
    mtce_responsibility text,
    ctor_name text,
    pers_display_name text,
    cloc_seq_nbr text,
    mtce_budgeted_cost text,
    mtce_actual_cost text,
    mtce_actual_start_date text,
    mtce_actual_completion_date text,
    modifiedby text,
    modifiedon text,
    modifiedusing text,
    createdby text,
    createdon text,
    createdusing text,
    road_seq_nbr bigint,
    mtce_seq_nbr bigint,
    mtce_seq_nbr_lng bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_maintenance AS SELECT * FROM lrm_replication.v_road_maintenance;

CREATE TABLE lrm_replication.v_road_management_unit (
    divi_div_nbr double precision,
    tso_code text,
    tso_name text,
    road_name text,
    uri text,
    field_team_desc text,
    manu_id text,
    manu_name text,
    rmanu_start_metre_nbr double precision,
    rmanu_end_metre_nbr double precision,
    modifiedby text,
    modifiedon timestamp without time zone,
    modifiedusing text,
    createdby text,
    createdon timestamp without time zone,
    createdusing text,
    road_seq_nbr bigint,
    manu_seq_nbr bigint,
    rmanu_seq_nbr bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_management_unit AS SELECT * FROM lrm_replication.v_road_management_unit;

CREATE TABLE lrm_replication.v_road_mapsheet (
    road_seq_nbr bigint,
    rmap_seq_nbr_lng text,
    divi_div_nbr text,
    tso_code text,
    tso_name text,
    nav_name text,
    field_team_desc text,
    road_road_name double precision,
    uri double precision,
    rmap_start_metre_nbr text,
    rmap_end_metre_nbr text,
    maps_mapsheet_id timestamp without time zone,
    modifiedby text,
    modifiedon text,
    modifiedusing text,
    createdby text,
    createdon bigint,
    createdusing bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_mapsheet AS SELECT * FROM lrm_replication.v_road_mapsheet;

CREATE TABLE lrm_replication.v_road_on_block (
    licn_seq_nbr bigint,
    mark_seq_nbr text,
    cutb_seq_nbr text,
    ronb_seq_nbr_lng text,
    divi_div_nbr text,
    tso_code text,
    tso_name text,
    field_team_desc double precision,
    manu_id double precision,
    road_road_name bigint,
    uri text,
    ronb_start_metre_nbr text,
    ronb_end_metre_nbr text,
    ronb_length text,
    licn_licence_id text,
    mark_mark_id text,
    cutb_block_id text,
    ronb_section_id text,
    modifiedby text,
    modifiedon text,
    modifiedusing bigint,
    createdby bigint,
    createdon bigint,
    createdusing bigint,
    ronb_seq_nbr bigint,
    road_seq_nbr bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_on_block AS SELECT * FROM lrm_replication.v_road_on_block;

CREATE TABLE lrm_replication.v_road_op_area (
    divi_div_nbr bigint,
    tso_code text,
    tso_name text,
    nav_name text,
    field_team_desc text,
    road_road_name text,
    uri text,
    ropa_start_metre_nbr double precision,
    ropa_end_metre_nbr double precision,
    ropa_length bigint,
    ropa_operating_area text,
    ropa_working_circle text,
    modifiedby text,
    modifiedon text,
    modifiedusing text,
    createdby text,
    createdon text,
    createdusing text,
    road_seq_nbr bigint,
    ropa_seq_nbr bigint,
    ropa_seq_nbr_lng bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_op_area AS SELECT * FROM lrm_replication.v_road_op_area;

CREATE TABLE lrm_replication.v_road_organic_mat (
    road_seq_nbr bigint,
    divi_div_nbr bigint,
    road_road_name text,
    uri text,
    romt_start_metre_nbr double precision,
    romt_end_metre_nbr double precision,
    abrm_feature_type text,
    romt_reported_ind text,
    romt_seq_nbr bigint,
    romt_seq_nbr_lng bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_organic_mat AS SELECT * FROM lrm_replication.v_road_organic_mat;

CREATE TABLE lrm_replication.v_road_permit (
    modifiedby bigint,
    modifiedon text,
    modifiedusing text,
    createdby text,
    createdon text,
    createdusing text,
    road_amendment_reason text,
    rdpm_cascade_split_code text,
    rdpm_mgmt_unit_type text,
    rdpm_mgmt_unit_id text,
    rdpm_amendment_type text,
    rdpm_application_desc text,
    rdpm_deemed_owner_ind text,
    rdpm_seq_nbr text,
    tso_code text,
    dsct_district_name text,
    lsee_licensee_id text,
    rdpm_permit_id text,
    rdpm_permit_type text,
    rdpm_expiry_date text,
    rdpm_start_date text,
    rdpm_primary_user text,
    rdpm_secondary_user text,
    rdpm_comments text,
    rdpm_amendment_nbr text,
    rdpm_timber_mark_id text,
    rdpm_parent_perm_id text,
    road_initial_road_length text,
    road_current_road_length text

);

CREATE TABLE bcts_reporting.forestview_v_road_permit AS SELECT * FROM lrm_replication.v_road_permit;

CREATE TABLE lrm_replication.v_road_prov_forest (
    road_seq_nbr bigint,
    divi_div_nbr bigint,
    road_road_name text,
    uri text,
    rprf_start_metre_nbr double precision,
    rprf_end_metre_nbr double precision,
    rprf_length bigint,
    rprf_conflict_code text,
    modifiedby text,
    modifiedon text,
    modifiedusing text,
    createdby text,
    createdon text,
    createdusing text,
    rprf_seq_nbr bigint,
    rprf_seq_nbr_lng bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_prov_forest AS SELECT * FROM lrm_replication.v_road_prov_forest;

CREATE TABLE lrm_replication.v_road_radio (
    modifiedusing bigint,
    createdby text,
    createdon text,
    createdusing text,
    road_seq_nbr text,
    rrad_seq_nbr text,
    rrad_seq_nbr_lng text,
    divi_div_nbr double precision,
    tso_code double precision,
    tso_name text,
    nav_name double precision,
    field_team_desc double precision,
    road_road_name text,
    uri timestamp without time zone,
    rrad_start_metre_nbr text,
    rrad_end_metre_nbr text,
    rrad_channel_name text,
    rrad_transmit_nbr text,
    rrad_receive_nbr bigint,
    modifiedby bigint,
    modifiedon bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_radio AS SELECT * FROM lrm_replication.v_road_radio;

CREATE TABLE lrm_replication.v_road_risk (
    divi_div_nbr bigint,
    tso_code text,
    tso_name text,
    nav_name text,
    field_team_desc text,
    road_road_name text,
    uri text,
    rrra_risk_rating text,
    rris_start_metre_nbr double precision,
    rris_end_metre_nbr double precision,
    rris_insp_freq bigint,
    rris_adjusted_insp_freq double precision,
    rris_memo text,
    rris_data_source text,
    modifiedby text,
    modifiedon timestamp without time zone,
    modifiedusing text,
    createdby text,
    createdon text,
    createdusing text,
    road_seq_nbr bigint,
    rris_seq_nbr bigint,
    rris_seq_nbr_lng bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_risk AS SELECT * FROM lrm_replication.v_road_risk;

CREATE TABLE lrm_replication.v_road_section (
    road_seq_nbr bigint,
    poc double precision,
    pot bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_section AS SELECT * FROM lrm_replication.v_road_section;

CREATE TABLE lrm_replication.v_road_spatial_meta (
    road_seq_nbr double precision,
    divi_div_nbr double precision,
    road_road_name text,
    uri text,
    rspm_start_metre_nbr double precision,
    rspm_end_metre_nbr double precision,
    rspm_length bigint,
    abru_data_source text,
    rspm_source_date timestamp without time zone,
    gmlc_capture_method text,
    rspm_observation_date timestamp without time zone,
    abrh_horizontal_datum text,
    abrz_vertical_datum text,
    abrs_ccsm_code text,
    abro_coordinate_system text,
    rspm_data_accuracy text,
    rspm_horiz_accuracy text,
    rspm_vert_accuracy text,
    rspm_reported_ind text,
    rspm_description text,
    rspm_seq_nbr bigint,
    rspm_seq_nbr_lng bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_spatial_meta AS SELECT * FROM lrm_replication.v_road_spatial_meta;

CREATE TABLE lrm_replication.v_road_status (
    tso_code bigint,
    tso_name text,
    nav_name text,
    field_team_desc text,
    road_road_name text,
    uri text,
    rsta_start_metre_nbr text,
    rsta_end_metre_nbr double precision,
    rsta_length double precision,
    rsta_status_code bigint,
    rsta_status_changed_date text,
    rsta_road_state text,
    modifiedby text,
    modifiedon text,
    modifiedusing timestamp without time zone,
    createdby text,
    createdon text,
    createdusing text,
    road_seq_nbr text,
    rsta_seq_nbr_lng bigint,
    rsta_cprp_protection_ind bigint,
    divi_div_nbr text

);

CREATE TABLE bcts_reporting.forestview_v_road_status AS SELECT * FROM lrm_replication.v_road_status;

CREATE TABLE lrm_replication.v_road_steward (
    divi_div_nbr bigint,
    tso_code text,
    tso_name text,
    nav_name text,
    field_team_desc text,
    road_road_name text,
    uri text,
    rdst_start_metre_nbr double precision,
    rdst_end_metre_nbr double precision,
    rdst_length bigint,
    rdst_steward_name text,
    modifiedby text,
    modifiedon timestamp without time zone,
    modifiedusing text,
    createdby text,
    createdon text,
    createdusing text,
    road_seq_nbr bigint,
    rdst_seq_nbr_lng bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_steward AS SELECT * FROM lrm_replication.v_road_steward;

CREATE TABLE lrm_replication.v_road_structure (
    rstr_seq_nbr_lng bigint,
    division_number text,
    tso_code text,
    tso_name text,
    nav_name text,
    field_team_desc text,
    road_road_name text,
    uri text,
    rstr_object_type timestamp without time zone,
    rstr_planned_date timestamp without time zone,
    rstr_install_date text,
    rstr_replace_date text,
    rstr_deactivate_date text,
    rstr_class_type text,
    rstr_status_code timestamp without time zone,
    rstr_status_date double precision,
    rstr_at_metre_nbr text,
    rstr_location_desc text,
    rstr_object_comments text,
    rstr_file_id text,
    rstr_latitude text,
    rstr_longitude text,
    rstr_lat_long_datatype text,
    rstr_drawings_on_file text,
    rstr_object_subtype text,
    rstr_structure_id text,
    rstr_budgeted_cost text,
    rstr_actual_cost text,
    modifiedby timestamp without time zone,
    modifiedon text,
    modifiedusing text,
    createdby text,
    createdon text,
    createdusing bigint,
    road_seq_nbr bigint,
    rstr_seq_nbr bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_structure AS SELECT * FROM lrm_replication.v_road_structure;

CREATE TABLE lrm_replication.v_road_structure_attr (
    divi_div_nbr bigint,
    road_road_name text,
    uri text,
    rstr_object_type text,
    rstr_at_metre_nbr double precision,
    rstr_start_metre_nbr double precision,
    sdef_attribute_type text,
    satr_data_desc text,
    satr_unit_code text,
    sdef_sort_nbr bigint,
    sdef_option_ind text,
    sdef_abr_code_id text,
    sdef_cost_survey_ind text,
    road_seq_nbr bigint,
    rstr_seq_nbr bigint,
    satr_seq_nbr bigint,
    satr_seq_nbr_lng bigint,
    sdef_seq_nbr bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_structure_attr AS SELECT * FROM lrm_replication.v_road_structure_attr;

CREATE TABLE lrm_replication.v_road_structure_culvert (
    divi_div_nbr bigint,
    tso_code text,
    tso_name text,
    nav_name text,
    field_team_desc text,
    road_road_name text,
    uri text,
    rstr_object_type text,
    rstr_object_subtype text,
    rstr_at_metre_nbr double precision,
    rstr_structure_id text,
    rstr_status_code text,
    rstr_class_type text,
    diam_diameter_width text,
    diam_diameter_unit_code text,
    diam_length_lgth text,
    diam_length_unit_code text,
    diam_flow_rate text,
    diam_seq_nbr text,
    road_seq_nbr bigint,
    rstr_seq_nbr bigint,
    rstr_seq_nbr_lng bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_structure_culvert AS SELECT * FROM lrm_replication.v_road_structure_culvert;

CREATE TABLE lrm_replication.v_road_structure_inspection (
    modifiedusing bigint,
    createdby bigint,
    createdon text,
    createdusing timestamp without time zone,
    insp_seq_nbr_lng timestamp without time zone,
    modifiedon text,
    modifiedby text,
    rstr_seq_nbr text,
    insp_seq_nbr double precision,
    meth_method_type text,
    insp_planned_date bigint,
    insp_inspection_date text,
    insp_inspection_file_id text,
    insp_inspector_type text,
    performed_by text,
    insp_budgeted_cost text,
    insp_actual_cost text,
    variance text,
    responsibility text,
    insp_condition_desc text,
    insp_inspection_memo bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_structure_inspection AS SELECT * FROM lrm_replication.v_road_structure_inspection;

CREATE TABLE lrm_replication.v_road_structure_maintenance (
    createdon bigint,
    createdusing bigint,
    main_seq_nbr_lng text,
    modifiedon timestamp without time zone,
    modifiedusing timestamp without time zone,
    createdby text,
    rstr_seq_nbr double precision,
    main_seq_nbr double precision,
    insp_seq_nbr double precision,
    main_planned_date text,
    main_completed_date text,
    meth_method_type text,
    main_budgeted_cost text,
    main_actual_cost text,
    variance text,
    ctor_name text,
    responsibility text,
    main_priority text,
    main_activity_memo text,
    main_activity_type text,
    main_method_type text,
    modifiedby bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_structure_maintenance AS SELECT * FROM lrm_replication.v_road_structure_maintenance;

CREATE TABLE lrm_replication.v_road_use_permit (
    divi_div_nbr bigint,
    tso_code text,
    tso_name text,
    nav_name text,
    field_team_desc text,
    road_name text,
    road_uri text,
    ruse_start_metre_nbr double precision,
    ruse_end_metre_nbr double precision,
    ruse_length bigint,
    rdpm_start_date text,
    rdpm_expiry_date text,
    rdpm_permit_type text,
    rdpm_permit_id text,
    ruse_permit_id text,
    ruse_primary_name text,
    ruse_secondary_name text,
    ruse_tenure_type text,
    ruse_amendment_nbr text,
    ruse_section_id text,
    ruse_poc text,
    ruse_memo text,
    ruse_gross_ha_area text,
    ruse_right_of_way_width text,
    ruse_cruise_m3_vol double precision,
    ruse_harv_completed_status text,
    modifiedby text,
    modifiedon timestamp without time zone,
    modifiedusing text,
    createdby text,
    createdon text,
    createdusing text,
    road_seq_nbr bigint,
    rdpm_seq_nbr bigint,
    ruse_seq_nbr bigint,
    ruse_seq_nbr_lng bigint

);

CREATE TABLE bcts_reporting.forestview_v_road_use_permit AS SELECT * FROM lrm_replication.v_road_use_permit;

CREATE TABLE lrm_replication.v_sale_forecast_tka_temp (
    field_team text,
    licn_licence_id text,
    cutb_block_id text,
    opar_operating_area_name text,
    blal_merch_ha_area double precision,
    cruise_m3 double precision,
    cruise_m3_per_tree double precision,
    cruise_label text,
    est_m3 double precision,
    est_m3_per_tree double precision,
    est_label text,
    fc_m3 text,
    fc_m3_per_tree text,
    fc_label text,
    ocular_m3 text,
    ocular_m3_per_tree text,
    ocular_label text,
    comp_m3 text,
    comp_m3_per_tree text,
    comp_label text,
    sisy_silvicultural_system_id text,
    num_system double precision,
    status text

);

CREATE TABLE bcts_reporting.forestview_v_sale_forecast_tka_temp AS SELECT * FROM lrm_replication.v_sale_forecast_tka_temp;

CREATE TABLE lrm_replication.v_silvicultural_system (
    cutb_seq_nbr bigint,
    silp_seq_nbr bigint,
    divi_div_nbr bigint,
    sisy_silvicultural_system_id text,
    siva_variant_id text,
    siph_cut_phase_id text,
    srty_reserve_type text,
    spss_area text,
    spss_stand_structure_site_cond text,
    spss_leave_tree_species_comm text,
    spss_composition_goals text,
    spss_residual_basal_area double precision,
    spss_residual_basal_density double precision,
    spss_opening_size_ha_max text,
    spss_opening_size_ha_min text,
    spss_opening_size_ha_avg text

);

CREATE TABLE bcts_reporting.forestview_v_silvicultural_system AS SELECT * FROM lrm_replication.v_silvicultural_system;

CREATE TABLE lrm_replication.v_silviculture_activity (
    hvc_date bigint,
    hvc_fiscal text,
    treatment_unit text,
    block_funding text,
    activity_funding text,
    base text,
    technique text,
    method text,
    activity text,
    status text,
    start_date text,
    start_fiscal text,
    complete_date text,
    complete_fiscal text,
    sila_season text,
    treatment_area double precision,
    sila_gross_area_char double precision,
    cost_per_ha_plan text,
    cost_per_ha timestamp without time zone,
    planned_total_cost bigint,
    actual_total_cost text,
    planned_service_line timestamp without time zone,
    planned_sl_description bigint,
    items_planned_total_cost text,
    actual_service_line text,
    actual_sl_description text,
    items_actual_total_cost text,
    planting_unit text,
    plun_digitised_ind text,
    plun_planned_total_cost text,
    plun_item_planned_total_cost text,
    plun_actual_total_cost timestamp without time zone,
    plun_item_actual_total_cost double precision,
    plun_ha_area timestamp without time zone,
    plun_net_area double precision,
    plun_density text,
    total_trees text,
    sica_key_ind text,
    objective1 text,
    objective2 text,
    objective3 text,
    responsibility text,
    target_species text,
    apply_rate text,
    pmp_nbr text,
    comments text,
    sila_formb_date text,
    sila_formb_printed text,
    project text,
    project_start_date text,
    project_end_date text,
    contract text,
    contractor text,
    contract_start_date text,
    contract_end_date text,
    plun_modifiedby text,
    plun_modifiedon text,
    plun_modifiedusing text,
    modifiedby text,
    modifiedon text,
    primary_record text,
    emsp_seq_nbr text,
    emsc_seq_nbr text,
    plun_seq_nbr text,
    sila_seq_nbr text,
    sica_seq_nbr text,
    cutb_seq_nbr text,
    licn_seq_nbr text,
    divi_div_nbr text,
    tso_code text,
    field_team text,
    manu_id text,
    operating_zone text,
    tenure text,
    licence text,
    permit text,
    mark text,
    block_id text,
    block_nbr text,
    ubi text,
    block_state text,
    cutb_opening text,
    sp_exempt text,
    cruise_volume text,
    nar_area text,
    hvs_status bigint,
    hvs_date bigint,
    hvs_fiscal bigint,
    hvc_status bigint

);

CREATE TABLE bcts_reporting.forestview_v_silviculture_activity AS SELECT * FROM lrm_replication.v_silviculture_activity;

CREATE TABLE lrm_replication.v_silviculture_activity_test1 (
    sica_seq_nbr bigint,
    cutb_seq_nbr text,
    licn_seq_nbr text,
    field_team text,
    manu_id text,
    operating_zone text,
    tenure text,
    licence text,
    permit text,
    mark text,
    block_id text,
    block_nbr text,
    ubi text,
    block_state text,
    cutb_opening text,
    sp_exempt double precision,
    cruise_volume double precision,
    nar_area text,
    hvs_status timestamp without time zone,
    hvs_date bigint,
    hvs_fiscal text,
    hvc_status timestamp without time zone,
    hvc_date bigint,
    hvc_fiscal text,
    treatment_unit text,
    block_funding text,
    activity_funding text,
    base text,
    technique text,
    method text,
    activity text,
    status timestamp without time zone,
    start_date double precision,
    start_fiscal timestamp without time zone,
    complete_date double precision,
    complete_fiscal text,
    sila_season text,
    treatment_area text,
    sila_gross_area_char text,
    cost_per_ha_plan text,
    cost_per_ha text,
    planned_total_cost text,
    actual_total_cost text,
    planned_service_line text,
    planned_sl_description text,
    items_planned_total_cost text,
    actual_service_line text,
    actual_sl_description text,
    items_actual_total_cost text,
    planting_unit text,
    plun_digitised_ind text,
    plun_planned_total_cost text,
    plun_item_planned_total_cost text,
    plun_actual_total_cost text,
    plun_item_actual_total_cost text,
    plun_ha_area text,
    plun_net_area text,
    plun_density text,
    total_trees text,
    sica_key_ind text,
    objective1 text,
    objective2 text,
    objective3 text,
    responsibility text,
    target_species text,
    apply_rate text,
    pmp_nbr text,
    comments text,
    sila_formb_date text,
    sila_formb_printed text,
    project text,
    project_start_date text,
    project_end_date text,
    contract text,
    contractor text,
    contract_start_date text,
    contract_end_date text,
    plun_modifiedby text,
    plun_modifiedon text,
    plun_modifiedusing text,
    modifiedby text,
    modifiedon text,
    primary_record text,
    emsp_seq_nbr text,
    emsc_seq_nbr text,
    plun_seq_nbr bigint,
    sila_seq_nbr bigint,
    divi_div_nbr bigint,
    tso_code bigint

);

CREATE TABLE bcts_reporting.forestview_v_silviculture_activity_test1 AS SELECT * FROM lrm_replication.v_silviculture_activity_test1;

CREATE TABLE lrm_replication.v_silviculture_amendment (
    samm_map_required bigint,
    samm_comment timestamp without time zone,
    samm_amendment_type timestamp without time zone,
    samm_status timestamp without time zone,
    amendment_type_code text,
    amnd_description text,
    responsibility text,
    silp_seq_nbr text,
    samm_amendment_nbr text,
    samm_amendment_date text,
    samm_licensee_appr_date text,
    samm_dist_appr_date bigint

);

CREATE TABLE bcts_reporting.forestview_v_silviculture_amendment AS SELECT * FROM lrm_replication.v_silviculture_amendment;

CREATE TABLE lrm_replication.v_silviculture_overlay_xref (
    siox_seq_nbr bigint,
    siox_ha_area double precision,
    siox_digitised_ind text,
    stun_seq_nbr bigint,
    sila_seq_nbr bigint,
    plun_seq_nbr double precision,
    sish_seq_nbr text,
    cbhm_seq_nbr text,
    siox_comments text

);

CREATE TABLE bcts_reporting.forestview_v_silviculture_overlay_xref AS SELECT * FROM lrm_replication.v_silviculture_overlay_xref;

CREATE TABLE lrm_replication.v_silviculture_prescription (
    silp_sp_report_format text,
    silp_perm_access_max_area text,
    silp_perm_access_max_pct text,
    max_roadside_disturbance text,
    soil_conservation_comments text,
    silp_temp_access_max_rehab text,
    silp_temp_access_comments double precision,
    silp_slope_instability double precision,
    silp_slope_required double precision,
    silp_slope_assessment text,
    forest_health_comments double precision,
    pest_specific_comments text,
    silp_pest_required text,
    silp_pest_assessment text,
    silp_vegetation_management text,
    silp_vegetation_required text,
    silp_livestock_used text,
    silp_riparian_comments text,
    silp_riparian_required text,
    silp_riparian_assessment text,
    silp_gully_manage_strategy text,
    silp_gully_required text,
    silp_gully_assessment text,
    silp_archaeological_sites text,
    silp_archeosite_required text,
    silp_archaeology_assessment text,
    silp_lterm_man_obj text,
    silp_wildlife text,
    silp_lichen_required text,
    silp_lichen_assessment text,
    silp_range text,
    silp_range_tenure_holder text,
    silp_fisheries text,
    silp_coarse_woody_debris text,
    performance_std_pct text,
    block_target_pct text,
    silp_coarse_woody_debris_m3_ha text,
    silp_watersheds text,
    silp_community_watershed_ind text,
    silp_sensitive_areas text,
    silp_recreation text,
    silp_na_conditions text,
    silp_visual_landscape text,
    silp_visual_required text,
    silp_visual_assessment text,
    silp_cultural_heritage text,
    silp_bio_diversity text,
    silp_biodiv_perf_std_start_pct text,
    silp_biodiv_perf_std_end_pct text,
    silp_bio_divers_block_tgt_pct text,
    silp_wildlife_tree_credit_ha text,
    silp_bio_diversity_calc_ind text,
    silp_other_resources text,
    silp_trapper_registration text,
    silp_guide_registration text,
    cutb_seq_nbr text,
    silp_seq_nbr text,
    divi_div_nbr text,
    prescription_prepared_by text,
    additional_sp_comments text,
    rfp_certification_comments bigint,
    silp_admin_assessment_comments bigint,
    amendments_comments bigint

);

CREATE TABLE bcts_reporting.forestview_v_silviculture_prescription AS SELECT * FROM lrm_replication.v_silviculture_prescription;

CREATE TABLE lrm_replication.v_silviculture_stocking_status (
    ssts_crown_closure bigint,
    ssts_reference_year text,
    sicl_site_class text,
    ssts_site_index text,
    ssts_density text,
    ssts_well_spaced_density text,
    ssts_free_growing_density bigint,
    srty_reserve_type bigint,
    ssts_basal_area double precision,
    ssts_cm_top_height double precision,
    ssts_cm_leader double precision,
    ssts_vigour_pct_good text,
    ssts_vigour_pct_medium bigint,
    ssts_vigour_pct_poor double precision,
    ssts_comments double precision,
    ssts_total_coniferous double precision,
    ssts_plantable_spots text,
    ssts_prepable_slash_spots text,
    ssts_prepable_brush_spots text,
    ssts_prepable_duff_spots text,
    ssts_non_productive_spots text,
    ssts_formc_printed_ind text,
    ssts_formc_date text,
    stst_stocking_status_id text,
    ssts_root_collar_diameter text,
    sssc_source_code text,
    ssts_free_grow_density_pref text,
    ssts_well_spaced_density_pref text,
    ssts_free_grow_lcl_density text,
    ssts_well_spaced_lcl_density text,
    ssts_countable_conifers text,
    ssts_reentry_year text,
    ssts_cvr_pattern text,
    ssts_res_objective text,
    ssts_total_well_spaced text,
    species text,
    sist_seq_nbr text,
    slay_layer text,
    srnk_rank text,
    sttp_stocking_type_id text,
    ssts_survey_source text,
    ssts_survey_date text,
    ssts_stock_age text,
    ssts_stock_age_plant double precision,
    ssts_stock_height text

);

CREATE TABLE bcts_reporting.forestview_v_silviculture_stocking_status AS SELECT * FROM lrm_replication.v_silviculture_stocking_status;

CREATE TABLE lrm_replication.v_silviculture_stratum_history (
    divi_div_nbr bigint,
    sish_seq_nbr bigint,
    sila_seq_nbr bigint,
    cutb_seq_nbr bigint,
    sish_stratum_name text,
    sish_digitised_ind text,
    sish_ha_area double precision,
    sish_green_up_date text,
    sish_green_up_ind text,
    sish_free_grow_date timestamp without time zone,
    sish_free_grow_ind text,
    sish_regen_delay_met_date text,
    sish_regen_delay_met_ind text,
    sila_comments text,
    stst_stocking_status_id text,
    sttp_stocking_type_id text,
    sish_mortality_pct text,
    sish_post_harvest_date text,
    sish_post_harvest_ind text,
    sish_plots text,
    sish_establishment_year text,
    sish_crop_stems_per_ha text,
    sish_total_stems_per_ha text,
    sish_site_index text,
    sish_pct_distribution text,
    sish_pct_productive text,
    sish_prefix text,
    sish_class text,
    sica_activity_name text,
    sila_start_date timestamp without time zone,
    sila_completion_date timestamp without time zone,
    sila_status text,
    sila_gross_ha_area double precision,
    stun_id text,
    sipr_project_id text,
    stun_seq_nbr text,
    suha_ha_area text,
    suha_digitised_ind text

);

CREATE TABLE bcts_reporting.forestview_v_silviculture_stratum_history AS SELECT * FROM lrm_replication.v_silviculture_stratum_history;

CREATE TABLE lrm_replication.v_silv_project (
    sipr_seq_nbr bigint,
    ctor_seq_nbr double precision,
    cloc_seq_nbr text,
    pers_seq_nbr text,
    tso_code text,
    tso_name text,
    project_id text,
    contractor text,
    contract_coord text,
    start_date timestamp without time zone,
    start_status text,
    end_date timestamp without time zone,
    end_status text,
    viewing_date timestamp without time zone,
    unit_bid_code text,
    total_bid_price double precision,
    total_overhead_cost double precision,
    total_actual_cost bigint,
    result_type text,
    sipr_contr_res_comment text,
    sipr_general_comment text,
    divi_div_nbr bigint,
    done double precision,
    planned text,
    sipr_project_type text,
    sipr_crew_hire_code text,
    sipr_result_type text

);

CREATE TABLE bcts_reporting.forestview_v_silv_project AS SELECT * FROM lrm_replication.v_silv_project;

CREATE TABLE lrm_replication.v_silv_project_block (
    cutb_seq_nbr bigint,
    sila_seq_nbr bigint,
    sipr_seq_nbr bigint,
    sipr_project_id text,
    divi_div_nbr bigint

);

CREATE TABLE bcts_reporting.forestview_v_silv_project_block AS SELECT * FROM lrm_replication.v_silv_project_block;

CREATE TABLE lrm_replication.v_silv_stockstat_history (
    sish_seq_nbr bigint,
    slay_layer text,
    srnk_rank text,
    stst_stocking_status_id text,
    sttp_stocking_type_id text,
    sssh_survey_source text,
    sssh_survey_date text,
    sssh_stock_age double precision,
    sssh_stock_age_plant double precision,
    sssh_stock_height double precision,
    sssh_crown_closure double precision,
    sssh_reference_year double precision,
    sicl_site_class text,
    sssh_site_index bigint,
    sssh_density double precision,
    sssh_well_spaced_density double precision,
    sssh_free_growing_density double precision,
    srty_reserve_type text,
    sssh_basal_area text,
    sssh_cm_top_height text,
    sssh_cm_leader text,
    sssh_vigour_pct_good text,
    sssh_vigour_pct_medium text,
    sssh_vigour_pct_poor text,
    sssh_comments text,
    sssh_total_coniferous text,
    sssh_plantable_spots text,
    sssh_prepable_slash_spots text,
    sssh_prepable_brush_spots text,
    sssh_prepable_duff_spots text,
    sssh_non_productive_spots text,
    sssh_root_collar_diameter text,
    sssc_source_code text,
    sssh_free_grow_density_pref text,
    sssh_well_spaced_density_pref text,
    sssh_free_grow_lcl_density text,
    sssh_well_spaced_lcl_density text,
    sssh_countable_conifers text,
    sssh_reentry_year text,
    sssh_cvr_pattern text,
    sssh_res_objective text,
    sssh_total_well_spaced double precision,
    sssh_germinant_per_ha text,
    sssh_greened_up_tree_per_ha text

);

CREATE TABLE bcts_reporting.forestview_v_silv_stockstat_history AS SELECT * FROM lrm_replication.v_silv_stockstat_history;

CREATE TABLE lrm_replication.v_species_composition (
    sist_seq_nbr bigint,
    slay_layer text,
    sisp_species_id text,
    spco_percent double precision,
    leading_species_ind text,
    spco_age double precision,
    spco_height double precision,
    spco_stems_per_ha text,
    spco_increment text,
    spco_well_spaced text,
    spco_free_growing text

);

CREATE TABLE bcts_reporting.forestview_v_species_composition AS SELECT * FROM lrm_replication.v_species_composition;

CREATE TABLE lrm_replication.v_species_composition_hist (
    sish_seq_nbr bigint,
    slay_layer text,
    sisp_species_id text,
    spch_percent double precision,
    spch_age text,
    spch_height text,
    spch_stems_per_ha text,
    spch_increment text,
    spch_well_spaced text,
    spch_free_growing text

);

CREATE TABLE bcts_reporting.forestview_v_species_composition_hist AS SELECT * FROM lrm_replication.v_species_composition_hist;

CREATE TABLE lrm_replication.v_stocking_standard (
    stun_seq_nbr bigint,
    layt_layer_code text,
    stsd_post_spacing_min double precision,
    stsd_post_spacing_max double precision,
    stsd_max_coniferous double precision,
    stsd_well_spaced_target double precision,
    stsd_well_spaced_min double precision,
    stsd_well_spaced_pref_min double precision,
    stsd_well_spaced_min_horiz double precision,
    stsd_min_prune_hgt_m text,
    stsd_height_rel_to_comp_pct double precision,
    stsd_height_rel_to_comp_cm text,
    silp_stocking_req_comments text

);

CREATE TABLE bcts_reporting.forestview_v_stocking_standard AS SELECT * FROM lrm_replication.v_stocking_standard;

CREATE TABLE lrm_replication.v_stratum_status (
    cutb_seq_nbr bigint,
    sist_seq_nbr bigint,
    stratum_name text,
    area double precision,
    sica_activity_name text,
    base text,
    technique text,
    method text,
    start_date timestamp without time zone,
    complete_date timestamp without time zone,
    current_status text,
    divi_div_nbr bigint,
    sstatus text,
    sipr_seq_nbr double precision,
    stun_seq_nbr bigint,
    stun_id text,
    stype text,
    sist_green_up_date text,
    sist_green_up_ind text,
    sist_regen_delay_met_date timestamp without time zone,
    sist_regen_delay_met_ind text,
    sist_post_harvest_date timestamp without time zone,
    sist_post_harvest_ind text,
    sist_free_grow_date timestamp without time zone,
    sist_free_grow_ind text

);

CREATE TABLE bcts_reporting.forestview_v_stratum_status AS SELECT * FROM lrm_replication.v_stratum_status;

CREATE TABLE lrm_replication.v_su (
    post_harv_date bigint,
    post_harv_ind bigint,
    regen_date text,
    regen_ind text,
    shsd_submission_date double precision,
    shsd_submission_ind text,
    stun_formc_postharv_prn_date bigint,
    stun_formc_regen_prn_date text,
    stun_formc_freegrow_prn_date bigint,
    suty_type_id bigint,
    stun_description bigint,
    stds_legal_id text,
    su_disturb_area text,
    stun_objective_type text,
    stty_original_standard_type text,
    stun_original_std_declare_date text,
    stun_declaration_area text,
    stun_declaration_area_lock_ind text,
    stun_designation_code text,
    spss_leave_tree_species_comm text,
    stun_soil_compaction text,
    stun_soil_erosion text,
    stun_soil_displacement text,
    stun_type_unfavourable text,
    stun_sediment_risk text,
    stun_depth_unfavourable_max text,
    stun_depth_unfavourable_min text,
    silp_sp_report_format text,
    cutb_seq_nbr text,
    stun_seq_nbr text,
    stun_id text,
    su_regen_obligation text,
    gross_area text,
    ncbr_area text,
    nar_num text,
    nar text,
    npnat_area text,
    npunn_area text,
    divi_div_nbr text,
    stun_max_disturbance text,
    regen_delay text,
    stun_regen_date_early text,
    early_ftg text,
    stun_freegrow_date_early text,
    late_ftg text,
    stun_freegrow_date_late text,
    silv_system_id text,
    siva_variant_id text,
    siph_cut_phase_id text,
    free_grow_date text,
    free_grow_ind text

);

CREATE TABLE bcts_reporting.forestview_v_su AS SELECT * FROM lrm_replication.v_su;

CREATE TABLE lrm_replication.v_su_eco_allocation (
    ecou_seq_nbr bigint,
    stun_seq_nbr bigint,
    suea_ha_area double precision,
    suea_digitised_ind text,
    cutb_seq_nbr bigint

);

CREATE TABLE bcts_reporting.forestview_v_su_eco_allocation AS SELECT * FROM lrm_replication.v_su_eco_allocation;

CREATE TABLE lrm_replication.v_su_layer (
    stun_seq_nbr bigint,
    stun_id text,
    layt_layer_code text,
    stsd_post_spacing_min double precision,
    stsd_post_spacing_max double precision,
    stsd_max_coniferous double precision,
    stsd_residual_area text,
    stsd_well_spaced_target double precision,
    stsd_well_spaced_min double precision,
    stsd_well_spaced_pref_min double precision,
    stsd_well_spaced_min_horiz double precision,
    stsd_height_rel_to_comp_pct double precision,
    stsd_height_rel_to_comp_cm text,
    stsd_min_prune_hgt_m text,
    preferred_species text,
    accepted_species text,
    cutb_seq_nbr bigint

);

CREATE TABLE bcts_reporting.forestview_v_su_layer AS SELECT * FROM lrm_replication.v_su_layer;

CREATE TABLE lrm_replication.v_su_stratum_allocation (
    sist_seq_nbr bigint,
    stun_seq_nbr bigint,
    susa_ha_area double precision,
    susa_digitised_ind text

);

CREATE TABLE bcts_reporting.forestview_v_su_stratum_allocation AS SELECT * FROM lrm_replication.v_su_stratum_allocation;

CREATE TABLE lrm_replication.v_third_party_interest (
    cutb_seq_nbr bigint,
    trdp_seq_nbr bigint,
    paty_party_type_id text,
    trdp_identifier_code text,
    divi_div_nbr bigint

);

CREATE TABLE bcts_reporting.forestview_v_third_party_interest AS SELECT * FROM lrm_replication.v_third_party_interest;

CREATE TABLE lrm_replication.v_timber_inventory_dip (
    ogs_reactivated_fn_proceed_status text,
    ogs_reactivated_fn_proceed text,
    ogs_reactivated_field_verified_status text,
    ogs_reactivated_field_verified text,
    ogs_reactivated_minor_status text,
    ogs_reactivated_minor text,
    ogs_reactivated_road_status text,
    ogs_reactivated_road text,
    ogs_reactivated_re_engineered_status text,
    ogs_reactivated_re_engineered text,
    xxx_zzz_flag text,
    spatial_flag text,
    rc_flag text,
    dr_flag text,
    dvs_flag text,
    dsc_flag text,
    dvc_flag text,
    count_of_blocks text,
    licn_seq_nbr double precision,
    mark_seq_nbr double precision,
    cutb_seq_nbr text,
    objectid text,
    business_area_region_category timestamp without time zone,
    business_area_region bigint,
    business_area text,
    business_area_code timestamp without time zone,
    fieldteam bigint,
    manu_id text,
    licence_id timestamp without time zone,
    tenure_type bigint,
    perm_permit_id text,
    mark_mark_id text,
    block_id text,
    ubi timestamp without time zone,
    block_nbr bigint,
    sub_operating_area bigint,
    licn_licence_state text,
    cutb_block_state text,
    deferred_at_report_date text,
    inventory_category text,
    merch_area timestamp without time zone,
    cruise_volume text,
    rw_volume timestamp without time zone,
    rc_status text,
    rc_date timestamp without time zone,
    rc_fiscal text,
    dr_status text,
    dr_date text,
    dr_fiscal text,
    dvs_status text,
    dvs_date text,
    dvs_fiscal text,
    dsc_status text,
    dsc_date text,
    dvc_status text,
    dvc_date text,
    dvc_fiscal text,
    days_in_dip text,
    woff_status text,
    woff_date text,
    woff_fiscal text,
    auc_status text,
    auc_date text,
    hi_status text,
    hi_date text,
    hvs_status text,
    hvs_date text,
    hvc_status text,
    hvc_date text,
    fg_met_status text,
    fg_date timestamp without time zone,
    def_change_of_op_plan_status text,
    def_change_of_op_plan text,
    def_first_nations_status text,
    def_first_nations text,
    def_loss_of_access_status text,
    def_loss_of_access text,
    def_other_status text,
    def_other timestamp without time zone,
    def_planning_constraint_status text,
    def_planning_constraint text,
    def_returned_to_bcts_status text,
    def_returned_to_bcts text,
    def_stale_dated_fieldwork_status text,
    def_stale_dated_fieldwork text,
    def_stakeholder_issue_status text,
    def_stakeholder_issue text,
    def_environmental_stewardship_initiative_status text,
    def_environmental_stewardship_initiative text,
    def_reactivated_status text,
    def_reactivated bigint,
    old_growth_strategy_status bigint,
    old_growth_strategy bigint,
    ogs_reactivated_forest_health_status bigint,
    ogs_reactivated_forest_health bigint

);

CREATE TABLE bcts_reporting.forestview_v_timber_inventory_dip AS SELECT * FROM lrm_replication.v_timber_inventory_dip;

COMMENT ON TABLE lrm_replication.v_activity_cost IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_apportionment IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_appr_bridge_tab_cost IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_appr_culvert_tab_cost IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_appr_internal_rate IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_appr_ministry_rate IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_appr_road_tab_cost IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_attachment IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_block IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_block_activity_all IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_block_area IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_block_cruise IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_block_cruise_all_coni_deci IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_block_depletion_stage IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_block_harvest_method IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_block_harvest_strategy IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_block_nmar IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_block_old IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_block_spatial IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_block_tasks_issue IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_block_timber IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_coastal_cost_survey_bh IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_coastal_cost_survey_roads IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_commitments IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_commit_tracking_sale_info IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_cost_survey_bridges IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_cp IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_detailed_site_assessment IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_ecology IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_ecology_site_series IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_ems_action_plan IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_ems_action_plan_descr IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_ems_contract IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_ems_inspection IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_ems_inspection_frequency IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_ems_inspection_test_drill IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_ems_issue IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_ems_issue_government IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_ems_issue_investigation IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_ems_plan_vs_complete_insp IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_ems_plan_vs_compl_prework IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_ems_requirement IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_fdu IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_forest_comment IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_frpa_results_strategies IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_gis_actd IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_gis_actd_dates IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_gis_acts IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_gis_acts_status IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_harvested_block_status IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_harvest_history IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_harvest_unit IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_interior_cost_survey_culv IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_interior_cost_survey_roads IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_licence IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_licence_activity_all IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_mark IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_mark_activity IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_non_frpa_results_strategies IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_pest_infestation IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_planting IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_planting_species IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_qb_valuation IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_riparian_zone IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_activity IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_activity_cost IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_activity_cost_row IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_activity_row IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_agri_land_reserve IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_assessment IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_class IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_completion IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_cut_block IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_deactivation IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_event_mapping IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_gap_analysis IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_inspection IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_linear_struct IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_maintenance IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_management_unit IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_mapsheet IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_on_block IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_op_area IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_organic_mat IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_permit IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_prov_forest IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_radio IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_risk IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_section IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_spatial_meta IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_status IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_steward IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_structure IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_structure_attr IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_structure_culvert IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_structure_inspection IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_structure_maintenance IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_road_use_permit IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_sale_forecast_tka_temp IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_silvicultural_system IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_silviculture_activity IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_silviculture_activity_test1 IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_silviculture_amendment IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_silviculture_overlay_xref IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_silviculture_prescription IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_silviculture_stocking_status IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_silviculture_stratum_history IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_silv_project IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_silv_project_block IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_silv_stockstat_history IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_species_composition IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_species_composition_hist IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_stocking_standard IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_stratum_status IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_su IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_su_eco_allocation IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_su_layer IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_su_stratum_allocation IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_third_party_interest IS 'Replication of the view from LRM FORESTVIEW as a table.';
COMMENT ON TABLE lrm_replication.v_timber_inventory_dip IS 'Replication of the view from LRM FORESTVIEW as a table.';

COMMENT ON TABLE bcts_reporting.forestview_v_activity_cost IS 'Replication of the view v_activity_cost from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_apportionment IS 'Replication of the view v_apportionment from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_appr_bridge_tab_cost IS 'Replication of the view v_appr_bridge_tab_cost from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_appr_culvert_tab_cost IS 'Replication of the view v_appr_culvert_tab_cost from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_appr_internal_rate IS 'Replication of the view v_appr_internal_rate from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_appr_ministry_rate IS 'Replication of the view v_appr_ministry_rate from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_appr_road_tab_cost IS 'Replication of the view v_appr_road_tab_cost from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_attachment IS 'Replication of the view v_attachment from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_block IS 'Replication of the view v_block from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_block_activity_all IS 'Replication of the view v_block_activity_all from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_block_area IS 'Replication of the view v_block_area from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_block_cruise IS 'Replication of the view v_block_cruise from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_block_cruise_all_coni_deci IS 'Replication of the view v_block_cruise_all_coni_deci from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_block_depletion_stage IS 'Replication of the view v_block_depletion_stage from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_block_harvest_method IS 'Replication of the view v_block_harvest_method from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_block_harvest_strategy IS 'Replication of the view v_block_harvest_strategy from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_block_nmar IS 'Replication of the view v_block_nmar from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_block_old IS 'Replication of the view v_block_old from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_block_spatial IS 'Replication of the view v_block_spatial from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_block_tasks_issue IS 'Replication of the view v_block_tasks_issue from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_block_timber IS 'Replication of the view v_block_timber from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_coastal_cost_survey_bh IS 'Replication of the view v_coastal_cost_survey_bh from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_coastal_cost_survey_roads IS 'Replication of the view v_coastal_cost_survey_roads from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_commitments IS 'Replication of the view v_commitments from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_commit_tracking_sale_info IS 'Replication of the view v_commit_tracking_sale_info from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_cost_survey_bridges IS 'Replication of the view v_cost_survey_bridges from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_cp IS 'Replication of the view v_cp from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_detailed_site_assessment IS 'Replication of the view v_detailed_site_assessment from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_ecology IS 'Replication of the view v_ecology from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_ecology_site_series IS 'Replication of the view v_ecology_site_series from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_ems_action_plan IS 'Replication of the view v_ems_action_plan from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_ems_action_plan_descr IS 'Replication of the view v_ems_action_plan_descr from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_ems_contract IS 'Replication of the view v_ems_contract from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_ems_inspection IS 'Replication of the view v_ems_inspection from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_ems_inspection_frequency IS 'Replication of the view v_ems_inspection_frequency from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_ems_inspection_test_drill IS 'Replication of the view v_ems_inspection_test_drill from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_ems_issue IS 'Replication of the view v_ems_issue from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_ems_issue_government IS 'Replication of the view v_ems_issue_government from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_ems_issue_investigation IS 'Replication of the view v_ems_issue_investigation from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_ems_plan_vs_complete_insp IS 'Replication of the view v_ems_plan_vs_complete_insp from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_ems_plan_vs_compl_prework IS 'Replication of the view v_ems_plan_vs_compl_prework from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_ems_requirement IS 'Replication of the view v_ems_requirement from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_fdu IS 'Replication of the view v_fdu from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_forest_comment IS 'Replication of the view v_forest_comment from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_frpa_results_strategies IS 'Replication of the view v_frpa_results_strategies from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_gis_actd IS 'Replication of the view v_gis_actd from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_gis_actd_dates IS 'Replication of the view v_gis_actd_dates from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_gis_acts IS 'Replication of the view v_gis_acts from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_gis_acts_status IS 'Replication of the view v_gis_acts_status from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_harvested_block_status IS 'Replication of the view v_harvested_block_status from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_harvest_history IS 'Replication of the view v_harvest_history from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_harvest_unit IS 'Replication of the view v_harvest_unit from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_interior_cost_survey_culv IS 'Replication of the view v_interior_cost_survey_culv from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_interior_cost_survey_roads IS 'Replication of the view v_interior_cost_survey_roads from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_licence IS 'Replication of the view v_licence from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_licence_activity_all IS 'Replication of the view v_licence_activity_all from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_mark IS 'Replication of the view v_mark from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_mark_activity IS 'Replication of the view v_mark_activity from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_non_frpa_results_strategies IS 'Replication of the view v_non_frpa_results_strategies from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_pest_infestation IS 'Replication of the view v_pest_infestation from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_planting IS 'Replication of the view v_planting from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_planting_species IS 'Replication of the view v_planting_species from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_qb_valuation IS 'Replication of the view v_qb_valuation from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_riparian_zone IS 'Replication of the view v_riparian_zone from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road IS 'Replication of the view v_road from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_activity IS 'Replication of the view v_road_activity from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_activity_cost IS 'Replication of the view v_road_activity_cost from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_activity_cost_row IS 'Replication of the view v_road_activity_cost_row from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_activity_row IS 'Replication of the view v_road_activity_row from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_agri_land_reserve IS 'Replication of the view v_road_agri_land_reserve from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_assessment IS 'Replication of the view v_road_assessment from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_class IS 'Replication of the view v_road_class from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_completion IS 'Replication of the view v_road_completion from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_cut_block IS 'Replication of the view v_road_cut_block from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_deactivation IS 'Replication of the view v_road_deactivation from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_event_mapping IS 'Replication of the view v_road_event_mapping from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_gap_analysis IS 'Replication of the view v_road_gap_analysis from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_inspection IS 'Replication of the view v_road_inspection from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_linear_struct IS 'Replication of the view v_road_linear_struct from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_maintenance IS 'Replication of the view v_road_maintenance from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_management_unit IS 'Replication of the view v_road_management_unit from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_mapsheet IS 'Replication of the view v_road_mapsheet from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_on_block IS 'Replication of the view v_road_on_block from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_op_area IS 'Replication of the view v_road_op_area from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_organic_mat IS 'Replication of the view v_road_organic_mat from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_permit IS 'Replication of the view v_road_permit from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_prov_forest IS 'Replication of the view v_road_prov_forest from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_radio IS 'Replication of the view v_road_radio from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_risk IS 'Replication of the view v_road_risk from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_section IS 'Replication of the view v_road_section from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_spatial_meta IS 'Replication of the view v_road_spatial_meta from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_status IS 'Replication of the view v_road_status from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_steward IS 'Replication of the view v_road_steward from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_structure IS 'Replication of the view v_road_structure from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_structure_attr IS 'Replication of the view v_road_structure_attr from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_structure_culvert IS 'Replication of the view v_road_structure_culvert from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_structure_inspection IS 'Replication of the view v_road_structure_inspection from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_structure_maintenance IS 'Replication of the view v_road_structure_maintenance from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_road_use_permit IS 'Replication of the view v_road_use_permit from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_sale_forecast_tka_temp IS 'Replication of the view v_sale_forecast_tka_temp from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_silvicultural_system IS 'Replication of the view v_silvicultural_system from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_silviculture_activity IS 'Replication of the view v_silviculture_activity from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_silviculture_activity_test1 IS 'Replication of the view v_silviculture_activity_test1 from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_silviculture_amendment IS 'Replication of the view v_silviculture_amendment from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_silviculture_overlay_xref IS 'Replication of the view v_silviculture_overlay_xref from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_silviculture_prescription IS 'Replication of the view v_silviculture_prescription from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_silviculture_stocking_status IS 'Replication of the view v_silviculture_stocking_status from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_silviculture_stratum_history IS 'Replication of the view v_silviculture_stratum_history from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_silv_project IS 'Replication of the view v_silv_project from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_silv_project_block IS 'Replication of the view v_silv_project_block from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_silv_stockstat_history IS 'Replication of the view v_silv_stockstat_history from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_species_composition IS 'Replication of the view v_species_composition from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_species_composition_hist IS 'Replication of the view v_species_composition_hist from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_stocking_standard IS 'Replication of the view v_stocking_standard from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_stratum_status IS 'Replication of the view v_stratum_status from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_su IS 'Replication of the view v_su from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_su_eco_allocation IS 'Replication of the view v_su_eco_allocation from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_su_layer IS 'Replication of the view v_su_layer from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_su_stratum_allocation IS 'Replication of the view v_su_stratum_allocation from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_third_party_interest IS 'Replication of the view v_third_party_interest from LRM FORESTVIEW as a table.';
COMMENT ON TABLE bcts_reporting.forestview_v_timber_inventory_dip IS 'Replication of the view v_timber_inventory_dip from LRM FORESTVIEW as a table.';
