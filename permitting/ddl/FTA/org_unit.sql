CREATE TABLE fta_replication.org_unit (
	org_unit_no bigint NOT NULL,
	org_unit_code VARCHAR(6) NOT NULL,
	org_unit_name VARCHAR(100) NOT NULL,
	location_code VARCHAR(3) NOT NULL,
	area_code VARCHAR(3) NOT NULL,
	telephone_no VARCHAR(7) NOT NULL,
	org_level_code VARCHAR(1) NOT NULL,
	office_name_code VARCHAR(2) NOT NULL,
	rollup_region_no bigint NOT NULL,
	rollup_region_code VARCHAR(6) NOT NULL,
	rollup_dist_no bigint NOT NULL,
	rollup_dist_code VARCHAR(6) NOT NULL,
	effective_date TIMESTAMP(0) NOT NULL,
	expiry_date TIMESTAMP(0) NOT NULL,
	update_timestamp TIMESTAMP(0) NULL
);
