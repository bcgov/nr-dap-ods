
CREATE OR REPLACE VIEW BCTS_STAGING.SILVILIABILITY_LRM AS
/* Licence Selection */
WITH BL AS
(
    SELECT
        A.CUTB_SEQ_NBR
        
    FROM
        LRM_REPLICATION.ACTIVITY_CLASS AC,
        LRM_REPLICATION.ACTIVITY_TYPE AT,
        LRM_REPLICATION.ACTIVITY A

    WHERE
        AC.ACCL_SEQ_NBR = AT.ACCL_SEQ_NBR
        AND AC.DIVI_DIV_NBR = AT.DIVI_DIV_NBR
        AND AT.ACTT_SEQ_NBR = A.ACTT_SEQ_NBR
        AND AC.ACCL_DESCRIPTION = 'CMB'
        AND AT.ACTT_KEY_IND IN ('HVC', 'HVS')
        AND A.PLAN_SEQ_NBR IS NULL
        AND A.ACTI_STATUS_IND = 'D'
        AND A.ACTI_STATUS_DATE >= TO_DATE('1994-04-01','YYYY-MM-DD')  -- Date: Fixed (1994-04-01)

    GROUP BY
    A.CUTB_SEQ_NBR
),
M AS
(
    SELECT
        hv.MARK_SEQ_NBR,
        Sum(hv.BCHH_VOLUME_BILLED) AS HBS_VOLUME_BILLED,
        Min(hv.BCHH_BILLING_PERIOD) AS FIRST_BILLING
    FROM
        LRM_REPLICATION.BCTS_HARVEST_HISTORY hv
    GROUP BY
        hv.MARK_SEQ_NBR
    ORDER BY
        hv.MARK_SEQ_NBR
),
LS AS
(
    Select
        ba.licn_seq_nbr,
        Max(m.HBS_VOLUME_BILLED) AS HBS_VOLUME_BILLED,
        Min(m.FIRST_BILLING) AS HBS_FIRST_BILLING
    From
        LRM_REPLICATION.BLOCK_ALLOCATION ba
        LEFT JOIN BL
        ON  ba.CUTB_SEQ_NBR = BL.CUTB_SEQ_NBR
        LEFT JOIN M
        ON ba.MARK_SEQ_NBR = M.MARK_SEQ_NBR
    WHERE  BL.CUTB_SEQ_NBR IS NOT NULL
        OR M.MARK_SEQ_NBR IS NOT NULL
    GROUP BY
            ba.licn_seq_nbr
),
/* HARVEST STARTED AND COMPLETED */
HV AS
(
    
    SELECT A.CUTB_SEQ_NBR,
        MAX(CASE WHEN AT.ACTT_KEY_IND = 'HVC' THEN A.ACTI_STATUS_IND ELSE NULL END) AS HVC_STATUS,
        MAX(CASE WHEN AT.ACTT_KEY_IND = 'HVC' THEN A.ACTI_STATUS_DATE ELSE NULL END) AS HVC_DATE,
        MAX(CASE WHEN AT.ACTT_KEY_IND = 'HVS' THEN A.ACTI_STATUS_IND ELSE NULL END) AS HVS_STATUS,
        MAX(CASE WHEN AT.ACTT_KEY_IND = 'HVS' THEN A.ACTI_STATUS_DATE ELSE NULL END) AS HVS_DATE

    FROM
        LRM_REPLICATION.ACTIVITY_CLASS AC,
        LRM_REPLICATION.ACTIVITY_TYPE AT,
        LRM_REPLICATION.ACTIVITY A

    WHERE
        AC.ACCL_SEQ_NBR = AT.ACCL_SEQ_NBR
        AND AC.DIVI_DIV_NBR = AT.DIVI_DIV_NBR
        AND AT.ACTT_SEQ_NBR = A.ACTT_SEQ_NBR
        AND AC.ACCL_DESCRIPTION = 'CMB'
        AND AT.ACTT_KEY_IND IN ('HVC', 'HVS')
        AND A.PLAN_SEQ_NBR IS NULL

    GROUP BY
        A.CUTB_SEQ_NBR
),

/* NAR */
NAR AS
(
    SELECT
        SILP.CUTB_SEQ_NBR,
        SUM( STUN_GROSS_HA_AREA ) AS NAR_AREA

    FROM
        LRM_REPLICATION.STANDARD_UNIT SU,
        LRM_REPLICATION.SU_TYPE SUTY,
        LRM_REPLICATION.SILVICULTURE_PRESCRIPTION SILP

    WHERE
        SU.SILP_SEQ_NBR = SILP.SILP_SEQ_NBR
        AND SU.SUTY_TYPE_ID = SUTY.SUTY_TYPE_ID
        AND SUTY.SUTY_KEY_IND = 'PRODV'

    GROUP BY
        SILP.CUTB_SEQ_NBR
),

/* Need Planting - ART */
ART AS
(
    Select
        m.CUTB_SEQ_NBR

    From
        LRM_REPLICATION.SILVICULTURE_STRATUM m,
        LRM_REPLICATION.silviculture_stocking_status k

    Where
        m.SIST_SEQ_NBR = k.SIST_SEQ_NBR
        And k.STTP_STOCKING_TYPE_ID = 'ART'

    Group By
        m.CUTB_SEQ_NBR
),

/*
Largest BEC in Block
The area of each matching BEC variant (Zone, Subzone, and Variant must match)
is summed together. The summed area of each BEC variant is compared; the
variant with the largest area is identified. If multiple variants tie for
maximum summed area, each BEC variant is listed.
*/
area_each_bec AS
(
select
    cutb_seq_nbr,
    GROSS_AREA_BEC,
    BEC,
    BIO_ZONE,
    BIO_SUBZONE,
    BIO_VARIANT,
    rank() over (
        partition by
            cutb_seq_nbr
        order by
            GROSS_AREA_BEC desc
    ) as bec_rank
from
    (
        SELECT
            e.CUTB_SEQ_NBR,
            sum(e.GROSS_AREA) AS GROSS_AREA_BEC,
            e.BIOZ_ZONE_ID || e.BIOS_SUBZONE_ID || e.BIOV_VARIANT_ID AS BEC,
            CASE
                WHEN bioz_zone_name IS NULL THEN e.BIOZ_ZONE_ID
                ELSE bioz_zone_name || ' (' || e.BIOZ_ZONE_ID || ')'
            END AS BIO_ZONE,
            case
                when
                    bios_subzone_name is not null
                then
                    bios_subzone_name || ' (' || e.BIOZ_ZONE_ID || e.BIOS_SUBZONE_ID || ')'
                when
                    e.BIOS_SUBZONE_ID is not null
                then
                    e.BIOZ_ZONE_ID || e.BIOS_SUBZONE_ID
                end as bio_subzone,
            case
                when
                    biov_variant_name is not null
                then
                    biov_variant_name || ' (' || e.BIOZ_ZONE_ID || e.BIOS_SUBZONE_ID || e.BIOV_VARIANT_ID || ')'
                when
                    e.BIOS_SUBZONE_ID is not null
                    and e.BIOV_VARIANT_ID is not null
                then
                    e.BIOZ_ZONE_ID || e.BIOS_SUBZONE_ID || e.BIOV_VARIANT_ID
                end as BIO_VARIANT
        FROM
            LRM_REPLICATION.V_ECOLOGY e
            LEFT JOIN LRM_REPLICATION.biogeoclimatic_zone bz
            ON e.BIOZ_ZONE_ID = bz.BIOZ_ZONE_ID
            LEFT JOIN LRM_REPLICATION.biogeoclimatic_subzone bsz
            ON e.BIOZ_ZONE_ID = bsz.BIOZ_ZONE_ID
            AND e.BIOS_SUBZONE_ID = bsz.BIOS_SUBZONE_ID
            LEFT JOIN LRM_REPLICATION.biogeoclimatic_variant bv
            ON  e.BIOZ_ZONE_ID = bv.BIOZ_ZONE_ID 
            AND e.BIOS_SUBZONE_ID = bv.BIOS_SUBZONE_ID 
            AND e.BIOV_VARIANT_ID = bv.BIOV_VARIANT_ID
        GROUP BY
            e.cutb_seq_nbr,
            e.BIOZ_ZONE_ID,
            e.BIOS_SUBZONE_ID,
            e.BIOV_VARIANT_ID,
            bz.bioz_zone_name,
            bsz.bios_subzone_name,
            bv.biov_variant_name
    ) AB   
),

BIO AS
(
    select
    cutb_seq_nbr,
    MAX(GROSS_AREA_BEC) AS LARGEST_ECO_AREA,
    COUNT(DISTINCT BEC) AS COUNT_BEC_WITH_LARGEST_ECO_AREA,
    STRING_AGG(DISTINCT BEC, ', ' ORDER BY BEC) AS BEC,
    STRING_AGG(DISTINCT BIO_ZONE, ', ' ORDER BY BIO_ZONE) AS BIO_ZONE,
    STRING_AGG(DISTINCT BIO_SUBZONE, ', ' ORDER BY BIO_SUBZONE) AS BIO_SUBZONE,
    STRING_AGG(DISTINCT BIO_VARIANT, ', ' ORDER BY BIO_VARIANT) AS BIO_VARIANT

    from area_each_bec
    where
        bec_rank = 1
    group by
        cutb_seq_nbr
),

/* Silviculture */
SA AS
(
    SELECT
        SA0.SILA_TREATMENT_UNIT_ID,
        SA0.FUND_FUNDING_CODE AS ACTIVITY_FUNDING,
        SA0.SILA_STATUS, SA0.RESP_RESPONSIBILITY_CODE,
        SA0.SILA_START_DATE,
        SA0.SILA_COMPLETION_DATE,
        SA0.SILA_GROSS_HA_AREA,
        SA0.SILA_COST_PER_HA_PLAN,
        SA0.SILA_COST_PER_HA,
        SUBSTR(SA0.SILA_COMMENTS, 1, 4000) AS COMMENTS,
        SA0.SILA_FORMB_DATE,
        SA0.SILA_FORMB_PRINTED,
        SA0.MODIFIEDBY,
        SA0.MODIFIEDON,
        PLU.PLUN_PLANTING_UNIT_ID,
        PLU.PLUN_DIGITISED_IND,
        PLU.PLUN_PLANTING_PLAN_COST,
        PLU.PLUN_PLANTING_COST,
        PLU.PLUN_HA_AREA,
        PLU.PLUN_NET_AREA,
        PLU.PLUN_DENSITY,
        PLU.TOTAL_TREES,
        PLU.MODIFIEDBY AS PLUN_MODIFIEDBY,
        PLU.MODIFIEDON AS PLUN_MODIFIEDON,
        PLU.MODIFIEDUSING AS PLUN_MODIFIEDUSING,
        COALESCE(PLU.PLUN_SEQ_NBR, 0) AS PLUN_SEQ_NBR,
        SA0.SILA_SEQ_NBR,
        SA0.SICA_SEQ_NBR,
        SA0.CUTB_SEQ_NBR
    FROM
        LRM_REPLICATION.SILVICULTURE_ACTIVITY SA0
        LEFT JOIN LRM_REPLICATION.PLANTING_UNIT PLU
        ON SA0.SILA_SEQ_NBR = PLU.SILA_SEQ_NBR
),

/* SPECIES */
SP AS
(
    SELECT
        BTS.SILA_SEQ_NBR,
        STRING_AGG(BTS.SISP_SPECIES_ID, ', ' ORDER BY BTS.SISP_SPECIES_ID) AS TARGET_SPECIES

    FROM
        LRM_REPLICATION.BRUSHING_TARGET_SPECIES BTS

    GROUP BY
        BTS.SILA_SEQ_NBR
),

SAC0 AS
(
    SELECT
    C0.SILA_SEQ_NBR,
    C0.PLUN_SEQ_NBR,
    MAX(
        CASE
            WHEN
                C0.SL_RANK = 1
                AND UPPER(C0.SACC_SERIES) = 'PLANNED'
            THEN
                C0.SCAC_SEQ_NBR
            END
    ) AS P_SCAC_SEQ_NBR,
    MAX(
        CASE
            WHEN
                C0.SL_RANK = 1
                AND UPPER(C0.SACC_SERIES) = 'ACTUAL'
            THEN
                C0.SCAC_SEQ_NBR
            END
    ) AS A_SCAC_SEQ_NBR,
    SUM(CASE WHEN UPPER(C0.SACC_SERIES) = 'PLANNED' THEN C0.SUB_COST ELSE 0 END) AS ITEM_TOTAL_PLANNED,
    SUM(CASE WHEN UPPER(C0.SACC_SERIES) = 'ACTUAL' THEN C0.SUB_COST ELSE 0 END) AS ITEM_TOTAL_ACTUAL

    FROM
    (
        SELECT
            C.SILA_SEQ_NBR,
            C.PLUN_SEQ_NBR,
            C.SCAC_SEQ_NBR,
            SUM(C.SACC_ITEM_COST) AS SUB_COST,
            RANK() OVER (
                PARTITION BY
                    C.SILA_SEQ_NBR,
                    C.PLUN_SEQ_NBR,
                    C.SACC_SERIES
                ORDER BY
                    SUM(COALESCE(C.SACC_ITEM_COST, 0))
            ) AS SL_RANK,
            C.SACC_SERIES
        FROM
            LRM_REPLICATION.SILV_ACTIVITY_COST C
        LEFT JOIN 

            /* PLANTING ACTIVITIES */
            (
                SELECT
                    SILA_SEQ_NBR
                FROM
                    LRM_REPLICATION.SILV_ACTIVITY_COST
                GROUP BY
                    SILA_SEQ_NBR
                HAVING
                    MAX(PLUN_SEQ_NBR) IS NOT NULL
                ORDER BY 1
            ) SPL

        ON C.SILA_SEQ_NBR = SPL.SILA_SEQ_NBR 
        WHERE
            /* Filter out hidden planting records without PLUN_SEQ_NBR */
            (
                SPL.SILA_SEQ_NBR IS NULL /* Non-planting */
                OR (
                    SPL.SILA_SEQ_NBR IS NOT NULL
                    AND C.PLUN_SEQ_NBR IS NOT NULL
                ) /* Planting with planting unit */
            )

        GROUP BY
            C.SILA_SEQ_NBR,
            C.PLUN_SEQ_NBR,
            C.SCAC_SEQ_NBR,
            C.SACC_SERIES
    ) C0
    GROUP BY
    C0.SILA_SEQ_NBR,
    C0.PLUN_SEQ_NBR
),

/* TOTAL BY ITEMS AND GET SERVICE LINE RANKED BY THE TOTAL COST. */
SAC AS
(
    SELECT
        SAC0.SILA_SEQ_NBR,
        COALESCE(SAC0.PLUN_SEQ_NBR, 0) AS PLUN_SEQ_NBR,
        SAC0.ITEM_TOTAL_PLANNED,
        SAC0.ITEM_TOTAL_ACTUAL,
        CI0.CSTI_COST_ITEM_ACCOUNT_CODE AS PLANNED_SERVICE_LINE,
        CI0.CSTI_COST_ITEM_DESCRIPTION AS PLANNED_SL_DESCRIPTION,
        CI1.CSTI_COST_ITEM_ACCOUNT_CODE AS ACTUAL_SERVICE_LINE,
        CI1.CSTI_COST_ITEM_DESCRIPTION AS ACTUAL_SL_DESCRIPTION,
        SCAC0.CSTI_COST_ITEM_ID AS PLANNED_COST_ITEM_ID,
        SCAC1.CSTI_COST_ITEM_ID AS ACTUAL_COST_ITEM_ID

    FROM SAC0
    LEFT JOIN LRM_REPLICATION.SILV_COMPANY_ACTIVITY_COST SCAC0
    ON SAC0.P_SCAC_SEQ_NBR = SCAC0.SCAC_SEQ_NBR 
    LEFT JOIN LRM_REPLICATION.FRST_COST_ITEM CI0
    ON SCAC0.DIVI_DIV_NBR = CI0.DIVI_DIV_NBR 
    AND SCAC0.CSTI_COST_ITEM_ID = CI0.CSTI_COST_ITEM_ID
    LEFT JOIN LRM_REPLICATION.SILV_COMPANY_ACTIVITY_COST SCAC1
    ON SAC0.A_SCAC_SEQ_NBR = SCAC1.SCAC_SEQ_NBR
    LEFT JOIN LRM_REPLICATION.FRST_COST_ITEM CI1
    ON SCAC1.DIVI_DIV_NBR = CI1.DIVI_DIV_NBR
    AND SCAC1.CSTI_COST_ITEM_ID = CI1.CSTI_COST_ITEM_ID   
),

SACT AS
(

/* ALL ITEMS TOTAL */

    SELECT
        C.SILA_SEQ_NBR,
        SUM(CASE WHEN UPPER(C.SACC_SERIES) = 'PLANNED' THEN C.SACC_ITEM_COST ELSE 0 END) AS ITEMS_TOTAL_PLANNED,
        SUM(CASE WHEN UPPER(C.SACC_SERIES) = 'ACTUAL' THEN C.SACC_ITEM_COST ELSE 0 END) AS ITEMS_TOTAL_ACTUAL

    FROM
        LRM_REPLICATION.SILV_ACTIVITY_COST C
    LEFT JOIN
        /* PLANTING ACTIVITIES */
        (
            SELECT
                SILA_SEQ_NBR

            FROM
                LRM_REPLICATION.SILV_ACTIVITY_COST

            GROUP BY
                SILA_SEQ_NBR

            HAVING
                MAX(PLUN_SEQ_NBR) IS NOT NULL

            ORDER BY 1
        ) SPL

    ON C.SILA_SEQ_NBR = SPL.SILA_SEQ_NBR 
    WHERE (
            SPL.SILA_SEQ_NBR IS NULL  /* Non-planting */
            OR (
                SPL.SILA_SEQ_NBR IS NOT NULL
                AND C.PLUN_SEQ_NBR IS NOT NULL
            )  /* Planting with planting unit */
        )

    GROUP BY
        C.SILA_SEQ_NBR
),

RK AS
/* Reqeust Key */
(
    SELECT DISTINCT
        SQ.PLUN_SEQ_NBR,
        STRING_AGG(
            SQ.SISP_SPECIES_ID
            || '/Lot:' || SQ.SISL_SEED_LOT_NUMBER
            || '/$' || SQ.PLSP_PRICE_PER_TREE
            || '/Trees:' || SQ.PLSP_NUMBER_TREES
            || '/Req_Key:' || SQ.SIRK_REQUEST_KEY,
            ' ' ORDER BY SQ.SISP_SPECIES_ID, SQ.SIRK_REQUEST_KEY, SQ.SISL_SEED_LOT_NUMBER
        ) AS SEEDLING_REQUEST
    FROM (
        SELECT
            PS.PLUN_SEQ_NBR,
            PS.SISP_SPECIES_ID,
            PS.SISL_SEED_LOT_NUMBER,
            PS.PLSP_PRICE_PER_TREE,
            PS.PLSP_NUMBER_TREES,
            PS.SIRK_REQUEST_KEY
        FROM
            LRM_REPLICATION.PLANTING_SPECIES PS
        ) AS SQ
    GROUP BY
    SQ.PLUN_SEQ_NBR
),

S AS
(
    SELECT
        SA.SILA_TREATMENT_UNIT_ID,
        SA.ACTIVITY_FUNDING,
        SCA.SIAB_BASE_CODE,
        SCA.SIAT_TECHNIQUE_CODE,
        SCA.SIAM_METHOD_CODE,
        SCA.SIAO_OBJECTIVE_CODE AS OBJECTIVE1,
        SCA.SIAO_OBJECTIVE_CODE2 AS OBJECTIVE2,
        SCA.SIAO_OBJECTIVE_CODE3 AS OBJECTIVE3,
        SCA.SICA_KEY_IND,
        SCA.SICA_ACTIVITY_NAME,
        SA.SILA_STATUS,
        SA.RESP_RESPONSIBILITY_CODE,
        SA.SILA_START_DATE,
        SA.SILA_COMPLETION_DATE,
        SA.SILA_GROSS_HA_AREA,
        SA.SILA_COST_PER_HA_PLAN,
        SA.SILA_COST_PER_HA,
        SAC.PLANNED_SERVICE_LINE,
        SAC.PLANNED_SL_DESCRIPTION,
        SACT.ITEMS_TOTAL_PLANNED,
        SAC.ITEM_TOTAL_PLANNED,
        SAC.ACTUAL_SERVICE_LINE,
        SAC.ACTUAL_SL_DESCRIPTION,
        SACT.ITEMS_TOTAL_ACTUAL,
        SAC.ITEM_TOTAL_ACTUAL,
        SA.PLUN_PLANTING_UNIT_ID,
        SA.PLUN_DIGITISED_IND,
        SA.PLUN_PLANTING_PLAN_COST,
        SA.PLUN_PLANTING_COST,
        SA.PLUN_HA_AREA,
        SA.PLUN_NET_AREA,
        SA.PLUN_DENSITY,
        SA.TOTAL_TREES,
        RK.SEEDLING_REQUEST,
        SA.PLUN_MODIFIEDBY,
        SA.PLUN_MODIFIEDON,
        SA.PLUN_MODIFIEDUSING,
        DS.DSAS_APPLY_RATE AS APPLY_RATE,
        DS.PMPL_PMP_NBR AS PMP_NBR,
        SP.TARGET_SPECIES AS TARGET_SPECIES,
        SA.COMMENTS,
        SA.SILA_FORMB_DATE,
        SA.SILA_FORMB_PRINTED,
        SA.MODIFIEDBY,
        SA.MODIFIEDON,
        RANK() OVER (
            PARTITION BY
                SA.SILA_SEQ_NBR
            ORDER BY
                SA.PLUN_PLANTING_UNIT_ID,
                SA.PLUN_SEQ_NBR,
                SAC.ACTUAL_COST_ITEM_ID,
                SAC.PLANNED_COST_ITEM_ID
            ) AS SILA_RANK,
        CASE
            WHEN SA.PLUN_SEQ_NBR = 0 THEN NULL
            ELSE SA.PLUN_SEQ_NBR
        END AS PLUN_SEQ_NBR,
        SA.SILA_SEQ_NBR,
        SA.SICA_SEQ_NBR,
        SA.CUTB_SEQ_NBR
    FROM
        LRM_REPLICATION.SILVICULTURE_COMPANY_ACTIVITY SCA
        INNER JOIN SA
        ON SCA.SICA_SEQ_NBR = SA.SICA_SEQ_NBR
        LEFT JOIN RK
        ON SA.PLUN_SEQ_NBR = RK.PLUN_SEQ_NBR
        LEFT JOIN SAC
        ON SA.SILA_SEQ_NBR = SAC.SILA_SEQ_NBR 
        AND SA.PLUN_SEQ_NBR = SAC.PLUN_SEQ_NBR
        LEFT JOIN SACT
        ON SA.SILA_SEQ_NBR = SACT.SILA_SEQ_NBR
        LEFT JOIN LRM_REPLICATION.DETAILED_SITE_ASSESSMENT DS
        ON SA.SILA_SEQ_NBR = DS.SILA_SEQ_NBR
        LEFT JOIN SP
        ON SA.SILA_SEQ_NBR = SP.SILA_SEQ_NBR
    WHERE COALESCE(SCA.SICA_KEY_IND, ' ') <> 'HV'
        AND SCA.SIAB_BASE_CODE Is Not Null
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
select distinct   -- Staff can enter multiple CSB SFIRE25 activity for a block; use DISTINCT to include the SFIRE25 activity only once per block.
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

/* Free Growing Met, Done (FG) */
FG AS
(
SELECT
    af.cutb_seq_nbr,
    af.acti_status_date AS FG_DONE

FROM
    LRM_REPLICATION.activity_class acf,
    LRM_REPLICATION.activity_type atypef,
    LRM_REPLICATION.activity af

WHERE
    acf.accl_seq_nbr = atypef.accl_seq_nbr
    AND acf.divi_div_nbr = atypef.divi_div_nbr
    AND atypef.actt_seq_nbr =  af.actt_seq_nbr
    AND atypef.actt_key_ind = 'FG'  -- Free Growing Met
    AND acf.accl_description = 'CMB'  -- Corporate Mandatory Block (CMB) activity class
    AND af.Acti_status_ind = 'D'  -- Done (D)
) 

SELECT
    CASE
        WHEN FD.DIVI_SHORT_CODE IN ('TBA', 'TPL', 'TPG', 'TSK', 'TSN', 'TCC', 'TKA', 'TKO', 'TOC') THEN 'Interior'
        WHEN FD.DIVI_SHORT_CODE IN ('TCH', 'TST', 'TSG') THEN 'Coast'
    END AS BUSINESS_AREA_REGION_CATEGORY,
    CASE
        WHEN FD.DIVI_SHORT_CODE IN ('TBA', 'TPL', 'TPG', 'TSK', 'TSN') THEN 'North Interior'
        WHEN FD.DIVI_SHORT_CODE IN ('TCC', 'TKA', 'TKO', 'TOC') THEN 'South Interior'
        WHEN FD.DIVI_SHORT_CODE IN ('TCH', 'TST', 'TSG') THEN 'Coast'
    END AS BUSINESS_AREA_REGION,
    COALESCE(NULLIF(FD.DIVI_DIVISION_NAME, 'Seaward'), 'Seaward-Tlasta') || ' (' || FD.DIVI_SHORT_CODE || ')' AS BUSINESS_AREA,
    FD.DIVI_ABBREVIATION_CODE AS BUSINESS_AREA_CODE,
    LKF.COLU_LOOKUP_DESC AS FIELD_TEAM,
    MU.MANU_ID,
    TENT.TENT_TENURE_ID AS TENURE,
    LICN.LICN_LICENCE_ID AS LICENCE,
    LS.HBS_FIRST_BILLING,
    LS.HBS_VOLUME_BILLED,
    CB.CUTB_BLOCK_ID AS BLOCK_ID,
    CB.CUTB_BLOCK_NUMBER AS BLOCK_NBR,
    CB.CUTB_SYSTEM_ID AS UBI,
    CB.CUTB_BLOCK_STATE AS BLOCK_STATE,
    CB.CUTB_OPENING,
    CB.CUTB_SITE_PLAN_EXEMPT_IND AS SP_EXEMPT,
    BLAL.BLAL_CRUISE_M3_VOL AS CRUISE_VOLUME,
    NAR.NAR_AREA,
    BIO.LARGEST_ECO_AREA,
    BIO.COUNT_BEC_WITH_LARGEST_ECO_AREA,
    BIO.BEC,
    BIO.BIO_ZONE,
    BIO.BIO_SUBZONE,
    BIO.BIO_VARIANT,
    HV.HVS_STATUS,
    HV.HVS_DATE,
    EXTRACT(YEAR FROM HV.HVS_DATE + INTERVAL '9 MONTH') AS HVS_FISCAL,
    HV.HVC_STATUS,
    HV.HVC_DATE,
    EXTRACT(YEAR FROM HV.HVC_DATE + INTERVAL '9 MONTH') AS HVC_FISCAL,
    S.SILA_TREATMENT_UNIT_ID AS TREATMENT_UNIT,
    CB.FUND_FUNDING_CODE AS BLOCK_FUNDING,
    S.ACTIVITY_FUNDING,
    S.SIAB_BASE_CODE AS BASE,
    S.SIAT_TECHNIQUE_CODE AS TECHNIQUE,
    S.SIAM_METHOD_CODE AS METHOD,
    S.SICA_ACTIVITY_NAME AS ACTIVITY,
    CASE
        WHEN S.SILA_STATUS = 'P' THEN 'PLANNED'
        WHEN S.SILA_STATUS = 'D' THEN 'DONE'
        ELSE S.SILA_STATUS
    END AS STATUS,
    S.SILA_START_DATE AS START_DATE,
    EXTRACT(YEAR FROM S.SILA_START_DATE + INTERVAL '9 MONTH') AS START_FISCAL,
    S.SILA_COMPLETION_DATE AS COMPLETE_DATE,
    EXTRACT(YEAR FROM S.SILA_COMPLETION_DATE + INTERVAL '9 MONTH') AS COMPLETE_FISCAL,
    CASE
        WHEN SILA_RANK = 1 THEN S.SILA_GROSS_HA_AREA
        ELSE NULL
    END AS TREATMENT_AREA,
    CASE
        WHEN SILA_RANK = 1 THEN ROUND(S.SILA_GROSS_HA_AREA, 1)::TEXT
        ELSE NULL
    END AS SILA_GROSS_AREA_CHAR,
    CASE
        WHEN SILA_RANK = 1 THEN
            CASE
                WHEN S.ITEMS_TOTAL_PLANNED > 0 AND S.SILA_GROSS_HA_AREA > 0 THEN ROUND(S.ITEMS_TOTAL_PLANNED / S.SILA_GROSS_HA_AREA, 2)
                ELSE S.SILA_COST_PER_HA_PLAN
            END
        ELSE NULL
    END AS COST_PER_HA_PLAN,
    CASE
        WHEN SILA_RANK = 1 THEN
            CASE
                WHEN S.ITEMS_TOTAL_ACTUAL > 0 AND S.SILA_GROSS_HA_AREA > 0 THEN ROUND(S.ITEMS_TOTAL_ACTUAL / S.SILA_GROSS_HA_AREA, 2)
                ELSE S.SILA_COST_PER_HA
            END
        ELSE NULL
    END AS COST_PER_HA,
    CASE
        WHEN SILA_RANK = 1 THEN ROUND(
            CASE
                WHEN COALESCE(S.ITEMS_TOTAL_PLANNED, 0) = 0 THEN S.SILA_COST_PER_HA_PLAN * S.SILA_GROSS_HA_AREA
                ELSE S.ITEMS_TOTAL_PLANNED
            END, 2)
        ELSE NULL
    END AS PLANNED_TOTAL_COST,
    CASE
        WHEN SILA_RANK = 1 THEN ROUND(S.SILA_GROSS_HA_AREA * S.SILA_COST_PER_HA_PLAN, 2)
        ELSE NULL
    END AS COST_PER_HA_PLAN_x_HA,
    CASE
        WHEN SILA_RANK = 1 THEN ROUND(
            CASE
                WHEN COALESCE(S.ITEMS_TOTAL_ACTUAL, 0) = 0 THEN S.SILA_COST_PER_HA * S.SILA_GROSS_HA_AREA
                ELSE S.ITEMS_TOTAL_ACTUAL
            END, 2)
        ELSE NULL
    END AS ACTUAL_TOTAL_COST,
    CASE
        WHEN SILA_RANK = 1 THEN ROUND(S.SILA_GROSS_HA_AREA * S.SILA_COST_PER_HA, 2)
        ELSE NULL
    END AS COST_PER_HA_x_HA,
    S.PLANNED_SERVICE_LINE,
    S.PLANNED_SL_DESCRIPTION,
    CASE
        WHEN SILA_RANK = 1 THEN S.ITEMS_TOTAL_PLANNED
        ELSE NULL
    END AS ITEMS_PLANNED_TOTAL_COST,
    S.ACTUAL_SERVICE_LINE,
    S.ACTUAL_SL_DESCRIPTION,
    CASE
        WHEN SILA_RANK = 1 THEN S.ITEMS_TOTAL_ACTUAL
        ELSE NULL
    END AS ITEMS_ACTUAL_TOTAL_COST,
    S.PLUN_PLANTING_UNIT_ID AS PLANTING_UNIT,
    S.PLUN_DIGITISED_IND,
    S.PLUN_PLANTING_PLAN_COST AS PLUN_PLANNED_TOTAL_COST,
    CASE
        WHEN S.SIAB_BASE_CODE = 'PL' THEN S.ITEM_TOTAL_PLANNED
        ELSE NULL
    END AS PLUN_ITEM_PLANNED_TOTAL_COST,
    S.PLUN_PLANTING_COST AS PLUN_ACTUAL_TOTAL_COST,
    CASE
        WHEN S.SIAB_BASE_CODE = 'PL' THEN S.ITEM_TOTAL_ACTUAL
        ELSE NULL
    END AS PLUN_ITEM_ACTUAL_TOTAL_COST,
    S.PLUN_HA_AREA,
    S.PLUN_NET_AREA,
    S.PLUN_DENSITY,
    S.TOTAL_TREES,
    S.SEEDLING_REQUEST,
    S.SICA_KEY_IND,
    S.PLUN_MODIFIEDBY,
    S.PLUN_MODIFIEDON,
    S.PLUN_MODIFIEDUSING,
    S.MODIFIEDBY,
    S.MODIFIEDON,
    CASE
        WHEN SILA_RANK = 1 THEN 'Y'
        ELSE 'N'
    END AS PRIMARY_RECORD,
    CASE
        WHEN art.cutb_seq_nbr IS NULL THEN 'N'
        ELSE 'Y'
    END AS Need_Planting,
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
    CASE
        WHEN salvage25.actt_key_ind IS NULL THEN NULL
        ELSE salvage25.activity_type || ' (' || salvage25.activity_class || ' - ' || salvage25.actt_key_ind || ')'
    END AS salvage_2025_fire,
    FG.FG_Done,
    S.PLUN_SEQ_NBR,
    S.SILA_SEQ_NBR,
    S.SICA_SEQ_NBR,
    BLAL.CUTB_SEQ_NBR,
    LICN.LICN_SEQ_NBR


FROM
    LRM_REPLICATION.DIVISION FD
    INNER JOIN LRM_REPLICATION.BLOCK_ALLOCATION BLAL
    ON FD.DIVI_DIV_NBR = BLAL.DIVI_DIV_NBR
    INNER JOIN LRM_REPLICATION.MANAGEMENT_UNIT MU
    ON BLAL.MANU_SEQ_NBR = MU.MANU_SEQ_NBR
    INNER JOIN LS
    ON BLAL.LICN_SEQ_NBR = LS.LICN_SEQ_NBR
    LEFT JOIN LRM_REPLICATION.LICENCE LICN
    ON BLAL.LICN_SEQ_NBR = LICN.LICN_SEQ_NBR
    LEFT JOIN LRM_REPLICATION.TENURE_TYPE TENT
    ON LICN.TENT_SEQ_NBR = TENT.TENT_SEQ_NBR
    LEFT JOIN LRM_REPLICATION.CODE_LOOKUP LKF
    ON LICN.LICN_FIELD_TEAM_ID = LKF.COLU_LOOKUP_ID
    AND LKF.COLU_LOOKUP_TYPE = 'FDTM'
    INNER JOIN LRM_REPLICATION.CUT_BLOCK CB
    ON BLAL.CUTB_SEQ_NBR = CB.CUTB_SEQ_NBR
    LEFT JOIN HV
    ON BLAL.CUTB_SEQ_NBR = HV.CUTB_SEQ_NBR
    LEFT JOIN NAR
    ON BLAL.CUTB_SEQ_NBR = NAR.CUTB_SEQ_NBR
    LEFT JOIN ART
    ON BLAL.CUTB_SEQ_NBR = ART.CUTB_SEQ_NBR
    LEFT JOIN BIO
    ON BLAL.CUTB_SEQ_NBR = BIO.CUTB_SEQ_NBR
    INNER JOIN S
    ON BLAL.CUTB_SEQ_NBR = S.CUTB_SEQ_NBR
    LEFT JOIN SALVAGE_ANY_FIRE_YEAR
    ON blal.cutb_seq_nbr = SALVAGE_ANY_FIRE_YEAR.cutb_seq_nbr
    LEFT JOIN salvage21
    ON blal.cutb_seq_nbr = salvage21.cutb_seq_nbr
    LEFT JOIN salvage22
    ON blal.cutb_seq_nbr = salvage22.cutb_seq_nbr
    LEFT JOIN salvage23
    ON blal.cutb_seq_nbr = salvage23.cutb_seq_nbr
    LEFT JOIN salvage24
    ON blal.cutb_seq_nbr = salvage24.cutb_seq_nbr
    LEFT JOIN salvage25
    ON blal.cutb_seq_nbr = salvage25.cutb_seq_nbr
    LEFT JOIN FG
    ON BLAL.CUTB_SEQ_NBR = FG.CUTB_SEQ_NBR

ORDER BY
    -- length(business_area_region) desc,
    business_area_region,
    business_area,
    MU.MANU_ID,
    LICN.LICN_LICENCE_ID,
    CB.CUTB_BLOCK_ID,
    S.SILA_SEQ_NBR,
    S.SILA_RANK
;
