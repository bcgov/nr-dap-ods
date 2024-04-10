create table fta_replication.aac_allocation_amount 
   (	aac_allocation_amount_id bigint not null, 
	aac_adjustment_reason_code varchar(4) not null, 
	aac_allocation_period_id bigint not null, 
	allowable_area_type_code varchar(3) not null, 
	allowable_cut_type_code varchar(3) not null, 
	allocation_amount decimal(14,4) not null, 
	adjustment_comment varchar(4000), 
	revision_count int not null, 
	entry_userid varchar(30) not null, 
	entry_timestamp timestamp(0) not null, 
	update_userid varchar(30) not null, 
	update_timestamp timestamp(0) not null, 
	fra2003_fn_share_vol_aac decimal(14,4), 
	is_revenue_shareable varchar(1) default 'u' not null
   ) 
 ;