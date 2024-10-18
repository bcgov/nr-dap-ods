DO $$
DECLARE
    tables text[] := ARRAY['DIVISION','BLOCK_ALLOCATION','MANAGEMENT_UNIT','LICENCE','BLOCK_ADMIN_ZONE','DIVISION_CODE_LOOKUP','CODE_LOOKUP','TENURE_TYPE','CUT_PERMIT','MARK','CUT_BLOCK','ACTIVITY_CLASS','ACTIVITY_TYPE','ACTIVITY'];  
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
            NULL,
            'Oracle'
        );
    END LOOP;
END $$;
