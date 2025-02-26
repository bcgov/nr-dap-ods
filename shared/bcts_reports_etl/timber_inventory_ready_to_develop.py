# -- Report Name: !Timber Inventory - Ready to Develop
# /* Report Query Name: qReadyToDevelop
# Specification:
# A monthly report of blocks that are DR 'Done', but are not development started or written off.
# - DR completion date is up to the reporting 'To' date.
# - DVS is NOT 'Done'.
# - DVC is NOT 'Done'.
# - Write Off is NOT 'Done'.
# - Deletion Approval is NOT 'Done'.
# - HI, HC, HX, and HS are NOT 'Done'.
# * INVENTORY_CATEGORY:
#      - OGS: Old Growth Strategy (OGS) Date is after any OGS related reactivation date.
#      - Deferred: The latest deferral (excuding OGS) date is after Reactivated (DRD) Date.
#      - No Deferral: Not OGS and Not Deferred.
#      o When both (OGS) and conventional deferrals exist for the same block, it is set to OGS.
# # Key Fields: DR Status, DR Completion Date, Development Started (DVS) Status, Development Completed (DVC) Status.
# Change Log:
# Implemented RC DR split. 2023-05-23, NJ.
# Added Environmental Stewardship Initiative deferral category. 2023-04-17, NJ.
# Split RCDR into RC and DR per Janie Ramsey's request. 2022-08-08, RX.
# Renamed to !TimberInventory_ReadytoDevelop from RCDR_Inventory per Ron Letham's request. 2022-06-08, RX.
# Added Deferrals per Ron Letham and Janie Ramsey's request. Removed planned dates as they are disabled in LRM for over a year now. 2022-05-11, RX.
# Added RCDR_Category per DSWG request. 2022-03-04, RX.
# Added Deletion Approval (DEL) filter to remove Deletion Approval 'Done' blocks per Ron Lathem's request. 2021-08-25, RX.
# *

def get_timber_inventory_ready_to_develop_query(end_date):
    sql_statement = \
    f"""    
    INSERT INTO bcts_staging.timber_inventory_ready_to_develop_hist(
    	business_area_region_category, business_area_region, business_area, business_area_code, field_team, nav_name, operatingarea, location, tenure, licence_id, licence_state, permit_id, block_id, ubi, block_state, deferred, inventory_category, cruise_vol, rw_vol, rc_status, rc_date, dr_status, dr_date, dr_fiscal, dr_quarter, dr_category, dvs_status, dvs_date, dvc_status, dvc_date, dvs_fiscal, dvs_quarter, def_change_of_op_plan_status, def_change_of_op_plan, def_first_nations_status, def_first_nations, def_loss_of_access_status, def_loss_of_access, def_other_status, def_other, def_planning_constraint_status, def_planning_constraint, def_returned_to_bcts_status, def_returned_to_bcts, def_stale_dated_fieldwork_status, def_stale_dated_fieldwork, def_stakeholder_issue_status, def_stakeholder_issue, def_environmental_stewardship_initiative_status, def_environmental_stewardship_initiative, def_reactivated_status, def_reactivated, old_growth_strategy_status, old_growth_strategy, ogs_reactivated_forest_health_status, ogs_reactivated_forest_health, ogs_reactivated_fn_proceed_status, ogs_reactivated_fn_proceed, ogs_reactivated_field_verified_status, ogs_reactivated_field_verified, ogs_reactivated_minor_status, ogs_reactivated_minor, ogs_reactivated_road_status, ogs_reactivated_road, ogs_reactivated_re_engineered_status, ogs_reactivated_re_engineered, spatial_flag, cutb_seq_nbr, report_end_date
    )

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
                BCTS_STAGING.FOREST_activity_class ac
            INNER JOIN BCTS_STAGING.FOREST_activity_type atype
            ON ac.accl_seq_nbr = atype.accl_seq_nbr
            AND ac.divi_div_nbr = atype.divi_div_nbr
            INNER JOIN BCTS_STAGING.FOREST_activity a
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
                BCTS_STAGING.FOREST_activity_class ac
            INNER JOIN BCTS_STAGING.FOREST_activity_type atype
            ON ac.accl_seq_nbr = atype.accl_seq_nbr
            AND ac.divi_div_nbr = atype.divi_div_nbr
            
            INNER JOIN BCTS_STAGING.FOREST_activity a
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
	LDF AS
	(
        /* Excluding DOG */
        SELECT
            A2.CUTB_SEQ_NBR,
            Max(A2.ACTIVITY_DATE) AS LATEST_DEF
        FROM
            BCTS_STAGING.FORESTVIEW_V_BLOCK_ACTIVITY_ALL A2
        WHERE
            A2.ACTIVITY_CLASS='CSB'
            AND A2.ACTT_KEY_IND In ('DCP', 'DFN', 'DLA', 'DOR', 'DPC', 'DRB', 'DSD', 'DSI', 'DESI')
            AND A2.ACTI_STATUS_IND='D'
            AND A2.ACTIVITY_DATE <= '{end_date}'  -- Date: end of reporting period
        GROUP BY
            A2.CUTB_SEQ_NBR
    ),
	LRCT AS
    (
        /* Excluding DRD */
        SELECT DISTINCT
            A4.CUTB_SEQ_NBR,
            MAX(A4.ACTIVITY_DATE) AS LATEST_OGS_REACTIVATED
        FROM
            BCTS_STAGING.FORESTVIEW_V_BLOCK_ACTIVITY_ALL A4
        WHERE
            A4.ACTIVITY_CLASS='CSB'
            AND A4.ACTT_KEY_IND IN ('RFH', 'RFN', 'RFV', 'RMN', 'RRD', 'RRE')
            AND A4.ACTI_STATUS_IND='D'
            AND A4.ACTIVITY_DATE <= '{end_date}'  -- Date: end of reporting period
        GROUP BY A4.CUTB_SEQ_NBR,
            A4.ACTI_STATUS_IND
    ),
	EXL AS
    (
        SELECT DISTINCT
            LICN_SEQ_NBR
        FROM
            BCTS_STAGING.FORESTVIEW_V_LICENCE_ACTIVITY_ALL
        WHERE
            (
                ACTIVITY_CLASS='CML'
                AND ACTT_KEY_IND In ('HI', 'HC', 'HX', 'HS')
                AND ACTI_STATUS_IND='D'
            )
        ORDER BY LICN_SEQ_NBR
    ) 


SELECT DISTINCT
    case
        when
            BLOCK.TSO_CODE in ('TBA', 'TPL', 'TPG', 'TSK', 'TSN', 'TCC', 'TKA', 'TKO', 'TOC')
        then
            'Interior'
        when
            BLOCK.TSO_CODE in ('TCH', 'TST', 'TSG')
        then
            'Coast'
        end as BUSINESS_AREA_REGION_CATEGORY,
    case
        when
            BLOCK.TSO_CODE in ('TBA', 'TPL', 'TPG', 'TSK', 'TSN')
        then
            'North Interior'
        when
            BLOCK.TSO_CODE in ('TCC', 'TKA', 'TKO', 'TOC')
        then
            'South Interior'
        when
            BLOCK.TSO_CODE in ('TCH', 'TST', 'TSG')
        then
            'Coast'
        end as BUSINESS_AREA_REGION,
    CASE 
	    WHEN BLOCK.TSO_NAME = 'Seaward' THEN 'Seaward/Tlasta' -- See https://apps.nrs.gov.bc.ca/int/jira/projects/SD/queues/issue/SD-74878 to track whether this DECODE statement still needs to be in this report
	    ELSE BLOCK.TSO_NAME 
	END || ' (' || BLOCK.TSO_CODE || ')' AS BUSINESS_AREA,
    BLOCK.TSO_CODE AS BUSINESS_AREA_CODE,
    LICENCE.FIELD_TEAM,
    LICENCE.NAV_NAME,
    BLOCK.OPAR_OPERATING_AREA_NAME AS OperatingArea,
    BLOCK.CUTB_LOCATION AS Location,
    LICENCE.TENURE,
    LICENCE.LICENCE_ID,
    LICENCE.LICN_LICENCE_STATE AS Licence_State,
    BLOCK.PERMIT_ID,
    BLOCK.BLOCK_ID,
    BLOCK.UBI,
    BLOCK.CUTB_BLOCK_STATE AS Block_State,
    CASE WHEN (ACTB.Old_Growth_Strategy > COALESCE(LRCT.LATEST_OGS_REACTIVATED, To_Date('1900-01-01', 'YYYY-MM-DD')))  -- Date: fixed (1900-01-01)
                OR (LDF.LATEST_DEF > COALESCE(ACTB.DEF_REACTIVATED, To_Date('1900-01-01', 'YYYY-MM-DD')))  -- Date: fixed (1900-01-01)
        THEN 'Y' ELSE 'N' END AS DEFERRED,
    CASE WHEN ACTB.Old_Growth_Strategy > COALESCE(LRCT.LATEST_OGS_REACTIVATED, To_Date('1900-01-01', 'YYYY-MM-DD'))  -- Date: fixed (1900-01-01)
            THEN 'Deferred-OGS'
        WHEN LDF.LATEST_DEF > COALESCE(ACTB.DEF_REACTIVATED, To_Date('1900-01-01', 'YYYY-MM-DD'))  -- Date: fixed (1900-01-01)
            THEN 'Deferred-Other' ELSE 'No Deferral' END AS INVENTORY_CATEGORY,
    BLOCK.CRUISE_VOL,
    BLOCK.BLAL_RW_VOL AS RW_VOL,
    ACTB_S.RC_Status,
    ACTB.RC_DATE,
    ACTB_S.DR_Status,
    ACTB.DR_DATE,
    EXTRACT(YEAR FROM (ACTB.DR_DATE + INTERVAL '9 months')) AS DR_Fiscal,
    CEIL(EXTRACT(MONTH FROM (ACTB.DR_DATE + INTERVAL '-3 months')) / 3.0) AS DR_Quarter,
    CASE 
	    WHEN EXTRACT(YEAR FROM (CURRENT_DATE + INTERVAL '9 months')) - 
	         EXTRACT(YEAR FROM (ACTB.DR_DATE + INTERVAL '9 months')) > 5 
	    THEN 
	        'Before ' || TO_CHAR(CURRENT_DATE + INTERVAL '-63 months', 'YY') || '/' || 
	        TO_CHAR(CURRENT_DATE + INTERVAL '-51 months', 'YY') 
	    ELSE 
	        TO_CHAR(ACTB.DR_DATE + INTERVAL '-3 months', 'YY') || '/' || 
	        TO_CHAR(ACTB.DR_DATE + INTERVAL '9 months', 'YY') 
	END AS DR_Category,
    ACTB_S.DVS_Status,
    ACTB.DVS_DATE,
    ACTB_S.DVC_Status,
    ACTB.DVC_DATE,
    EXTRACT(YEAR FROM (ACTB.DVS_DATE + INTERVAL '9 months')) AS DVS_Fiscal,
	CEIL(EXTRACT(MONTH FROM (ACTB.DVS_DATE + INTERVAL '-3 months')) / 3.0) AS DVS_Quarter,
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
    BS.SPATIAL_FLAG,
    BLOCK.CUTB_SEQ_NBR,
    '{end_date}'::date

FROM
    BCTS_STAGING.FORESTVIEW_V_BLOCK BLOCK
	INNER JOIN ACTB_S
	ON BLOCK.CUTB_SEQ_NBR = ACTB_S.CUTB_SEQ_NBR
	AND ACTB_S.DR_STATUS = 'D'
	AND (COALESCE(ACTB_S.DVC_STATUS, ' ') <> 'D')
    AND (COALESCE(ACTB_S.DVS_STATUS, ' ') <> 'D')
    AND (COALESCE(ACTB_S.DEL_STATUS, ' ') <> 'D')
    AND (COALESCE(ACTB_S.WOFF_Status, ' ') <> 'D')
	INNER JOIN ACTB
	ON BLOCK.CUTB_SEQ_NBR = ACTB.CUTB_SEQ_NBR
	AND ACTB.DR_DATE <= '{end_date}'  -- Date: end of reporting period
	LEFT JOIN BCTS_STAGING.FORESTVIEW_V_BLOCK_SPATIAL BS
	ON BLOCK.CUTB_SEQ_NBR = BS.CUTB_SEQ_NBR 
	LEFT JOIN LDF
	ON BLOCK.CUTB_SEQ_NBR = LDF.CUTB_SEQ_NBR 
	LEFT JOIN LRCT
	ON BLOCK.CUTB_SEQ_NBR = LRCT.CUTB_SEQ_NBR 
	LEFT JOIN BCTS_STAGING.FORESTVIEW_V_LICENCE LICENCE
	ON BLOCK.LICN_SEQ_NBR = LICENCE.LICN_SEQ_NBR 
	LEFT JOIN EXL
	ON LICENCE.LICN_SEQ_NBR = EXL.LICN_SEQ_NBR
	AND EXL.LICN_SEQ_NBR Is Null

ORDER BY
    -- length(business_area_region) desc,
    business_area_region,
    business_area,
    LICENCE.FIELD_TEAM,
    LICENCE.NAV_NAME,
    LICENCE.LICENCE_ID,
    BLOCK.PERMIT_ID,
    BLOCK.BLOCK_ID;

        """
    return sql_statement
