DROP TABLE IF EXISTS bcts_staging.DIVISION;
CREATE TABLE bcts_staging.DIVISION AS
    SELECT * FROM lrm_replication.DIVISION;

DROP TABLE IF EXISTS bcts_staging.BLOCK_ALLOCATION;
CREATE TABLE bcts_staging.BLOCK_ALLOCATION AS
    SELECT * FROM lrm_replication.BLOCK_ALLOCATION;

DROP TABLE IF EXISTS bcts_staging.MANAGEMENT_UNIT;
CREATE TABLE bcts_staging.MANAGEMENT_UNIT AS
    SELECT * FROM lrm_replication.MANAGEMENT_UNIT;

DROP TABLE IF EXISTS bcts_staging.LICENCE;
CREATE TABLE bcts_staging.LICENCE AS
    SELECT * FROM lrm_replication.LICENCE;

DROP TABLE IF EXISTS bcts_staging.BLOCK_ADMIN_ZONE;
CREATE TABLE bcts_staging.BLOCK_ADMIN_ZONE AS
    SELECT * FROM lrm_replication.BLOCK_ADMIN_ZONE;

DROP TABLE IF EXISTS bcts_staging.DIVISION_CODE_LOOKUP;
CREATE TABLE bcts_staging.DIVISION_CODE_LOOKUP AS
    SELECT * FROM lrm_replication.DIVISION_CODE_LOOKUP;

DROP TABLE IF EXISTS bcts_staging.CODE_LOOKUP;
CREATE TABLE bcts_staging.CODE_LOOKUP AS
    SELECT * FROM lrm_replication.CODE_LOOKUP;

DROP TABLE IF EXISTS bcts_staging.TENURE_TYPE;
CREATE TABLE bcts_staging.TENURE_TYPE AS
    SELECT * FROM lrm_replication.TENURE_TYPE;

DROP TABLE IF EXISTS bcts_staging.CUT_PERMIT;
CREATE TABLE bcts_staging.CUT_PERMIT AS
    SELECT * FROM lrm_replication.CUT_PERMIT;

DROP TABLE IF EXISTS bcts_staging.MARK;
CREATE TABLE bcts_staging.MARK AS
    SELECT * FROM lrm_replication.MARK;

DROP TABLE IF EXISTS bcts_staging.DIVISION_CODE_LOOKUP;
CREATE TABLE bcts_staging.DIVISION_CODE_LOOKUP AS
    SELECT * FROM lrm_replication.DIVISION_CODE_LOOKUP;

DROP TABLE IF EXISTS bcts_staging.CUT_BLOCK;
CREATE TABLE bcts_staging.CUT_BLOCK AS
    SELECT * FROM lrm_replication.CUT_BLOCK;

DROP TABLE IF EXISTS bcts_staging.ACTIVITY_CLASS;
CREATE TABLE bcts_staging.ACTIVITY_CLASS AS
    SELECT * FROM lrm_replication.ACTIVITY_CLASS;

DROP TABLE IF EXISTS bcts_staging.ACTIVITY_TYPE;
CREATE TABLE bcts_staging.ACTIVITY_TYPE AS
    SELECT * FROM lrm_replication.ACTIVITY_TYPE;

DROP TABLE IF EXISTS bcts_staging.ACTIVITY;
CREATE TABLE bcts_staging.ACTIVITY AS
    SELECT * FROM lrm_replication.ACTIVITY;


DROP TABLE IF EXISTS bcts_staging.annual_developed_volume;

CREATE TABLE bcts_staging.annual_developed_volume AS
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
        lrm_replication.division             d
        INNER JOIN bcts_staging.block_allocation     ba
            ON d.divi_div_nbr = ba.divi_div_nbr
        INNER JOIN bcts_staging.management_unit      mu
            ON ba.manu_seq_nbr = mu.manu_seq_nbr
        INNER JOIN bcts_staging.licence              l
            ON ba.licn_seq_nbr = l.licn_seq_nbr
        LEFT OUTER JOIN bcts_staging.block_admin_zone     z
            ON l.divi_div_nbr = z.divi_div_nbr 
            AND l.blaz_admin_zone_id = z.blaz_admin_zone_id 
            AND ba.licn_seq_nbr = l.licn_seq_nbr
            AND l.divi_div_nbr = z.divi_div_nbr 
            AND l.blaz_admin_zone_id = z.blaz_admin_zone_id 
        LEFT OUTER JOIN bcts_staging.division_code_lookup dcl
            ON l.licn_field_team_id = dcl.colu_lookup_id 
            AND l.divi_div_nbr = dcl.divi_div_nbr 
        LEFT OUTER JOIN bcts_staging.code_lookup          cl
            ON  dcl.colu_lookup_type = cl.colu_lookup_type 
            AND dcl.colu_lookup_id = cl.colu_lookup_id 
        LEFT JOIN bcts_staging.tenure_type tn
            ON l.tent_seq_nbr = tn.tent_seq_nbr
        LEFT OUTER JOIN bcts_staging.cut_permit           cp
            ON ba.perm_seq_nbr = cp.perm_seq_nbr 
        LEFT JOIN bcts_staging.mark                 m
            ON ba.mark_seq_nbr = m.mark_seq_nbr 
        INNER JOIN  bcts_staging.cut_block            b
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
                    bcts_staging.ACTIVITY_CLASS C,
                    bcts_staging.ACTIVITY_TYPE T,
                    bcts_staging.ACTIVITY A
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

SELECT *
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

DROP TABLE IF EXISTS bcts_reporting.annual_developed_volume;

CREATE TABLE bcts_reporting.annual_developed_volume AS
    SELECT * FROM bcts_staging.annual_developed_volume;