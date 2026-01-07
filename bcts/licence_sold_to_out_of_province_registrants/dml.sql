-- BCTSADMIN DBP01 THE. bcts_registrant 
INSERT INTO ods_data_management.cdc_master_table_list 
VALUES (
    NULL,
    'bctsadmin',
    NULL,               
    'the',
    'BCTS_REGISTRANT',               
    'bctsadmin_replication',
    'BCTS_REGISTRANT',
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

-- FOREST CLIENT DBP01 THE. client_location  
INSERT INTO ods_data_management.cdc_master_table_list 
VALUES (
    NULL,
    'mof-client',
    NULL,               
    'the',
    'CLIENT_LOCATION',               
    'mofclient_replication',
    'CLIENT_LOCATION',
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
