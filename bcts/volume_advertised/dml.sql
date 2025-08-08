
INSERT INTO ods_data_management.cdc_master_table_list 
        VALUES (
            NULL,
            'lrm',
            NULL,               
            'forestview',
            'SV_SALES_SCHEDULE',               
            'lrm_replication',
            'SV_SALES_SCHEDULE',
            'Y',
            NULL,
            NULL,
            NULL,
            'Y',
            1,
            'N',
            'Y',
            'SELECT divi_div_nbr, divi_short_code, ozon_operating_zone_id, field_team, manu_id, opar_operating_area_name, licence_id, licn_category_id, linc_cert_level_id, term, tenure_type, licn_licence_state, registrant, perm_permit_id, geographic_location, mark_mark_id, block_id, block_full_name, cutb_system_id, cutb_block_state, cutb_longitude, cutb_latitude, sttp_stand_type, cutb_vol_data_source, blal_merch_ha_area, blal_harvested_ha_area, blal_cruise_m3_vol, rw_vol, block_volume, blal_harvested_m3_vol, auction_status, auction_date, auction_fiscal, auction_quarter, auc_quart_month, current_period_flag, current_period_start, current_period_end, silviculture_system, yarding_system, harvest_considerations, piece_size, species_composition, hi_status, hi_date, expire_status, expire_date, rc_status, rc_date, dr_status, dr_date, dvs_status, dvs_date, layout_status, layout_date, dvc_status, dvc_date, write_off_status, write_off_date, licn_seq_nbr, cutb_seq_nbr, objectid, ''redacted'' from forestview.SV_SALES_SCHEDULE',
            'Oracle'
        );

INSERT INTO ods_data_management.cdc_master_table_list 
        VALUES (
            NULL,
            'bctsadmin',
            NULL,               
            'the',
            'BCTS_CATEGORY_CODE',               
            'bctsadmin_replication',
            'BCTS_CATEGORY_CODE',
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
