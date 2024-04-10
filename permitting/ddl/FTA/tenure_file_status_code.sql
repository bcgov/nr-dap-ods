create table fta_replication.tenure_file_status_code 
   (	tenure_file_status_code varchar(3) not null, 
	description varchar(120) not null, 
	effective_date timestamp(0) not null, 
	expiry_date timestamp(0) not null, 
	update_timestamp timestamp(0) not null
   ) 
 ;