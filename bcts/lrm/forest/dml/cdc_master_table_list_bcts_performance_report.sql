DO $$
DECLARE
    tables text[] := ARRAY['OPERATING_AREA','LRM_VT_COMMIT_LIC_TYPE','PERMIT_ALLOCATION','CUT_BLOCK_SILV_REGIME','V_RES_VT_FDTM_TEAM','COMMITMENT_PARTITION','BLOCK_SEED_ZONE','STANDARD_UNIT','APPORTIONMENT','SILV_TREATMENT_REGIME','BCTS_HARVEST_HISTORY','COMMITMENTS','ECOLOGY_UNIT','SUB_OPERATING_AREA','MARK_ALLOCATION','CTOR_CONTRACTOR','LICENCE_ALLOCATION','LICENSEE', 'LICENCE_SHAPE_EVW'];  
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
            'LICENCE_ISSUED_ADVERTISED_LRM',               
            'bcts_staging',
            'LICENCE_ISSUED_ADVERTISED_LRM',
            'Y',
            NULL,
            NULL,
            NULL,
            'Y',
            1,
            'N',
            'Y',
            'select
                licence.business_area_region_category,
                licence.business_area_region,
                licence.business_area,
                licence.licence_id,
                licence.Management_Unit,
                licence.District,
                licence.Category_ID_LRM,
                total_licence_info.LRM_TOTAL_VOLUME,
                total_licence_info.count_all_blocks_in_licence,
                salvage_all_fire_year.LRM_TOTAL_VOLUME_SALVAGE_ALL_FIRE_YEARS,
                salvage_all_fire_year.count_blocks_salvage_any_fire_year,
                salvage21fire.LRM_TOTAL_VOLUME_SALVAGE_2021_FIRE,
                salvage21fire.count_blocks_salvage_21_fire,
                salvage22fire.LRM_TOTAL_VOLUME_SALVAGE_2022_FIRE,
                salvage22fire.count_blocks_salvage_22_fire,
                salvage23fire.LRM_TOTAL_VOLUME_SALVAGE_2023_FIRE,
                salvage23fire.count_blocks_salvage_23_fire,
                salvage24fire.LRM_TOTAL_VOLUME_SALVAGE_2024_FIRE,
                salvage24fire.count_blocks_salvage_24_fire,
                salvage25fire.LRM_TOTAL_VOLUME_SALVAGE_2025_FIRE,
                salvage25fire.count_blocks_salvage_25_fire,
                licence.licn_seq_nbr

            from
                /* Licence Info */
                (
                    select
                        licn_seq_nbr,
                        case
                            when
                                TSO_CODE in (''TBA'', ''TPL'', ''TPG'', ''TSK'', ''TSN'', ''TCC'', ''TKA'', ''TKO'', ''TOC'')
                            then
                                ''Interior''
                            when
                                TSO_CODE in (''TCH'', ''TST'', ''TSG'')
                            then
                                ''Coast''
                            end as BUSINESS_AREA_REGION_CATEGORY,
                        case
                            when
                                TSO_CODE in (''TBA'', ''TPL'', ''TPG'', ''TSK'', ''TSN'')
                            then
                                ''North Interior''
                            when
                                TSO_CODE in (''TCC'', ''TKA'', ''TKO'', ''TOC'')
                            then
                                ''South Interior''
                            when
                                TSO_CODE in (''TCH'', ''TST'', ''TSG'')
                            then
                                ''Coast''
                            end as BUSINESS_AREA_REGION,
                        decode(
                            TSO_NAME,
                            ''Seaward'',
                            ''Seaward-Tlasta'',
                            TSO_NAME
                        ) || '' ('' || TSO_CODE || '')'' AS BUSINESS_AREA,
                        Licence_ID,
                        nav_name as Management_Unit,
                        District_Name as District,
                        Licn_Category_ID as Category_ID_LRM,
                        Category as Category_LRM
                    from
                        forestview.v_licence
                ) licence,

                /* Total Licence Info -- Info about all blocks in licence */
                (
                    select
                        B.LICN_SEQ_NBR,
                        count(*) as count_all_blocks_in_licence,
                        Sum(B.BLAL_RW_VOL) AS LRM_RW_VOLUME,
                        Sum(B.CRUISE_VOL) AS LRM_CRUISE_VOLUME,
                        Sum(Nvl(CRUISE_VOL,0) + Nvl(BLAL_RW_VOL,0)) AS LRM_TOTAL_VOLUME
                    from
                        FORESTVIEW.V_BLOCK B
                    group by
                        b.licn_seq_nbr
                ) total_licence_info,

                /*
                salvage_all_fire_year

                Volume of blocks within licence that have any SFIRE## activities.
                If a block has multiple salvage fire years, the block volume is only
                included once in the total; no double-counting.
                */
                (
                    select
                        B.LICN_SEQ_NBR,
                        count(*) as count_blocks_salvage_any_fire_year,
                        Sum(B.BLAL_RW_VOL) AS LRM_RW_VOLUME_SALVAGE_ALL_FIRE_YEARS,
                        Sum(B.CRUISE_VOL) AS LRM_CRUISE_VOLUME_SALVAGE_ALL_FIRE_YEARS,
                        Sum(Nvl(CRUISE_VOL,0) + Nvl(BLAL_RW_VOL,0)) AS LRM_TOTAL_VOLUME_SALVAGE_ALL_FIRE_YEARS
                    from
                        FORESTVIEW.V_BLOCK B,
                        (
                            /*
                            This distinct clause ensures each block is only counted once
                            if it has any SFIRE activities.
                            */
                            select distinct
                                cutb_seq_nbr

                            from
                                forestview.v_block_activity_all

                            where
                                activity_class = ''CSB''
                                and actt_key_ind like ''SFIRE%''
                        ) block_with_any_sfire_year
                    where
                        b.cutb_seq_nbr = block_with_any_sfire_year.cutb_seq_nbr
                    group by
                        B.TSO_CODE,
                        B.TSO_NAME,
                        licn_seq_nbr
                ) salvage_all_fire_year,

                /*
                salvage21fire

                Volume within licence that is salvage from a 2021 fire.
                Only blocks with SFIRE21 activity are included.

                */
                (
                    SELECT
                        B.LICN_SEQ_NBR,
                        count(*) as count_blocks_salvage_21_fire,
                        Sum(B.BLAL_RW_VOL) AS LRM_RW_VOLUME_SALVAGE_2021_FIRE,
                        Sum(B.CRUISE_VOL) AS LRM_CRUISE_VOLUME_SALVAGE_2021_FIRE,
                        Sum(Nvl(CRUISE_VOL,0) + Nvl(BLAL_RW_VOL,0)) AS LRM_TOTAL_VOLUME_SALVAGE_2021_FIRE
                    FROM
                        FORESTVIEW.V_BLOCK B,
                        (
                            /*
                            The SFIRE21 activity can be entered multiple times for the same
                            block. The SFIRE21 activity is meant to be present for
                            blocks that are salvage from 2021 fires, and absent for those
                            that are not. Multiple entries of the activity on one block are
                            meaningless. For the purposes of this query, we assume that
                            multiple entries are intended to indicate the block is salvage.
                            This DISTINCT query ensures we only count the block volume once
                            for each SFIRE21 activity on the block.
                            */
                            select distinct
                                cutb_seq_nbr
                            from
                                forestview.v_block_activity_all
                            where
                                activity_class = ''CSB''
                                and actt_key_ind = ''SFIRE21''
                        ) block_with_sfire21
                    where
                        b.cutb_seq_nbr = block_with_sfire21.cutb_seq_nbr
                    GROUP BY
                        B.LICN_SEQ_NBR
                ) salvage21fire,

                /*
                salvage22fire

                Volume within licence that is salvage from a 2022 fire.
                Only blocks with SFIRE22 activity are included.

                */
                (
                    SELECT
                        B.LICN_SEQ_NBR,
                        count(*) as count_blocks_salvage_22_fire,
                        Sum(B.BLAL_RW_VOL) AS LRM_RW_VOLUME_SALVAGE_2022_FIRE,
                        Sum(B.CRUISE_VOL) AS LRM_CRUISE_VOLUME_SALVAGE_2022_FIRE,
                        Sum(Nvl(CRUISE_VOL,0) + Nvl(BLAL_RW_VOL,0)) AS LRM_TOTAL_VOLUME_SALVAGE_2022_FIRE
                    FROM
                        FORESTVIEW.V_BLOCK B,
                        (
                            /*
                            The SFIRE22 activity can be entered multiple times for the same
                            block. The SFIRE22 activity is meant to be present for
                            blocks that are salvage from 2022 fires, and absent for those
                            that are not. Multiple entries of the activity on one block are
                            meaningless. For the purposes of this query, we assume that
                            multiple entries are intended to indicate the block is salvage.
                            This DISTINCT query ensures we only count the block volume once
                            for each SFIRE22 activity on the block.
                            */
                            select distinct
                                cutb_seq_nbr
                            from
                                forestview.v_block_activity_all
                            where
                                activity_class = ''CSB''
                                and actt_key_ind = ''SFIRE22''
                        ) block_with_sfire22
                    where
                        b.cutb_seq_nbr = block_with_sfire22.cutb_seq_nbr
                    GROUP BY
                        B.LICN_SEQ_NBR
                ) salvage22fire,

                /*
                salvage23fire

                Volume within licence that is salvage from a 2023 fire.
                Only blocks with SFIRE23 activity are included.
                */
                (
                    SELECT
                        B.LICN_SEQ_NBR,
                        count(*) as count_blocks_salvage_23_fire,
                        Sum(B.BLAL_RW_VOL) AS LRM_RW_VOLUME_SALVAGE_2023_FIRE,
                        Sum(B.CRUISE_VOL) AS LRM_CRUISE_VOLUME_SALVAGE_2023_FIRE,
                        Sum(Nvl(CRUISE_VOL,0) + Nvl(BLAL_RW_VOL,0)) AS LRM_TOTAL_VOLUME_SALVAGE_2023_FIRE
                    FROM
                        FORESTVIEW.V_BLOCK B,
                        (
                            /*
                            The SFIRE23 activity can be entered multiple times for the same
                            block. The SFIRE23 activity is meant to be present for
                            blocks that are salvage from 2023 fires, and absent for those
                            that are not. Multiple entries of the activity on one block are
                            meaningless. For the purposes of this query, we assume that
                            multiple entries are intended to indicate the block is salvage.
                            This DISTINCT query ensures we only count the block volume once
                            for each SFIRE23 activity on the block.
                            */
                            select distinct
                                cutb_seq_nbr
                            from
                                forestview.v_block_activity_all
                            where
                                activity_class = ''CSB''
                                and actt_key_ind = ''SFIRE23''
                        ) block_with_sfire23
                    where
                        b.cutb_seq_nbr = block_with_sfire23.cutb_seq_nbr
                    GROUP BY
                        B.LICN_SEQ_NBR
                ) salvage23fire,

                /*
                salvage24fire

                Volume within licence that is salvage from a 2024 fire.
                Only blocks with SFIRE24 activity are included.

                As at 2024-02-13, this activity code has not been deployed;
                it is scripted here in anticipation of future deployment.
                */
                (
                    SELECT
                        B.LICN_SEQ_NBR,
                        count(*) as count_blocks_salvage_24_fire,
                        Sum(B.BLAL_RW_VOL) AS LRM_RW_VOLUME_SALVAGE_2024_FIRE,
                        Sum(B.CRUISE_VOL) AS LRM_CRUISE_VOLUME_SALVAGE_2024_FIRE,
                        Sum(Nvl(CRUISE_VOL,0) + Nvl(BLAL_RW_VOL,0)) AS LRM_TOTAL_VOLUME_SALVAGE_2024_FIRE
                    FROM
                        FORESTVIEW.V_BLOCK B,
                        (
                            /*
                            The SFIRE24 activity can be entered multiple times for the same
                            block. The SFIRE24 activity is meant to be present for
                            blocks that are salvage from 2024 fires, and absent for those
                            that are not. Multiple entries of the activity on one block are
                            meaningless. For the purposes of this query, we assume that
                            multiple entries are intended to indicate the block is salvage.
                            This DISTINCT query ensures we only count the block volume once
                            for each SFIRE24 activity on the block.
                            */
                            select distinct
                                cutb_seq_nbr
                            from
                                forestview.v_block_activity_all
                            where
                                activity_class = ''CSB''
                                and actt_key_ind = ''SFIRE24''
                        ) block_with_sfire24
                    where
                        b.cutb_seq_nbr = block_with_sfire24.cutb_seq_nbr
                    GROUP BY
                        B.LICN_SEQ_NBR
                ) salvage24fire,

                /*
                salvage25fire

                Volume within licence that is salvage from a 2025 fire.
                Only blocks with SFIRE25 activity are included.

                As at 2024-02-13, this activity code has not been deployed;
                it is scripted here in anticipation of future deployment.
                */
                (
                    SELECT
                        B.LICN_SEQ_NBR,
                        count(*) as count_blocks_salvage_25_fire,
                        Sum(B.BLAL_RW_VOL) AS LRM_RW_VOLUME_SALVAGE_2025_FIRE,
                        Sum(B.CRUISE_VOL) AS LRM_CRUISE_VOLUME_SALVAGE_2025_FIRE,
                        Sum(Nvl(CRUISE_VOL,0) + Nvl(BLAL_RW_VOL,0)) AS LRM_TOTAL_VOLUME_SALVAGE_2025_FIRE
                    FROM
                        FORESTVIEW.V_BLOCK B,
                        (
                            /*
                            The SFIRE25 activity can be entered multiple times for the same
                            block. The SFIRE25 activity is meant to be present for
                            blocks that are salvage from 2025 fires, and absent for those
                            that are not. Multiple entries of the activity on one block are
                            meaningless. For the purposes of this query, we assume that
                            multiple entries are intended to indicate the block is salvage.
                            This DISTINCT query ensures we only count the block volume once
                            for each SFIRE25 activity on the block.
                            */
                            select distinct
                                cutb_seq_nbr
                            from
                                forestview.v_block_activity_all
                            where
                                activity_class = ''CSB''
                                and actt_key_ind = ''SFIRE25''
                        ) block_with_sfire25
                    where
                        b.cutb_seq_nbr = block_with_sfire25.cutb_seq_nbr
                    GROUP BY
                        B.LICN_SEQ_NBR
                ) salvage25fire

            where
                licence.licn_seq_nbr = total_licence_info.licn_seq_nbr (+)
                and licence.licn_seq_nbr = salvage_all_fire_year.licn_seq_nbr (+)
                and licence.licn_seq_nbr = salvage21fire.licn_seq_nbr (+)
                and licence.licn_seq_nbr = salvage22fire.licn_seq_nbr (+)
                and licence.licn_seq_nbr = salvage23fire.licn_seq_nbr (+)
                and licence.licn_seq_nbr = salvage24fire.licn_seq_nbr (+)
                and licence.licn_seq_nbr = salvage25fire.licn_seq_nbr (+)

            order by
                business_area_region_category desc,
                business_area_region,
                business_area,
                licence_id',
            'Oracle'
        );



