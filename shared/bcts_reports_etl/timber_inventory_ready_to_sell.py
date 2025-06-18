def get_timber_inventory_ready_to_sell_query(end_date):
    sql_statement = \
    f"""    
    INSERT INTO bcts_staging.timber_inventory_ready_to_sell_hist(
    business_area_region_category, business_area_region, business_area, business_area_code, field_team, nav_name, operatingarea, location, tenure, licence_id, licence_state, permit_id, block_id, ubi, block_state, dvc_category, dr_category, deferred_at_report_date, inventory_category, deferred_activity, latest_deferral_date,spatial_flag, cruise_vol, rw_vol, rc_date, rc_fiscal, rc_quarter, dr_date, dr_fiscal, dr_quarter, dvs_date, dvc_date, dvc_fiscal, dvc_quarter, auc_date, auc_status, def_change_of_op_plan, def_first_nations, def_loss_of_access, def_other, def_planning_constraint, def_returned_to_bcts, def_stale_dated_fieldwork, def_stakeholder_issue, def_environmental_stewardship_initiative, def_reactivated, old_growth_strategy, ogs_reactivated_forest_health, ogs_reactivated_fn_proceed, ogs_reactivated_field_verified, ogs_reactivated_minor, ogs_reactivated_road, ogs_reactivated_re_engineered, salvage_any_fire_year, salvage_fire_years, salvage_2021_fire, salvage_2022_fire, salvage_2023_fire, salvage_2024_fire, cutb_seq_nbr, ancient, remnant, big_treed, ancient_volume, remnant_volume, big_treed_volume, report_end_date
    )

    WITH A_D AS
    /* Block Activity Date (A_D) */
    (
    SELECT CUTB_SEQ_NBR,
        MAX(CASE WHEN ACTT_KEY_IND = 'DEL' THEN ACTIVITY_DATE ELSE NULL END)::DATE AS Deletion_Approval_Date,
        MAX(CASE WHEN ACTT_KEY_IND = 'DVC' THEN ACTIVITY_DATE ELSE NULL END)::DATE AS DVC_Date,
        MAX(CASE WHEN ACTT_KEY_IND = 'DVS' THEN ACTIVITY_DATE ELSE NULL END)::DATE AS DVS_Date,
        MAX(CASE WHEN ACTT_KEY_IND = 'RC' THEN ACTIVITY_DATE ELSE NULL END)::DATE AS RC_Date,
        MAX(CASE WHEN ACTT_KEY_IND = 'DR' THEN ACTIVITY_DATE ELSE NULL END)::DATE AS DR_Date,
        MAX(CASE WHEN ACTT_KEY_IND = 'WO' THEN ACTIVITY_DATE ELSE NULL END)::DATE AS Write_Off_Date,
        MAX(CASE WHEN ACTT_KEY_IND = 'DCP' THEN ACTIVITY_DATE ELSE NULL END)::DATE AS DEF_Change_of_Op_Plan,
        MAX(CASE WHEN ACTT_KEY_IND = 'DFN' THEN ACTIVITY_DATE ELSE NULL END)::DATE AS DEF_First_Nations,
        MAX(CASE WHEN ACTT_KEY_IND = 'DLA' THEN ACTIVITY_DATE ELSE NULL END)::DATE AS DEF_Loss_of_Access,
        MAX(CASE WHEN ACTT_KEY_IND = 'DOR' THEN ACTIVITY_DATE ELSE NULL END)::DATE AS DEF_Other,
        MAX(CASE WHEN ACTT_KEY_IND = 'DPC' THEN ACTIVITY_DATE ELSE NULL END)::DATE AS DEF_Planning_Constraint,
        MAX(CASE WHEN ACTT_KEY_IND = 'DRB' THEN ACTIVITY_DATE ELSE NULL END)::DATE AS DEF_Returned_to_BCTS,
        MAX(CASE WHEN ACTT_KEY_IND = 'DSD' THEN ACTIVITY_DATE ELSE NULL END)::DATE AS DEF_Stale_dated_Fieldwork,
        MAX(CASE WHEN ACTT_KEY_IND = 'DSI' THEN ACTIVITY_DATE ELSE NULL END)::DATE AS DEF_Stakeholder_Issue,
        MAX(CASE WHEN ACTT_KEY_IND = 'DESI' THEN ACTIVITY_DATE ELSE NULL END)::DATE AS DEF_Environmental_Stewardship_Initiative,
        MAX(CASE WHEN ACTT_KEY_IND = 'DRD' THEN ACTIVITY_DATE ELSE NULL END)::DATE AS DEF_REACTIVATED,
        MAX(CASE WHEN ACTT_KEY_IND = 'DOG' THEN ACTIVITY_DATE ELSE NULL END)::DATE AS Old_Growth_Strategy,
        MAX(CASE WHEN ACTT_KEY_IND = 'RFH' THEN ACTIVITY_DATE ELSE NULL END)::DATE AS OGS_Reactivated_Forest_Health,
        MAX(CASE WHEN ACTT_KEY_IND = 'RFN' THEN ACTIVITY_DATE ELSE NULL END)::DATE AS OGS_Reactivated_FN_Proceed,
        MAX(CASE WHEN ACTT_KEY_IND = 'RFV' THEN ACTIVITY_DATE ELSE NULL END)::DATE AS OGS_Reactivated_Field_Verified,
        MAX(CASE WHEN ACTT_KEY_IND = 'RMN' THEN ACTIVITY_DATE ELSE NULL END)::DATE AS OGS_Reactivated_Minor,
        MAX(CASE WHEN ACTT_KEY_IND = 'RRD' THEN ACTIVITY_DATE ELSE NULL END)::DATE AS OGS_Reactivated_Road,
        MAX(CASE WHEN ACTT_KEY_IND = 'RRE' THEN ACTIVITY_DATE ELSE NULL END)::DATE AS OGS_Reactivated_Re_Engineered

        FROM
            (
                SELECT
                    A0.CUTB_SEQ_NBR,
                    A0.ACTT_KEY_IND,
                    A0.ACTIVITY_DATE
                FROM
                    LRM_REPLICATION.V_BLOCK_ACTIVITY_ALL A0
                WHERE
                    (
                        (
                            A0.ACTIVITY_CLASS = 'CMB'  -- Corporate Mandatory Block (CMB) activity class
                            AND A0.ACTT_KEY_IND In (
                                'DVC',  -- Development Completed
                                'DVS',  -- Development Started
                                'RC',  -- Referral Complete
                                'DR',  -- Development Ready
                                'WO'  -- Write-off
                            )
                        ) OR (
                            A0.ACTIVITY_CLASS = 'CSB'  -- Corporate Standard Block (CSB) activity class
                            AND A0.ACTT_KEY_IND IN (
                                'DEL',  -- Deletion Approval
                                'DCP',  -- Deferred - Change of Op Plan
                                'DFN',  -- Deferred - First Nations
                                'DLA',  -- Deferred - Loss of Access
                                'DOG',  -- Deferred - Old Growth Strategy
                                'DOR',  -- Deferred - Other
                                'DPC',  -- Deferred - Planning Constraint
                                'DRB',  -- Deferred - Returned to BCTS
                                'DSD',  -- Deferred - Stale-dated Fieldwork
                                'DSI',  -- Deferred - Stakeholder Issue
                                'DESI',  -- Deferred - Environmental Stewardship Initiative
                                'DRD',  -- Deferred - Reactivated(non-OGS)
                                'RFH',  -- Deferred - Reactivated(OGS-Forest Health)
                                'RFN',  -- Deferred - Reactivated(OGS-FN Proceed)
                                'RFV',  -- Deferred - Reactivated(OGS-Field Verified)
                                'RMN',  -- Deferred - Reactivated(OGS-Minor)
                                'RRD',  -- Deferred - Reactivated(OGS-Road)
                                'RRE'  -- Deferred - Reactivated(OGS-Re-Engineered)
                            )
                        )
                    ) AND A0.ACTI_STATUS_IND = 'D'  -- Done (D)
                    AND A0.ACTIVITY_DATE <= '{end_date}'  -- Date: end of reporting period
            ) TEMP

            GROUP BY CUTB_SEQ_NBR
    ),

    DF AS
    /* Deferral Block Activity and Date */
    (SELECT DISTINCT ON (cutb_seq_nbr) 
        cutb_seq_nbr,
        activity_date as Latest_Deferral_Date,
        activity_type as DEFERRED_ACTIVITY
    FROM 
        lrm_replication.v_block_activity_all DA1
    WHERE  
        acti_status_ind = 'D' 
        AND activity_class = 'CSB'
        AND DA1.ACTT_KEY_IND In ('DCP', 'DFN', 'DLA', 'DOG', 'DOR', 'DPC', 'DRB', 'DSD', 'DSI', 'DESI') 
        AND DA1.ACTIVITY_DATE <= '{end_date}'  -- Date: end of reporting period
    ORDER BY 
        cutb_seq_nbr, 
        activity_date DESC
    ),

	LDF AS
	/* Latest Non-Old-Growth-Strategy Deferral Block Activity (LDF) */
    (
        SELECT
            A2.CUTB_SEQ_NBR,
            Max(A2.ACTIVITY_DATE) AS LATEST_DEF
        FROM
            LRM_REPLICATION.V_BLOCK_ACTIVITY_ALL A2
        WHERE
            A2.ACTIVITY_CLASS = 'CSB'  -- Corporate Standard Block (CSB) activity class
            AND A2.ACTT_KEY_IND In (
                'DCP',  -- Deferred - Change of Op Plan
                'DFN',  -- Deferred - First Nations
                'DLA',  -- Deferred - Loss of Access
                'DOR',  -- Deferred - Other
                'DPC',  -- Deferred - Planning Constraint
                'DRB',  -- Deferred - Returned to BCTS
                'DSD',  -- Deferred - Stale-dated Fieldwork
                'DSI',  -- Deferred - Stakeholder Issue
                'DESI'  -- Deferred - Environmental Stewardship Initiative
            )
            AND A2.ACTI_STATUS_IND = 'D'  -- Done (D)
            AND A2.ACTIVITY_DATE <= '{end_date}'  -- Date: end of reporting period

        GROUP BY
            A2.CUTB_SEQ_NBR
    ),

    /* Latest Reactivated Block Activity (LRCT) */
	LRCT AS
    (
        SELECT DISTINCT
            A4.CUTB_SEQ_NBR,
            MAX(A4.ACTIVITY_DATE) AS LATEST_OGS_REACTIVATED
        FROM
            LRM_REPLICATION.V_BLOCK_ACTIVITY_ALL A4
        WHERE
            A4.ACTIVITY_CLASS = 'CSB'  -- Corporate Standard Block (CSB) activity class
            AND A4.ACTT_KEY_IND IN (
                'RFH',  -- Deferred - Reactivated(OGS-Forest Health)
                'RFN',  -- Deferred - Reactivated(OGS-FN Proceed)
                'RFV',  -- Deferred - Reactivated(OGS-Field Verified)
                'RMN',  -- Deferred - Reactivated(OGS-Minor)
                'RRD',  -- Deferred - Reactivated(OGS-Road)
                'RRE',  -- Deferred - Reactivated(OGS-Re-Engineered)
                'DRD'  -- Deferred - Reactivated(non-OGS). DRD Added on 2025-03-15. BD
            )
            AND A4.ACTI_STATUS_IND = 'D'  -- Done (D)
            AND A4.ACTIVITY_DATE <= '{end_date}'  -- Date: end of reporting period
        GROUP BY
            A4.CUTB_SEQ_NBR,
            A4.ACTI_STATUS_IND
    ),

    /* Auction Licence Activity (AUC) */
	AUC AS
    (
        SELECT
            LA1.LICN_SEQ_NBR,
            LA1.ACTI_TARGET_DATE,
            LA1.ACTIVITY_DATE,
            LA1.ACTI_STATUS_IND
        FROM
            LRM_REPLICATION.V_LICENCE_ACTIVITY_ALL LA1
        WHERE
            LA1.ACTIVITY_CLASS = 'CML'  -- Corporate Mandatory Licence (CML) activity class
            AND LA1.ACTT_KEY_IND = 'AUC'  -- Auction
    ),

    /* Harvest Licence Issued (HI) */
	HI AS
    (
        SELECT
            LA2.LICN_SEQ_NBR
        FROM
            LRM_REPLICATION.V_LICENCE_ACTIVITY_ALL LA2
        WHERE
            LA2.ACTIVITY_CLASS = 'CML'  -- Corporate Mandatory Licence (CML) activity class
            AND LA2.ACTT_KEY_IND = 'HI'  -- Licence Issued
            AND LA2.ACTIVITY_DATE <= '{end_date}'  -- Date: end of reporting period
            AND LA2.ACTI_STATUS_IND = 'D'  -- Done
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
    )


select distinct
	case
		when
			B.TSO_CODE in ('TBA', 'TPL', 'TPG', 'TSK', 'TSN', 'TCC', 'TKA', 'TKO', 'TOC')
		then
			'Interior'
		when
			B.TSO_CODE in ('TCH', 'TST', 'TSG')
		then
			'Coast'
		end as BUSINESS_AREA_REGION_CATEGORY,
	case
		when
			B.TSO_CODE in ('TBA', 'TPL', 'TPG', 'TSK', 'TSN')
		then
			'North Interior'
		when
			B.TSO_CODE in ('TCC', 'TKA', 'TKO', 'TOC')
		then
			'South Interior'
		when
			B.TSO_CODE in ('TCH', 'TST', 'TSG')
		then
			'Coast'
		end as BUSINESS_AREA_REGION,
	(CASE 
		WHEN B.TSO_NAME = 'Seaward' THEN 'Seaward-Tlasta' 
		ELSE B.TSO_NAME 
	END) || ' (' || B.TSO_CODE || ')' AS BUSINESS_AREA,
    B.TSO_CODE AS BUSINESS_AREA_CODE,
    L.FIELD_TEAM,
    L.NAV_NAME,
    B.OPAR_OPERATING_AREA_NAME AS OperatingArea,
    B.CUTB_LOCATION AS Location,
    L.TENURE,
    L.LICENCE_ID,
    L.LICN_LICENCE_STATE AS Licence_State,
    B.PERMIT_ID,
    B.BLOCK_ID,
    B.UBI,
    B.CUTB_BLOCK_STATE AS Block_State,
	CASE
	    WHEN 
	        EXTRACT(YEAR FROM CURRENT_DATE + INTERVAL '9 months') - 
	        EXTRACT(YEAR FROM A_D.DVC_Date + INTERVAL '9 months') > 5
	    THEN 
	        'Before ' || TO_CHAR(CURRENT_DATE - INTERVAL '63 months', 'YY') || '/' || 
	        TO_CHAR(CURRENT_DATE - INTERVAL '51 months', 'YY')
	    ELSE 
	        TO_CHAR(A_D.DVC_Date - INTERVAL '3 months', 'YY') || '/' || 
	        TO_CHAR(A_D.DVC_Date + INTERVAL '9 months', 'YY')
	END AS DVC_Category,

	CASE
	    WHEN 
	        EXTRACT(YEAR FROM CURRENT_DATE + INTERVAL '9 months') - 
	        EXTRACT(YEAR FROM A_D.DR_Date + INTERVAL '9 months') > 5
	    THEN 
	        'Before ' || TO_CHAR(CURRENT_DATE - INTERVAL '63 months', 'YY') || '/' || 
	        TO_CHAR(CURRENT_DATE - INTERVAL '51 months', 'YY')
	    ELSE 
	        TO_CHAR(A_D.DR_Date - INTERVAL '3 months', 'YY') || '/' || 
	        TO_CHAR(A_D.DR_Date + INTERVAL '9 months', 'YY')
	END AS DR_Category,

    CASE
        WHEN
            (
                (
                    A_D.Old_Growth_Strategy > COALESCE(LRCT.LATEST_OGS_REACTIVATED, To_Date('1900-01-01', 'YYYY-MM-DD'))  -- Date: fixed (1900-01-01)
                ) OR (
                    LDF.LATEST_DEF > COALESCE(A_D.DEF_REACTIVATED, To_Date('1900-01-01', 'YYYY-MM-DD'))  -- Date: fixed (1900-01-01)
                )
            )
        THEN
            'Y'
        ELSE
            'N'
        END AS DEFERRED_AT_REPORT_DATE,
    CASE
        WHEN
            A_D.Old_Growth_Strategy > COALESCE(LRCT.LATEST_OGS_REACTIVATED, To_Date('1900-01-01', 'YYYY-MM-DD'))  -- Date: fixed (1900-01-01)
        THEN
            'Deferred-OGS'
        WHEN
            LDF.LATEST_DEF > COALESCE(A_D.DEF_REACTIVATED, To_Date('1900-01-01', 'YYYY-MM-DD'))  -- Date: fixed (1900-01-01)
        THEN
            'Deferred-Other'
        ELSE
            'Ready to Sell'
        END AS INVENTORY_CATEGORY,
    DF.DEFERRED_ACTIVITY,
    DF.LATEST_DEFERRAL_DATE,
    BS.SPATIAL_FLAG,
    B.CRUISE_VOL,
    B.BLAL_RW_VOL AS RW_VOL,
    A_D.RC_Date,
	EXTRACT(YEAR FROM A_D.RC_Date + INTERVAL '9 months') AS RC_Fiscal,
	'Q' || CEIL(EXTRACT(MONTH FROM A_D.RC_Date - INTERVAL '3 months') / 3.0) AS RC_Quarter,
	A_D.DR_Date,
	EXTRACT(YEAR FROM A_D.DR_Date + INTERVAL '9 months') AS DR_Fiscal,
	'Q' || CEIL(EXTRACT(MONTH FROM A_D.DR_Date - INTERVAL '3 months') / 3.0) AS DR_Quarter,
	A_D.DVS_Date,
	A_D.DVC_Date,
	EXTRACT(YEAR FROM A_D.DVC_Date + INTERVAL '9 months') AS DVC_Fiscal,
	'Q' || CEIL(EXTRACT(MONTH FROM A_D.DVC_Date - INTERVAL '3 months') / 3.0) AS DVC_Quarter,
    AUC.ACTIVITY_DATE AS AUC_Date,
    AUC.ACTI_STATUS_IND AS AUC_Status,
    A_D.DEF_Change_of_Op_Plan,
    A_D.DEF_First_Nations,
    A_D.DEF_Loss_of_Access,
    A_D.DEF_Other,
    A_D.DEF_Planning_Constraint,
    A_D.DEF_Returned_to_BCTS,
    A_D.DEF_Stale_dated_Fieldwork,
    A_D.DEF_Stakeholder_Issue,
    A_D.DEF_Environmental_Stewardship_Initiative,
    A_D.DEF_REACTIVATED,
    A_D.Old_Growth_Strategy,
    A_D.OGS_Reactivated_Forest_Health,
    A_D.OGS_Reactivated_FN_Proceed,
    A_D.OGS_Reactivated_Field_Verified,
    A_D.OGS_Reactivated_Minor,
    A_D.OGS_Reactivated_Road,
    A_D.OGS_Reactivated_Re_Engineered,
    CASE 
	    WHEN SALVAGE_ANY_FIRE_YEAR.cutb_seq_nbr IS NULL THEN 'N' 
	    ELSE 'Y' 
	END AS SALVAGE_ANY_FIRE_YEAR,
    SALVAGE_ANY_FIRE_YEAR.salvage_fire_years,
	CASE 
	    WHEN salvage21.actt_key_ind IS NULL THEN NULL 
	    ELSE salvage21.activity_type || ' (' || salvage21.activity_class || ' - ' || salvage21.actt_key_ind || ')' 
	END AS salvage_2021_fire,
	
	CASE 
	    WHEN salvage22.actt_key_ind IS NULL THEN NULL 
	    ELSE salvage22.activity_type || ' (' || salvage22.activity_class || ' - ' || salvage22.actt_key_ind || ')' 
	END AS salvage_2022_fire,
	
	CASE 
	    WHEN salvage23.actt_key_ind IS NULL THEN NULL 
	    ELSE salvage23.activity_type || ' (' || salvage23.activity_class || ' - ' || salvage23.actt_key_ind || ')' 
	END AS salvage_2023_fire,
	
	CASE 
	    WHEN salvage24.actt_key_ind IS NULL THEN NULL 
	    ELSE salvage24.activity_type || ' (' || salvage24.activity_class || ' - ' || salvage24.actt_key_ind || ')' 
	END AS salvage_2024_fire,
    B.CUTB_SEQ_NBR,
    OGC.ancient,
    OGC.remnant,
    OGC.big_treed,
    CASE
        WHEN OGC.ancient = 'Y' THEN B.CRUISE_VOL ELSE 0
    END AS ANCIENT_VOLUME,
    CASE
        WHEN OGC.remnant = 'Y' THEN B.CRUISE_VOL ELSE 0
    END AS REMNANT_VOLUME,
    CASE
        WHEN OGC.big_treed = 'Y' THEN B.CRUISE_VOL ELSE 0
    END AS BIG_TREED_VOLUME,
    '{end_date}'::date

FROM
    LRM_REPLICATION.V_BLOCK B
	INNER JOIN A_D
	ON B.CUTB_SEQ_NBR = A_D.CUTB_SEQ_NBR
	LEFT JOIN LDF
	ON B.CUTB_SEQ_NBR = LDF.CUTB_SEQ_NBR 
	LEFT JOIN LRCT
	ON B.CUTB_SEQ_NBR = LRCT.CUTB_SEQ_NBR 
    LEFT JOIN DF
	ON B.CUTB_SEQ_NBR = DF.CUTB_SEQ_NBR
	LEFT JOIN LRM_REPLICATION.V_BLOCK_SPATIAL BS
	ON B.CUTB_SEQ_NBR = BS.CUTB_SEQ_NBR 
	LEFT JOIN LRM_REPLICATION.V_LICENCE L
	ON B.LICN_SEQ_NBR = L.LICN_SEQ_NBR 
	LEFT JOIN AUC
	ON L.LICN_SEQ_NBR = AUC.LICN_SEQ_NBR 
	LEFT JOIN HI
	ON L.LICN_SEQ_NBR = HI.LICN_SEQ_NBR 
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
    LEFT JOIN bcts_staging.old_growth_tap_deferral_categories OGC
    ON B.UBI = OGC.UBI
WHERE 1 = 1
    AND COALESCE(L.TENURE,' ') <> 'B07'
    AND A_D.RC_Date Is Not Null
    AND A_D.DR_Date Is Not Null
    AND A_D.DVC_Date Is Not Null
    AND A_D.Deletion_Approval_Date Is Null
    AND A_D.Write_Off_Date Is Null
    AND HI.LICN_SEQ_NBR Is Null

ORDER BY
    -- LEN(BUSINESS_AREA_REGION) desc,
    BUSINESS_AREA_REGION,
    BUSINESS_AREA,
    L.FIELD_TEAM,
    L.NAV_NAME,
    L.LICENCE_ID,
    B.PERMIT_ID,
    B.BLOCK_ID;
    """
    return sql_statement
