CREATE TABLE ats_replication.ats_partner_agencies (
	partner_agency_id NUMBER(38, 0) NOT NULL,
	agency_name VARCHAR2(60) NOT NULL,
	description VARCHAR2(75) NOT NULL,
	sort_seq NUMBER(38, 0) NULL,
	overseen_government_level_code VARCHAR2(6) NOT NULL,
	cmpnt_of_government_level_code VARCHAR2(6) NOT NULL,
	who_created VARCHAR2(30) NOT NULL,
	when_created DATE NOT NULL,
	who_updated VARCHAR2(30) NULL,
	when_updated DATE NULL,
	expiry_date DATE NULL
);
