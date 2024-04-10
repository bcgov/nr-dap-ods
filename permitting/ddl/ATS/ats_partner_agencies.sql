create table ats_replication.ats_partner_agencies (
	partner_agency_id number(38,0) not null,
	agency_name varchar2(60) not null,
	description varchar2(75) not null,
	sort_seq number(38,0) null,
	overseen_government_level_code varchar2(6) not null,
	cmpnt_of_government_level_code varchar2(6) not null,
	who_created varchar2(30) not null,
	when_created date not null,
	who_updated varchar2(30) null,
	when_updated date null,
	expiry_date date null
);