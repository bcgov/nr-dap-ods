def get_roads_planned_deactivation_query(end_date):
    sql_statement = \
    f"""    
    INSERT INTO bcts_staging.roads_planned_deactivation_hist(
		business_area_region_category, business_area_region, business_area, business_area_code, road_seq_nbr, deac_seq_nbr, uri, road_road_name, field_team_desc, poc, pot, total_length, effective_planned_cost, deac_budgeted_cost, deac_budgeted_item_cost, rcls_accounting_type, rdst_steward_name, deac_planned_date, deac_end_date, deac_method_type, deac_level_type, fiscal_year, fiscal, report_end_date   
    )
    WITH GAP AS (
        SELECT
            divi_division_name,
            tso_code,
            road_seq_nbr,
            DEAC_SEQ_NBR,
            uri,
            road_road_name,
            FIELD_TEAM_DESC,
            poc,
            pot,
            Lead(POC, 1) OVER (
                PARTITION BY
                    DEAC_SEQ_NBR
                ORDER BY
                    DEAC_SEQ_NBR,
                    POC
            ) AS POC_Next,
            Lag(POT, 1) OVER (
                PARTITION BY
                    DEAC_SEQ_NBR
                ORDER BY
                    DEAC_SEQ_NBR,
                    POC
            ) AS POT_Prev,
            deac_budgeted_cost,
            rcls_accounting_type,
            rdst_steward_name,
            DATE_TRUNC('day', deac_planned_date)::date AS deac_planned_date,
            deac_end_date,
            deac_method_type,
            deac_level_type
        FROM
            lrm_replication.v_road_gap_analysis G
        WHERE
            G.rdst_steward_name IN ('BCTS', 'former BCTS')
            AND G.uri IS NOT NULL
            AND G.deac_end_date IS NULL
            AND G.rcls_accounting_type IN (
                '1 Sale = 5 yrs',
                'S.Term = 10 yrs',
                'Perm = 40 yrs'
            )
            -- AND  UPPER(G.DEAC_LEVEL_TYPE) = 'PERMANENT'
            AND G.deac_method_type IN ('DEACT', 'REHAB', 'TRANSFER OUT')
        ORDER BY
            road_seq_nbr,
            DEAC_SEQ_NBR,
            poc
    ),

    R AS (
        SELECT
            divi_division_name,
            tso_code,
            road_seq_nbr,
            DEAC_SEQ_NBR,
            uri,
            road_road_name,
            FIELD_TEAM_DESC,
            Min(poc) AS POC,
            Max(pot) AS POT,
            (Max(pot) - Min(poc)) / 1000 AS total_Length,
            deac_budgeted_cost,
            rcls_accounting_type,
            rdst_steward_name,
            deac_planned_date,
            deac_end_date,
            deac_method_type,
            deac_level_type
        FROM GAP 
            
        GROUP BY
            divi_division_name,
            tso_code,
            road_seq_nbr,
            DEAC_SEQ_NBR,
            uri,
            road_road_name,
            FIELD_TEAM_DESC,
            deac_budgeted_cost,
            rcls_accounting_type,
            rdst_steward_name,
            deac_planned_date,
            deac_end_date,
            deac_method_type,
            deac_level_type,
            CASE
                WHEN POC_Next IS NULL
                AND POT_PREV IS NULL THEN 'N'
                WHEN POT < POC_Next THEN 'Before'
                WHEN POC > POT_Prev THEN 'After'
                WHEN POC = POC_Next
                OR POC = POT_PREV
                OR POT = POC_NEXT
                OR POT = POT_PREV THEN 'Y'
                ELSE 'G'
            END
    ),
    DC AS (
        SELECT
            Sum(C.RACO_ITEM_COST) AS deac_budgeted_item_cost,
            C.DEAC_SEQ_NBR
        FROM
            lrm_replication.V_ROAD_ACTIVITY_COST C
        WHERE
            (
                (C.DEAC_SEQ_NBR IS NOT NULL)
                AND (UPPER(C.RACO_COST_TYPE) = 'BUDGETED_COST')
            )
        GROUP BY
            C.DEAC_SEQ_NBR
    ) 

    SELECT

        CASE
            WHEN tso_code IN ('TBA','TPL','TPG','TSK','TSN','TCC','TKA','TKO','TOC') THEN 'Interior'
            WHEN tso_code IN ('TCH','TST','TSG') THEN 'Coast'
        END AS business_area_region_category,

        CASE
            WHEN tso_code IN ('TBA','TPL','TPG','TSK','TSN') THEN 'North Interior'
            WHEN tso_code IN ('TCC','TKA','TKO','TOC') THEN 'South Interior'
            WHEN tso_code IN ('TCH','TST','TSG') THEN 'Coast'
        END AS business_area_region,

        (
        CASE
            WHEN divi_division_name = 'Seaward' THEN 'Seaward-Tlasta'
            ELSE divi_division_name
        END
        || ' (' || tso_code || ')'
        ) AS business_area,
        TSO_CODE AS BUSINESS_AREA_CODE,
        road_seq_nbr,
        R.DEAC_SEQ_NBR,
        uri,
        road_road_name,
        FIELD_TEAM_DESC,
        POC,
        POT,
        total_Length,
        CASE
            WHEN COALESCE(deac_budgeted_cost, 0) >= COALESCE(deac_budgeted_item_cost, 0)
                THEN deac_budgeted_cost
            ELSE deac_budgeted_item_cost
        END AS effective_planned_cost,
        deac_budgeted_cost,
        deac_budgeted_item_cost,
        rcls_accounting_type,
        rdst_steward_name,
        deac_planned_date,
        deac_end_date,
        deac_method_type,
        deac_level_type,
        EXTRACT(
            YEAR FROM (deac_planned_date + INTERVAL '9 months')
        ) AS fiscal_year,
        '{end_date}'::DATE AS report_end_date

        CASE
            WHEN EXTRACT(YEAR FROM (deac_planned_date + INTERVAL '9 months'))
            < EXTRACT(YEAR FROM (DATE '{end_date}' + INTERVAL '9 months'))
            THEN
                'Past Fiscals (Pre-'
                || EXTRACT(YEAR FROM (DATE '{end_date}' + INTERVAL '9 months'))
                || ')'

            WHEN EXTRACT(YEAR FROM (deac_planned_date + INTERVAL '9 months'))
            = EXTRACT(YEAR FROM (DATE '{end_date}' + INTERVAL '9 months'))
            THEN
                'Current Fiscal ('
                || EXTRACT(YEAR FROM (deac_planned_date + INTERVAL '9 months'))
                || ')'

            WHEN EXTRACT(YEAR FROM (deac_planned_date + INTERVAL '9 months'))
            - EXTRACT(YEAR FROM (DATE '{end_date}' + INTERVAL '9 months')) = 1
            THEN
                '1st Fiscal ('
                || EXTRACT(YEAR FROM (deac_planned_date + INTERVAL '9 months'))
                || ')'

            WHEN EXTRACT(YEAR FROM (deac_planned_date + INTERVAL '9 months'))
            - EXTRACT(YEAR FROM (DATE '{end_date}' + INTERVAL '9 months')) = 2
            THEN
                '2nd Fiscal ('
                || EXTRACT(YEAR FROM (deac_planned_date + INTERVAL '9 months'))
                || ')'

            WHEN EXTRACT(YEAR FROM (deac_planned_date + INTERVAL '9 months'))
            - EXTRACT(YEAR FROM (DATE '{end_date}' + INTERVAL '9 months')) = 3
            THEN
                '3rd Fiscal ('
                || EXTRACT(YEAR FROM (deac_planned_date + INTERVAL '9 months'))
                || ')'

            WHEN EXTRACT(YEAR FROM (deac_planned_date + INTERVAL '9 months'))
            - EXTRACT(YEAR FROM (DATE '{end_date}' + INTERVAL '9 months')) = 4
            THEN
                '4th Fiscal ('
                || EXTRACT(YEAR FROM (deac_planned_date + INTERVAL '9 months'))
                || ')'

            WHEN EXTRACT(YEAR FROM (deac_planned_date + INTERVAL '9 months'))
            - EXTRACT(YEAR FROM (DATE '{end_date}' + INTERVAL '9 months')) = 5
            THEN
                '5th Fiscal ('
                || EXTRACT(YEAR FROM (deac_planned_date + INTERVAL '9 months'))
                || ')'

            WHEN EXTRACT(YEAR FROM (deac_planned_date + INTERVAL '9 months'))
            - EXTRACT(YEAR FROM (DATE '{end_date}' + INTERVAL '9 months')) > 5
            THEN
                '6th Fiscal-Onwards ('
                || (EXTRACT(YEAR FROM (DATE '{end_date}' + INTERVAL '9 months')) + 6)
                || '+)'
        END AS fiscal

    FROM R
    LEFT JOIN DC ON R.DEAC_SEQ_NBR = DC.DEAC_SEQ_NBR
    ORDER BY
        BUSINESS_AREA_REGION_CATEGORY DESC,
        BUSINESS_AREA_REGION,
        BUSINESS_AREA,
        FIELD_TEAM_DESC,
        URI,
        POC,
        POT,
        R.DEAC_SEQ_NBR;
    """
    return sql_statement




