create table fta_replication.harvest_type_code 
   (	harvest_type_code varchar(1) not null, 
	description varchar(120) not null, 
	effective_date timestamp(0) not null, 
	expiry_date timestamp(0) not null, 
	update_timestamp timestamp(0) not null
   ) 
 ;