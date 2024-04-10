create table app_rrs1.road_org_unit_sdw 
   (	road_org_unit_sdw_guid bytea not null, 
	organization_unit_uri varchar(2000) not null, 
	organization_unit_code varchar(6) not null, 
	road_organization_unit_id bigint not null, 
	organization_unit_name varchar(100) not null, 
	organization_level_code varchar(1) not null, 
	rollup_region_code varchar(6) not null, 
	effective_date timestamp(0) not null, 
	expiry_date timestamp(0) not null, 
	create_user varchar(32) not null, 
	create_date timestamp(0) default current_timestamp(0) not null, 
	update_user varchar(32) not null, 
	update_date timestamp(0) default current_timestamp(0) not null
   ) 
 ;

comment on table app_rrs1.road_org_unit_sdw is 'a road organization unit record contains road organization unit records consumed by resource road system (rrs).  the organization records are used to keep the managing hierarchy as well as geographical.   the source records are external to the resource road system. so, the rrs will be updated via a service, either on demand or based on an scheduled synchronization process.  definition (from the fta system): records codes for ministry organizational units (offices), such as branch, region, or district office. codes are currently defined to the office, section/program, and subsection level. ';
comment on column app_rrs1.road_org_unit_sdw.road_org_unit_sdw_guid is 'road_org_unit_sdw_guid is a unique identifier for the record.';
comment on column app_rrs1.road_org_unit_sdw.organization_unit_uri is 'represents the uri resource value. uri: uniform resource identifier (uri) is a string of characters used to identify a name or a resource on the internet.  such identification enables interaction with representations of the resource over a network (typically the world wide web) using specific protocols';
comment on column app_rrs1.road_org_unit_sdw.organization_unit_code is 'identifies any office within the ministry.  first character identifies exec, hq branch, region, or district.  next two chars identify the office name; next two the section (hq branch) or program (region or district); last char identifies the subsection.';
comment on column app_rrs1.road_org_unit_sdw.road_organization_unit_id is 'a system generated sequence number used to uniquely identify a road organization unit.';
comment on column app_rrs1.road_org_unit_sdw.organization_unit_name is 'the name or title of a ministry office or section; for example kamloops forest region; silviculture branch; kispiox forest district protection program.';
comment on column app_rrs1.road_org_unit_sdw.organization_level_code is 'a one character code enumerating the level of an organization level.  valid values include:  	t    abcs (timber sales)  	r    region  	d    district  	h   headquarter ';
comment on column app_rrs1.road_org_unit_sdw.rollup_region_code is 'identifier designating the region to which the org unit is rolled into for reporting purposes.';
comment on column app_rrs1.road_org_unit_sdw.effective_date is 'the date the organizational unit became effective as a valid org unit within the ministry''s organizational structure.';
comment on column app_rrs1.road_org_unit_sdw.expiry_date is 'the date the organizational unit is obsolete and is no longer an active org unit within the ministry organizational structure.  at the determination of human resources branch, an expired org unit may be retained for historical purposed, or may be deleted.';
comment on column app_rrs1.road_org_unit_sdw.create_user is 'create_user is an audit column that indicates the user that created the record.';
comment on column app_rrs1.road_org_unit_sdw.create_date is 'create_date is the date and time the row of data was created.';
comment on column app_rrs1.road_org_unit_sdw.update_user is 'update_user is an audit column that indicates the user that updated the record.';
comment on column app_rrs1.road_org_unit_sdw.update_date is 'update_date is the date and time the row of data was updated.';
