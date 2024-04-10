CREATE TABLE app_rrs1.road_tenure_type_code 
   (	road_tenure_type_code VARCHAR(10) NOT NULL, 
	description VARCHAR(200) NOT NULL, 
	display_order SMALLINT, 
	effective_date TIMESTAMP(0) DEFAULT DATE_TRUNC('day', CURRENT_TIMESTAMP(0)) NOT NULL, 
	expiry_date TIMESTAMP(0) DEFAULT TO_DATE('9999-12-31', 'yyyy-mm-dd') NOT NULL, 
	create_user VARCHAR(32) NOT NULL, 
	create_date TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP(0) NOT NULL, 
	update_user VARCHAR(32) NOT NULL, 
	update_date TIMESTAMP(0) DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
   ) 
   ;

comment on table app_rrs1.road_tenure_type_code is 'a road tenure type code record enumerates an rrs road tenure type. valid values include:  b01 road permit    b40 forest service road    s01 special use permit, forest    s02 special use permit, non-forest    q02 non status road  q03 real property project';
comment on column app_rrs1.road_tenure_type_code.road_tenure_type_code is 'road_tenure_type_code is a unique identifier for the record.';
comment on column app_rrs1.road_tenure_type_code.description is 'description is the display quality description of the code value.';
comment on column app_rrs1.road_tenure_type_code.display_order is 'display order is to allow non alphabetic sorting e.g. m t w th f s s.';
comment on column app_rrs1.road_tenure_type_code.effective_date is 'effective_date is the date code value becomes effective.';
comment on column app_rrs1.road_tenure_type_code.expiry_date is 'expiry_date is the date code value expires.';
comment on column app_rrs1.road_tenure_type_code.create_user is 'create_user is an audit column that indicates the user that created the record.';
comment on column app_rrs1.road_tenure_type_code.create_date is 'create_date is the date and time the row of data was created.';
comment on column app_rrs1.road_tenure_type_code.update_user is 'update_user is an audit column that indicates the user that updated the record.';
comment on column app_rrs1.road_tenure_type_code.update_date is 'update_date is the date and time the row of data was updated.';
