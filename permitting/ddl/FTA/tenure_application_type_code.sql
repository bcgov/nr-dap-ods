create table fta_replication.tenure_application_type_code 
   (	tenure_application_type_code varchar(3) not null, 
	description varchar(120) not null, 
	effective_date timestamp(0) not null, 
	expiry_date timestamp(0) not null, 
	update_timestamp timestamp(0) not null
   ) 
 ;