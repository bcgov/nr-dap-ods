CREATE TABLE fta_replication.file_type_code (
	file_type_code VARCHAR(10) NOT NULL,
	description VARCHAR(120) NOT NULL,
	effective_date TIMESTAMP(0) NOT NULL,
	expiry_date TIMESTAMP(0) NOT NULL,
	update_timestamp TIMESTAMP(0) NOT NULL
);
