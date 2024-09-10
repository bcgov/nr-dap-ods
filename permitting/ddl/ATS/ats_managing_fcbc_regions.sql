CREATE TABLE ats_replication.ats_managing_fcbc_regions (
	managing_fcbc_region_id DECIMAL(38, 0) NOT NULL,
	region_name VARCHAR(50) NOT NULL,
	description VARCHAR(80) NOT NULL,
	fcbc_manager_user VARCHAR(40) NOT NULL,
	who_created VARCHAR(30) NOT NULL,
	when_created TIMESTAMP(0) NOT NULL,
	who_updated VARCHAR(30) NULL,
	when_updated TIMESTAMP(0) NULL,
	expiry_date TIMESTAMP(0) NULL
);
