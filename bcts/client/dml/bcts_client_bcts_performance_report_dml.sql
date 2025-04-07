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
            'mof-client',
            NULL,               
            'the',
            table_name,               
            'mofclient_replication',
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
