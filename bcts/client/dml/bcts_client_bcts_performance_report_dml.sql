-- Add the tables to the master tables list for replication
DO $$
DECLARE
    tables text[] := ARRAY['V_CLIENT_PUBLIC', 'ORG_UNIT'];  
    table_name text;
BEGIN
    -- Loop through the list of table names
    FOREACH table_name IN ARRAY tables
    LOOP
        INSERT INTO ods_data_management.cdc_master_table_list 
        VALUES (
            NULL,
            'client',
            NULL,               
            'the',
            table_name,               
            'bcts_client_replication',
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
