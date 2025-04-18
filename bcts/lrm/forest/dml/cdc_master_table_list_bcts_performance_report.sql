DO $$
DECLARE
    tables text[] := ARRAY['OPERATING_AREA','LRM_VT_COMMIT_LIC_TYPE','PERMIT_ALLOCATION','CUT_BLOCK_SILV_REGIME','V_RES_VT_FDTM_TEAM','COMMITMENT_PARTITION','BLOCK_SEED_ZONE','STANDARD_UNIT','APPORTIONMENT','SILV_TREATMENT_REGIME','BCTS_HARVEST_HISTORY','COMMITMENTS','ECOLOGY_UNIT','SUB_OPERATING_AREA','MARK_ALLOCATION','CTOR_CONTRACTOR','LICENCE_ALLOCATION','LICENSEE'];  
    table_name text;
BEGIN
    -- Loop through the list of table names
    FOREACH table_name IN ARRAY tables
    LOOP
        INSERT INTO ods_data_management.cdc_master_table_list 
        VALUES (
            NULL,
            'lrm',
            NULL,               
            'forest',
            table_name,               
            'lrm_replication',
            table_name,
            'Y',
            NULL,
            NULL,
            NULL,
            'Y',
            1,
            'N',
            'N',
            NULL,
            'Oracle'
        );
    END LOOP;
END $$;


-- FOREST VIEWS
DO $$
DECLARE
    tables text[] := ARRAY['V_LRM_CUT_BLOCK','V_LRM_LICENCE', 'V_LRM_COMMITMENTS'];  
    table_name text;
BEGIN
    -- Loop through the list of table names
    FOREACH table_name IN ARRAY tables
    LOOP
        INSERT INTO ods_data_management.cdc_master_table_list 
        VALUES (
            NULL,
            'lrm',
            NULL,               
            'forest',
            table_name,               
            'lrm_replication',
            table_name,
            'Y',
            NULL,
            NULL,
            NULL,
            'Y',
            1,
            'N',
            'N',
            NULL,
            'Oracle'
        );
    END LOOP;
END $$;


-- Tables with custom SQL
INSERT INTO ods_data_management.cdc_master_table_list 
        VALUES (
            NULL,
            'lrm',
            NULL,               
            'forest',
            'CTOR_CONTRACTOR_LOCATION',               
            'lrm_replication',
            'CTOR_CONTRACTOR_LOCATION',
            'Y',
            NULL,
            NULL,
            NULL,
            'Y',
            1,
            'N',
            'Y',
            'SELECT cloc_seq_nbr, 
                ctor_seq_nbr, 
                case when cloc_address_line1 is not null then ''REDACTED'' else cloc_address_line1 end as cloc_address_line1, 
                case when cloc_address_line2 is not null then ''REDACTED'' else cloc_address_line2 end as cloc_address_line2, 
                case when cloc_address_line3 is not null then ''REDACTED'' else cloc_address_line3 end as cloc_address_line3,
                case when cloc_city is not null then ''REDACTED'' else cloc_city end as cloc_city,
                case when cloc_phone_number1 is not null then ''REDACTED'' else cloc_phone_number1 end as cloc_phone_number1,
                case when cloc_phone_number2 is not null then ''REDACTED'' else cloc_phone_number2 end as cloc_phone_number2,
                case when cloc_fax_number is not null then ''REDACTED'' else cloc_fax_number end as cloc_fax_number,
                case when ctry_country_code is not null then ''REDACTED'' else ctry_country_code end as ctry_country_code,
                case when prov_prov_state_code is not null then ''REDACTED'' else prov_prov_state_code end as prov_prov_state_code,
                case when cloc_postal_code is not null then ''REDACTED'' else cloc_postal_code end as cloc_postal_code,
                cloc_client_number, 
                cloc_client_location_code, 
                cloc_client_location_name, 
                cloc_locn_expired_ind, 
                cloc_returned_mail_date, 
                modifiedby, 
                modifiedon, 
                modifiedusing, 
                createdby, 
                createdon, 
                createdusing
            FROM forest.ctor_contractor_location',
            'Oracle'
        );


INSERT INTO ods_data_management.cdc_master_table_list 
        VALUES (
            NULL,
            'lrm',
            NULL,               
            'forest',
            'PERSON',               
            'lrm_replication',
            'PERSON',
            'Y',
            NULL,
            NULL,
            NULL,
            'Y',
            1,
            'N',
            'Y',
            'SELECT pers_seq_nbr, 
                divi_div_nbr, 
                ''REDACTED'' AS pers_first_name, 
                ''REDACTED'' AS pers_last_name, 
                ''REDACTED'' AS pers_display_name, 
                ''REDACTED'' AS pers_person_number, 
                ''REDACTED'' AS pers_phone_number, 
                ''REDACTED'' AS pers_email, 
                ''REDACTED'' AS pers_fax, 
                ctor_seq_nbr, 
                tpct_category_id, 
                tpdp_department_id, 
                ''REDACTED'' AS pers_comment, 
                pers_active_ind, 
                pers_inactive_date, 
                ''REDACTED'' AS pers_professional_number, 
                modifiedby, 
                modifiedon, 
                modifiedusing, 
                createdby, 
                createdon, 
                createdusing
                FROM forest.person',
            'Oracle'
        );


INSERT INTO ods_data_management.cdc_master_table_list 
        VALUES (
            NULL,
            'lrm',
            NULL,               
            'forest',
            'SILVICULTURE_PRESCRIPTION',               
            'lrm_replication',
            'SILVICULTURE_PRESCRIPTION',
            'Y',
            NULL,
            NULL,
            NULL,
            'Y',
            1,
            'N',
            'Y',
            'SELECT silp_seq_nbr, 
                divi_div_nbr, 
                cutb_seq_nbr, 
                silp_lterm_man_obj, 
                silp_wildlife, 
                silp_sensitive_areas, 
                silp_fisheries, 
                silp_watersheds, 
                silp_recreation, 
                silp_community_watershed_ind, 
                silp_bio_diversity, 
                silp_wildlife_tree_credit_ha, 
                silp_visual_landscape, 
                silp_visual_assessment, 
                silp_cultural_heritage, 
                silp_range, 
                silp_range_tenure_holder, 
                silp_other_resources, 
                case when silp_trapper_registration is not null then ''REDACTED'' else silp_trapper_registration end as silp_trapper_registration, 
                case when silp_guide_registration is not null then ''REDACTED'' else silp_guide_registration end as silp_guide_registration,
                silp_na_conditions, 
                silp_riparian_assessment, 
                silp_gully_manage_strategy, 
                silp_gully_assessment, 
                silp_forest_health, 
                silp_pest_assessment, 
                silp_coarse_woody_debris, 
                silp_archaeological_sites, 
                silp_archaeology_assessment, 
                silp_vegetation_management, 
                silp_livestock_used, 
                silp_slope_instability, 
                silp_slope_assessment, 
                silp_perm_access_max_pct, 
                silp_temp_access_max_rehab, 
                silp_temp_access_max_disturb, 
                silp_temp_access_location, 
                silp_temp_access_bank_height, 
                silp_temp_access_avg_bank_hgt, 
                silp_temp_access_equipment, 
                silp_temp_access_ha_area, 
                silp_soil_cons_comments, 
                silp_stocking_req_comments, 
                pers_seq_nbr, 
                silp_sp_report_format, 
                silp_amendments_comments, 
                silp_temp_access_comments, 
                silp_riparian_comments, 
                silp_bio_diversity_calc_ind, 
                silp_rpf_certify_comments, 
                silp_admin_assessment_comments, 
                silp_use_block_num_ind, 
                silp_coarse_woody_debris_m3_ha, 
                silp_bio_diversity_pct, 
                silp_lichen_assessment, 
                silp_roadside_disturb_max_pct, 
                silp_biodiv_perf_std_start_pct, 
                silp_bio_divers_block_tgt_pct, 
                silp_cwd_perf_std_pct, 
                silp_cwd_block_tgt_pct, 
                silp_perm_access_max_area, 
                silp_additional_comments, 
                silp_pest_required, 
                silp_visual_required, 
                silp_vegetation_required, 
                silp_raiparian_required, 
                silp_fhealth_required, 
                silp_gully_required, 
                silp_archeosite_required, 
                silp_slope_required, 
                silp_lichen_required, 
                silp_forest_health_pest, 
                silp_biodiv_perf_std_end_pct, 
                slip_updated_by, 
                slip_updated_date,
                modifiedby, modifiedon,
                modifiedusing, 
                createdby,
                createdon, 
                createdusing, 
                fspm_seq_nbr
                FROM forest.silviculture_prescription',
            'Oracle'
        );



INSERT INTO ods_data_management.cdc_master_table_list 
        VALUES (
            NULL,
            'lrm',
            NULL,               
            'forest',
            'V_LRM_LICENCE_SHAPE',               
            'lrm_replication',
            'V_LRM_LICENCE_SHAPE',
            'Y',
            NULL,
            NULL,
            NULL,
            'Y',
            1,
            'N',
            'Y',
            'SELECT objectid, manu_seq_nbr, licn_seq_nbr, sde_state_id, v_treefield, shape_area, modifiedby, modifiedon, modifiedusing, createdby, createdon, createdusing
	FROM forest.V_LRM_LICENCE_SHAPE',
            'Oracle'
        );



INSERT INTO ods_data_management.cdc_master_table_list 
        VALUES (
            NULL,
            'lrm',
            NULL,               
            'forest',
            'CUT_BLOCK_SHAPE_EVW',               
            'lrm_replication',
            'CUT_BLOCK_SHAPE_EVW',
            'Y',
            NULL,
            NULL,
            NULL,
            'Y',
            1,
            'N',
            'Y',
            'SELECT objectid, transaction_id, cutb_seq_nbr, bufferdist, objectid_1, transactio, objectid_2, hectares, feature_len, feature_area, shape_len, shape_area, licn_seq_nbr, manu_seq_nbr, mark_seq_nbr, perm_seq_nbr, modifiedby, modifiedon, modifiedusing, createdby, createdon, createdusing, sde_state_id
	FROM forest.CUT_BLOCK_SHAPE_EVW',
            'Oracle'
        );








INSERT INTO ods_data_management.cdc_master_table_list 
        VALUES (
            NULL,
            'lrm',
            NULL,               
            'forest',
            'LICENCE_SHAPE_EVW',               
            'lrm_replication',
            'LICENCE_SHAPE_EVW',
            'Y',
            NULL,
            NULL,
            NULL,
            'Y',
            1,
            'N',
            'Y',
            'SELECT objectid, transaction_id, licn_seq_nbr, feature_len, feature_area, shape_len, shape_area, manu_seq_nbr, modifiedby, modifiedon, modifiedusing, createdby, createdon, createdusing, sde_state_id
	FROM forest.licence_shape_evw',
            'Oracle'
        );


