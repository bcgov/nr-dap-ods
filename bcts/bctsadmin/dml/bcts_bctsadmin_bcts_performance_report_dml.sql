-- Add the tables to the master tables list for replication
DO $$
DECLARE
    tables text[] := ARRAY['BCTS_TENURE_BIDDER', 'BCTS_TIMBER_SALE', 'NO_SALE_RATIONALE_CODE'];  
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
            'the',
            table_name,               
            'bctsadmin_replication',
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
