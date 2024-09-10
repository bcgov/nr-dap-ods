CREATE TABLE ats_replication.ats_authorization_instruments (
	authorization_instrument_id DECIMAL(38, 0) NOT NULL,
	authorization_instrument_name VARCHAR(175) NOT NULL,
	partner_agency_id DECIMAL(38, 0) NOT NULL,
	description VARCHAR(120) NOT NULL,
	expiry_date TIMESTAMP(0) NULL,
	tier_level SMALLINT NULL,
	who_created VARCHAR(30) NOT NULL,
	when_created TIMESTAMP(0) NOT NULL,
	who_updated VARCHAR(30) NULL,
	when_updated TIMESTAMP(0) NULL
);
