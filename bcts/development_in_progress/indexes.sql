CREATE INDEX idx_activity_licn_seq_nbr ON LRM_REPLICATION.activity (licn_seq_nbr);
CREATE INDEX idx_v_block_activity_all_cutb_seq_nbr ON LRM_REPLICATION.v_block_activity_all (cutb_seq_nbr);
CREATE INDEX idx_v_block_activity_all_actt_key_ind ON LRM_REPLICATION.v_block_activity_all (actt_key_ind);
CREATE INDEX idx_activity_type_actt_key_ind ON LRM_REPLICATION.activity_type (actt_key_ind);
CREATE INDEX idx_block_allocationlicn_seq_nbr ON LRM_REPLICATION.block_allocation (licn_seq_nbr);
