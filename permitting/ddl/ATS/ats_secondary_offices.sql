create table ats_replication.ats_secondary_offices (
	secondary_office_id decimal(38,0) not null,
	secondary_office_name varchar(50) not null,
	description varchar(80) not null,
	expiry_date timestamp(0) null,
	managing_fcbc_region_id decimal(38,0) not null,
	who_created varchar(30) not null,
	when_created timestamp(0) not null,
	who_updated varchar(30) null,
	when_updated timestamp(0) null
);