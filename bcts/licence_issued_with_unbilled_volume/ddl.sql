CREATE TABLE lrm_replication.v_scaling_history (
    timber_mark VARCHAR(6),
    scale_site VARCHAR(4),
    scaling_period TIMESTAMP,
    scale_species_code VARCHAR(2),
    scale_product_code VARCHAR(2),
    scale_grade_code VARCHAR(1),
    billing_type_code VARCHAR(2),
    volume_scaled NUMERIC(10, 3),
    total_amount NUMERIC(15, 2),
    royalty_amount NUMERIC(11, 2),
    reserve_stmpg_amt NUMERIC(11, 2),
    bonus_stumpage_amt NUMERIC(11, 2),
    silv_levy_amount NUMERIC(11, 2),
    dev_levy_amount NUMERIC(11, 2),
    entry_timestamp TIMESTAMP,
    entry_userid VARCHAR(8),
    update_timestamp TIMESTAMP,
    update_userid VARCHAR(8)
);

