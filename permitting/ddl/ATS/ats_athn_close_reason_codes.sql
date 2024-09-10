CREATE TABLE ats_replication.ats_athn_close_reason_codes (
	athn_close_reason_code VARCHAR(6) NOT NULL,
	NAME VARCHAR(40) NOT NULL,
	description VARCHAR(80) NOT NULL,
	sort_seq DECIMAL(38, 0) NULL,
	who_created VARCHAR(30) NOT NULL,
	when_created TIMESTAMP(0) NOT NULL,
	who_updated VARCHAR(30) NULL,
	when_updated TIMESTAMP(0) NULL
);
