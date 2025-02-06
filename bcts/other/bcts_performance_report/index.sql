-- Create indexes for the CUT_BLOCK table (B)
CREATE INDEX idx_cut_block_cutb_seq_nbr ON LRM_REPLICATION.CUT_BLOCK (CUTB_SEQ_NBR);
CREATE INDEX idx_cut_block_suop_subop_area_id ON LRM_REPLICATION.CUT_BLOCK (SUOP_SUBOP_AREA_ID);
CREATE INDEX idx_cut_block_opar_operating_area_id ON LRM_REPLICATION.CUT_BLOCK (OPAR_OPERATING_AREA_ID);

-- Create indexes for the DIVISION table (D)
CREATE INDEX idx_division_divi_div_nbr ON LRM_REPLICATION.DIVISION (DIVI_DIV_NBR);

-- Create indexes for the BLOCK_ALLOCATION table (BA)
CREATE INDEX idx_block_allocation_cutb_seq_nbr ON LRM_REPLICATION.BLOCK_ALLOCATION (CUTB_SEQ_NBR);
CREATE INDEX idx_block_allocation_manu_seq_nbr ON LRM_REPLICATION.BLOCK_ALLOCATION (MANU_SEQ_NBR);
CREATE INDEX idx_block_allocation_perm_seq_nbr ON LRM_REPLICATION.BLOCK_ALLOCATION (PERM_SEQ_NBR);
CREATE INDEX idx_block_allocation_mark_seq_nbr ON LRM_REPLICATION.BLOCK_ALLOCATION (MARK_SEQ_NBR);

-- Create indexes for the MANAGEMENT_UNIT table (M)
CREATE INDEX idx_management_unit_manu_seq_nbr ON LRM_REPLICATION.MANAGEMENT_UNIT (MANU_SEQ_NBR);

-- Create indexes for the LICENCE table (L)
CREATE INDEX idx_licence_licn_seq_nbr ON LRM_REPLICATION.LICENCE (LICN_SEQ_NBR);
CREATE INDEX idx_licence_licn_field_team_id ON LRM_REPLICATION.LICENCE (LICN_FIELD_TEAM_ID);

-- Create indexes for the TENURE_TYPE table (TN)
CREATE INDEX idx_tenure_type_tent_seq_nbr ON LRM_REPLICATION.TENURE_TYPE (TENT_SEQ_NBR);

-- Create indexes for the CUT_PERMIT table (P)
CREATE INDEX idx_cut_permit_perm_seq_nbr ON LRM_REPLICATION.CUT_PERMIT (PERM_SEQ_NBR);

-- Create indexes for the MARK table (MK)
CREATE INDEX idx_mark_mark_seq_nbr ON LRM_REPLICATION.MARK (MARK_SEQ_NBR);

-- Create indexes for the OPERATING_AREA table (OA)

-- Create indexes for the CUT_BLOCK_SILV_REGIME table (CBSR)
CREATE INDEX idx_cut_block_silv_regime_cutb_seq_nbr ON LRM_REPLICATION.CUT_BLOCK_SILV_REGIME (CUTB_SEQ_NBR);

-- Create indexes for the SILV_TREATMENT_REGIME table (STR)
CREATE INDEX idx_silv_treatment_regime_treg_seq_nbr ON LRM_REPLICATION.SILV_TREATMENT_REGIME (TREG_SEQ_NBR);
CREATE INDEX idx_silv_treatment_regime_pers_seq_nbr ON LRM_REPLICATION.SILV_TREATMENT_REGIME (PERS_SEQ_NBR);

-- Create indexes for the CODE_LOOKUP table (COLU)
CREATE INDEX idx_code_lookup_colu_lookup_id ON LRM_REPLICATION.CODE_LOOKUP (COLU_LOOKUP_ID);

-- Create indexes for the SUB_OPERATING_AREA table (SUOP)
CREATE INDEX idx_sub_operating_area_subop_area_id ON LRM_REPLICATION.SUB_OPERATING_AREA (SUOP_SUBOP_AREA_ID);
CREATE INDEX idx_sub_operating_area_divi_div_nbr ON LRM_REPLICATION.SUB_OPERATING_AREA (DIVI_DIV_NBR);
CREATE INDEX idx_sub_operating_area_opar_operating_area_id ON LRM_REPLICATION.SUB_OPERATING_AREA (OPAR_OPERATING_AREA_ID);

-- Create indexes for the PERSON table (PER)
CREATE INDEX idx_person_pers_seq_nbr ON LRM_REPLICATION.PERSON (PERS_SEQ_NBR);

-- Create indexes for the ACTIVITY_TYPE table (AT0)
CREATE INDEX idx_activity_type_actt_key_ind ON LRM_REPLICATION.activity_type (actt_key_ind);

-- Create indexes for the ACTIVITY table (A0)
CREATE INDEX idx_activity_cutb_seq_nbr ON LRM_REPLICATION.activity (CUTB_SEQ_NBR);
CREATE INDEX idx_activity_actt_seq_nbr ON LRM_REPLICATION.activity (actt_seq_nbr);

-- Create indexes for the ECOLOGY_UNIT table (EU)
CREATE INDEX idx_ecology_unit_cutb_seq_nbr ON LRM_REPLICATION.ECOLOGY_UNIT (CUTB_SEQ_NBR);

-- Create indexes for the SILVICULTURE_PRESCRIPTION table (SILP)
CREATE INDEX idx_silviculture_prescription_cutb_seq_nbr ON LRM_REPLICATION.SILVICULTURE_PRESCRIPTION (CUTB_SEQ_NBR);

-- Create indexes for the STANDARD_UNIT table (STUN)
CREATE INDEX idx_standard_unit_silp_seq_nbr ON LRM_REPLICATION.STANDARD_UNIT (SILP_SEQ_NBR);

-- Create indexes for the BLOCK_SEED_ZONE table (BSZ)
CREATE INDEX idx_block_seed_zone_cutb_seq_nbr ON LRM_REPLICATION.BLOCK_SEED_ZONE (CUTB_SEQ_NBR);
CREATE INDEX idx_block_seed_zone_blsz_zone_id ON LRM_REPLICATION.BLOCK_SEED_ZONE (BLSZ_ZONE_ID);

-- Create indexes for the CUT_BLOCK (B) and the related tables (HV, ELV, SI, SZ)
CREATE INDEX idx_block_activity_cutb_seq_nbr ON LRM_REPLICATION.activity (CUTB_SEQ_NBR);
