create table ats_replication.ats_project_status_codes (
	project_status_code varchar(6) not null,
	name varchar(20) not null,
	description varchar(50) not null,
	sort_seq decimal(38,0) null,
	who_created varchar(30) not null,
	when_created timestamp(0) not null,
	who_updated varchar(30) null,
	when_updated timestamp(0) null
);