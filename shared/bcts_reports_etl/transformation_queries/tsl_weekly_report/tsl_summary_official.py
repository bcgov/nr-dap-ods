def get_tsl_summary_official_query(start_date, end_date):
    return \
    f"""
    INSERT INTO bcts_staging.tsl_summary_official(
	business_area_region_category, business_area_region, business_area, business_area_code, forest_file_id, status, volume_advertised_m3, volume_readvertised_m3, last_auction_date, last_auction_bcts_category_code, last_auction_volume, auction_count_all_time_to_report_period_end, bidder_count, readvertised_auction, no_bid, no_bid_info, upset_rate_value, bonus_bid_offer, report_start_date, report_end_date
	)
    WITH all_auctions_to_date AS (
        SELECT
            ts.forest_file_id,
            COUNT(ts.auction_date) AS auction_count_all_time_to_report_period_end,
            MIN(ts.auction_date) AS first_auction_date,
            MAX(ts.auction_date) AS last_auction_date
        FROM
            bctsadmin_replication.bcts_timber_sale ts
        WHERE
            coalesce(no_sale_rationale_code, ' ') <> 'TB'
            AND auction_date <= TO_DATE('{end_date}', 'YYYY-MM-DD')
        GROUP BY
            ts.forest_file_id
    ),
    first_auction AS (
        SELECT
            forest_file_id,
            auction_date,
            bcts_category_code,
            sale_volume
        FROM
            bctsadmin_replication.bcts_timber_sale ts
    ),
    last_auction AS (
        SELECT
            forest_file_id,
            MAX(auction_date) AS last_auction_date
        FROM
            bctsadmin_replication.bcts_timber_sale ts
        WHERE
            coalesce(no_sale_rationale_code, ' ') <> 'TB'
            AND auction_date BETWEEN TO_DATE('{start_date}', 'YYYY-MM-DD')
                AND TO_DATE('{end_date}', 'YYYY-MM-DD')
        GROUP BY
            forest_file_id
    ),
    advertised AS (
        SELECT
            ts.forest_file_id,
            all_auctions_to_date.first_auction_date,
            last_auction.last_auction_date,
            all_auctions_to_date.auction_count_all_time_to_report_period_end,
            first_auction.bcts_category_code AS first_bcts_category_code,
            ts.bcts_category_code AS last_auction_bcts_category_code,
            first_auction.sale_volume AS first_auction_volume,
            ts.sale_volume AS last_auction_volume
        FROM
            bctsadmin_replication.bcts_timber_sale ts
            left join bctsadmin_replication.no_sale_rationale_code nsrc
            ON ts.no_sale_rationale_code = nsrc.no_sale_rationale_code
            INNER JOIN all_auctions_to_date
            ON ts.forest_file_id = all_auctions_to_date.forest_file_id
            AND ts.auction_date = all_auctions_to_date.last_auction_date
            INNER JOIN last_auction
            ON ts.forest_file_id = last_auction.forest_file_id
            INNER JOIN first_auction
            ON ts.forest_file_id = first_auction.forest_file_id
            AND all_auctions_to_date.first_auction_date = first_auction.auction_date
    )
    SELECT DISTINCT
        qo.business_area_region_category,
        qo.business_area_region,
        qo.business_area,
        qo.business_area_code,
        qo.forest_file_id,
        qo.status,
        CASE
            WHEN qo.auction_count_all_time_to_report_period_end = 1 THEN qo.last_auction_volume
            ELSE NULL
        END AS volume_advertised_m3,
        CASE
            WHEN qo.auction_count_all_time_to_report_period_end > 1 THEN qo.last_auction_volume
            ELSE NULL
        END AS volume_readvertised_m3,
        qo.last_auction_date,
        qo.last_auction_bcts_category_code,
        qo.last_auction_volume,
        auction_count_all_time_to_report_period_end,
        CASE
            WHEN COALESCE(bidder_count.bidder_count, 0) > 0 THEN CAST(bidder_count.bidder_count AS TEXT)
            WHEN COALESCE(bidder_count.bidder_count, 0) = 0 THEN '0'
            ELSE ''
        END AS bidder_count,
        CASE
            WHEN qo.auction_count_all_time_to_report_period_end > 1 THEN 'Y'
            WHEN qo.auction_count_all_time_to_report_period_end = 1 THEN 'N'
            WHEN auction_count_all_time_to_report_period_end IS NULL THEN ''
        END AS readvertised_auction,
        CASE
            WHEN COALESCE(bidder_count.bidder_count, 0) > 0 THEN ''
            WHEN ts_max.auction_date > CURRENT_DATE OR auction_count_all_time_to_report_period_end IS NULL THEN ''
            ELSE 'Y'
        END AS no_bid,

        CASE
            WHEN COALESCE(bidder_count.bidder_count, 0) > 0 THEN 'N'
            WHEN ts_max.auction_date > CURRENT_DATE OR auction_count_all_time_to_report_period_end IS NULL THEN ''
            ELSE 'Y'
        END AS no_bid_info,

        CASE
            WHEN qo.cruise_based = 'N' THEN ts_max.upset_rate
            ELSE ts_max.total_upset_value
        END AS upset_rate_value,
        CASE
            WHEN qo.cruise_based = 'N' THEN qo.bonus_bid
            ELSE qo.bonus_offer
        END AS bonus_bid_offer,
        '{start_date}'::Date as report_start_date,
        '{end_date}'::Date as report_end_date
    FROM (
        SELECT DISTINCT
            CASE
                WHEN ou.org_unit_code IN ('TBA', 'TPL', 'TPG', 'TSK', 'TSN', 'TCC', 'TKA', 'TKO', 'TOC') THEN 'Interior'
                WHEN ou.org_unit_code IN ('TCH', 'TST', 'TSG') THEN 'Coast'
            END AS business_area_region_category,
            CASE
                WHEN ou.org_unit_code IN ('TBA', 'TPL', 'TPG', 'TSK', 'TSN') THEN 'North Interior'
                WHEN ou.org_unit_code IN ('TCC', 'TKA', 'TKO', 'TOC') THEN 'South Interior'
                WHEN ou.org_unit_code IN ('TCH', 'TST', 'TSG') THEN 'Coast'
            END AS business_area_region,
            CASE
                WHEN ou.org_unit_code IS NULL THEN NULL
                ELSE REPLACE(
                    CASE
                        WHEN ou.org_unit_name = 'Seaward Timber Sales Office' THEN 'Seaward-Tlasta'
                        ELSE ou.org_unit_name
                    END || ' (' || ou.org_unit_code || ')',
                    ' Timber Sales Office',
                    ''
                )
            END AS business_area,
            ou.org_unit_code AS business_area_code,
            pfu.forest_file_id,
            NULL AS status,
            ts.auction_date,
            ts.upset_rate AS upset_rate,
            tb.bonus_bid AS bonus_bid,
            tm.cruise_based_ind AS cruise_based,
            ts.total_upset_value,
            tb1.bonus_offer AS bonus_offer,
            advertised.auction_count_all_time_to_report_period_end,
            advertised.first_auction_date,
            advertised.first_bcts_category_code,
            advertised.first_auction_volume,
            advertised.last_auction_date,
            advertised.last_auction_bcts_category_code,
            advertised.last_auction_volume,
            CASE
                WHEN tfsc.description IS NOT NULL THEN tfsc.description || ' (' || pfu.file_status_st || ')'
                ELSE pfu.file_status_st
            END AS fta_file_status,
            pfu.file_status_date AS fta_file_status_date
        FROM
        bcts_staging.fta_prov_forest_use pfu
        left join bctsadmin_replication.bcts_timber_sale ts
        on pfu.forest_file_id = ts.forest_file_id 
        inner join  mofclient_replication.org_unit ou
        on pfu.bcts_org_unit = ou.org_unit_no
        left join bcts_staging.fta_timber_mark tm
        on pfu.forest_file_id = tm.forest_file_id
        left join
        (
            SELECT forest_file_id, MAX(bonus_bid) AS bonus_bid
            FROM bctsadmin_replication.bcts_tenure_bidder
            GROUP BY forest_file_id, auction_date
        ) tb
        on ts.forest_file_id = tb.forest_file_id
        left join 
        (
            SELECT forest_file_id, MAX(bonus_offer) AS bonus_offer
            FROM bctsadmin_replication.bcts_tenure_bidder
            GROUP BY forest_file_id, auction_date
        ) tb1
        on ts.forest_file_id = tb1.forest_file_id 
        left join bcts_staging.fta_tenure_term tt
        on pfu.forest_file_id = tt.forest_file_id
        left join bcts_staging.fta_tenure_file_status_code tfsc
        on pfu.file_status_st = tfsc.tenure_file_status_code
        left join advertised
        on ts.forest_file_id = advertised.forest_file_id
    ) qo


    /* LEFT JOIN to get count of bidders 2025-05-14 BD */ 
    LEFT JOIN

    (
    SELECT 
        FOREST_FILE_ID, 
        AUCTION_DATE,
        COUNT(DISTINCT CLIENT_NUMBER) AS bidder_count
    FROM 
        bctsadmin_replication.bcts_tenure_bidder

    GROUP BY 
        FOREST_FILE_ID, AUCTION_DATE

    ) bidder_count

    ON qo.forest_file_id = bidder_count.FOREST_FILE_ID
    AND  qo.LAST_AUCTION_DATE = bidder_count.AUCTION_DATE

    LEFT JOIN

    (
    SELECT 
        FOREST_FILE_ID, 
        AUCTION_DATE,
        UPSET_RATE AS Upset_Rate,
        TOTAL_UPSET_VALUE
        
    FROM 
        bctsadmin_replication.bcts_timber_sale ts

    ) ts_max

    ON qo.forest_file_id = ts_max.FOREST_FILE_ID
    AND  qo.LAST_AUCTION_DATE = ts_max.AUCTION_DATE;
    """
