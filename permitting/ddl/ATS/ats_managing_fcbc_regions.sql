create table ats_replication.ats_managing_fcbc_regions (
	managing_fcbc_region_id decimal(38,0) not null,
	region_name varchar(50) not null,
	description varchar(80) not null,
	fcbc_manager_user varchar(40) not null,
	who_created varchar(30) not null,
	when_created timestamp(0) not null,
	who_updated varchar(30) null,
	when_updated timestamp(0) null,
	expiry_date timestamp(0) null
);