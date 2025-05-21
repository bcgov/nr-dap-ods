def get_timber_inventory_development_in_progress_query(end_date):
    sql_statement = \
    f"""    
    INSERT INTO bcts_staging.timber_inventory_development_in_progress_hist(
    	business_area_region_category, business_area_region, business_area, business_area_code, fieldteam, manu_id, licence_id, tenure_type, perm_permit_id, mark_mark_id, block_id, ubi, block_nbr, sub_operating_area, licn_licence_state, cutb_block_state, deferred_at_report_date, inventory_category, merch_area, cruise_volume, rw_volume, rc_status, rc_date, rc_fiscal, dr_status, dr_date, dr_fiscal, dvs_status, dvs_date, dvs_fiscal, dsc_status, dsc_date, dvc_status, dvc_date, dvc_fiscal, days_in_dip, days_in_dip_category, woff_status, woff_date, woff_fiscal, auc_status, auc_date, hi_status, hi_date, hvs_status, hvs_date, hvc_status, hvc_date, fg_met_status, fg_date, def_change_of_op_plan_status, def_change_of_op_plan, def_first_nations_status, def_first_nations, def_loss_of_access_status, def_loss_of_access, def_other_status, def_other, def_planning_constraint_status, def_planning_constraint, def_returned_to_bcts_status, def_returned_to_bcts, def_stale_dated_fieldwork_status, def_stale_dated_fieldwork, def_stakeholder_issue_status, def_stakeholder_issue, def_environmental_stewardship_initiative_status, def_environmental_stewardship_initiative, def_reactivated_status, def_reactivated, old_growth_strategy_status, old_growth_strategy, ogs_reactivated_forest_health_status, ogs_reactivated_forest_health, ogs_reactivated_fn_proceed_status, ogs_reactivated_fn_proceed, ogs_reactivated_field_verified_status, ogs_reactivated_field_verified, ogs_reactivated_minor_status, ogs_reactivated_minor, ogs_reactivated_road_status, ogs_reactivated_road, ogs_reactivated_re_engineered_status, ogs_reactivated_re_engineered, xxx_zzz_flag, spatial_flag, rc_flag, dr_flag, dvs_flag, dsc_flag, dvc_flag, count_of_blocks, salvage_any_fire_year, salvage_fire_years, salvage_2021_fire, salvage_2022_fire, salvage_2023_fire, salvage_2024_fire, salvage_2025_fire, licn_seq_nbr, mark_seq_nbr, cutb_seq_nbr, ancient, remanant, big_treed, ancient_volume, remnant_volume, big_treed_volume, report_end_date   
    )
    /* Block Activity (ACTB) */
    WITH ACTB AS
        (
        Select cutb_seq_nbr,
            MAX(CASE WHEN ACTT_KEY_IND = 'DEL' THEN ACTI_STATUS_DATE ELSE NULL END)::DATE AS DEL_DATE,
            MAX(CASE WHEN ACTT_KEY_IND = 'DSC' THEN ACTI_STATUS_DATE ELSE NULL END)::DATE AS DSC_DATE,
            MAX(CASE WHEN ACTT_KEY_IND = 'DVC' THEN ACTI_STATUS_DATE ELSE NULL END)::DATE AS DVC_DATE,
            MAX(CASE WHEN ACTT_KEY_IND = 'DVS' THEN ACTI_STATUS_DATE ELSE NULL END)::DATE AS DVS_DATE,
            MAX(CASE WHEN ACTT_KEY_IND = 'FG' THEN ACTI_STATUS_DATE ELSE NULL END)::DATE AS FG_DATE,
            MAX(CASE WHEN ACTT_KEY_IND = 'HVC' THEN ACTI_STATUS_DATE ELSE NULL END)::DATE AS HVC_DATE,
            MAX(CASE WHEN ACTT_KEY_IND = 'HVS' THEN ACTI_STATUS_DATE ELSE NULL END)::DATE AS HVS_DATE,
            MAX(CASE WHEN ACTT_KEY_IND = 'RC' THEN ACTI_STATUS_DATE ELSE NULL END)::DATE AS RC_DATE,
            MAX(CASE WHEN ACTT_KEY_IND = 'DR' THEN ACTI_STATUS_DATE ELSE NULL END)::DATE AS DR_DATE,
            MAX(CASE WHEN ACTT_KEY_IND = 'WO' THEN ACTI_STATUS_DATE ELSE NULL END)::DATE AS WOFF_DATE,
            MAX(CASE WHEN ACTT_KEY_IND = 'DCP' THEN ACTI_STATUS_DATE ELSE NULL END)::DATE AS DEF_Change_of_Op_Plan,
            MAX(CASE WHEN ACTT_KEY_IND = 'DFN' THEN ACTI_STATUS_DATE ELSE NULL END)::DATE AS DEF_First_Nations,
            MAX(CASE WHEN ACTT_KEY_IND = 'DLA' THEN ACTI_STATUS_DATE ELSE NULL END)::DATE AS DEF_Loss_of_Access,
            MAX(CASE WHEN ACTT_KEY_IND = 'DOR' THEN ACTI_STATUS_DATE ELSE NULL END)::DATE AS DEF_Other,
            MAX(CASE WHEN ACTT_KEY_IND = 'DPC' THEN ACTI_STATUS_DATE ELSE NULL END)::DATE AS DEF_Planning_Constraint,
            MAX(CASE WHEN ACTT_KEY_IND = 'DRB' THEN ACTI_STATUS_DATE ELSE NULL END)::DATE AS DEF_Returned_to_BCTS,
            MAX(CASE WHEN ACTT_KEY_IND = 'DSD' THEN ACTI_STATUS_DATE ELSE NULL END)::DATE AS DEF_Stale_dated_Fieldwork,
            MAX(CASE WHEN ACTT_KEY_IND = 'DSI' THEN ACTI_STATUS_DATE ELSE NULL END)::DATE AS DEF_Stakeholder_Issue,
            MAX(CASE WHEN ACTT_KEY_IND = 'DESI' THEN ACTI_STATUS_DATE ELSE NULL END)::DATE AS DEF_Environmental_Stewardship_Initiative,
            MAX(CASE WHEN ACTT_KEY_IND = 'DRD' THEN ACTI_STATUS_DATE ELSE NULL END)::DATE AS DEF_REACTIVATED,
            MAX(CASE WHEN ACTT_KEY_IND = 'DOG' THEN ACTI_STATUS_DATE ELSE NULL END)::DATE AS Old_Growth_Strategy,
            MAX(CASE WHEN ACTT_KEY_IND = 'RFH' THEN ACTI_STATUS_DATE ELSE NULL END)::DATE AS OGS_Reactivated_Forest_Health,
            MAX(CASE WHEN ACTT_KEY_IND = 'RFN' THEN ACTI_STATUS_DATE ELSE NULL END)::DATE AS OGS_Reactivated_FN_Proceed,
            MAX(CASE WHEN ACTT_KEY_IND = 'RFV' THEN ACTI_STATUS_DATE ELSE NULL END)::DATE AS OGS_Reactivated_Field_Verified,
            MAX(CASE WHEN ACTT_KEY_IND = 'RMN' THEN ACTI_STATUS_DATE ELSE NULL END)::DATE AS OGS_Reactivated_Minor,
            MAX(CASE WHEN ACTT_KEY_IND = 'RRD' THEN ACTI_STATUS_DATE ELSE NULL END)::DATE AS OGS_Reactivated_Road,
            MAX(CASE WHEN ACTT_KEY_IND = 'RRE' THEN ACTI_STATUS_DATE ELSE NULL END)::DATE AS OGS_Reactivated_Re_Engineered
        From
            (
                SELECT
                    a.cutb_seq_nbr,
                    atype.actt_key_ind,
                    a.acti_status_date
                FROM
                    LRM_REPLICATION.activity_class ac
                INNER JOIN LRM_REPLICATION.activity_type atype
                ON ac.accl_seq_nbr = atype.accl_seq_nbr
                AND ac.divi_div_nbr = atype.divi_div_nbr
                INNER JOIN LRM_REPLICATION.activity a
                ON atype.actt_seq_nbr =  a.actt_seq_nbr
                AND a.plan_seq_nbr Is Null
                WHERE
                        (
                            atype.actt_key_ind In (
                                'DSC', 'DVC', 'DVS', 'FG', 'HVC', 'HVS', 'RC', 'DR', 'WO'
                            )
                            AND ac.accl_key_ind = 'CMB'
                        ) OR (
                            atype.actt_key_ind IN (
                                'DEL', 	-- Deletion Approval
                                'DCP', 'DFN', 'DLA', 'DOG', 'DOR', 'DPC', 'DRB', 'DSD', 'DSI',
                                'DESI', 'DRD', 'RFH', 'RFN', 'RFV', 'RMN', 'RRD', 'RRE'
                            ) AND ac.accl_key_ind = 'CSB'
                        )
        ) TEMP
        GROUP BY cutb_seq_nbr
        ),

        /* Block Activity Status (ACTB_S) */
    ACTB_S AS
        (
            Select CUTB_SEQ_NBR,
            MAX(CASE WHEN ACTT_KEY_IND = 'DEL' THEN ACTI_STATUS_IND ELSE NULL END) AS DEL_Status,
            MAX(CASE WHEN ACTT_KEY_IND = 'DSC' THEN ACTI_STATUS_IND ELSE NULL END) AS DSC_Status,
            MAX(CASE WHEN ACTT_KEY_IND = 'DVC' THEN ACTI_STATUS_IND ELSE NULL END) AS DVC_Status,
            MAX(CASE WHEN ACTT_KEY_IND = 'DVS' THEN ACTI_STATUS_IND ELSE NULL END) AS DVS_Status,
            MAX(CASE WHEN ACTT_KEY_IND = 'FG' THEN ACTI_STATUS_IND ELSE NULL END) AS FG_Met_Status,
            MAX(CASE WHEN ACTT_KEY_IND = 'HVC' THEN ACTI_STATUS_IND ELSE NULL END) AS HVC_Status,
            MAX(CASE WHEN ACTT_KEY_IND = 'HVS' THEN ACTI_STATUS_IND ELSE NULL END) AS HVS_Status,
            MAX(CASE WHEN ACTT_KEY_IND = 'RC' THEN ACTI_STATUS_IND ELSE NULL END) AS RC_Status,
            MAX(CASE WHEN ACTT_KEY_IND = 'DR' THEN ACTI_STATUS_IND ELSE NULL END) AS DR_Status,
            MAX(CASE WHEN ACTT_KEY_IND = 'WO' THEN ACTI_STATUS_IND ELSE NULL END) AS WOFF_Status,
            MAX(CASE WHEN ACTT_KEY_IND = 'DCP' THEN ACTI_STATUS_IND ELSE NULL END) AS DEF_Change_of_Op_Plan_Status,
            MAX(CASE WHEN ACTT_KEY_IND = 'DFN' THEN ACTI_STATUS_IND ELSE NULL END) AS DEF_First_Nations_Status,
            MAX(CASE WHEN ACTT_KEY_IND = 'DLA' THEN ACTI_STATUS_IND ELSE NULL END) AS DEF_Loss_of_Access_Status,
            MAX(CASE WHEN ACTT_KEY_IND = 'DOR' THEN ACTI_STATUS_IND ELSE NULL END) AS DEF_Other_Status,
            MAX(CASE WHEN ACTT_KEY_IND = 'DPC' THEN ACTI_STATUS_IND ELSE NULL END) AS DEF_Planning_Constraint_Status,
            MAX(CASE WHEN ACTT_KEY_IND = 'DRB' THEN ACTI_STATUS_IND ELSE NULL END) AS DEF_Returned_to_BCTS_Status,
            MAX(CASE WHEN ACTT_KEY_IND = 'DSD' THEN ACTI_STATUS_IND ELSE NULL END) AS DEF_Stale_dated_Fieldwork_Status,
            MAX(CASE WHEN ACTT_KEY_IND = 'DSI' THEN ACTI_STATUS_IND ELSE NULL END) AS DEF_Stakeholder_Issue_Status,
            MAX(CASE WHEN ACTT_KEY_IND = 'DESI' THEN ACTI_STATUS_IND ELSE NULL END) AS DEF_Environmental_Stewardship_Initiative_Status,
            MAX(CASE WHEN ACTT_KEY_IND = 'DRD' THEN ACTI_STATUS_IND ELSE NULL END) AS DEF_REACTIVATED_Status,
            MAX(CASE WHEN ACTT_KEY_IND = 'DOG' THEN ACTI_STATUS_IND ELSE NULL END) AS Old_Growth_Strategy_Status,
            MAX(CASE WHEN ACTT_KEY_IND = 'RFH' THEN ACTI_STATUS_IND ELSE NULL END) AS OGS_Reactivated_Forest_Health_Status,
            MAX(CASE WHEN ACTT_KEY_IND = 'RFN' THEN ACTI_STATUS_IND ELSE NULL END) AS OGS_Reactivated_FN_Proceed_Status,
            MAX(CASE WHEN ACTT_KEY_IND = 'RFV' THEN ACTI_STATUS_IND ELSE NULL END) AS OGS_Reactivated_Field_Verified_Status,
            MAX(CASE WHEN ACTT_KEY_IND = 'RMN' THEN ACTI_STATUS_IND ELSE NULL END) AS OGS_Reactivated_Minor_Status,
            MAX(CASE WHEN ACTT_KEY_IND = 'RRD' THEN ACTI_STATUS_IND ELSE NULL END) AS OGS_Reactivated_Road_Status,
            MAX(CASE WHEN ACTT_KEY_IND = 'RRE' THEN ACTI_STATUS_IND ELSE NULL END) AS OGS_Reactivated_Re_Engineered_Status
        From
            (
                SELECT
                    a.cutb_seq_nbr,
                    atype.actt_key_ind,
                    a.acti_status_ind
                FROM
                    LRM_REPLICATION.activity_class ac
                INNER JOIN LRM_REPLICATION.activity_type atype
                ON ac.accl_seq_nbr = atype.accl_seq_nbr
                AND ac.divi_div_nbr = atype.divi_div_nbr
                
                INNER JOIN LRM_REPLICATION.activity a
                ON atype.actt_seq_nbr =  a.actt_seq_nbr
                AND (
                    (
                        atype.actt_key_ind In ('DSC', 'DVC', 'DVS', 'FG', 'HVC', 'HVS', 'RC', 'DR', 'WO')
                        AND ac.accl_key_ind = 'CMB'
                    ) OR (
                        atype.actt_key_ind IN (
                            'DEL', 	-- Deletion Approval
                            'DCP', 'DFN', 'DLA', 'DOG', 'DOR', 'DPC', 'DRB', 'DSD', 'DSI',
                            'DESI', 'DRD', 'RFH', 'RFN', 'RFV', 'RMN', 'RRD', 'RRE'
                        ) AND ac.accl_key_ind = 'CSB'
                    )
                )
                AND a.plan_seq_nbr Is Null
            ) TEMP
        GROUP BY cutb_seq_nbr
        ),

        /* Latest non-old-growth deferral activity (LDF) */
        LDF AS
        (
            /* Excluding DOG */
            SELECT
                A2.CUTB_SEQ_NBR,
                Max(A2.ACTIVITY_DATE) AS LATEST_DEF
            FROM
                LRM_REPLICATION.V_BLOCK_ACTIVITY_ALL A2
            WHERE
                A2.ACTIVITY_CLASS='CSB'
                AND A2.ACTT_KEY_IND In ('DCP', 'DFN', 'DLA', 'DOR', 'DPC', 'DRB', 'DSD', 'DSI', 'DESI')
                AND A2.ACTI_STATUS_IND='D'
                AND A2.ACTIVITY_DATE <= '{end_date}' -- Date: end of reporting period
            GROUP BY
                A2.CUTB_SEQ_NBR
        ),

        /*
        Latest reactivation activity,
        except for Deferred - Reactivated(non-OGS) (DRD)
        (LRCT)
        */
        LRCT AS
        (
            /* Excluding DRD */
            SELECT DISTINCT
                A4.CUTB_SEQ_NBR,
                MAX(A4.ACTIVITY_DATE) AS LATEST_OGS_REACTIVATED
            FROM
                LRM_REPLICATION.V_BLOCK_ACTIVITY_ALL A4
            WHERE
                A4.ACTIVITY_CLASS='CSB'
                AND A4.ACTT_KEY_IND IN ('RFH', 'RFN', 'RFV', 'RMN', 'RRD', 'RRE')
                AND A4.ACTI_STATUS_IND='D'
                AND A4.ACTIVITY_DATE <= '{end_date}'  -- Date: end of reporting period
            GROUP BY A4.CUTB_SEQ_NBR,
                A4.ACTI_STATUS_IND
        ),

        /*
        Block Activity Flags (ACTB_F)
        For each cutblock sequence number (cutb_seq_nbr),
        indicated 'Y' if the block has each activity associated with it,
        and Null if not.
        */
        ACTB_F AS
        (
        SELECT
            cutb_seq_nbr,
            MAX(CASE WHEN actt_key_ind = 'DSC' THEN 'Y' END) AS has_dsc,
            MAX(CASE WHEN actt_key_ind = 'DVC' THEN 'Y' END) AS has_dvc,
            MAX(CASE WHEN actt_key_ind = 'DVS' THEN 'Y' END) AS has_dvs,
            MAX(CASE WHEN actt_key_ind = 'FG'  THEN 'Y' END) AS has_fg,
            MAX(CASE WHEN actt_key_ind = 'HVC' THEN 'Y' END) AS has_hvc,
            MAX(CASE WHEN actt_key_ind = 'HVS' THEN 'Y' END) AS has_hvs,
            MAX(CASE WHEN actt_key_ind = 'RC'  THEN 'Y' END) AS has_rc,
            MAX(CASE WHEN actt_key_ind = 'DR'  THEN 'Y' END) AS has_dr,
            MAX(CASE WHEN actt_key_ind = 'WO'  THEN 'Y' END) AS has_woff
        FROM (
            SELECT
                a.cutb_seq_nbr,
                a.acti_seq_nbr,
                atype.actt_key_ind
            FROM
                LRM_REPLICATION.activity_class ac
            JOIN LRM_REPLICATION.activity_type atype
                ON ac.accl_seq_nbr = atype.accl_seq_nbr
                AND ac.divi_div_nbr = atype.divi_div_nbr
            JOIN LRM_REPLICATION.activity a
                ON atype.actt_seq_nbr = a.actt_seq_nbr
            WHERE
                atype.actt_key_ind IN ('DSC', 'DVC', 'DVS', 'FG', 'HVC', 'HVS', 'RC', 'DR', 'WO')
                AND a.plan_seq_nbr IS NULL
                AND ac.accl_key_ind = 'CMB'
        ) sub
        GROUP BY cutb_seq_nbr

        ),

        /* Auction status and date for licence (AUC) */
        AUC AS
        (
            SELECT
                A.LICN_SEQ_NBR,
                A.ACTI_STATUS_IND AS AUC_Status,
                A.ACTI_STATUS_DATE AS AUC_DATE

            FROM
                LRM_REPLICATION.activity_class ac,
                LRM_REPLICATION.activity_type atype,
                LRM_REPLICATION.activity A

            WHERE
                ac.accl_seq_nbr = atype.accl_seq_nbr
                AND ac.divi_div_nbr = atype.divi_div_nbr
                AND atype.actt_seq_nbr =  a.actt_seq_nbr
                AND atype.actt_key_ind = 'AUC'
                AND ac.accl_key_ind = 'CML'
        ),

        /* Licence Issued status and date for licence (HI) */
        HI AS
        (
            SELECT
                A.LICN_SEQ_NBR,
                A.ACTI_STATUS_IND AS HI_Status,
                A.ACTI_STATUS_DATE AS HI_DATE
            FROM
                LRM_REPLICATION.activity_class ac,
                LRM_REPLICATION.activity_type atype,
                LRM_REPLICATION.activity A

            WHERE
                ac.accl_seq_nbr = atype.accl_seq_nbr
                AND ac.divi_div_nbr = atype.divi_div_nbr
                AND atype.actt_seq_nbr =  a.actt_seq_nbr
                AND atype.actt_key_ind = 'HI'
                AND ac.accl_key_ind = 'CML'
        ),

        /* Salvage - Any fire year */
        SALVAGE_ANY_FIRE_YEAR AS
        (
            select
                cutb_seq_nbr,
                string_agg(
                DISTINCT substring(
                        activity_type from position('2' in activity_type) for 4
                    ),
                    ', ' -- ORDER BY actt_key_ind
                ) AS salvage_fire_years
                from
                lrm_replication.v_block_activity_all

                where
                activity_class = 'CSB'
                and actt_key_ind like 'SFIRE%'
                group by cutb_seq_nbr
        ),

        /* Salvage - 2021 Fire (calendar year of fire) */
        SALVAGE21 AS
        (
            select distinct  -- Stafff can enter multiple CSB SFIRE21 activity for a block; use DISTINCT to include the SFIRE21 activity only once per block.
                cutb_seq_nbr,
                activity_class,
                actt_key_ind,
                activity_type

            from
                LRM_REPLICATION.v_block_activity_all

            where
                activity_class = 'CSB'
                and actt_key_ind = 'SFIRE21'
        ),


        /* Salvage - 2022 Fire (calendar year of fire) */
        SALVAGE22 AS
        (
            select distinct  -- Stafff can enter multiple CSB SFIRE22 activity for a block; use DISTINCT to include the SFIRE22 activity only once per block.
                cutb_seq_nbr,
                activity_class,
                actt_key_ind,
                activity_type

            from
                LRM_REPLICATION.v_block_activity_all

            where
                activity_class = 'CSB'
                and actt_key_ind = 'SFIRE22'
        ),

        /* Salvage - 2023 Fire (calendar year of fire) */
        SALVAGE23 AS
        (
            select distinct   -- Stafff can enter multiple CSB SFIRE23 activity for a block; use DISTINCT to include the SFIRE23 activity only once per block.
                cutb_seq_nbr,
                activity_class,
                actt_key_ind,
                activity_type

            from
                LRM_REPLICATION.v_block_activity_all

            where
                activity_class = 'CSB'
                and actt_key_ind = 'SFIRE23'
        ),

        /* Salvage - 2024 Fire (calendar year of fire) */
        SALVAGE24 AS
        (
            select distinct   -- Stafff can enter multiple CSB SFIRE23 activity for a block; use DISTINCT to include the SFIRE23 activity only once per block.
                cutb_seq_nbr,
                activity_class,
                actt_key_ind,
                activity_type

            from
                LRM_REPLICATION.v_block_activity_all

            where
                activity_class = 'CSB'
                and actt_key_ind = 'SFIRE24'
        ),

        /* Salvage - 2025 Fire (calendar year of fire) */
        SALVAGE25 AS
        (
            select distinct   -- Staff can enter multiple CSB SFIRE25 activity for a block; use DISTINCT to include the SFIRE23 activity only once per block.
                cutb_seq_nbr,
                activity_class,
                actt_key_ind,
                activity_type

            from
                LRM_REPLICATION.v_block_activity_all

            where
                activity_class = 'CSB'
                and actt_key_ind = 'SFIRE25'
        ),

        
        /*
        Number of Licences Per Block (BlockCount)
        (
        */
        BlockCount AS MATERIALIZED -- Forcing PostgreSQL to not to re-evaluate for each row. Materialization of CTE is not the default after version 12. Query Optimizer decides
        -- On testing it was found that this CTE was being treated as inline query, resulting in slow performance
        (
            SELECT
                BL0.LICN_SEQ_NBR,
                Count(DISTINCT BL0.CUTB_SEQ_NBR) AS Count_Of_Blocks

            FROM
                LRM_REPLICATION.BLOCK_ALLOCATION BL0

            GROUP BY
                BL0.LICN_SEQ_NBR
        ) 


    select distinct
        case
            when
                DIV.DIVI_SHORT_CODE in ('TBA', 'TPL', 'TPG', 'TSK', 'TSN', 'TCC', 'TKA', 'TKO', 'TOC')
            then
                'Interior'
            when
                DIV.DIVI_SHORT_CODE in ('TCH', 'TST', 'TSG')
            then
                'Coast'
            end as BUSINESS_AREA_REGION_CATEGORY,
        case
            when
                DIV.DIVI_SHORT_CODE in ('TBA', 'TPL', 'TPG', 'TSK', 'TSN')
            then
                'North Interior'
            when
                DIV.DIVI_SHORT_CODE in ('TCC', 'TKA', 'TKO', 'TOC')
            then
                'South Interior'
            when
                DIV.DIVI_SHORT_CODE in ('TCH', 'TST', 'TSG')
            then
                'Coast'
            end as BUSINESS_AREA_REGION,
        (CASE 
            WHEN B.TSO_NAME = 'Seaward' THEN 'Seaward-Tlasta' 
            ELSE B.TSO_NAME 
        END) || ' (' || B.TSO_CODE || ')' AS BUSINESS_AREA,
        DIV.DIVI_SHORT_CODE as BUSINESS_AREA_CODE,
        CL.COLU_LOOKUP_DESC AS FieldTeam,
        MANU.MANU_ID,
        LICN.LICN_LICENCE_ID AS LICENCE_ID,
    --	LICN.BLAZ_ADMIN_ZONE_ID,
        TN.TENT_TENURE_ID AS TENURE_TYPE,
        PERM.PERM_PERMIT_ID,
        MARK.MARK_MARK_ID,
        CUTB.CUTB_BLOCK_ID AS BLOCK_ID,
        CUTB.CUTB_SYSTEM_ID AS UBI,
        B.BLOCK_NBR,
        B.SUOP_SUBOP_AREA_NAME as SUB_OPERATING_AREA,
        LICN.LICN_LICENCE_STATE,
        CUTB.CUTB_BLOCK_STATE,
        CASE
            WHEN
                (
                    ACTB.Old_Growth_Strategy > COALESCE(LRCT.LATEST_OGS_REACTIVATED, To_Date('1900-01-01', 'YYYY-MM-DD'))  -- Date: fixed (1900-01-01)
                )
                OR (LDF.LATEST_DEF > COALESCE(ACTB.DEF_REACTIVATED, To_Date('1900-01-01', 'YYYY-MM-DD')))  -- Date: fixed (1900-01-01)
            THEN
                'Y'
            ELSE
                'N'
            END AS DEFERRED_AT_REPORT_DATE,
        CASE
            WHEN
                ACTB.Old_Growth_Strategy > COALESCE(LRCT.LATEST_OGS_REACTIVATED, To_Date('1900-01-01', 'YYYY-MM-DD'))  -- Date: fixed (1900-01-01)
            THEN
                'Deferred-OGS'
            WHEN
                LDF.LATEST_DEF > COALESCE(ACTB.DEF_REACTIVATED, To_Date('1900-01-01', 'YYYY-MM-DD'))  -- Date: fixed (1900-01-01)
            THEN
                'Deferred-Other'
            ELSE
                'No Deferral'
            END AS INVENTORY_CATEGORY,
        BLAL.BLAL_MERCH_HA_AREA AS MERCH_AREA,
        BLAL.BLAL_CRUISE_M3_VOL AS CRUISE_VOLUME,
        BLAL.BLAL_RW_VOL AS RW_VOLUME,
        ACTB_S.RC_Status,
        ACTB.RC_DATE,
        EXTRACT(YEAR FROM ACTB.RC_DATE + INTERVAL '9 months') AS rc_fiscal,
        ACTB_S.dr_status,
        ACTB.dr_date,
        EXTRACT(YEAR FROM ACTB.dr_date + INTERVAL '9 months') AS dr_fiscal,
        ACTB_S.dvs_status,
        ACTB.dvs_date,
        EXTRACT(YEAR FROM ACTB.dvs_date + INTERVAL '9 months') AS dvs_fiscal,
        ACTB_S.dsc_status,
        ACTB.dsc_date,
        ACTB_S.dvc_status,
        ACTB.dvc_date,
        EXTRACT(YEAR FROM ACTB.dvc_date + INTERVAL '9 months') AS dvc_fiscal,

        ROUND(
            (
                LEAST(CURRENT_DATE, DATE '{end_date}') - ACTB.DVS_DATE
            )
        ) AS Days_in_DIP,

        CASE
            WHEN ROUND(LEAST(CURRENT_DATE, DATE '{end_date}') - ACTB.DVS_DATE) < 1 THEN 'Less than One Day'
            WHEN ROUND(LEAST(CURRENT_DATE, DATE '{end_date}') - ACTB.DVS_DATE) < 181 THEN '1 to 180 Days'
            WHEN ROUND(LEAST(CURRENT_DATE, DATE '{end_date}') - ACTB.DVS_DATE) < 366 THEN '181 to 365 Days'
            WHEN ROUND(LEAST(CURRENT_DATE, DATE '{end_date}') - ACTB.DVS_DATE) < 546 THEN '366 to 545 Days'
            WHEN ROUND(LEAST(CURRENT_DATE, DATE '{end_date}') - ACTB.DVS_DATE) < 731 THEN '546 to 730 Days'
            ELSE 'Greater Than Two Years'
        END AS Days_in_DIP_Category,

        ACTB_S.WOFF_Status,
        ACTB.WOFF_DATE,
        EXTRACT(YEAR FROM ACTB.WOFF_DATE + INTERVAL '9 months') AS WOFF_Fiscal,
        AUC.AUC_Status,
        AUC.AUC_DATE,
        HI.HI_Status,
        HI.HI_DATE,
        ACTB_S.HVS_Status,
        ACTB.HVS_DATE,
        ACTB_S.HVC_Status,
        ACTB.HVC_DATE,
        FG_Met_Status, FG_DATE,
        ACTB_S.DEF_Change_of_Op_Plan_Status,
        ACTB.DEF_Change_of_Op_Plan,
        ACTB_S.DEF_First_Nations_Status,
        ACTB.DEF_First_Nations,
        ACTB_S.DEF_Loss_of_Access_Status,
        ACTB.DEF_Loss_of_Access,
        ACTB_S.DEF_Other_Status,
        ACTB.DEF_Other,
        ACTB_S.DEF_Planning_Constraint_Status,
        ACTB.DEF_Planning_Constraint,
        ACTB_S.DEF_Returned_to_BCTS_Status,
        ACTB.DEF_Returned_to_BCTS,
        ACTB_S.DEF_Stale_dated_Fieldwork_Status,
        ACTB.DEF_Stale_dated_Fieldwork,
        ACTB_S.DEF_Stakeholder_Issue_Status,
        ACTB.DEF_Stakeholder_Issue,
        ACTB_S.DEF_Environmental_Stewardship_Initiative_Status,
        ACTB.DEF_Environmental_Stewardship_Initiative,
        ACTB_S.DEF_REACTIVATED_Status,
        ACTB.DEF_REACTIVATED,
        ACTB_S.Old_Growth_Strategy_Status,
        ACTB.Old_Growth_Strategy,
        ACTB_S.OGS_Reactivated_Forest_Health_Status,
        ACTB.OGS_Reactivated_Forest_Health,
        ACTB_S.OGS_Reactivated_FN_Proceed_Status,
        ACTB.OGS_Reactivated_FN_Proceed,
        ACTB_S.OGS_Reactivated_Field_Verified_Status,
        ACTB.OGS_Reactivated_Field_Verified,
        ACTB_S.OGS_Reactivated_Minor_Status,
        ACTB.OGS_Reactivated_Minor,
        ACTB_S.OGS_Reactivated_Road_Status,
        ACTB.OGS_Reactivated_Road,
        ACTB_S.OGS_Reactivated_Re_Engineered_Status,
        ACTB.OGS_Reactivated_Re_Engineered,
        CASE 
            WHEN POSITION('XXX' IN UPPER(CUTB.CUTB_BLOCK_ID)) + POSITION('ZZZ' IN UPPER(CUTB.CUTB_BLOCK_ID)) = 0 
            THEN 'NO' 
            ELSE 'YES' 
        END AS xxx_zzz_flag,

        CASE 
            WHEN BSH.CUTB_SEQ_NBR IS NULL 
            THEN 'NO' 
            ELSE 'YES' 
        END AS spatial_flag,

        CASE 
            WHEN ACTB_F.HAS_RC = 'Y' 
            THEN 'YES' 
            ELSE 'NO' 
        END AS rc_flag,

        CASE 
            WHEN ACTB_F.HAS_DR = 'Y' 
            THEN 'YES' 
            ELSE 'NO' 
        END AS dr_flag,

        CASE 
            WHEN ACTB_F.HAS_DVS = 'Y' 
            THEN 'YES' 
            ELSE 'NO' 
        END AS dvs_flag,

        CASE 
            WHEN ACTB_F.HAS_DSC = 'Y' 
            THEN 'YES' 
            ELSE 'NO' 
        END AS dsc_flag,

        CASE 
            WHEN ACTB_F.HAS_DVC = 'Y' 
            THEN 'YES' 
            ELSE 'NO' 
        END AS dvc_flag,

        BlockCount.Count_Of_Blocks,

        CASE 
            WHEN SALVAGE_ANY_FIRE_YEAR.cutb_seq_nbr IS NULL 
            THEN 'N' 
            ELSE 'Y' 
        END AS salvage_any_fire_year,

        SALVAGE_ANY_FIRE_YEAR.salvage_fire_years,

        CASE 
            WHEN salvage21.actt_key_ind IS NULL 
            THEN NULL 
            ELSE salvage21.activity_type || ' (' || salvage21.activity_class || ' - ' || salvage21.actt_key_ind || ')' 
        END AS salvage_2021_fire,

        CASE 
            WHEN salvage22.actt_key_ind IS NULL 
            THEN NULL 
            ELSE salvage22.activity_type || ' (' || salvage22.activity_class || ' - ' || salvage22.actt_key_ind || ')' 
        END AS salvage_2022_fire,

        CASE 
            WHEN salvage23.actt_key_ind IS NULL 
            THEN NULL 
            ELSE salvage23.activity_type || ' (' || salvage23.activity_class || ' - ' || salvage23.actt_key_ind || ')' 
        END AS salvage_2023_fire,

        CASE 
            WHEN salvage24.actt_key_ind IS NULL 
            THEN NULL 
            ELSE salvage24.activity_type || ' (' || salvage24.activity_class || ' - ' || salvage24.actt_key_ind || ')' 
        END AS salvage_2024_fire,

        CASE 
            WHEN salvage25.actt_key_ind IS NULL 
            THEN NULL 
            ELSE salvage25.activity_type || ' (' || salvage25.activity_class || ' - ' || salvage25.actt_key_ind || ')' 
        END AS salvage_2025_fire,

        BLAL.LICN_SEQ_NBR,
        BLAL.MARK_SEQ_NBR,
        CUTB.CUTB_SEQ_NBR,
        OGC.ancient,
        OGC.remanant,
        OGC.big_treed,
        CASE
            WHEN OGC.ancient = 'Y' THEN BLAL.BLAL_CRUISE_M3_VOL ELSE 0
        END AS ANCIENT_VOLUME,
        CASE
            WHEN OGC.remanant = 'Y' THEN BLAL.BLAL_CRUISE_M3_VOL ELSE 0
        END AS REMNANT_VOLUME,
        CASE
            WHEN OGC.big_treed = 'Y' THEN BLAL.BLAL_CRUISE_M3_VOL ELSE 0
        END AS BIG_TREED_VOLUME,
        '{end_date}' AS report_end_date
        
    FROM
        LRM_REPLICATION.CUT_BLOCK CUTB
        INNER JOIN LRM_REPLICATION.DIVISION DIV
        ON DIV.DIVI_DIV_NBR = CUTB.DIVI_DIV_NBR
        LEFT JOIN LRM_REPLICATION.v_block B
        ON  cutb.cutb_seq_nbr = b.cutb_seq_nbr
        AND div.divi_div_nbr = b.divi_div_nbr
        LEFT JOIN LRM_REPLICATION.BLOCK_ALLOCATION BLAL
        ON CUTB.CUTB_SEQ_NBR = BLAL.CUTB_SEQ_NBR
        LEFT JOIN LRM_REPLICATION.LICENCE LICN
        ON licn.licn_seq_nbr = b.licn_seq_nbr
        AND BLAL.LICN_SEQ_NBR = LICN.LICN_SEQ_NBR
        LEFT JOIN LRM_REPLICATION.MANAGEMENT_UNIT MANU
        ON BLAL.MANU_SEQ_NBR = MANU.MANU_SEQ_NBR
        LEFT JOIN LRM_REPLICATION.DIVISION_CODE_LOOKUP dcl
        ON LICN.LICN_FIELD_TEAM_ID = dcl.COLU_LOOKUP_ID
        AND LICN.DIVI_DIV_NBR = dcl.DIVI_DIV_NBR
        LEFT JOIN LRM_REPLICATION.CODE_LOOKUP cl
        ON dcl.COLU_LOOKUP_TYPE = cl.COLU_LOOKUP_TYPE
        AND dcl.COLU_LOOKUP_ID = cl.COLU_LOOKUP_ID
        LEFT JOIN LRM_REPLICATION.TENURE_TYPE tn
        ON LICN.TENT_SEQ_NBR = tn.TENT_SEQ_NBR
        LEFT JOIN LRM_REPLICATION.CUT_PERMIT PERM
        ON BLAL.PERM_SEQ_NBR = PERM.PERM_SEQ_NBR
        LEFT JOIN LRM_REPLICATION.MARK MARK
        ON BLAL.MARK_SEQ_NBR = MARK.MARK_SEQ_NBR
        LEFT JOIN LRM_REPLICATION.CUT_BLOCK_SHAPE BSH
        ON BLAL.CUTB_SEQ_NBR = BSH.CUTB_SEQ_NBR
        LEFT JOIN ACTB
        ON BLAL.CUTB_SEQ_NBR = ACTB.CUTB_SEQ_NBR
        LEFT JOIN ACTB_S
        ON BLAL.CUTB_SEQ_NBR = ACTB_S.CUTB_SEQ_NBR
        LEFT JOIN LDF
        ON BLAL.CUTB_SEQ_NBR = LDF.CUTB_SEQ_NBR
        LEFT JOIN LRCT
        ON BLAL.CUTB_SEQ_NBR = LRCT.CUTB_SEQ_NBR
        LEFT JOIN ACTB_F
        ON BLAL.CUTB_SEQ_NBR = ACTB_F.CUTB_SEQ_NBR
        LEFT JOIN AUC
        ON BLAL.LICN_SEQ_NBR = AUC.LICN_SEQ_NBR
        LEFT JOIN HI
        ON BLAL.LICN_SEQ_NBR = HI.LICN_SEQ_NBR
        LEFT JOIN SALVAGE_ANY_FIRE_YEAR
        ON b.cutb_seq_nbr = SALVAGE_ANY_FIRE_YEAR.cutb_seq_nbr
        LEFT JOIN salvage21
        ON b.cutb_seq_nbr = salvage21.cutb_seq_nbr
        LEFT JOIN salvage22
        ON b.cutb_seq_nbr = salvage22.cutb_seq_nbr
        LEFT JOIN salvage23
        ON b.cutb_seq_nbr = salvage23.cutb_seq_nbr
        LEFT JOIN salvage24
        ON b.cutb_seq_nbr = salvage24.cutb_seq_nbr
        LEFT JOIN salvage25
        ON b.cutb_seq_nbr = salvage25.cutb_seq_nbr
        LEFT JOIN BlockCount
        ON BLAL.LICN_SEQ_NBR = BlockCount.LICN_SEQ_NBR
        LEFT JOIN bcts_staging.old_growth_tap_deferral_categories OGC
        ON CUTB.CUTB_SYSTEM_ID = OGC.UBI
    WHERE
        COALESCE(TN.TENT_TENURE_ID, ' ') <> 'B07'
        AND (
            ACTB_S.DVS_Status = 'D'
            AND ACTB.DVS_DATE <= To_Date('{end_date}', 'YYYY-MM-DD')  -- Date: end of reporting period
        )
        AND (
            COALESCE(ACTB_S.DEL_Status, ' ') <> 'D'
            OR ACTB.DEL_DATE Is Null
            OR (
                ACTB_S.DEL_Status = 'D'
                AND ACTB.DEL_DATE > To_Date('{end_date}', 'YYYY-MM-DD')  -- Date: end of reporting period
            )
            )
        AND (
            COALESCE(ACTB_S.DVC_Status, ' ') <> 'D'
            OR ACTB.DVC_DATE Is Null
            OR (
                ACTB_S.DVC_Status = 'D'
                AND ACTB.DVC_DATE > To_Date('{end_date}', 'YYYY-MM-DD') -- Date: end of reporting period
            )
        )
        AND (
            COALESCE(ACTB_S.WOFF_Status, ' ') <> 'D'
            OR ACTB.WOFF_DATE Is Null
            OR (
                ACTB_S.WOFF_Status = 'D'
                AND ACTB.WOFF_DATE > To_Date('{end_date}', 'YYYY-MM-DD')  -- Date: end of reporting period
            )
        )
        AND (
            COALESCE(AUC.AUC_Status, ' ') <> 'D'
            OR AUC.AUC_DATE Is Null
            OR (
                AUC.AUC_Status = 'D'
                AND AUC.AUC_DATE > To_Date('{end_date}', 'YYYY-MM-DD')  -- Date: end of reporting period
            )
        )
        AND (
            COALESCE(HI.HI_Status, ' ') <> 'D'
            OR HI.HI_DATE Is Null
            OR (
                HI.HI_Status = 'D'
                AND HI.HI_DATE > To_Date('{end_date}', 'YYYY-MM-DD')  -- Date: end of reporting period
            )
        )

    Order By
        -- length(business_area_region) desc,
        business_area_region,
        business_area,
        fieldteam,
        manu_id,
        licence_id,
        CUTB.CUTB_SYSTEM_ID
    ;
    
    """
    return sql_statement
