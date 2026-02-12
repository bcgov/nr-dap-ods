def get_weighted_sale_term_query(start_date, end_date):
    return \
    f"""
    INSERT INTO bcts_staging.weighted_sale_term_hist(
    business_area_region_category, business_area_region, business_area, auction_fiscal, awarded_licence_volume_class, sum_awarded_licence_volume, sum_awarded_licence_volume_x_tenure_term, weighted_tenure_term, count_awarded_licences, report_start_date, report_end_date, report_run_date, report_run_timestamp
    )
    --weighted term
    with sold_licence_bid_info as 
    /* Bid Info for Sold Licences (Licences issued within reporting period) */
    (
        SELECT
            ts0.forest_file_id,
            ts0.auction_date,
            ts0.total_upset_value AS cruise_total_upset_value,
            ts0.upset_rate AS scale_upset_rate,
            ts0.sale_volume AS sale_volume,
            tb.bonus_bid AS sold_licence_bonus_bid,
            tb.bonus_offer AS sold_licence_bonus_offer,
            CASE
                WHEN ts0.total_upset_value > 0 THEN
                    ROUND(
                        ts0.total_upset_value + tb.bonus_offer,  -- Cruise-based licence pricing
                        2
                    )
                ELSE
                    ROUND(
                        (ts0.upset_rate + tb.bonus_bid) * ts0.sale_volume,  -- Scale-based licence pricing
                        2
                    )
            END AS sold_licence_maximum_value,
            tb.client_number AS sold_licence_client_number

        FROM bctsadmin_replication.bcts_timber_sale ts0
        JOIN bctsadmin_replication.bcts_tenure_bidder tb
            ON ts0.forest_file_id = tb.forest_file_id
            AND ts0.auction_date = tb.auction_date
        JOIN bcts_staging.fta_prov_forest_use pfu
            ON pfu.forest_file_id = ts0.forest_file_id
        JOIN bcts_staging.fta_tenure_term tt
            ON tt.forest_file_id = pfu.forest_file_id

        WHERE UPPER(tb.sale_awarded_ind) = 'Y'  -- Only winning bid
        AND ts0.no_sale_rationale_code IS NULL

        AND pfu.file_status_st IN (
                'HI',  -- Issued
                'HC',  -- Closed
                'LC',  -- Logging Complete
                'HX',  -- Cancelled
                'HS',  -- Suspended
                'HRS'  -- Harvesting Rights Surrendered
        )

        -- Tenure term legal effective date in reporting period
        AND tt.legal_effective_dt BETWEEN To_Date('{start_date}', 'YYYY-MM-DD')
                                    AND To_Date('{end_date}', 'YYYY-MM-DD')
    ),
    awarded_sale_info as
    /* Bid Info for Successful Auctions (Licences awarded within reporting period) */
    (
        SELECT
            ts1.forest_file_id,
            ts1.auction_date,
            ts1.total_upset_value AS cruise_total_upset_value,
            ts1.upset_rate AS scale_upset_rate,
            ts1.sale_volume AS sale_volume,
            tb.bonus_bid AS awarded_sale_bonus_bid,
            tb.bonus_offer AS awarded_sale_bonus_offer,
            CASE
                WHEN ts1.total_upset_value > 0 THEN
                    ROUND(
                        ts1.total_upset_value + tb.bonus_offer,  -- Cruise-based licence pricing
                        2
                    )
                ELSE
                    ROUND(
                        (ts1.upset_rate + tb.bonus_bid) * ts1.sale_volume,  -- Scale-based licence pricing
                        2
                    )
            END AS awarded_licence_maximum_value,
            tb.client_number AS awarded_licence_client_number

        FROM bctsadmin_replication.bcts_timber_sale ts1
        JOIN bctsadmin_replication.bcts_tenure_bidder tb
            ON ts1.forest_file_id = tb.forest_file_id
            AND ts1.auction_date = tb.auction_date

        WHERE UPPER(tb.sale_awarded_ind) = 'Y'  -- Only winning bid
        AND ts1.auction_date BETWEEN To_Date('{start_date}', 'YYYY-MM-DD')
                                AND To_Date('{end_date}', 'YYYY-MM-DD')
    ), 
    per_licence as 
        (
        SELECT DISTINCT
            CASE
                WHEN ou.org_unit_code IN ('TBA', 'TPL', 'TPG', 'TSK', 'TSN', 'TCC', 'TKA', 'TKO', 'TOC')
                THEN 'Interior'
                WHEN ou.org_unit_code IN ('TCH', 'TST', 'TSG')
                THEN 'Coast'
            END AS Business_Area_Region_Category,
            CASE
                WHEN ou.org_unit_code IN ('TBA', 'TPL', 'TPG', 'TSK', 'TSN')
                THEN 'North Interior'
                WHEN ou.org_unit_code IN ('TCC', 'TKA', 'TKO', 'TOC')
                THEN 'South Interior'
                WHEN ou.org_unit_code IN ('TCH', 'TST', 'TSG')
                THEN 'Coast'
            END AS Business_Area_Region,
            COALESCE(
                REPLACE(
                    CASE
                        WHEN ou.org_unit_name = 'Seaward Timber Sales Office' THEN 'Seaward-Tlasta'
                        ELSE ou.org_unit_name
                    END || ' (' || ou.org_unit_code || ')',
                    ' Timber Sales Office',
                    ''
                ),
                NULL
            ) AS Business_Area,
            ou.org_unit_code AS Business_Area_Code,
            ts.forest_file_id,
            pfu.file_type_code,
            CASE
                WHEN cc.description IS NULL THEN ts.bcts_category_code
                ELSE cc.description || ' (' || ts.bcts_category_code || ')'
            END AS BCTS_Category,
            ts.auction_date AS BCTS_Admin_Auction_Date,
            EXTRACT(YEAR FROM ts.auction_date + INTERVAL '9 months') AS Auction_Fiscal,  -- fiscal year offset by 9 months
            CASE
                WHEN ts.auction_date IS NULL THEN NULL
                ELSE 'Q' || CEIL(EXTRACT(MONTH FROM ts.auction_date - INTERVAL '3 months') / 3.0)
            END AS Auction_Quarter,
            tt.legal_effective_dt AS FTA_Legal_Effective_Date,
            EXTRACT(YEAR FROM tt.legal_effective_dt + INTERVAL '9 months') AS Legal_Effective_Fiscal,
            CASE
                WHEN tt.legal_effective_dt IS NULL THEN NULL
                ELSE 'Q' || CEIL(EXTRACT(MONTH FROM tt.legal_effective_dt - INTERVAL '3 months') / 3.0)
            END AS Legal_Effective_Quarter,
            tt.tenure_term,
            sold_licence_bid_info.sale_volume AS sold_licence_volume,
            tt.tenure_term * sold_licence_bid_info.sale_volume AS sold_licence_volume_X_tenure_term,

            fc_sold.client_number AS sold_licence_client_number,
            COALESCE(
                fc_sold.legal_first_name || ' ', ''
            ) || COALESCE(
                fc_sold.legal_middle_name || ' ', ''
            ) || fc_sold.client_name AS sold_licence_client_name,

            awarded_sale_info.sale_volume AS awarded_licence_volume,
            CASE
                WHEN awarded_sale_info.sale_volume <= 5000 THEN '0.0 to 5,000.0 m3'
                WHEN awarded_sale_info.sale_volume <= 15000 THEN '5,000.1 to 15,000.0 m3'
                WHEN awarded_sale_info.sale_volume <= 30000 THEN '15,000.1 to 30,000.0 m3'
                WHEN awarded_sale_info.sale_volume <= 75000 THEN '30,000.1 to 75,000.0 m3'
                ELSE '75,000.1 m3 and above'
            END AS awarded_licence_volume_class,
            CASE
                WHEN awarded_sale_info.sale_volume <= 5000 THEN 1
                WHEN awarded_sale_info.sale_volume <= 15000 THEN 2
                WHEN awarded_sale_info.sale_volume <= 30000 THEN 3
                WHEN awarded_sale_info.sale_volume <= 75000 THEN 4
                ELSE 5
            END AS awarded_licence_volume_class_sort_order,
            tt.tenure_term * awarded_sale_info.sale_volume AS awarded_licence_volume_X_tenure_term,

            fc_awarded.client_number AS awarded_licence_client_number,
            COALESCE(
                fc_awarded.legal_first_name || ' ', ''
            ) || COALESCE(
                fc_awarded.legal_middle_name || ' ', ''
            ) || fc_awarded.client_name AS awarded_licence_client_name,

            CASE
                WHEN pfu.file_status_st IS NOT NULL THEN tfsc.description || ' (' || pfu.file_status_st || ')'
                ELSE NULL
            END AS FTA_File_Status,
            pfu.file_status_date AS FTA_File_Status_Date,

            CASE
                WHEN ts.no_sale_rationale_code IS NULL
                    AND pfu.file_status_st IN (
                        'HI',  -- Issued
                        'HC',  -- Closed
                        'LC',  -- Logging Complete
                        'HX',  -- Cancelled
                        'HS',  -- Suspended
                        'HRS'  -- Harvesting Rights Surrendered
                    )
                    AND tt.legal_effective_dt BETWEEN To_Date('{start_date}', 'YYYY-MM-DD') AND To_Date('{end_date}', 'YYYY-MM-DD')  -- reporting period
                THEN 'Y'
                ELSE 'N'
            END AS Sold_in_Report_Period,

            CASE
                WHEN ts.auction_date BETWEEN To_Date('{start_date}', 'YYYY-MM-DD') AND To_Date('{end_date}', 'YYYY-MM-DD')
                THEN 'Y'
                ELSE 'N'
            END AS Auction_in_Report_Period,

            CASE
                WHEN pfu.file_type_code = 'B20' THEN NULL
                ELSE pfu.file_type_code
            END AS QA_non_B20_licence,

            CASE
                WHEN ts.auction_date > CURRENT_DATE THEN 'Future auction (BCTS Admin)'
                WHEN (sold_licence_bid_info.sold_licence_maximum_value IS NULL OR sold_licence_bid_info.sold_licence_maximum_value = 0)
                    AND (awarded_sale_info.awarded_licence_maximum_value IS NULL OR awarded_sale_info.awarded_licence_maximum_value = 0)
                    AND ts.no_sale_rationale_code IS NULL
                THEN 'Auction result data missing (BCTS Admin)'
            END AS QA_auction_results_missing_bcts_admin

        FROM bcts_staging.fta_tenure_term tt
        LEFT JOIN bctsadmin_replication.bcts_timber_sale ts
            ON ts.forest_file_id = tt.forest_file_id
        LEFT JOIN bcts_staging.fta_prov_forest_use pfu
            ON ts.forest_file_id = pfu.forest_file_id
        LEFT JOIN bcts_staging.fta_org_unit ou
            ON pfu.bcts_org_unit = ou.org_unit_no
        LEFT JOIN bcts_staging.fta_tenure_file_status_code tfsc
            ON pfu.file_status_st = tfsc.tenure_file_status_code
        LEFT JOIN bctsadmin_replication.bcts_category_code cc
            ON ts.bcts_category_code = cc.bcts_category_code
        LEFT JOIN sold_licence_bid_info
            ON ts.forest_file_id = sold_licence_bid_info.forest_file_id
            AND ts.auction_date = sold_licence_bid_info.auction_date
        LEFT JOIN awarded_sale_info
            ON ts.forest_file_id = awarded_sale_info.forest_file_id
            AND ts.auction_date = awarded_sale_info.auction_date
        LEFT JOIN mofclient_replication.v_client_public fc_sold
            ON sold_licence_bid_info.sold_licence_client_number = fc_sold.client_number
        LEFT JOIN mofclient_replication.v_client_public fc_awarded
            ON awarded_sale_info.awarded_licence_client_number = fc_awarded.client_number

        WHERE
            
                -- Criteria for Licences Sold in reporting period
                (ts.no_sale_rationale_code IS NULL
                AND pfu.file_status_st IN ('HI','HC','LC','HX','HS','HRS')
                AND tt.legal_effective_dt BETWEEN To_Date('{start_date}', 'YYYY-MM-DD') AND To_Date('{end_date}', 'YYYY-MM-DD')
                -- Criteria for auctions within the reporting period
                OR ts.auction_date BETWEEN To_Date('{start_date}', 'YYYY-MM-DD') AND To_Date('{end_date}', 'YYYY-MM-DD')
            
    ) 
    select
        Business_Area_Region_Category,
        Business_Area_Region,
        Business_Area,
        Auction_Fiscal,
        awarded_licence_volume_class,
        sum(awarded_licence_volume) as sum_awarded_licence_volume,
        sum(awarded_licence_volume_X_tenure_term) as sum_awarded_licence_volume_X_tenure_term,
        round(
            sum(awarded_licence_volume_X_tenure_term) / sum(awarded_licence_volume),
            1
        ) as weighted_tenure_term,
        count(awarded_licence_volume) as count_awarded_licences,
        '{start_date}'::Date as report_start_date,
        '{end_date}'::Date as report_end_date,
        report_run_date date DEFAULT CURRENT_DATE,
        report_run_timestamp timestamp DEFAULT CURRENT_TIMESTAMP AT TIME ZONE 'PST'

    from per_licence

    group by
        Business_Area_Region_Category,
        Business_Area_Region,
        Business_Area,
        Auction_Fiscal,
        awarded_licence_volume_class,
        awarded_licence_volume_class_sort_order

    ORDER BY
        business_area_region_category desc,
        business_area_region,
        business_area,
        auction_fiscal desc,
        awarded_licence_volume_class_sort_order
    ;
    """
