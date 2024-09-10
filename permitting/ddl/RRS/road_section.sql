CREATE TABLE app_rrs1.road_section (
	road_section_guid bytea NOT NULL,
	resource_road_tenure_guid bytea,
	road_section_id VARCHAR(30) NOT NULL,
	valid_start TIMESTAMP (6),
	valid_end TIMESTAMP (6),
	prev_road_section_guid bytea,
	common_road_section_guid bytea NOT NULL,
	geometry_road_section_guid bytea,
	road_section_amendment_code VARCHAR(10),
	road_section_status_code VARCHAR(10) NOT NULL,
	road_retirement_reason_code VARCHAR(10),
	section_name VARCHAR(30),
	current_length DECIMAL(11, 4) NOT NULL,
	section_width SMALLINT NOT NULL,
	retirement_date TIMESTAMP(0),
	agriculture_land_reserve_ind VARCHAR(1),
	current_ind VARCHAR(1) DEFAULT 'n' NOT NULL,
	district_admin_zone VARCHAR(4),
	overarching_tenure_id VARCHAR(10),
	last_status_date TIMESTAMP(0) NOT NULL,
	segments_confirmed_ind VARCHAR(1) DEFAULT 'n' NOT NULL,
	segments_confirmed_userid VARCHAR(32),
	segments_confirmed_timestamp TIMESTAMP(0),
	comments VARCHAR(2000),
	revision_count bigint DEFAULT 0 NOT NULL,
	create_user VARCHAR(32) NOT NULL,
	create_date TIMESTAMP(0) DEFAULT current_timestamp(0) NOT NULL,
	update_user VARCHAR(32) NOT NULL,
	update_date TIMESTAMP(0) DEFAULT current_timestamp(0) NOT NULL,
	issuance_conditions VARCHAR(2000)
);

COMMENT ON TABLE app_rrs1.road_section IS 'a road is divided in one or more sections in order to have more control over it for managerial and maintenance purposes. a road is built in sections. as a road is lengthened, or shortened, this is done by section. sections are added by submission; shortened or lengthened by amendment submission; transferred and/ or retired. retirements occur within the application or by submission. transfers can only be done within the rrs application. each road section record maintains and holds section information such as section name, center-line, width, length, original length, retirement date, and pointer to its special information. road section records kept with their historical changes. changes (amendments) are recorded with current ind set to ''n'' until it approved (which it becomes the current and the record with the current ind updated to ''n''). rejected amendment records are marked for later purge.';

COMMENT ON column app_rrs1.road_section.road_section_guid IS 'road_section_guid is a unique identifier for the record.';

COMMENT ON column app_rrs1.road_section.road_section_id IS 'an alpha-numeric value used to uniquely identify an section within a road tenure.  because the section history records are kept in this entity, the road section id + road tenure id may not be unique.';

COMMENT ON column app_rrs1.road_section.valid_start IS 'a timestamp indicating the date/time when road section record becomes valid/effective.';

COMMENT ON column app_rrs1.road_section.valid_end IS 'a timestamp indicating the date/time when road section record is not in effect anymore (not valid).';

COMMENT ON column app_rrs1.road_section.prev_road_section_guid IS 'prev_road_section_guid: is a foreign key to road_section: a road is divided in one or more sections in order to have more control over it for managerial and maintenance purposes. a road is built in sections. as a road is lengthened, or shortened, this is done by section. sections are added by submission; shortened or lengthened by amendment submission; transferred and/ or retired. retirements occur within the application or by submission. transfers can only be done within the rrs application. each road section record maintains and holds section information such as section name, center-line, width, length, original length, retirement date, and pointer to its special information. road section records kept with their historical changes. changes (amendments) are recorded with current ind set to ''n'' until it approved (which it becomes the current and the record with the current ind updated to ''n''). rejected amendment records are marked for later purge.';

COMMENT ON column app_rrs1.road_section.common_road_section_guid IS 'common_road_section_guid: is a foreign key to road_section: a road is divided in one or more sections in order to have more control over it for managerial and maintenance purposes. a road is built in sections. as a road is lengthened, or shortened, this is done by section. sections are added by submission; shortened or lengthened by amendment submission; transferred and/ or retired. retirements occur within the application or by submission. transfers can only be done within the rrs application. each road section record maintains and holds section information such as section name, center-line, width, length, original length, retirement date, and pointer to its special information. road section records kept with their historical changes. changes (amendments) are recorded with current ind set to ''n'' until it approved (which it becomes the current and the record with the current ind updated to ''n''). rejected amendment records are marked for later purge.';

COMMENT ON column app_rrs1.road_section.geometry_road_section_guid IS 'geometry_road_section_guid: is a foreign key to road_section: a road is divided in one or more sections in order to have more control over it for managerial and maintenance purposes. a road is built in sections. as a road is lengthened, or shortened, this is done by section. sections are added by submission; shortened or lengthened by amendment submission; transferred and/ or retired. retirements occur within the application or by submission. transfers can only be done within the rrs application. each road section record maintains and holds section information such as section name, center-line, width, length, original length, retirement date, and pointer to its special information. road section records kept with their historical changes. changes (amendments) are recorded with current ind set to ''n'' until it approved (which it becomes the current and the record with the current ind updated to ''n''). rejected amendment records are marked for later purge.';

COMMENT ON column app_rrs1.road_section.road_section_amendment_code IS 'road_section_amendment_code: is a foreign key to road_section_amendment_code: a code / abbreviated text enumerates a type of amendment with regards to an existing road. valid values include:  rmv	remove   add         adding section   ren 	re-engineering       code                  description ----------               ------------------------------------------------- create                  creating a new section re-eng                   re-engineering a section shortening        reducing a section length increase               increasing a section length delete                   deleting a section relabel                 re-labeling a section transfer              transferring a section split      splitting a section';

COMMENT ON column app_rrs1.road_section.road_section_status_code IS 'road_section_status_code: is a foreign key to road_section_status_code: a road section status code record enumerates a status code of road section.   valid values include: hi	issued  hn	issued but not printed  pe	pending electronic ';

COMMENT ON column app_rrs1.road_section.road_retirement_reason_code IS 'road_retirement_reason_code: is a foreign key to road_retirement_reason_code: it enumerates the retirement reason type.  valid values include:     deactivation     reassignment     not built';

COMMENT ON column app_rrs1.road_section.section_name IS 'a text value specifying the name of a road section within a road tenure.';

COMMENT ON column app_rrs1.road_section.current_length IS 'a numeric value showing the section''s current length in kilometer.';

COMMENT ON column app_rrs1.road_section.section_width IS 'a numeric value representing the width of section in meters.';

COMMENT ON column app_rrs1.road_section.retirement_date IS 'a date value representing the date when a road section was retired.';

COMMENT ON column app_rrs1.road_section.agriculture_land_reserve_ind IS 'a one character flag indicating whether a section is within an agriculture land reserve (''y'') or is not (''n'').';

COMMENT ON column app_rrs1.road_section.current_ind IS 'a flag indicating the currency of the section. at any time only one section with a specific  road section id (within a road permit) can be current. newly approved changes to an existing section will be the current road section and the existing record current ind updates to ''n'', indicating the record isn''t current anymore.';

COMMENT ON column app_rrs1.road_section.district_admin_zone IS 'district admin zone is a free format field used internally by the districts to group files within a district for reporting purposes.  examples of use are setting the field to a geographic area or to a persons initials.  reports can be pulled off by district admin zone to aid work management. this field is not used by all districts.';

COMMENT ON column app_rrs1.road_section.overarching_tenure_id IS 'an alpha-numeric value representing the overarching tenure id (forest file id in fta) for the section. ';

COMMENT ON column app_rrs1.road_section.last_status_date IS 'the date the amendment status was changed.';

COMMENT ON column app_rrs1.road_section.segments_confirmed_ind IS 'identifies if segments for the given section have been confirmed in the inbox.';

COMMENT ON column app_rrs1.road_section.segments_confirmed_userid IS ' identifies the application user who confirmed the segments in the inbox for the given section.';

COMMENT ON column app_rrs1.road_section.segments_confirmed_timestamp IS 'identifies the date and time the application user confirmed the segments in the inbox for the given section.';

COMMENT ON column app_rrs1.road_section.comments IS 'a free format text providing additional notes/comments related to a road section. ';

COMMENT ON column app_rrs1.road_section.revision_count IS 'revision_count is the number of times that the row of data has been changed. the column is used for optimistic locking via application code.';

COMMENT ON column app_rrs1.road_section.create_user IS 'create_user is an audit column that indicates the user that created the record.';

COMMENT ON column app_rrs1.road_section.create_date IS 'create_date is the date and time the row of data was created.';

COMMENT ON column app_rrs1.road_section.update_user IS 'update_user is an audit column that indicates the user that updated the record.';

COMMENT ON column app_rrs1.road_section.update_date IS 'update_date is the date and time the row of data was updated.';

COMMENT ON column app_rrs1.road_section.issuance_conditions IS 'issuance_conditions these are any conditions attached to the issuance of this road section such as � road may not be used or built during the spring due to ungulate breeding.';
