CREATE TABLE ats_replication.ats_projects (
	project_id DECIMAL(38, 0) NOT NULL,
	project_name VARCHAR(125) NOT NULL,
	project_status_code VARCHAR(6) NOT NULL,
	description VARCHAR(1200) NULL,
	location VARCHAR(200) NOT NULL,
	location_description VARCHAR(1000) NULL,
	managing_fcbc_region_id DECIMAL(38, 0) NOT NULL,
	subregional_office_id DECIMAL(38, 0) NULL,
	secondary_office_id DECIMAL(38, 0) NULL,
	who_created VARCHAR(30) NOT NULL,
	when_created TIMESTAMP(0) NOT NULL,
	who_updated VARCHAR(30) NULL,
	when_updated TIMESTAMP(0) NULL
);
