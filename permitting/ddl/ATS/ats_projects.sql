create table ats_replication.ats_projects (
	project_id decimal(38,0) not null,
	project_name varchar(125) not null,
	project_status_code varchar(6) not null,
	description varchar(1200) null,
	location varchar(200) not null,
	location_description varchar(1000) null,
	managing_fcbc_region_id decimal(38,0) not null,
	subregional_office_id decimal(38,0) null,
	secondary_office_id decimal(38,0) null,
	who_created varchar(30) not null,
	when_created timestamp(0) not null,
	who_updated varchar(30) null,
	when_updated timestamp(0) null
);