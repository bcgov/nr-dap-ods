CREATE TABLE ats_replication.ats_regional_users (
	regional_user_id DECIMAL(38, 0) NOT NULL,
	regional_user VARCHAR(40) NOT NULL,
	first_name VARCHAR(40) NOT NULL,
	surname VARCHAR(40) NOT NULL,
	email VARCHAR(128) NOT NULL,
	active_ind VARCHAR(3) DEFAULT 'yes' NOT NULL,
	resource_officer_ind VARCHAR(3) DEFAULT 'no' NOT NULL,
	managing_fcbc_region_id DECIMAL(38, 0) NOT NULL,
	who_created VARCHAR(30) NOT NULL,
	when_created TIMESTAMP(0) NOT NULL,
	who_updated VARCHAR(30) NULL,
	when_updated TIMESTAMP(0) NULL,
	subregional_office_id DECIMAL(38, 0) NULL
);
