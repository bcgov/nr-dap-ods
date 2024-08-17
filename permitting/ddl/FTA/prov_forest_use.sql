CREATE TABLE fta_replication.prov_forest_use (
	forest_file_id VARCHAR(10) NOT NULL,
	file_status_st VARCHAR(3),
	file_status_date TIMESTAMP(0),
	file_type_code VARCHAR(3),
	forest_region bigint NOT NULL,
	bcts_org_unit bigint,
	sb_funded_ind VARCHAR(1) DEFAULT 'n' NOT NULL,
	district_admin_zone VARCHAR(4),
	mgmt_unit_type VARCHAR(1),
	mgmt_unit_id VARCHAR(4),
	revision_count INT NOT NULL,
	entry_userid VARCHAR(30) NOT NULL,
	entry_timestamp TIMESTAMP(0) NOT NULL,
	update_userid VARCHAR(30) NOT NULL,
	update_timestamp TIMESTAMP(0) NOT NULL,
	forest_tenure_guid bytea NOT NULL
);

COMMENT ON column fta_replication.prov_forest_use.forest_tenure_guid IS 'a global unique identifier used to globally identified a forest tenure (aka, forest file). it is used for exchanging data between external applications and services.';
