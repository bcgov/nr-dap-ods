
def get_volume_advertised_official_query(start_date, end_date):
    return \
    f"""

    /* qAdvertised_Official */
    INSERT INTO BCTS_STAGING.volume_advertised_official (
	business_area_region_category, business_area_region, business_area, business_area_code, mgmt_unit_type, mgmt_unit_id, description, forest_file_id, bcts_category_code, category, auction_date, sale_volume, fta_volume, client_count, eligible_client_count, ineligible_client_count, client_count_eligibility_indicator_missing, no_sale_rationale_code, no_sale_rationale, auction_date_fiscal, auction_date_quarter, tenure_term, initial_expiry_dt, current_expiry_dt, awarded_ind, file_status_st, first_auction_date, last_auction_date, auction_count, first_auction, last_auction, last_auction_no_sale, report_start_date, report_end_date, fiscal_year
    )
    with AU_CNT as
    (
        select
            ts.forest_file_id,
            count(ts.auction_date) as auction_count,
            min(ts.auction_date) as first_auction_date,
            max(ts.auction_date) as last_auction_date
        from
            bctsadmin_replication.bcts_timber_sale ts,
            (
                select
                forest_file_id,
                auction_date
                from bctsadmin_replication.bcts_timber_sale
                where
                    COALESCE(no_sale_rationale_code, ' ') <> 'TB'
                    and auction_date <= to_date('{end_date}', 'YYYY-MM-DD')  -- Date: end of reporting period
            ) auction_filter
        where
            ts.forest_file_id = auction_filter.forest_file_id
            and ts.auction_date = auction_filter.auction_date
        group by
            ts.forest_file_id
        Order By
            1
        ),
        bid_info as
        (
            SELECT
                b.forest_file_id,
                b.auction_date,
                count(
                    client_number
                ) as client_count,
                count(
                    case
                        when
                        upper(ineligible_ind) = 'N'
                    then
                        client_number
                    end
                ) as eligible_client_count,
                count(
                    case
                        when
                            upper(ineligible_ind) = 'Y'
                        then
                            client_number
                        end
                ) as ineligible_client_count,
                count(
                    case
                        when
                            ineligible_ind is null
                        then
                            client_number
                        end
                ) as client_count_eligibility_indicator_missing,
                Max(b.sale_awarded_ind) AS awarded_ind
            FROM
                bctsadmin_replication.bcts_tenure_bidder b
            WHERE
                b.auction_date
                        BETWEEN To_Date('{start_date}', 'YYYY-MM-DD')  -- Date: beginning of current fiscal
                        AND To_Date('{end_date}', 'YYYY-MM-DD')  -- Date: end of reporting period
        GROUP BY
            b.forest_file_id,
            b.auction_date
        )

    select distinct
        case
            when
                ou.org_unit_code in ('TBA', 'TPL', 'TPG', 'TSK', 'TSN', 'TCC', 'TKA', 'TKO', 'TOC')
            then
                'Interior'
            when
                ou.org_unit_code in ('TCH', 'TST', 'TSG')
            then
                'Coast'
            end as Business_Area_Region_Category,
        case
            when
                ou.org_unit_code in ('TBA', 'TPL', 'TPG', 'TSK', 'TSN')
            then
                'North Interior'
            when
                ou.org_unit_code in ('TCC', 'TKA', 'TKO', 'TOC')
            then
                'South Interior'
            when
                ou.org_unit_code in ('TCH', 'TST', 'TSG')
            then
                'Coast'
            end as Business_Area_Region,
        replace(
            CASE 
                WHEN ou.org_unit_name = 'Seaward Timber Sales Office' 
                THEN 'Seaward-Tlasta' 
                ELSE ou.org_unit_name 
            END || ' (' || ou.org_unit_code || ')',
            ' Timber Sales Office',
            ''
        ) AS Business_Area,
        ou.org_unit_code as Business_Area_Code,
        pfu.mgmt_unit_type,
        pfu.mgmt_unit_id,
        ta.description,
        ts.forest_file_id,
        ts.BCTS_CATEGORY_CODE,
        c.DESCRIPTION AS Category,
        ts.auction_date,
        ts.sale_volume,
        hs.sale_volume AS FTA_VOLUME,
        bid_info.client_count,
        bid_info.eligible_client_count,
        bid_info.ineligible_client_count,
        bid_info.client_count_eligibility_indicator_missing,
        ts.no_sale_rationale_code,
        CASE 
            WHEN ts.no_sale_rationale_code IS NULL THEN NULL
            ELSE no_sale.description || ' (' || ts.no_sale_rationale_code || ')'
        END AS no_sale_rationale,
        EXTRACT(YEAR FROM (ts.auction_date + INTERVAL '9 months')) AS auction_date_fiscal,
        'Q' || CEIL(EXTRACT(MONTH FROM (ts.auction_date + INTERVAL '-3 months')) / 3.0) AS auction_date_quarter,
        TE.TENURE_TERM,
        TE.INITIAL_EXPIRY_DT,
        TE.CURRENT_EXPIRY_DT,
        bid_info.awarded_ind,
        pfu.FILE_STATUS_ST,
        au_cnt.First_Auction_Date,
        au_cnt.Last_Auction_Date,
        AU_CNT.Auction_Count,
        CASE WHEN ts.auction_date = au_cnt.first_auction_date THEN 'Y' ELSE 'N' END AS first_auction,
        CASE WHEN ts.auction_date = au_cnt.last_auction_date THEN 'Y' ELSE 'N' END AS last_auction,

        case
            when
                ts.auction_date = au_cnt.last_auction_date
                and ts.no_sale_rationale_code is not null
            then
                'This auction is the last auction for the licence in the report period and is a no sale.'
            end as last_auction_no_sale,
        '{start_date}'::Date as report_start_date,
        '{end_date}'::Date as report_end_date,
        CASE
            WHEN EXTRACT(MONTH FROM '{end_date}'::Date) >= 4 THEN EXTRACT(YEAR FROM '{end_date}'::Date)
            ELSE EXTRACT(YEAR FROM '{end_date}'::Date) - 1
        END AS fiscal_year
    from
        bctsadmin_replication.bcts_timber_sale ts
        left join bcts_staging.fta_harvest_sale hs
        on ts.forest_file_id = hs.forest_file_id
        left join bctsadmin_replication.BCTS_CATEGORY_CODE c
        on ts.BCTS_CATEGORY_CODE = c.BCTS_CATEGORY_CODE
        inner join bcts_staging.fta_prov_forest_use pfu
        on ts.forest_file_id = pfu.forest_file_id
        inner join mofclient_replication.org_unit ou
        on pfu.bcts_org_unit = ou.org_unit_no
        left join bcts_staging.fta_TENURE_TERM TE
        on TS.FOREST_FILE_ID = TE.FOREST_FILE_ID
        left join bctsadmin_replication.no_sale_rationale_code no_sale
        on ts.no_sale_rationale_code = no_sale.no_sale_rationale_code
        left join bcts_staging.fta_tsa_number_code ta
        on pfu.MGMT_UNIT_ID = ta.TSA_NUMBER
        left join bcts_staging.fta_tfl_number_code tf
        on pfu.mgmt_unit_id = tf.tfl_number
        left join AU_CNT
        on ts.forest_file_id = AU_CNT.forest_file_id
        left join bid_info
        on ts.forest_file_id = bid_info.forest_file_id
        and ts.auction_date = bid_info.auction_date
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
