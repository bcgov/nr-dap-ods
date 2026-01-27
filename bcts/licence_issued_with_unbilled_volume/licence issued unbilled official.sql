    CREATE OR REPLACE VIEW bcts_staging.licence_issued_with_unbilled_volume_Official AS
    
    WITH auction_with_winner AS
    (
        SELECT
            tb.forest_file_id,
            tb.auction_date,
            tb.client_number,
            (
                CASE
                    WHEN fc.legal_first_name IS NOT NULL
                    THEN fc.legal_first_name || ' '
                    ELSE ''
                END ||
                CASE
                    WHEN fc.legal_middle_name IS NOT NULL
                    THEN fc.legal_middle_name || ' '
                    ELSE ''
                END ||
                fc.client_name
            ) AS client
        FROM bctsadmin_replication.bcts_tenure_bidder tb
        JOIN mofclient_replication.v_client_public fc
        ON tb.client_number = fc.client_number
        WHERE UPPER(tb.sale_awarded_ind) = 'Y'
    ),
    latest_auction_with_winner AS
    (
        SELECT
            forest_file_id,
            max(auction_date) AS latest_auction_date
        FROM
            bctsadmin_replication.bcts_tenure_bidder tb
        WHERE
            upper(tb.sale_awarded_ind) = 'Y'
        GROUP BY
            forest_file_id
    ),
    bid_info AS
    /*

    Some historic auction data has multiple sale_awarded_ind = 'Y'

    for the same forest_file_id. This subquery looks at the winning

    bid info for the most recent auction for each successful auction.

    */
    (
        SELECT DISTINCT
            auction_with_winner.forest_file_id,
            auction_with_winner.auction_date,
            client_number,
            client
        FROM
            auction_with_winner
        JOIN
            latest_auction_with_winner
        ON auction_with_winner.forest_file_id = latest_auction_with_winner.forest_file_id
        AND auction_with_winner.auction_date = latest_auction_with_winner.latest_auction_date                     
    ),
    
    issued_active AS
    (
        SELECT
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

    CASE
        WHEN ou.org_unit_code IS NULL THEN NULL
        ELSE
            replace(
                (CASE
                    WHEN ou.org_unit_name = 'Seaward Timber Sales Office'
                        THEN 'Seaward-Tlasta'
                    ELSE ou.org_unit_name
                 END) || ' (' || ou.org_unit_code || ')',
                ' Timber Sales Office',
                ''
            )
    END AS business_area,

    ts.forest_file_id,
    pfu.file_type_code,
    ts.bcts_category_code,
    tt.legal_effective_dt AS legal_effective_date_fta,

    /* report need, flags added */
    CURRENT_DATE AS report_date,

    CASE
        WHEN tt.legal_effective_dt + INTERVAL '20 months' < CURRENT_DATE
            THEN 1 ELSE 0
    END AS effective_date_add_20_flag,

    CASE
        WHEN (
            COALESCE(tt.current_expiry_dt, tt.initial_expiry_dt)
            - INTERVAL '6 months'
        ) < CURRENT_DATE
            THEN 1 ELSE 0
    END AS expire_date_minus_6_flag,

    /* Fiscal year calculation */
    CASE
        WHEN tt.legal_effective_dt IS NULL THEN NULL
        ELSE
            'Fiscal ' ||
            (EXTRACT(YEAR FROM (tt.legal_effective_dt + INTERVAL '9 months')) - 1)
            || '/' ||
            EXTRACT(YEAR FROM (tt.legal_effective_dt + INTERVAL '9 months'))
    END AS legal_effective_fiscal_fta,

    tt.initial_expiry_dt AS initial_expiry_fta,
    tt.current_expiry_dt AS current_expiry_fta,
    COALESCE(tt.current_expiry_dt, tt.initial_expiry_dt) AS expiry_fta,

    tt.tenure_term AS advertised_licence_term,

    /* months_between replacement */
    ROUND(
        EXTRACT(YEAR FROM AGE(tt.current_expiry_dt, tt.initial_expiry_dt)) * 12 +
        EXTRACT(MONTH FROM AGE(tt.current_expiry_dt, tt.initial_expiry_dt))
    ) AS extension_term,

    ROUND(
        EXTRACT(YEAR FROM AGE(
            COALESCE(tt.current_expiry_dt, tt.initial_expiry_dt),
            tt.legal_effective_dt
        )) * 12 +
        EXTRACT(MONTH FROM AGE(
            COALESCE(tt.current_expiry_dt, tt.initial_expiry_dt),
            tt.legal_effective_dt
        ))
    ) AS total_tenure_term,

    bid_info.client_number,
    bid_info.client,

    CASE
        WHEN tfsc.description IS NULL
            THEN pfu.file_status_st
        ELSE tfsc.description || ' (' || pfu.file_status_st || ')'
    END AS fta_file_status,

    pfu.file_status_date AS fta_file_status_date,
    ts.sale_volume

    FROM bctsadmin_replication.bcts_timber_sale ts
    JOIN bcts_staging.fta_prov_forest_use pfu
        ON pfu.forest_file_id = ts.forest_file_id
    JOIN bcts_staging.fta_tenure_term tt
        ON pfu.forest_file_id = tt.forest_file_id
    JOIN bid_info
        ON ts.forest_file_id = bid_info.forest_file_id
    AND ts.auction_date = bid_info.auction_date
    JOIN mofclient_replication.org_unit ou
        ON pfu.bcts_org_unit = ou.org_unit_no
    LEFT JOIN bcts_staging.fta_tenure_file_status_code tfsc
        ON pfu.file_status_st = tfsc.tenure_file_status_code

    WHERE
        ts.no_sale_rationale_code IS NULL  -- This statement should be redundant and is included as a failsafe.
        AND pfu.file_type_code = 'B20'
        /* For this Licence Issued and Unharvested timber report, exclude the

            FTA statuses that can indicate a licence was once issued,

            and has since been closed (HC), logging complete (LC),

            cancelled (HX), surrendered (HRS).

            This report is concerned with currently active licences

            with unbilled volume. */
        AND pfu.file_status_st IN ('HI','HS') -- Issued or Suspended
         /* Tenure term legal effective date has begun */
        AND tt.legal_effective_dt < CURRENT_DATE

),
/* Harvest Billing System (HBS) */
hbs AS
    (
    SELECT
    p.bcts_org_unit,
    p.forest_file_id,
    m.timber_mark,
    m.cruise_based_ind,
    s.sale_volume,

    SUM(h.volume_scaled) AS billed_volume,

    SUM(
        CASE
            WHEN h.billing_type_code = 'WU'
                THEN h.volume_scaled
            ELSE NULL
        END
    ) AS billed_wu_volume,

    SUM(
        CASE
            WHEN h.billing_type_code = 'WA'
                THEN h.volume_scaled
            ELSE NULL
        END
    ) AS billed_wa_volume,

    SUM(h.total_amount) AS billed_amount,
    SUM(h.royalty_amount) AS royalty_amount,
    SUM(h.reserve_stmpg_amt) AS reserve_stumpage_amount,
    SUM(h.bonus_stumpage_amt) AS bonus_stumpage_amount,
    SUM(h.dev_levy_amount) AS dev_levy_amount

FROM bcts_staging.fta_harvest_sale s
JOIN bcts_staging.fta_prov_forest_use p
    ON s.forest_file_id = p.forest_file_id
JOIN bcts_staging.fta_timber_mark m
    ON p.forest_file_id = m.forest_file_id
LEFT JOIN lrm_replication.v_scaling_history h
    ON m.timber_mark = h.timber_mark

WHERE
    p.bcts_org_unit IS NOT NULL

GROUP BY
    p.bcts_org_unit,
    p.forest_file_id,
    m.timber_mark,
    m.cruise_based_ind,
    s.sale_volume

    ) 

SELECT
    issued_active.*,
    hbs.cruise_based_ind,
    hbs.billed_volume,

    /* Calculate unbilled volume */
    COALESCE(issued_active.sale_volume, 0)
        - COALESCE(hbs.billed_volume, 0) AS unbilled_volume,

    /* Percentage of unbilled volume */
    ROUND(
        (
            COALESCE(issued_active.sale_volume, 0)
            - COALESCE(hbs.billed_volume, 0)
        ) / issued_active.sale_volume * 100,
        1
    ) AS percent_unbilled

FROM
    issued_active
    LEFT JOIN hbs
        ON issued_active.forest_file_id = hbs.forest_file_id

WHERE
    /* Licence has not expired */
    issued_active.expiry_fta > CURRENT_DATE

    /* 
     Look at licences where more than 100 cubic metres
     is still unbilled
    */
    AND (
        COALESCE(issued_active.sale_volume, 0)
        - COALESCE(hbs.billed_volume, 0)
    ) > 100;
