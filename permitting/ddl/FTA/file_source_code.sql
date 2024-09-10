CREATE TABLE fta_replication.file_source_code (
	file_source_code VARCHAR(1) NOT NULL,
	description VARCHAR(120) NOT NULL,
	effective_date TIMESTAMP(0) NOT NULL,
	expiry_date TIMESTAMP(0) NOT NULL,
	update_timestamp TIMESTAMP(0) NOT NULL
);
