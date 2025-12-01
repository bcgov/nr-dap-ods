def get_licence_transfer_query(start_date, end_date):
    return \
    f"""
    INSERT INTO bcts_staging.licence_transfer_hist(
	business_area_region, business_area, management_unit_type, management_unit_id, management_unit, forest_file_id, bcts_category_code, category, auction_date, sale_volume, fta_file_status, legal_effective_date, client_number, client_name, client_type, registry_company_type_code, licensee_start_date, licensee_end_date, revision_count, licensee_order,report_start_date, report_end_date)
    WITH CL AS
    (
            SELECT
                ff.FOREST_FILE_ID,
                ff.CLIENT_NUMBER,
                ff.LICENSEE_START_DATE,
                ff.LICENSEE_END_DATE,
                ff.REVISION_COUNT,
                fc.legal_first_name,
                fc.legal_middle_name,
                fc.CLIENT_NAME,
                ff.FOREST_FILE_CLIENT_TYPE_CODE,
                FC.CLIENT_ACRONYM,
                fc.REGISTRY_COMPANY_TYPE_CODE
            FROM
                BCTS_STAGING.FTA_FOREST_FILE_CLIENT ff,
                MOFCLIENT_REPLICATION.V_CLIENT_PUBLIC FC 
            WHERE
                ff.CLIENT_NUMBER = FC.CLIENT_NUMBER
                AND FC.CLIENT_NAME NOT LIKE ('TIMBER SALES MANAGER%')
        ),
    CC AS
        (
            SELECT
                FF1.FOREST_FILE_ID,
                COUNT(DISTINCT FF1.CLIENT_NUMBER) CLIENT_COUNT
            FROM
                BCTS_STAGING.FTA_FOREST_FILE_CLIENT FF1,
                MOFCLIENT_REPLICATION.V_CLIENT_PUBLIC FC1,
                BCTS_STAGING.FTA_tenure_term TT1
            WHERE
                FF1.CLIENT_NUMBER = FC1.CLIENT_NUMBER
                AND ff1.forest_file_id = TT1.forest_file_id
                AND FC1.CLIENT_NAME NOT LIKE ('TIMBER SALES MANAGER%')
                AND FF1.FOREST_FILE_ID IN (
                    SELECT
                        FF0.FOREST_FILE_ID
                    FROM
                        BCTS_STAGING.FTA_FOREST_FILE_CLIENT FF0
                    WHERE
                        FF0.LICENSEE_START_DATE BETWEEN To_Date ('{start_date}', 'YYYY-MM-DD') -- Report period start date
    AND To_Date  ('{end_date}', 'YYYY-MM-DD') -- Report period end date
                )
            GROUP BY
                FF1.FOREST_FILE_ID
            HAVING
                COUNT(*) > 1
                AND COUNT(DISTINCT FF1.FOREST_FILE_CLIENT_TYPE_CODE) > 1
                AND max(FF1.licensee_start_date) >= max(TT1.LEGAL_EFFECTIVE_DT) -- Latest licensee start date after licence issuance, indicating the previous licensee was not sold the licence.
        ) 

    SELECT DISTINCT
        CASE
            WHEN ou.org_unit_code IN ('TBA', 'TPL', 'TPG', 'TSK', 'TSN') THEN 'North Interior'
            WHEN ou.org_unit_code IN ('TCC', 'TKA', 'TKO', 'TOC') THEN 'South Interior'
            WHEN ou.org_unit_code IN ('TCH', 'TST', 'TSG') THEN 'Coast'
        END AS business_area_region,

        REPLACE(
            CASE
                WHEN ou.org_unit_name = 'Seaward Timber Sales Office' THEN 'Seaward/Tlasta'
                ELSE ou.org_unit_name
            END || ' (' || ou.org_unit_code || ')',
            ' Timber Sales Office',
            ''
        ) AS business_area,

        CASE
            WHEN mutc.description IS NULL THEN pfu.mgmt_unit_type
            ELSE mutc.description || ' (' || pfu.mgmt_unit_type || ')'
        END AS management_unit_type,

        pfu.mgmt_unit_id AS management_unit_id,

        CASE
            WHEN pfu.mgmt_unit_type = 'U' THEN ta.description
            ELSE tf.description
        END AS management_unit,

        ts.forest_file_id,
        ts.bcts_category_code,
        c.description AS category,
        ts.auction_date,
        ts.sale_volume,

        tfsc.description || ' (' || pfu.file_status_st || ')' AS fta_file_status,
        tt.legal_effective_dt AS legal_effective_date,
        cl.client_number,

        COALESCE(cl.legal_first_name || ' ', '') ||
        COALESCE(cl.legal_middle_name || ' ', '') ||
        cl.client_name AS client_name,

        CASE
            WHEN fctc.description IS NULL THEN cl.forest_file_client_type_code
            ELSE fctc.description || ' (' || cl.forest_file_client_type_code || ')'
        END AS client_type,

        cl.registry_company_type_code,
        cl.licensee_start_date,
        cl.licensee_end_date,
        cl.revision_count,

        RANK() OVER (
            PARTITION BY ts.forest_file_id
            ORDER BY cl.licensee_start_date
        ) AS licensee_order,
        '{start_date}'::Date as report_start_date,
        '{end_date}'::Date as report_end_date
    FROM bctsadmin_replication.bcts_timber_sale ts
    INNER JOIN BCTS_STAGING.FTA_prov_forest_use pfu 
    ON ts.forest_file_id = pfu.forest_file_id
    INNER JOIN BCTS_STAGING.FTA_org_unit ou 
    ON pfu.bcts_org_unit = ou.org_unit_no
    INNER JOIN CL 
    ON ts.forest_file_id = CL.forest_file_id
    INNER JOIN CC ON 
    ts.forest_file_id = CC.forest_file_id
    LEFT JOIN BCTS_STAGING.FTA_tenure_file_status_code tfsc 
    ON pfu.file_status_st = tfsc.tenure_file_status_code
    LEFT JOIN BCTS_STAGING.FTA_file_client_type_code fctc 
    ON cl.forest_file_client_type_code = fctc.file_client_type_code
    LEFT JOIN BCTS_STAGING.FTA_mgmt_unit_type_code mutc 
    ON pfu.mgmt_unit_type = mutc.mgmt_unit_type_code
    LEFT JOIN BCTS_STAGING.FTA_tsa_number_code ta 
    ON pfu.mgmt_unit_id = ta.tsa_number
    LEFT JOIN BCTS_STAGING.FTA_tfl_number_code tf 
    ON pfu.mgmt_unit_id = tf.tfl_number
    LEFT JOIN BCTS_STAGING.FTA_tenure_term tt 
    ON pfu.forest_file_id = tt.forest_file_id
    LEFT JOIN bctsadmin_replication.BCTS_CATEGORY_CODE c 
    ON ts.BCTS_CATEGORY_CODE = c.BCTS_CATEGORY_CODE

    WHERE pfu.file_status_st IN ('HI', 'HC', 'LC', 'HX', 'HS', 'HRS')
    AND ts.no_sale_rationale_code IS NULL
    ORDER BY
    -- length (business_area_region) DESC,
    business_area_region,
    business_area,
    ts.forest_file_id,
    CL.LICENSEE_START_DATE DESC;
    """
