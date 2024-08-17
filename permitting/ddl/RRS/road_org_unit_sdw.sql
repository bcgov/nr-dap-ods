CREATE TABLE app_rrs1.road_org_unit_sdw (
	road_org_unit_sdw_guid bytea NOT NULL,
	organization_unit_uri VARCHAR(2000) NOT NULL,
	organization_unit_code VARCHAR(6) NOT NULL,
	road_organization_unit_id bigint NOT NULL,
	organization_unit_name VARCHAR(100) NOT NULL,
	organization_level_code VARCHAR(1) NOT NULL,
	rollup_region_code VARCHAR(6) NOT NULL,
	effective_date TIMESTAMP(0) NOT NULL,
	expiry_date TIMESTAMP(0) NOT NULL,
	create_user VARCHAR(32) NOT NULL,
	create_date TIMESTAMP(0) DEFAULT current_timestamp(0) NOT NULL,
	update_user VARCHAR(32) NOT NULL,
	update_date TIMESTAMP(0) DEFAULT current_timestamp(0) NOT NULL
);

COMMENT ON TABLE app_rrs1.road_org_unit_sdw IS 'a road organization unit record contains road organization unit records consumed by resource road system (rrs).  the organization records are used to keep the managing hierarchy as well as geographical.   the source records are external to the resource road system. so, the rrs will be updated via a service, either on demand or based on an scheduled synchronization process.  definition (from the fta system): records codes for ministry organizational units (offices), such as branch, region, or district office. codes are currently defined to the office, section/program, and subsection level. ';

COMMENT ON column app_rrs1.road_org_unit_sdw.road_org_unit_sdw_guid IS 'road_org_unit_sdw_guid is a unique identifier for the record.';

COMMENT ON column app_rrs1.road_org_unit_sdw.organization_unit_uri IS 'represents the uri resource value. uri: uniform resource identifier (uri) is a string of characters used to identify a name or a resource on the internet.  such identification enables interaction with representations of the resource over a network (typically the world wide web) using specific protocols';

COMMENT ON column app_rrs1.road_org_unit_sdw.organization_unit_code IS 'identifies any office within the ministry.  first character identifies exec, hq branch, region, or district.  next two chars identify the office name; next two the section (hq branch) or program (region or district); last char identifies the subsection.';

COMMENT ON column app_rrs1.road_org_unit_sdw.road_organization_unit_id IS 'a system generated sequence number used to uniquely identify a road organization unit.';

COMMENT ON column app_rrs1.road_org_unit_sdw.organization_unit_name IS 'the name or title of a ministry office or section; for example kamloops forest region; silviculture branch; kispiox forest district protection program.';

COMMENT ON column app_rrs1.road_org_unit_sdw.organization_level_code IS 'a one character code enumerating the level of an organization level.  valid values include:  	t    abcs (timber sales)  	r    region  	d    district  	h   headquarter ';

COMMENT ON column app_rrs1.road_org_unit_sdw.rollup_region_code IS 'identifier designating the region to which the org unit is rolled into for reporting purposes.';

COMMENT ON column app_rrs1.road_org_unit_sdw.effective_date IS 'the date the organizational unit became effective as a valid org unit within the ministry''s organizational structure.';

COMMENT ON column app_rrs1.road_org_unit_sdw.expiry_date IS 'the date the organizational unit is obsolete and is no longer an active org unit within the ministry organizational structure.  at the determination of human resources branch, an expired org unit may be retained for historical purposed, or may be deleted.';

COMMENT ON column app_rrs1.road_org_unit_sdw.create_user IS 'create_user is an audit column that indicates the user that created the record.';

COMMENT ON column app_rrs1.road_org_unit_sdw.create_date IS 'create_date is the date and time the row of data was created.';

COMMENT ON column app_rrs1.road_org_unit_sdw.update_user IS 'update_user is an audit column that indicates the user that updated the record.';

COMMENT ON column app_rrs1.road_org_unit_sdw.update_date IS 'update_date is the date and time the row of data was updated.';
