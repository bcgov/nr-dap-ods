DO $$
DECLARE
    tables text[] := ARRAY[
  'BIOGEOCLIMATIC_SUBZONE',
  'BIOGEOCLIMATIC_VARIANT',
  'BIOGEOCLIMATIC_ZONE',
  'BRUSHING_TARGET_SPECIES',
  'DETAILED_SITE_ASSESSMENT',
  'FRST_COST_ITEM',
  'PLANTING_SPECIES',
  'PLANTING_UNIT',
  'SILVICULTURE_ACTIVITY',
  'SILVICULTURE_COMPANY_ACTIVITY',
  'SILVICULTURE_STOCKING_STATUS',
  'SILVICULTURE_STRATUM',
  'SILV_ACTIVITY_COST',
  'SILV_COMPANY_ACTIVITY_COST',
  'SU_TYPE'
]
;
    table_name text;
BEGIN
    -- Loop through the list of table names
    FOREACH table_name IN ARRAY tables
    LOOP
        INSERT INTO ods_data_management.cdc_master_table_list 
        VALUES (
            NULL,
            'lrm2',
            NULL,               
            'forest',
            table_name,               
            'lrm_replication',
            table_name,
            'Y',
            NULL,
            NULL,
            NULL,
            'Y',
            1,
            'N',
            'N',
            NULL,
            'Oracle'
        );
    END LOOP;
END $$;

-- DBP01
DO $$
DECLARE
    tables text[] := ARRAY[
    'STOCKING_MILESTONE',
    'STOCKING_STANDARD_UNIT'
]
;
    table_name text;
BEGIN
    -- Loop through the list of table names
    FOREACH table_name IN ARRAY tables
    LOOP
        INSERT INTO ods_data_management.cdc_master_table_list 
        VALUES (
            NULL,
            'results',
            NULL,               
            'the',
            table_name,               
            'results_replication',
            table_name,
            'Y',
            NULL,
            NULL,
            NULL,
            'Y',
            1,
            'N',
            'N',
            NULL,
            'Oracle'
        );
    END LOOP;
END $$;

INSERT INTO ods_data_management.cdc_master_table_list 
VALUES (
    NULL,
    'results',
    NULL,               
    'the',
    'silviliability_results',               
    'results_replication',
    'silviliability_results',
    'Y',
    NULL,
    NULL,
    NULL,
    'Y',
    1,
    'N',
    'Y',
    'SELECT
        CB.FOREST_FILE_ID,
        CB.CUT_BLOCK_ID,
        MAX(CB.OPENING_ID) AS OPENING,
        COUNT(CB.OPENING_ID) AS OPENING_COUNT,
        -- COUNT(FG.OPENING_ID) AS OPENING_FG_COUNT,
        MAX(FG.DECLARED_DATE) AS RESULTS_FG_DECLARED

    FROM
        THE.RSLT_OPENING_POLYGON CB,
        (
            SELECT
                SU.OPENING_ID,
                COUNT(DISTINCT SU.STOCKING_STANDARD_UNIT_ID) AS SU_COUNT,
                COUNT(DISTINCT ML.STOCKING_STANDARD_UNIT_ID) AS SU_FG_COUNT,
                MAX(ML.DECLARED_DATE) AS DECLARED_DATE

            FROM
                THE.STOCKING_STANDARD_UNIT SU,
                (
                    SELECT
                        SM.STOCKING_STANDARD_UNIT_ID,
                        MAX(SM.DECLARED_DATE) AS DECLARED_DATE
                    FROM
                        THE.STOCKING_MILESTONE SM
                    WHERE
                        SM.SILV_MILESTONE_TYPE_CODE = ''FG''
                        AND SM.DECLARE_IND = ''Y''
                    GROUP BY
                        SM.STOCKING_STANDARD_UNIT_ID
                    ORDER BY
                        1
                ) ML

            WHERE
                SU.STOCKING_STANDARD_UNIT_ID = ML.STOCKING_STANDARD_UNIT_ID (+)

            GROUP BY
                SU.OPENING_ID

            HAVING
                COUNT(DISTINCT SU.STOCKING_STANDARD_UNIT_ID) = COUNT(DISTINCT ML.STOCKING_STANDARD_UNIT_ID)

            ORDER BY 1
        ) FG

    WHERE
        CB.OPENING_ID = FG.OPENING_ID (+)

    GROUP BY
        CB.FOREST_FILE_ID, CB.CUT_BLOCK_ID

    HAVING
        COUNT(DISTINCT CB.OPENING_ID) = COUNT(DISTINCT FG.OPENING_ID)

    ORDER BY
        1,
        2
    ',
    'Oracle'
);

