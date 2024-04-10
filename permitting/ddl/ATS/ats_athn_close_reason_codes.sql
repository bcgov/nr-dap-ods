create table ats_replication.ats_athn_close_reason_codes (
	athn_close_reason_code varchar(6) not null,
	name varchar(40) not null,
	description varchar(80) not null,
	sort_seq decimal(38,0) null,
	who_created varchar(30) not null,
	when_created timestamp(0) not null,
	who_updated varchar(30) null,
	when_updated timestamp(0) null
);