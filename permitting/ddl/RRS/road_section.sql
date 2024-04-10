create table app_rrs1.road_section 
   (	road_section_guid bytea not null, 
	resource_road_tenure_guid bytea, 
	road_section_id varchar(30) not null, 
	valid_start timestamp (6), 
	valid_end timestamp (6), 
	prev_road_section_guid bytea, 
	common_road_section_guid bytea not null, 
	geometry_road_section_guid bytea, 
	road_section_amendment_code varchar(10), 
	road_section_status_code varchar(10) not null, 
	road_retirement_reason_code varchar(10), 
	section_name varchar(30), 
	current_length decimal(11,4) not null, 
	section_width smallint not null, 
	retirement_date timestamp(0), 
	agriculture_land_reserve_ind varchar(1), 
	current_ind varchar(1) default 'n' not null, 
	district_admin_zone varchar(4), 
	overarching_tenure_id varchar(10), 
	last_status_date timestamp(0) not null, 
	segments_confirmed_ind varchar(1) default 'n' not null, 
	segments_confirmed_userid varchar(32), 
	segments_confirmed_timestamp timestamp(0), 
	comments varchar(2000), 
	revision_count bigint default 0 not null, 
	create_user varchar(32) not null, 
	create_date timestamp(0) default current_timestamp(0) not null, 
	update_user varchar(32) not null, 
	update_date timestamp(0) default current_timestamp(0) not null, 
	issuance_conditions varchar(2000)
   ) 
 ;

comment on table app_rrs1.road_section is 'a road is divided in one or more sections in order to have more control over it for managerial and maintenance purposes. a road is built in sections. as a road is lengthened, or shortened, this is done by section. sections are added by submission; shortened or lengthened by amendment submission; transferred and/ or retired. retirements occur within the application or by submission. transfers can only be done within the rrs application. each road section record maintains and holds section information such as section name, center-line, width, length, original length, retirement date, and pointer to its special information. road section records kept with their historical changes. changes (amendments) are recorded with current ind set to ''n'' until it approved (which it becomes the current and the record with the current ind updated to ''n''). rejected amendment records are marked for later purge.';
comment on column app_rrs1.road_section.road_section_guid is 'road_section_guid is a unique identifier for the record.';
comment on column app_rrs1.road_section.road_section_id is 'an alpha-numeric value used to uniquely identify an section within a road tenure.  because the section history records are kept in this entity, the road section id + road tenure id may not be unique.';
comment on column app_rrs1.road_section.valid_start is 'a timestamp indicating the date/time when road section record becomes valid/effective.';
comment on column app_rrs1.road_section.valid_end is 'a timestamp indicating the date/time when road section record is not in effect anymore (not valid).';
comment on column app_rrs1.road_section.prev_road_section_guid is 'prev_road_section_guid: is a foreign key to road_section: a road is divided in one or more sections in order to have more control over it for managerial and maintenance purposes. a road is built in sections. as a road is lengthened, or shortened, this is done by section. sections are added by submission; shortened or lengthened by amendment submission; transferred and/ or retired. retirements occur within the application or by submission. transfers can only be done within the rrs application. each road section record maintains and holds section information such as section name, center-line, width, length, original length, retirement date, and pointer to its special information. road section records kept with their historical changes. changes (amendments) are recorded with current ind set to ''n'' until it approved (which it becomes the current and the record with the current ind updated to ''n''). rejected amendment records are marked for later purge.';
comment on column app_rrs1.road_section.common_road_section_guid is 'common_road_section_guid: is a foreign key to road_section: a road is divided in one or more sections in order to have more control over it for managerial and maintenance purposes. a road is built in sections. as a road is lengthened, or shortened, this is done by section. sections are added by submission; shortened or lengthened by amendment submission; transferred and/ or retired. retirements occur within the application or by submission. transfers can only be done within the rrs application. each road section record maintains and holds section information such as section name, center-line, width, length, original length, retirement date, and pointer to its special information. road section records kept with their historical changes. changes (amendments) are recorded with current ind set to ''n'' until it approved (which it becomes the current and the record with the current ind updated to ''n''). rejected amendment records are marked for later purge.';
comment on column app_rrs1.road_section.geometry_road_section_guid is 'geometry_road_section_guid: is a foreign key to road_section: a road is divided in one or more sections in order to have more control over it for managerial and maintenance purposes. a road is built in sections. as a road is lengthened, or shortened, this is done by section. sections are added by submission; shortened or lengthened by amendment submission; transferred and/ or retired. retirements occur within the application or by submission. transfers can only be done within the rrs application. each road section record maintains and holds section information such as section name, center-line, width, length, original length, retirement date, and pointer to its special information. road section records kept with their historical changes. changes (amendments) are recorded with current ind set to ''n'' until it approved (which it becomes the current and the record with the current ind updated to ''n''). rejected amendment records are marked for later purge.';
comment on column app_rrs1.road_section.road_section_amendment_code is 'road_section_amendment_code: is a foreign key to road_section_amendment_code: a code / abbreviated text enumerates a type of amendment with regards to an existing road. valid values include:  rmv	remove   add         adding section   ren 	re-engineering       code                  description ----------               ------------------------------------------------- create                  creating a new section re-eng                   re-engineering a section shortening        reducing a section length increase               increasing a section length delete                   deleting a section relabel                 re-labeling a section transfer              transferring a section split      splitting a section';
comment on column app_rrs1.road_section.road_section_status_code is 'road_section_status_code: is a foreign key to road_section_status_code: a road section status code record enumerates a status code of road section.   valid values include: hi	issued  hn	issued but not printed  pe	pending electronic ';
comment on column app_rrs1.road_section.road_retirement_reason_code is 'road_retirement_reason_code: is a foreign key to road_retirement_reason_code: it enumerates the retirement reason type.  valid values include:     deactivation     reassignment     not built';
comment on column app_rrs1.road_section.section_name is 'a text value specifying the name of a road section within a road tenure.';
comment on column app_rrs1.road_section.current_length is 'a numeric value showing the section''s current length in kilometer.';
comment on column app_rrs1.road_section.section_width is 'a numeric value representing the width of section in meters.';
comment on column app_rrs1.road_section.retirement_date is 'a date value representing the date when a road section was retired.';
comment on column app_rrs1.road_section.agriculture_land_reserve_ind is 'a one character flag indicating whether a section is within an agriculture land reserve (''y'') or is not (''n'').';
comment on column app_rrs1.road_section.current_ind is 'a flag indicating the currency of the section. at any time only one section with a specific  road section id (within a road permit) can be current. newly approved changes to an existing section will be the current road section and the existing record current ind updates to ''n'', indicating the record isn''t current anymore.';
comment on column app_rrs1.road_section.district_admin_zone is 'district admin zone is a free format field used internally by the districts to group files within a district for reporting purposes.  examples of use are setting the field to a geographic area or to a persons initials.  reports can be pulled off by district admin zone to aid work management. this field is not used by all districts.';
comment on column app_rrs1.road_section.overarching_tenure_id is 'an alpha-numeric value representing the overarching tenure id (forest file id in fta) for the section. ';
comment on column app_rrs1.road_section.last_status_date is 'the date the amendment status was changed.';
comment on column app_rrs1.road_section.segments_confirmed_ind is 'identifies if segments for the given section have been confirmed in the inbox.';
comment on column app_rrs1.road_section.segments_confirmed_userid is ' identifies the application user who confirmed the segments in the inbox for the given section.';
comment on column app_rrs1.road_section.segments_confirmed_timestamp is 'identifies the date and time the application user confirmed the segments in the inbox for the given section.';
comment on column app_rrs1.road_section.comments is 'a free format text providing additional notes/comments related to a road section. ';
comment on column app_rrs1.road_section.revision_count is 'revision_count is the number of times that the row of data has been changed. the column is used for optimistic locking via application code.';
comment on column app_rrs1.road_section.create_user is 'create_user is an audit column that indicates the user that created the record.';
comment on column app_rrs1.road_section.create_date is 'create_date is the date and time the row of data was created.';
comment on column app_rrs1.road_section.update_user is 'update_user is an audit column that indicates the user that updated the record.';
comment on column app_rrs1.road_section.update_date is 'update_date is the date and time the row of data was updated.';
comment on column app_rrs1.road_section.issuance_conditions is 'issuance_conditions these are any conditions attached to the issuance of this road section such as � road may not be used or built during the spring due to ungulate breeding.';
