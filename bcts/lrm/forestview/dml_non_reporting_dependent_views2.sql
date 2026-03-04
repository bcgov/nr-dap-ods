DO $$
DECLARE
    tables text[] := ARRAY[
        'V_PEST_INFESTATION',
        'V_PLANTING_SPECIES',
        'V_QB_VALUATION',
        'V_RIPARIAN_ZONE',
        'V_ROAD',
        'V_ROAD_ACTIVITY',
        'V_ROAD_ACTIVITY_COST',
        'V_ROAD_ACTIVITY_COST_ROW',
        'V_ROAD_ACTIVITY_ROW',
        'V_ROAD_AGRI_LAND_RESERVE',
        'V_ROAD_ASSESSMENT',
        'V_ROAD_CLASS',
        'V_ROAD_COMPLETION',
        'V_ROAD_CUT_BLOCK',
        'V_ROAD_DEACTIVATION',
        'V_ROAD_EVENT_MAPPING',
        'V_ROAD_GAP_ANALYSIS',
        'V_ROAD_INSPECTION',
        'V_ROAD_LINEAR_STRUCT',
        'V_ROAD_MAINTENANCE',
        'V_ROAD_MANAGEMENT_UNIT',
        'V_ROAD_MAPSHEET',
        'V_ROAD_ON_BLOCK',
        'V_ROAD_OP_AREA',
        'V_ROAD_ORGANIC_MAT',
        'V_ROAD_PERMIT',
        'V_ROAD_PROV_FOREST',
        'V_ROAD_RADIO',
        'V_ROAD_RISK',
        'V_ROAD_SECTION',
        'V_ROAD_SPATIAL_META',
        'V_ROAD_STATUS'
        ];
    table_name text;
BEGIN
    -- Loop through the list of table names
    FOREACH table_name IN ARRAY tables
    LOOP
        INSERT INTO ods_data_management.cdc_master_table_list 
        VALUES (
            NULL,
            'lrm4',
            NULL,               
            'forestview',
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

