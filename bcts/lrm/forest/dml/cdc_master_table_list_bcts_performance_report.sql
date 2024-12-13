DO $$
DECLARE
    tables text[] := ARRAY['OPERATING_AREA','LRM_VT_COMMIT_LIC_TYPE','PERMIT_ALLOCATION','CTOR_CONTRACTOR_LOCATION','CUT_BLOCK_SILV_REGIME','V_RES_VT_FDTM_TEAM','COMMITMENT_PARTITION','BLOCK_SEED_ZONE','STANDARD_UNIT','APPORTIONMENT','SILV_TREATMENT_REGIME','PERSON','BCTS_HARVEST_HISTORY','COMMITMENTS','ECOLOGY_UNIT','SUB_OPERATING_AREA','MARK_ALLOCATION','CTOR_CONTRACTOR','LICENCE_ALLOCATION','SILVICULTURE_PRESCRIPTION'];  
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
