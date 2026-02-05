CREATE TABLE lrm_replication.v_scaling_history (
    timber_mark         VARCHAR(6),
    scale_site          VARCHAR(4),
    scaling_period      TIMESTAMP,
    scale_species_code  VARCHAR(2),
    scale_product_code  VARCHAR(2),
    scale_grade_code    VARCHAR(1),
    billing_type_code   VARCHAR(2),
    volume_scaled       NUMERIC(10, 3),
    total_amount        NUMERIC(15, 2),
    royalty_amount      NUMERIC(11, 2),
    reserve_stmpg_amt   NUMERIC(11, 2),
    bonus_stumpage_amt  NUMERIC(11, 2),
    silv_levy_amount    NUMERIC(11, 2),
    dev_levy_amount     NUMERIC(11, 2),
    entry_timestamp     TIMESTAMP,
    entry_userid        VARCHAR(8),
    update_timestamp    TIMESTAMP,
    update_userid       VARCHAR(8),
    CONSTRAINT sh_pk PRIMARY KEY (
        timber_mark,
        scale_site,
        scaling_period,
        scale_species_code,
        scale_product_code,
        scale_grade_code,
        billing_type_code
    )
);

-- If table is already created
ALTER TABLE lrm_replication.v_scaling_history
ADD CONSTRAINT sh_pk PRIMARY KEY (
    timber_mark,
    scale_site,
    scaling_period,
    scale_species_code,
    scale_product_code,
    scale_grade_code,
    billing_type_code
);
