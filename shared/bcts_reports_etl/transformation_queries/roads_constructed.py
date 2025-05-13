def get_roads_constructed_query(start_date, end_date):
    sql_statement = \
    f"""    
    INSERT INTO bcts_staging.roads_constructed_hist(
	business_area_region_category, business_area_region, business_area, business_area_code, road_seq_nbr, uri, road_road_name, rcls_accounting_type, poc, pot, length, rcom_completion_date, const_method_type, rcom_method, rdst_steward_name, fiscal_year_start_date, report_end_date   
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
        (CASE 
                WHEN divi_division_name = 'Seaward' THEN 'Seaward-Tlasta' 
                ELSE divi_division_name 
        END) || ' (' || TSO_CODE || ')' AS BUSINESS_AREA,
        TSO_CODE AS BUSINESS_AREA_CODE,
        ROAD_SEQ_NBR,
        URI,
        ROAD_ROAD_NAME,
        RCLS_ACCOUNTING_TYPE,
        POC,
        POT, 
        ((POT - POC) / 1000) AS Length,
        DATE_TRUNC('DAY', RCOM_COMPLETION_DATE) AS RCOM_COMPLETION_DATE,
        CONST_METHOD_TYPE,
        RCOM_METHOD,
        RDST_STEWARD_NAME,
        '{start_date}'::DATE AS fiscal_year_start_date,
        '{end_date}'::DATE AS report_end_date
    FROM
        LRM_REPLICATION.V_ROAD_GAP_ANALYSIS
    WHERE
        URI Is Not NULL
        and RCLS_ACCOUNTING_TYPE In (
            '1 Sale = 5 yrs',
            'S.Term = 10 yrs',
            'Perm = 40 yrs'
        )
        and RDST_STEWARD_NAME = 'BCTS'
        and RCOM_COMPLETION_DATE
            BETWEEN '{start_date}'  /* Date: beginning of reporting period (usually beginning of current fiscal) */
        AND '{end_date}'  /* Date: end of reporting period */
        AND (
            (
                CONST_METHOD_TYPE = 'NEW ROAD'
                AND RCOM_METHOD <> 'Road Permit'
                AND RCOM_METHOD <> 'TSL (on-block)'
            ) OR (
                CONST_METHOD_TYPE = 'TRANSFER IN'
                AND rcom_method = 'With Costs'
            )
        )
    ORDER BY
        business_area_region_category desc,
        business_area_region,
        business_area,
        ROAD_ROAD_NAME,
        RCLS_ACCOUNTING_TYPE,
        POC
    ;
    """
    return sql_statement
