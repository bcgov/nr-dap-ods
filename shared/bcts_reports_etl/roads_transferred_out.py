def get_roads_transferred_out_query(start_date, end_date):
    sql_statement = \
    f"""    
    INSERT INTO bcts_staging.roads_transferred_out_hist(
    business_area_region_category, business_area_region, business_area, business_area_code, road_seq_nbr, uri, road_road_name, rcls_accounting_type, poc, pot, length, transfer_date, deac_method_type, deac_level_type, rdst_steward_name, fiscal_year_start_date, report_end_date   
    )
    SELECT DISTINCT
        case
            when
                TSO_CODE in ('TBA', 'TPL', 'TPG', 'TSK', 'TSN', 'TCC', 'TKA', 'TKO', 'TOC')
            then
                'Interior'
            when
                TSO_CODE in ('TCH', 'TST', 'TSG')
            then
                'Coast'
        end as BUSINESS_AREA_REGION_CATEGORY,
        case
            when
                TSO_CODE in ('TBA', 'TPL', 'TPG', 'TSK', 'TSN')
            then
                'North Interior'
            when
                TSO_CODE in ('TCC', 'TKA', 'TKO', 'TOC')
            then
                'South Interior'
            when
                TSO_CODE in ('TCH', 'TST', 'TSG')
            then
                'Coast'
        end as BUSINESS_AREA_REGION,
        CASE 
                WHEN DIVI_DIVISION_NAME = 'Seaward' THEN 'Seaward-Tlasta'
                ELSE DIVI_DIVISION_NAME
            END || ' (' || TSO_CODE || ')' AS BUSINESS_AREA,
        TSO_CODE as BUSINESS_AREA_CODE,
        ROAD_SEQ_NBR,
        URI,
        ROAD_ROAD_NAME,
        RCLS_ACCOUNTING_TYPE,
        POC,
        POT,
        ((POT-POC)/1000) AS Length,
        DEAC_END_DATE::DATE AS TRANSFER_DATE,
        DEAC_METHOD_TYPE,
        DEAC_LEVEL_TYPE,
        RDST_STEWARD_NAME,
        '{start_date}'::DATE AS fiscal_year_start_date,
        '{end_date}'::DATE AS report_end_date
    FROM
        LRM_REPLICATION.V_ROAD_GAP_ANALYSIS
    WHERE
        upper(DEAC_METHOD_TYPE) = 'TRANSFER OUT'
        AND URI Is Not NULL
        AND RCLS_ACCOUNTING_TYPE In ('1 Sale = 5 yrs', 'S.Term = 10 yrs', 'Perm = 40 yrs')
        AND DEAC_END_DATE
            BETWEEN '{start_date}'   /* Date: beginning of reporting period (usually beginning of current fiscal) */
            AND '{end_date}'  /* Date: end of reporting period */
    ORDER BY
        BUSINESS_AREA_REGION_CATEGORY desc,
        BUSINESS_AREA_REGION,
        BUSINESS_AREA,
        ROAD_ROAD_NAME
;

    """
    return sql_statement
