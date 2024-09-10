CREATE TABLE fta_replication.harvest_auth_status_code (
	harvest_auth_status_code VARCHAR(3) NOT NULL,
	description VARCHAR(120) NOT NULL,
	effective_date TIMESTAMP(0) NOT NULL,
	expiry_date TIMESTAMP(0) NOT NULL,
	update_timestamp TIMESTAMP(0) NOT NULL
);
