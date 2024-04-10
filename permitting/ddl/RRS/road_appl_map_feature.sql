create table app_rrs1.road_appl_map_feature 
   (	road_appl_map_feature_guid bytea not null, 
	map_feature_id bigint not null, 
	road_application_guid bytea, 
	road_request_guid bytea, 
	data_source_code varchar(10), 
	road_feature_class_sdw_guid bytea, 
	overlap_provincial_forest_code varchar(10), 
	capture_method_code varchar(30), 
	feature_record_type_code varchar(10) not null, 
	road_tenure_id varchar(10), 
	object_length decimal(15,4), 
	object_area decimal(15,4), 
	point_of_commencement varchar(2000), 
	reference_name varchar(50), 
	bcgs_map_sheet_reference varchar(15), 
	refer_to_file_number_desc varchar(1000), 
	observation_date timestamp(0), 
	data_quality_comment varchar(1000), 
	feature_record_guid bytea, 
	feature_business_identifier varchar(100), 
	road_section_start_station decimal(11,4), 
	road_section_end_station decimal(11,4), 
	revision_count bigint default 0 not null, 
	create_user varchar(32) not null, 
	create_date timestamp(0) default current_timestamp(0) not null, 
	update_user varchar(32) not null, 
	update_date timestamp(0) default current_timestamp(0) not null
   ) 
 ;

comment on table app_rrs1.road_appl_map_feature is 'a road application map feature record represents one map feature of an application. for, example, a road application can consists of one or more sections. each section has its on set of attributes. also, each historical change to an existing section, would have its own record. each record is associated with an image showing the (section, row, gravel pit etc) feature visually. ';
comment on column app_rrs1.road_appl_map_feature.road_appl_map_feature_guid is 'road_appl_map_feature_guid is a unique identifier for the record.';
comment on column app_rrs1.road_appl_map_feature.map_feature_id is 'a system generated sequence number used to uniquely identify a road application map feature  instance.   a global unique identifier used to globally identify a road application map feature record as its primary key, while the map feature id is used as unique key. it used for exchanging information with external applications and services.';
comment on column app_rrs1.road_appl_map_feature.road_application_guid is 'road_application_guid: is a foreign key to road_application: each road application record holds information submitted by the proponents applying for road permit (new construction, amendment or ownership/use).';
comment on column app_rrs1.road_appl_map_feature.road_request_guid is 'road_request_guid is foreign key of road_request. road request contains new (b41, road use permit) or changes requests that submitted via nrsos (aka smart forms).  this class in fact represents the spatial-less application/request. this entity can be seen as an exclusive sibling sub-entity of road application. ';
comment on column app_rrs1.road_appl_map_feature.data_source_code is 'data_source_code: is a foreign key to data_source_code: describes the origin of a feature image.  valid values include:  ap	air photo  cdms	cdms  fc1	forest cover maps  sat	satellite  sur	survey  trim	trim  unk	unknown ';
comment on column app_rrs1.road_appl_map_feature.road_feature_class_sdw_guid is 'road_feature_class_sdw_guid: is a foreign key to road_feature_class_sdw: a road feature class record contains feature class records consumed by resource road system (rrs).  the source records are out of the resource road system. so, the rrs will be updated via a service, either on the demand or based on an scheduled synchronization process.';
comment on column app_rrs1.road_appl_map_feature.overlap_provincial_forest_code is 'overlap_provincial_forest_code: is a foreign key to overlap_provincial_forest_code: an overlap provincial forest code record defines whether an object is within, partially within or completely within a provincial crown land. valid values include: in	area is totally inside of the provincial forest   out	area is totally outside of the provincial forest.   par	area is partially within of the provincial forest  ';
comment on column app_rrs1.road_appl_map_feature.capture_method_code is 'capture_method_code: is a foreign key to capture_method_code: a capture method code record enumerates type of gps capturing method.  valid value includes:  rubbersheeting photogrammetric differentialgps orthophotography unknown nondifferentialgps';
comment on column app_rrs1.road_appl_map_feature.feature_record_type_code is 'feature_record_type_code: is a foreign key to feature_record_type_code: a short text used to uniquely identify a feature record type in the road application map feature. the road application map feature contains different types of features.  valid values include:  real property project non status road gravel pit gazette dedication declaration section              (road section) land                  (road land use)';
comment on column app_rrs1.road_appl_map_feature.road_tenure_id is 'contains the resource road tenure id (in fta referred to as forest file id). ';
comment on column app_rrs1.road_appl_map_feature.object_length is 'the length of the object in meters, remembering that an exhibit a can be made up of multiple objects.';
comment on column app_rrs1.road_appl_map_feature.object_area is 'the area of the object in hectares, remembering that an exhibit a can be made up of multiple objects.';
comment on column app_rrs1.road_appl_map_feature.point_of_commencement is 'the point of commencement for the tenure application map feature.';
comment on column app_rrs1.road_appl_map_feature.reference_name is 'a reference name to a map object that helps someone understand the location of block or other map object without a map. this will likely be supplied via electronic submission.';
comment on column app_rrs1.road_appl_map_feature.bcgs_map_sheet_reference is 'a bcgs map reference that will help a user determine the approximate geographic location of a tenure.';
comment on column app_rrs1.road_appl_map_feature.refer_to_file_number_desc is 'the file number reference for the tenure application map feature.';
comment on column app_rrs1.road_appl_map_feature.observation_date is 'captures the data of observation for the given feature image.';
comment on column app_rrs1.road_appl_map_feature.data_quality_comment is 'allows users to specify comments regarding the accuracy and general quality of the given feature''s data.';
comment on column app_rrs1.road_appl_map_feature.feature_record_guid is 'a global unique identifier referencing a child record that this road application map feature record is created for. this value along with the feature record type (indicating the feature record source) are used to reach the feature record.';
comment on column app_rrs1.road_appl_map_feature.feature_business_identifier is 'contains business key identifier value. it''s a de-normalized value used to pass to the status & clearance application. it used to save more back and forth references between the two application. for example, for road section record the value would the road section id, and for special access road gravel pit, is gravel pit number.';
comment on column app_rrs1.road_appl_map_feature.road_section_start_station is 'the start station of the road section amendment in kilometers.';
comment on column app_rrs1.road_appl_map_feature.road_section_end_station is 'the end station of the road section amendment in kilometers.';
comment on column app_rrs1.road_appl_map_feature.revision_count is 'revision_count is the number of times that the row of data has been changed. the column is used for optimistic locking via application code.';
comment on column app_rrs1.road_appl_map_feature.create_user is 'create_user is an audit column that indicates the user that created the record.';
comment on column app_rrs1.road_appl_map_feature.create_date is 'create_date is the date and time the row of data was created.';
comment on column app_rrs1.road_appl_map_feature.update_user is 'update_user is an audit column that indicates the user that updated the record.';
comment on column app_rrs1.road_appl_map_feature.update_date is 'update_date is the date and time the row of data was updated.';
