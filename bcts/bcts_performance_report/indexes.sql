-- Indexes for activity_class
CREATE INDEX IF NOT EXISTS idx_activity_class_accl_seq_nbr_divi_div_nbr
ON lrm_replication.activity_class (accl_seq_nbr, divi_div_nbr, accl_key_ind);

-- Indexes for activity_type
CREATE INDEX IF NOT EXISTS idx_activity_type_accl_seq_nbr_divi_div_nbr
ON lrm_replication.activity_type (accl_seq_nbr, divi_div_nbr, actt_seq_nbr, actt_key_ind);

-- Indexes for activity
CREATE INDEX IF NOT EXISTS idx_activity_actt_seq_nbr
ON lrm_replication.activity (actt_seq_nbr);

CREATE INDEX IF NOT EXISTS idx_activity_licn_seq_nbr_status_date
ON lrm_replication.activity (licn_seq_nbr, acti_status_ind, acti_status_date);

-- Indexes for v_block
CREATE INDEX IF NOT EXISTS idx_v_block_licn_seq_nbr
ON lrm_replication.v_block (licn_seq_nbr);

-- Indexes for v_licence
CREATE INDEX IF NOT EXISTS idx_v_licence_tso_code_licn_seq_nbr
ON lrm_replication.v_licence (tso_code, licn_seq_nbr);

-- Indexes for division
CREATE INDEX IF NOT EXISTS idx_division_divi_short_code
ON lrm_replication.division (divi_short_code);
