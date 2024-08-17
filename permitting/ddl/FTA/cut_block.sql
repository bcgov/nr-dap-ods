CREATE TABLE fta_replication.cut_block (
	cb_skey bigint NOT NULL,
	hva_skey bigint,
	forest_file_id VARCHAR(10) NOT NULL,
	cutting_permit_id VARCHAR(3),
	timber_mark VARCHAR(10),
	cut_block_id VARCHAR(10) NOT NULL,
	sp_exempt_ind VARCHAR(1) DEFAULT 'n' NOT NULL,
	block_status_date TIMESTAMP(0),
	cut_block_description VARCHAR(120),
	cut_regulation_code VARCHAR(3),
	block_status_st VARCHAR(3) NOT NULL,
	reforest_declare_type_code VARCHAR(3),
	revision_count INT NOT NULL,
	entry_userid VARCHAR(30) NOT NULL,
	entry_timestamp TIMESTAMP(0) NOT NULL,
	update_userid VARCHAR(30) NOT NULL,
	update_timestamp TIMESTAMP(0) NOT NULL,
	is_waste_assessment_required VARCHAR(1) DEFAULT 'u' NOT NULL,
	cut_block_guid bytea NOT NULL
);

COMMENT ON column fta_replication.cut_block.is_waste_assessment_required IS 'a value indicating whefta_replicationr a harvesting authority record requires waste assessment or not.';

COMMENT ON column fta_replication.cut_block.cut_block_guid IS 'global unique identifier. created as part of cp / fta 5 changes.';
