INSERT INTO ods_data_management.cdc_master_table_list 
        VALUES (
            NULL,
            'lrm',
            NULL,               
            'forest',
            'CUT_BLOCK_SHAPE',               
            'lrm_replication',
            'CUT_BLOCK_SHAPE',
            'Y',
            NULL,
            NULL,
            NULL,
            'Y',
            1,
            'N',
            'Y',
            'SELECT objectid, transaction_id, cutb_seq_nbr, bufferdist, objectid_1, transactio, objectid_2, hectares, feature_len, feature_area, shape_len, shape_area, ''redacted'' as shape, licn_seq_nbr, manu_seq_nbr, mark_seq_nbr, perm_seq_nbr, modifiedby, modifiedon, modifiedusing, createdby, createdon, createdusing FROM forest.cut_block_shape',
            'Oracle'
        );
