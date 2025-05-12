
DO $$
DECLARE
    tables text[] := ARRAY['SU_TYPE', 'SILVICULTURE_STRATUM', 'SILVICULTURE_STOCKING_STATUS', 'BIOGEOCLIMATIC_ZONE', 'BIOGEOCLIMATIC_SUBZONE', 'BIOGEOCLIMATIC_VARIANT', 'SILVICULTURE_ACTIVITY', 'PLANTING_UNIT', 'BRUSHING_TARGET_SPECIES', 'PLANTING_SPECIES', 'SILV_COMPANY_ACTIVITY_COST', 'FRST_COST_ITEM', 'SILVICULTURE_COMPANY_ACTIVITY', 'DETAILED_SITE_ASSESSMENT'];  
    table_name text;
BEGIN
    -- Loop through the list of table names
    FOREACH table_name IN ARRAY tables
    LOOP
        INSERT INTO ods_data_management.cdc_master_table_list 
        VALUES (
            NULL,
            'lrm',
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
