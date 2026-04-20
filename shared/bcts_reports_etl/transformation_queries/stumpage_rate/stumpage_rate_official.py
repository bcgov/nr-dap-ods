
def get_stumpage_rate_official_query(start_date, end_date):
    return \
    f"""
    SELECT
        data.*,
        CASE
            WHEN data.total_upset_value IS NULL
                THEN data.upset_rate + data.bonus_bid
        END AS total_stumpage_m3,
        CASE
            WHEN data.total_upset_value IS NOT NULL
                THEN data.total_upset_value + data.bonus_offer
        END AS total_stumpage_value,
        '{start_date}'::Date as report_start_date,
        '{end_date}'::Date as report_end_date
    FROM (
        SELECT DISTINCT
            CASE
                WHEN ou.org_unit_code IN ('TBA','TPL','TPG','TSK','TSN','TCC','TKA','TKO','TOC')
                    THEN 'Interior'
                WHEN ou.org_unit_code IN ('TCH','TST','TSG')
                    THEN 'Coast'
            END AS business_area_region_category,

            CASE
                WHEN ou.org_unit_code IN ('TBA','TPL','TPG','TSK','TSN')
                    THEN 'North Interior'
                WHEN ou.org_unit_code IN ('TCC','TKA','TKO','TOC')
                    THEN 'South Interior'
                WHEN ou.org_unit_code IN ('TCH','TST','TSG')
                    THEN 'Coast'
            END AS business_area_region,

            REPLACE(
                (
                    CASE
                        WHEN ou.org_unit_name = 'Seaward Timber Sales Office'
                            THEN 'Seaward-Tlasta'
                        ELSE ou.org_unit_name
                    END
                    || ' (' || ou.org_unit_code || ')'
                ),
                ' Timber Sales Office',
                ''
            ) AS business_area,

            ou.org_unit_code AS business_area_code,
            ts.forest_file_id,
            ts.bcts_category_code,
            ts.auction_date,
            tt.legal_effective_dt,
            ts.sale_volume,
            ts.upset_rate,
            ts.total_upset_value,
            bid_info.bonus_bid,
            bid_info.bonus_offer,
            bid_info.client_count,
            pfu.file_status_st
        FROM bctsadmin_replication.bcts_timber_sale ts
        -- Oracle: ts.BCTS_CATEGORY_CODE = c.BCTS_CATEGORY_CODE (+)
        LEFT JOIN bctsadmin_replication.bcts_category_code c
            ON ts.bcts_category_code = c.bcts_category_code

        -- Oracle: ts.forest_file_id = pfu.forest_file_id (inner join)
        JOIN bcts_staging.fta_prov_forest_use pfu
            ON ts.forest_file_id = pfu.forest_file_id

        JOIN bcts_staging.fta_org_unit ou
            ON pfu.bcts_org_unit = ou.org_unit_no

        -- Oracle: pfu.mgmt_unit_id = ta.tsa_number (+)
        LEFT JOIN bcts_staging.fta_tsa_number_code ta
            ON pfu.mgmt_unit_id = ta.tsa_number

        -- Oracle: pfu.mgmt_unit_id = tf.tfl_number (+)
        LEFT JOIN bcts_staging.fta_tfl_number_code tf
            ON pfu.mgmt_unit_id = tf.tfl_number

        -- Oracle: pfu.forest_file_id = tt.forest_file_id (+)
        LEFT JOIN bcts_staging.fta_tenure_term tt
            ON pfu.forest_file_id = tt.forest_file_id

        -- Oracle: ts.forest_file_id = tm.forest_file_id (+)
        LEFT JOIN bcts_staging.fta_timber_mark tm
            ON ts.forest_file_id = tm.forest_file_id

        -- Oracle: tm.FOREST_DISTRICT = ou1.org_unit_no (+)
        LEFT JOIN bcts_staging.fta_org_unit ou1
            ON tm.forest_district = ou1.org_unit_no

        -- Inline view (bid_info) + Oracle outer join (+)
        LEFT JOIN (
            SELECT
                bd.forest_file_id,
                bd.auction_date,
                MAX(CASE WHEN bd.sale_awarded_ind = 'Y' THEN bd.bonus_bid   ELSE 0 END) AS bonus_bid,
                MAX(CASE WHEN bd.sale_awarded_ind = 'Y' THEN bd.bonus_offer ELSE 0 END) AS bonus_offer,
                COUNT(DISTINCT bd.client_number) AS client_count
            FROM bctsadmin_replication.bcts_timber_sale ts0
            JOIN bctsadmin_replication.bcts_tenure_bidder bd
                ON ts0.forest_file_id = bd.forest_file_id
            WHERE bd.ineligible_ind = 'N'
            GROUP BY
                bd.forest_file_id,
                bd.auction_date
        ) bid_info
            ON ts.forest_file_id = bid_info.forest_file_id
        AND ts.auction_date   = bid_info.auction_date

        WHERE
            ts.auction_date BETWEEN DATE '2025-04-01'  -- beginning of current fiscal
                            AND DATE '2025-10-31'  -- end of reporting period
            AND ts.no_sale_rationale_code IS NULL
            AND pfu.file_status_st IN ('HI', 'HC', 'LC', 'HX', 'HS', 'HRS')
    ) AS data








    INSERT INTO BCTS_STAGING.stumpage_rate_official (
    )
    
        '{start_date}'::Date as report_start_date,
        '{end_date}'::Date as report_end_date,
      
    where
        ts.auction_date
            BETWEEN To_Date('{start_date}', 'YYYY-MM-DD')  -- Date: beginning of reporting period, usually beginning of current fiscal
            AND To_Date('{end_date}', 'YYYY-MM-DD')  -- Date: end of reporting period
        AND COALESCE(ts.no_sale_rationale_code, ' ') <> 'TB'  -- Exclude tied bid (TB) auctions.
    order by
        -- length(business_area_region) desc,
        business_area_region,
        business_area,
        ts.forest_file_id,
        ts.auction_date
    ;
        
"""
