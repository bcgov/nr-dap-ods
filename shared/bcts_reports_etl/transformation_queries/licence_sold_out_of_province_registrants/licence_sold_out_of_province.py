def get_licence_sold_out_of_province_query(start_date, end_date):
    return \
    f"""
    INSERT INTO bcts_staging.licence_sold_to_out_of_province_registrants_hist(
    management_unit, forest_file_id, bcts_category_code, legal_effective_date, auction_date, sale_volume, client_number, licensee_name, licensee_address, postal_code, city, province, country, client_locn_code, forest_file_client_type_code, registry_company_type_code, registrant_expiry_date, client_comment, org_unit_code, mgmt_unit_type, mgmt_unit_id, category, file_status_st, fiscal_issued, upset_rate, total_upset_value, bonus_bid, bonus_offer, report_start_date, report_end_date
    )
    WITH licence_info AS
    (
        SELECT DISTINCT
            ou.org_unit_code,
            pfu.mgmt_unit_type,
            pfu.mgmt_unit_id,
            CASE
                WHEN pfu.mgmt_unit_type = 'U' THEN ta.description
                ELSE tf.description
            END AS management_unit,
            ts.forest_file_id,
            ts.bcts_category_code,
            c.description AS category,
            pfu.file_status_st,
            tt.legal_effective_dt,
            EXTRACT(YEAR FROM (tt.legal_effective_dt + INTERVAL '9 months')) AS fiscal_issued,
            ts.auction_date,
            ts.sale_volume,
            ts.upset_rate,
            ts.total_upset_value,
            btb.bonus_bid,
            btb.bonus_offer,
            ffc.client_number,
            ffc.client_locn_code
        FROM bctsadmin_replication.bcts_timber_sale        AS ts
        LEFT JOIN bctsadmin_replication.bcts_category_code AS c
            ON ts.bcts_category_code = c.bcts_category_code
        LEFT JOIN bctsadmin_replication.bcts_tenure_bidder AS btb
            ON ts.forest_file_id = btb.forest_file_id
            AND ts.auction_date   = btb.auction_date
            AND btb.sale_awarded_ind = 'Y'
        LEFT JOIN mofclient_replication.v_client_public      AS fc
            ON btb.client_number = fc.client_number
        JOIN bcts_staging.fta_forest_file_client      AS ffc
            ON ts.forest_file_id = ffc.forest_file_id
        JOIN mofclient_replication.client_location         AS cl
            ON ffc.client_number   = cl.client_number
            AND ffc.client_locn_code = cl.client_locn_code
        JOIN mofclient_replication.v_client_public           AS fc2
            ON cl.client_number = fc2.client_number
        JOIN bcts_staging.fta_prov_forest_use         AS pfu
            ON ts.forest_file_id = pfu.forest_file_id
        JOIN bcts_staging.fta_org_unit                AS ou
            ON pfu.bcts_org_unit = ou.org_unit_no
        LEFT JOIN bcts_staging.fta_tsa_number_code    AS ta
            ON pfu.mgmt_unit_id = ta.tsa_number
        LEFT JOIN bcts_staging.fta_tfl_number_code    AS tf
            ON pfu.mgmt_unit_id = tf.tfl_number
        LEFT JOIN bcts_staging.fta_tenure_term        AS tt
            ON pfu.forest_file_id = tt.forest_file_id
        WHERE pfu.file_status_st IN ('HI', 'HC', 'LC', 'HX', 'HS', 'HRS')
        AND ts.no_sale_rationale_code IS NULL
        AND AND tt.legal_effective_dt BETWEEN To_Date ('{start_date}', 'YYYY-MM-DD') -- Report period start date
            AND To_Date  ('{end_date}', 'YYYY-MM-DD') -- Report period end date
        ORDER BY tt.legal_effective_dt DESC
    ) 

    SELECT DISTINCT
        licence_info.Management_Unit,
        licence_info.Forest_File_Id,
        licence_info.BCTS_Category_Code,
        licence_info.legal_effective_dt AS Legal_Effective_Date,
        licence_info.auction_date,
        licence_info.sale_volume,
        br.client_number,
        CASE
            WHEN fc.legal_first_name IS NOT NULL
            AND fc.legal_middle_name IS NOT NULL THEN fc.legal_first_name || ' ' || fc.legal_middle_name || ' ' || FC.CLIENT_NAME
            WHEN fc.legal_first_name IS NOT NULL THEN fc.legal_first_name || ' ' || FC.CLIENT_NAME
            ELSE FC.CLIENT_NAME
        END AS Licensee_Name,
        CONCAT_WS(' ', CL.address_1, CL.address_2, CL.address_3) AS licensee_address,
        CL.POSTAL_CODE,
        CL.City,
        CL.PROVINCE,
        CL.COUNTRY,
        br.CLIENT_LOCN_CODE,
        FFC.FOREST_FILE_CLIENT_TYPE_CODE,
        NULL AS REGISTRY_COMPANY_TYPE_CODE,
        br.registrant_expiry_date,
        NULL AS CLIENT_COMMENT,
        licence_info.org_unit_code,
        licence_info.MGMT_UNIT_TYPE,
        licence_info.mgmt_unit_id,
        licence_info.Category,
        licence_info.file_status_st,
        licence_info.Fiscal_Issued,
        licence_info.UPSET_RATE,
        licence_info.TOTAL_UPSET_VALUE,
        licence_info.BONUS_BID,
        licence_info.bonus_offer,
        '{start_date}'::Date as report_start_date,
        '{end_date}'::Date as report_end_date

    FROM bctsadmin_replication.bcts_registrant      AS br
    JOIN mofclient_replication.client_location      AS cl
    ON br.client_number   = cl.client_number
    AND br.client_locn_code = cl.client_locn_code
    JOIN bcts_staging.fta_forest_file_client   AS ffc
    ON br.client_number   = ffc.client_number
    AND br.client_locn_code = ffc.client_locn_code
    JOIN mofclient_replication.v_client_public        AS fc
    ON br.client_number = fc.client_number
    JOIN licence_info
    ON br.client_number   = licence_info.client_number
    AND br.client_locn_code = licence_info.client_locn_code
    WHERE
    /* Registrant criteria */
    ffc.forest_file_client_type_code = 'A'  -- Licensee client type
    AND cl.province <> 'BC'               -- Registrants outside BC

    ORDER BY
        licence_info.legal_effective_dt DESC,
        licensee_name,
        licence_info.auction_date DESC,
        licence_info.forest_file_id;
    """
