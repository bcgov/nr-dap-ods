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
    'RSLT_OPENING_POLYGON',
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

