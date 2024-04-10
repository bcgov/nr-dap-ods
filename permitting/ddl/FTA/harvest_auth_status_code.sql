create table fta_replication.harvest_auth_status_code 
   (	harvest_auth_status_code varchar(3) not null, 
	description varchar(120) not null, 
	effective_date timestamp(0) not null, 
	expiry_date timestamp(0) not null, 
	update_timestamp timestamp(0) not null
   ) 
 ;