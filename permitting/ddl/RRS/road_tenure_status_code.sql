create table app_rrs1.road_tenure_status_code 
   (	road_tenure_status_code varchar(10) not null, 
	description varchar(200) not null, 
	display_order smallint, 
	effective_date timestamp(0) default date_trunc('day', current_timestamp(0)) not null, 
	expiry_date timestamp(0) default to_date('9999-12-31', 'yyyy-mm-dd') not null, 
	create_user varchar(32) not null, 
	create_date timestamp(0) default current_timestamp(0) not null, 
	update_user varchar(32) not null, 
	update_date timestamp(0) default current_timestamp(0) not null
   ) 
 ;

comment on table app_rrs1.road_tenure_status_code is 'a road tenure status code record enumerates road tenure statuses.  valid values include: a	active ah	active (hdbs) an	active - map notation ar	archived as	active - suspended at	archived - transferred ay	active - abeyance ca	cancelled cl	clearance d	disallowed de	designation ee	entered in error hrs	harvesting rights surrendered i	inactive ic	inactive - completed id	inactive - closed (deactivated) ih	inactive - deactivated (hdbs) nc	no clearance or designation p	pending pa	pending - application pe	pending electronic pp	pending - planning pr	pending - review su	suspended';
comment on column app_rrs1.road_tenure_status_code.road_tenure_status_code is 'road_tenure_status_code is a unique identifier for the record.';
comment on column app_rrs1.road_tenure_status_code.description is 'description is the display quality description of the code value.';
comment on column app_rrs1.road_tenure_status_code.display_order is 'display order is to allow non alphabetic sorting e.g. m t w th f s s.';
comment on column app_rrs1.road_tenure_status_code.effective_date is 'effective_date is the date code value becomes effective.';
comment on column app_rrs1.road_tenure_status_code.expiry_date is 'expiry_date is the date code value expires.';
comment on column app_rrs1.road_tenure_status_code.create_user is 'create_user is an audit column that indicates the user that created the record.';
comment on column app_rrs1.road_tenure_status_code.create_date is 'create_date is the date and time the row of data was created.';
comment on column app_rrs1.road_tenure_status_code.update_user is 'update_user is an audit column that indicates the user that updated the record.';
comment on column app_rrs1.road_tenure_status_code.update_date is 'update_date is the date and time the row of data was updated.';