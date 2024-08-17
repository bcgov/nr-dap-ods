CREATE TABLE ats_replication.ats_project_status_codes (
	project_status_code VARCHAR(6) NOT NULL,
	NAME VARCHAR(20) NOT NULL,
	description VARCHAR(50) NOT NULL,
	sort_seq DECIMAL(38, 0) NULL,
	who_created VARCHAR(30) NOT NULL,
	when_created TIMESTAMP(0) NOT NULL,
	who_updated VARCHAR(30) NULL,
	when_updated TIMESTAMP(0) NULL
);
