CREATE TABLE fta_replication.aac_allocation_amount (
	aac_allocation_amount_id bigint NOT NULL,
	aac_adjustment_reason_code VARCHAR(4) NOT NULL,
	aac_allocation_period_id bigint NOT NULL,
	allowable_area_type_code VARCHAR(3) NOT NULL,
	allowable_cut_type_code VARCHAR(3) NOT NULL,
	allocation_amount DECIMAL(14, 4) NOT NULL,
	adjustment_comment VARCHAR(4000),
	revision_count INT NOT NULL,
	entry_userid VARCHAR(30) NOT NULL,
	entry_timestamp TIMESTAMP(0) NOT NULL,
	update_userid VARCHAR(30) NOT NULL,
	update_timestamp TIMESTAMP(0) NOT NULL,
	fra2003_fn_share_vol_aac DECIMAL(14, 4),
	is_revenue_shareable VARCHAR(1) DEFAULT 'u' NOT NULL
);
