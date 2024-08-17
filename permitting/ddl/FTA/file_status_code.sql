CREATE TABLE fta_replication.file_status_code (
	file_status_code VARCHAR(3) NOT NULL,
	description VARCHAR(120) NOT NULL,
	effective_date TIMESTAMP(0) NOT NULL,
	expiry_date TIMESTAMP(0) NOT NULL,
	update_timestamp TIMESTAMP(0) NOT NULL
);
