create table fta_replication.org_unit (
	org_unit_no bigint not null,
	org_unit_code varchar(6) not null,
	org_unit_name varchar(100) not null,
	location_code varchar(3) not null,
	area_code varchar(3) not null,
	telephone_no varchar(7) not null,
	org_level_code varchar(1) not null,
	office_name_code varchar(2) not null,
	rollup_region_no bigint not null,
	rollup_region_code varchar(6) not null,
	rollup_dist_no bigint not null,
	rollup_dist_code varchar(6) not null,
	effective_date timestamp(0) not null,
	expiry_date timestamp(0) not null,
	update_timestamp timestamp(0) null
);