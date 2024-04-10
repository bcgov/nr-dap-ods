create table ats_replication.ats_regional_users (
	regional_user_id decimal(38,0) not null,
	regional_user varchar(40) not null,
	first_name varchar(40) not null,
	surname varchar(40) not null,
	email varchar(128) not null,
	active_ind varchar(3) default 'yes'  not null,
	resource_officer_ind varchar(3) default 'no'  not null,
	managing_fcbc_region_id decimal(38,0) not null,
	who_created varchar(30) not null,
	when_created timestamp(0) not null,
	who_updated varchar(30) null,
	when_updated timestamp(0) null,
	subregional_office_id decimal(38,0) null
);