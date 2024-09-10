CREATE TABLE app_rrs1.road_feature_class_sdw (
	road_feature_class_sdw_guid bytea NOT NULL,
	feature_class_uri VARCHAR(2000) NOT NULL,
	feature_class_skey bigint NOT NULL,
	NAME VARCHAR(60) NOT NULL,
	group_name_code VARCHAR(10) NOT NULL,
	feature_type_code VARCHAR(10) NOT NULL,
	create_user VARCHAR(32) NOT NULL,
	create_date TIMESTAMP(0) DEFAULT current_timestamp(0) NOT NULL,
	update_user VARCHAR(32) NOT NULL,
	update_date TIMESTAMP(0) DEFAULT current_timestamp(0) NOT NULL
);

COMMENT ON TABLE app_rrs1.road_feature_class_sdw IS 'a road feature class record contains feature class records consumed by resource road system (rrs).  the source records are out of the resource road system. so, the rrs will be updated via a service, either on the demand or based on an scheduled synchronization process.';

COMMENT ON column app_rrs1.road_feature_class_sdw.road_feature_class_sdw_guid IS 'road_feature_class_sdw_guid is a unique identifier for the record.';

COMMENT ON column app_rrs1.road_feature_class_sdw.feature_class_uri IS 'contains the uri of feature classes resource.  uri: uniform resource identifier (uri) is a string of characters used to identify a name or a resource on the internet.  such identification enables interaction with representations of the resource over a network (typically the world wide web) using specific protocols';

COMMENT ON column app_rrs1.road_feature_class_sdw.feature_class_skey IS 'unique identifier of the feature class.';

COMMENT ON column app_rrs1.road_feature_class_sdw.name IS 'a text value specifying the name of the feature class.';

COMMENT ON column app_rrs1.road_feature_class_sdw.group_name_code IS 'a code specifying the group that the feature class is belonged to.';

COMMENT ON column app_rrs1.road_feature_class_sdw.feature_type_code IS 'a code representing the type of feature class.';

COMMENT ON column app_rrs1.road_feature_class_sdw.create_user IS 'create_user is an audit column that indicates the user that created the record.';

COMMENT ON column app_rrs1.road_feature_class_sdw.create_date IS 'create_date is the date and time the row of data was created.';

COMMENT ON column app_rrs1.road_feature_class_sdw.update_user IS 'update_user is an audit column that indicates the user that updated the record.';

COMMENT ON column app_rrs1.road_feature_class_sdw.update_date IS 'update_date is the date and time the row of data was updated.';
