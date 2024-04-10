create table app_rrs1.road_feature_class_sdw 
   (	road_feature_class_sdw_guid bytea not null, 
	feature_class_uri varchar(2000) not null, 
	feature_class_skey bigint not null, 
	name varchar(60) not null, 
	group_name_code varchar(10) not null, 
	feature_type_code varchar(10) not null, 
	create_user varchar(32) not null, 
	create_date timestamp(0) default current_timestamp(0) not null, 
	update_user varchar(32) not null, 
	update_date timestamp(0) default current_timestamp(0) not null
   ) 
 ;

comment on table app_rrs1.road_feature_class_sdw is 'a road feature class record contains feature class records consumed by resource road system (rrs).  the source records are out of the resource road system. so, the rrs will be updated via a service, either on the demand or based on an scheduled synchronization process.';
comment on column app_rrs1.road_feature_class_sdw.road_feature_class_sdw_guid is 'road_feature_class_sdw_guid is a unique identifier for the record.';
comment on column app_rrs1.road_feature_class_sdw.feature_class_uri is 'contains the uri of feature classes resource.  uri: uniform resource identifier (uri) is a string of characters used to identify a name or a resource on the internet.  such identification enables interaction with representations of the resource over a network (typically the world wide web) using specific protocols';
comment on column app_rrs1.road_feature_class_sdw.feature_class_skey is 'unique identifier of the feature class.';
comment on column app_rrs1.road_feature_class_sdw.name is 'a text value specifying the name of the feature class.';
comment on column app_rrs1.road_feature_class_sdw.group_name_code is 'a code specifying the group that the feature class is belonged to.';
comment on column app_rrs1.road_feature_class_sdw.feature_type_code is 'a code representing the type of feature class.';
comment on column app_rrs1.road_feature_class_sdw.create_user is 'create_user is an audit column that indicates the user that created the record.';
comment on column app_rrs1.road_feature_class_sdw.create_date is 'create_date is the date and time the row of data was created.';
comment on column app_rrs1.road_feature_class_sdw.update_user is 'update_user is an audit column that indicates the user that updated the record.';
comment on column app_rrs1.road_feature_class_sdw.update_date is 'update_date is the date and time the row of data was updated.';
