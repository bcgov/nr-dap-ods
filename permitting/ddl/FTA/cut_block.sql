create table fta_replication.cut_block 
   (	cb_skey bigint not null, 
	hva_skey bigint, 
	forest_file_id varchar(10) not null, 
	cutting_permit_id varchar(3), 
	timber_mark varchar(10), 
	cut_block_id varchar(10) not null, 
	sp_exempt_ind varchar(1) default 'n' not null, 
	block_status_date timestamp(0), 
	cut_block_description varchar(120), 
	cut_regulation_code varchar(3), 
	block_status_st varchar(3) not null, 
	reforest_declare_type_code varchar(3), 
	revision_count int not null, 
	entry_userid varchar(30) not null, 
	entry_timestamp timestamp(0) not null, 
	update_userid varchar(30) not null, 
	update_timestamp timestamp(0) not null, 
	is_waste_assessment_required varchar(1) default 'u' not null, 
	cut_block_guid bytea not null
   ) 
 ;

comment on column fta_replication.cut_block.is_waste_assessment_required is 'a value indicating whefta_replicationr a harvesting authority record requires waste assessment or not.';
comment on column fta_replication.cut_block.cut_block_guid is 'global unique identifier. created as part of cp / fta 5 changes.';
