def get_annual_developed_volume_query(start_date, end_date):
    sql_statement = \
    f"""    
    INSERT INTO bcts_staging.annual_developed_volume_hist(
    business_area_region_category, business_area_region, business_area, business_area_code, "Field Team", manu_id, licence, "File Type", agreement_type_code, agreement_type, permit, mark, block, ubi, block_state, cruise_volume, rw_volume, rc_done, rc_done_fiscal, dr_done, dr_done_fiscal, dvs_done, dvs_done_fiscal, dvc_done, dvc_done_fiscal, cutb_seq_nbr, fiscal_year_start_date, report_end_date   
    )
        WITH annual_developed_volume AS
    (
        SELECT DISTINCT
            CASE
                WHEN d.divi_short_code IN ( 'TBA', 'TPL', 'TPG', 'TSK', 'TSN',
                                            'TCC', 'TKA', 'TKO', 'TOC' ) THEN
                    'Interior'
                WHEN d.divi_short_code IN ( 'TCH', 'TST', 'TSG' ) THEN
                    'Coast'
            END                                             AS business_area_region_category,
            CASE
                WHEN d.divi_short_code IN ( 'TBA', 'TPL', 'TPG', 'TSK', 'TSN' ) THEN
                    'North Interior'
                WHEN d.divi_short_code IN ( 'TCC', 'TKA', 'TKO', 'TOC' ) THEN
                    'South Interior'
                WHEN d.divi_short_code IN ( 'TCH', 'TST', 'TSG' ) THEN
                    'Coast'
            END                                             AS business_area_region,
            CASE WHEN d.divi_division_name = 'Seaward' THEN 'Seaward-Tlasta' ELSE d.divi_division_name END
            || ' ('
            || d.divi_short_code
            || ')'                                          AS business_area,
            d.divi_short_code                               AS business_area_code,
            cl.colu_lookup_desc                             AS "Field Team",
            mu.manu_id,
            l.licn_licence_id                               AS licence,
            tn.tent_tenure_id                               AS "File Type",
            l.blaz_admin_zone_id                            AS agreement_type_code,
            z.blaz_admin_zone_desc                          AS agreement_type,
            cp.perm_permit_id                               AS permit,
            m.mark_mark_id                                  AS mark,
            b.cutb_block_id                                 AS block,
            b.cutb_system_id                                AS ubi,
            b.cutb_block_state                              AS block_state,
            ba.blal_cruise_m3_vol                           AS cruise_volume,
            ba.blal_rw_vol                                  AS rw_volume,
            actb.rc_done,
            EXTRACT(YEAR FROM (actb.rc_done + INTERVAL '9 months'))  AS rc_done_fiscal,
            actb.dr_done,
            EXTRACT(YEAR FROM (actb.dr_done + INTERVAL '9 months'))  AS dr_done_fiscal,
            actb.dvs_done,
            EXTRACT(YEAR FROM (actb.dvs_done + INTERVAL '9 months')) AS dvs_done_fiscal,
            actb.dvc_done,
            EXTRACT(YEAR FROM (actb.dvc_done + INTERVAL '9 months')) AS dvc_done_fiscal,
            b.cutb_seq_nbr
        FROM
            bcts_staging.forest_division             d
            INNER JOIN bcts_staging.forest_block_allocation     ba
                ON d.divi_div_nbr = ba.divi_div_nbr
            INNER JOIN bcts_staging.forest_management_unit      mu
                ON ba.manu_seq_nbr = mu.manu_seq_nbr
            INNER JOIN bcts_staging.forest_licence              l
                ON ba.licn_seq_nbr = l.licn_seq_nbr
            LEFT OUTER JOIN bcts_staging.forest_block_admin_zone     z
                ON l.divi_div_nbr = z.divi_div_nbr 
                AND l.blaz_admin_zone_id = z.blaz_admin_zone_id 
                AND ba.licn_seq_nbr = l.licn_seq_nbr
                AND l.divi_div_nbr = z.divi_div_nbr 
                AND l.blaz_admin_zone_id = z.blaz_admin_zone_id 
            LEFT OUTER JOIN bcts_staging.forest_division_code_lookup dcl
                ON l.licn_field_team_id = dcl.colu_lookup_id 
                AND l.divi_div_nbr = dcl.divi_div_nbr 
            LEFT OUTER JOIN bcts_staging.forest_code_lookup          cl
                ON  dcl.colu_lookup_type = cl.colu_lookup_type 
                AND dcl.colu_lookup_id = cl.colu_lookup_id 
            LEFT JOIN bcts_staging.forest_tenure_type tn
                ON l.tent_seq_nbr = tn.tent_seq_nbr
            LEFT OUTER JOIN bcts_staging.forest_cut_permit           cp
                ON ba.perm_seq_nbr = cp.perm_seq_nbr 
            LEFT JOIN bcts_staging.forest_mark                 m
                ON ba.mark_seq_nbr = m.mark_seq_nbr 
            INNER JOIN  bcts_staging.forest_cut_block            b
                ON ba.cutb_seq_nbr = b.cutb_seq_nbr
            INNER JOIN
            (
                SELECT
                        A.CUTB_SEQ_NBR,
                        MAX(CASE WHEN ACTT_KEY_IND = 'RC' THEN DATE_TRUNC('DAY', ACTI_STATUS_DATE) END)::DATE AS RC_Done,
                        MAX(CASE WHEN ACTT_KEY_IND = 'DR' THEN DATE_TRUNC('DAY',ACTI_STATUS_DATE) END)::DATE AS DR_Done,
                        MAX(CASE WHEN ACTT_KEY_IND = 'DVS' THEN DATE_TRUNC('DAY',ACTI_STATUS_DATE) END)::DATE AS DVS_Done,
                        MAX(CASE WHEN ACTT_KEY_IND = 'DVC' THEN DATE_TRUNC('DAY',ACTI_STATUS_DATE) END)::DATE AS DVC_Done
                    FROM
                        bcts_staging.forest_ACTIVITY_CLASS C,
                        bcts_staging.forest_ACTIVITY_TYPE T,
                        bcts_staging.forest_ACTIVITY A
                    WHERE
                        C.ACCL_SEQ_NBR = T.ACCL_SEQ_NBR
                        AND T.ACTT_SEQ_NBR = A.ACTT_SEQ_NBR
                        AND C.ACCL_DESCRIPTION = 'CMB'
                        AND T.ACTT_KEY_IND In ('RC', 'DR', 'DVS', 'DVC')
                        AND A.ACTI_STATUS_IND = 'D'
                    GROUP BY  A.CUTB_SEQ_NBR, T.ACTT_KEY_IND
            ) ACTB
            ON ba.cutb_seq_nbr = actb.cutb_seq_nbr
                AND actb.dvc_done BETWEEN TO_DATE('2024-04-01', 'YYYY-MM-DD')  -- Date: beginning of current fiscal
                AND TO_DATE('2024-09-30', 'YYYY-MM-DD')  -- Date: end of reporting period
    )

    SELECT *,
        '{start_date}' AS fiscal_year_start_date,
        '{end_date}' AS report_end_date
    FROM annual_developed_volume
    ORDER BY
        length(business_area_region) desc,
        business_area_region,
        business_area,
        "Field Team",
        MANU_ID,
        licence,
        permit,
        mark,
        block
    ;
    """
    return sql_statement
