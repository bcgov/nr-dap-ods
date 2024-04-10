create table ats_replication.ats_project_type_codes (
	project_type_code varchar(6) not null,
	name varchar(60) not null,
	description varchar(150) not null,
	sort_seq decimal(38,0) null,
	who_created varchar(30) not null,
	when_created timestamp(0) not null,
	who_updated varchar(30) null,
	when_updated timestamp(0) null,
	expiry_date timestamp(0) null,
	category varchar(1) not null
);