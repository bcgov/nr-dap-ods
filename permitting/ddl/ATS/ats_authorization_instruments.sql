create table ats_replication.ats_authorization_instruments (
	authorization_instrument_id decimal(38,0) not null,
	authorization_instrument_name varchar(175) not null,
	partner_agency_id decimal(38,0) not null,
	description varchar(120) not null,
	expiry_date timestamp(0) null,
	tier_level smallint null,
	who_created varchar(30) not null,
	when_created timestamp(0) not null,
	who_updated varchar(30) null,
	when_updated timestamp(0) null
);