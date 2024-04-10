create table fta_replication.prov_forest_use 
   (	forest_file_id varchar(10) not null, 
	file_status_st varchar(3), 
	file_status_date timestamp(0), 
	file_type_code varchar(3), 
	forest_region bigint not null, 
	bcts_org_unit bigint, 
	sb_funded_ind varchar(1) default 'n' not null, 
	district_admin_zone varchar(4), 
	mgmt_unit_type varchar(1), 
	mgmt_unit_id varchar(4), 
	revision_count int not null, 
	entry_userid varchar(30) not null, 
	entry_timestamp timestamp(0) not null, 
	update_userid varchar(30) not null, 
	update_timestamp timestamp(0) not null, 
	forest_tenure_guid bytea not null
   ) 
 ;

comment on column fta_replication.prov_forest_use.forest_tenure_guid is 'a global unique identifier used to globally identified a forest tenure (aka, forest file). it is used for exchanging data between external applications and services.';
