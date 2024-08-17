CREATE TABLE ats_replication.ats_proj_proj_type_code_xref (
	project_id DECIMAL(38, 0) NOT NULL,
	project_type_code VARCHAR(6) NOT NULL,
	who_created VARCHAR(30) NOT NULL,
	when_created TIMESTAMP(0) NOT NULL,
	who_updated VARCHAR(30) NULL,
	when_updated TIMESTAMP(0) NULL
);
