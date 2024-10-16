CREATE TABLE app_rrs1.resource_road_tenure (
	resource_road_tenure_guid bytea NOT NULL,
	resource_road_tenure_id VARCHAR(10) NOT NULL,
	road_tenure_type_code VARCHAR(10) NOT NULL,
	forest_region_org_unit_guid bytea NOT NULL,
	bcts_org_unit_guid bytea,
	road_tenure_status_code VARCHAR(10) NOT NULL,
	road_forest_mgt_unit_sdw_guid bytea,
	small_business_funded_ind VARCHAR(1) DEFAULT 'n' NOT NULL,
	district_admin_zone VARCHAR(4),
	last_status_date TIMESTAMP(0),
	revision_count bigint DEFAULT 0 NOT NULL,
	create_user VARCHAR(32) NOT NULL,
	create_date TIMESTAMP(0) DEFAULT current_timestamp(0) NOT NULL,
	update_user VARCHAR(32) NOT NULL,
	update_date TIMESTAMP(0) DEFAULT current_timestamp(0) NOT NULL
);

COMMENT ON TABLE app_rrs1.resource_road_tenure IS 'each resource road tenure  record contains information about the rights granted to a client (legal or individual) under which the client can construct/extend/maintain various type of activities other than only use.  each record eventually can end up to a road permit, for example there are submission and application that created for preparation, (such as declaration, gazette and dedication), or real property project. also, non-status-road while existing don''t have any road tenure/permit records but kept in as resource road tenure till their status are changed.  contains granting permission information for purposes of constructing a road.   notes taken from: https://www.for.gov.bc.ca/hth/timber-tenures/agreements/road-permit.htm  a road permit is needed to construct, use and maintain a road if the access is not a forest service road or under another tenure.   if necessary, the road permit may include cutting authority for the timber within the road right of way.   a road permit authorizing construction can only be applied for after frpa planning requirements have been met.   if the road is an existing, non-status road (an older, abandoned road with no active tenure), a road permit is required for industrial use and maintenance.  the road permit document has provisions that:    define the legal area of interest (the permit area described on the exhibit a map)                                      define the rights granted (including, if necessary, the harvest of timber within clearing area)                                     set the term (beginning date and criteria for termination)                                     establish that permit rights are non-exclusive, (other than timber authorized for harvesting within the clearing area).                                     link any timber harvesting under the permit with the cut control specifications and waste assessment requirements of specific agreements.                                     identify the timber mark(s) for any timber harvested from the clearing area.                                   a road permit  that includes cutting authority is always associated with at least one agreement for cut control purposes, but technically is considered a stand-alone agreement under the forest act.';

COMMENT ON column app_rrs1.resource_road_tenure.resource_road_tenure_guid IS 'resource_road_tenure_guid is a unique identifier for the record.';

COMMENT ON column app_rrs1.resource_road_tenure.resource_road_tenure_id IS 'an alpha numeric value up to 10-character used to uniquely identify a resource road tenure. the resource source tenure id, aka forest file id is created based on the type of tenure (file). most of the b40 (forest service   road) tenure id contain digits only while other types may start with characters such r03050 (showing  a road permit id) or nrs10101 which can identify a non status road tenure. examples, r1234 (tenure type b01) 98672 (tenure type b40) s019220 (tenure type s01, s02) nsr123 (non-status road)';

COMMENT ON column app_rrs1.resource_road_tenure.road_tenure_type_code IS 'road_tenure_type_code: is a foreign key to road_tenure_type_code: a road tenure type code record enumerates an rrs road tenure type. valid values include:  b01 road permit    b40 forest service road    s01 special use permit, forest    s02 special use permit, non-forest    q02 non status road  q03 real property project';

COMMENT ON column app_rrs1.resource_road_tenure.forest_region_org_unit_guid IS 'forest_region_org_unit_guid: is a foreign key to road_org_unit_sdw: a road organization unit record contains road organization unit records consumed by resource road system (rrs).  the organization records are used to keep the managing hierarchy as well as geographical.   the source records are external to the resource road system. so, the rrs will be updated via a service, either on demand or based on an scheduled synchronization process.  definition (from the fta system): records codes for ministry organizational units (offices), such as branch, region, or district office. codes are currently defined to the office, section/program, and subsection level. ';

COMMENT ON column app_rrs1.resource_road_tenure.bcts_org_unit_guid IS 'bcts_org_unit_guid: is a foreign key to road_org_unit_sdw: a road organization unit record contains road organization unit records consumed by resource road system (rrs).  the organization records are used to keep the managing hierarchy as well as geographical.   the source records are external to the resource road system. so, the rrs will be updated via a service, either on demand or based on an scheduled synchronization process.  definition (from the fta system): records codes for ministry organizational units (offices), such as branch, region, or district office. codes are currently defined to the office, section/program, and subsection level. ';

COMMENT ON column app_rrs1.resource_road_tenure.road_tenure_status_code IS 'road_tenure_status_code: is a foreign key to road_tenure_status_code: a road tenure status code record enumerates road tenure statuses.  valid values include: a	active ah	active (hdbs) an	active - map notation ar	archived as	active - suspended at	archived - transferred ay	active - abeyance ca	cancelled cl	clearance d	disallowed de	designation ee	entered in error hrs	harvesting rights surrendered i	inactive ic	inactive - completed id	inactive - closed (deactivated) ih	inactive - deactivated (hdbs) nc	no clearance or designation p	pending pa	pending - application pe	pending electronic pp	pending - planning pr	pending - review su	suspended';

COMMENT ON column app_rrs1.resource_road_tenure.road_forest_mgt_unit_sdw_guid IS 'road_forest_mgt_unit_sdw_guid: is a foreign key to road_forest_mgt_unit_sdw: a road forest management unit record contains forest management unit records consumed by resource road system (rrs). the source records are out of the resource road system. so, the rrs will be updated via a service, either on the demand or based on an scheduled synchronization process.';

COMMENT ON column app_rrs1.resource_road_tenure.small_business_funded_ind IS 'a one character flag indicating whether the road tenure was given to small business funded party (''y'') or does not (''n'').';

COMMENT ON column app_rrs1.resource_road_tenure.district_admin_zone IS 'district admin zone is a free format field used internally by the districts to group files within a district for reporting purposes.  examples of use are setting the field to a geographic area or to a persons initials.  reports can be pulled off by district admin zone to aid work management. this field is not used by all districts.';

COMMENT ON column app_rrs1.resource_road_tenure.last_status_date IS 'a date value representing the date when a road tenure status has changed.';

COMMENT ON column app_rrs1.resource_road_tenure.revision_count IS 'revision_count is the number of times that the row of data has been changed. the column is used for optimistic locking via application code.';

COMMENT ON column app_rrs1.resource_road_tenure.create_user IS 'create_user is an audit column that indicates the user that created the record.';

COMMENT ON column app_rrs1.resource_road_tenure.create_date IS 'create_date is the date and time the row of data was created.';

COMMENT ON column app_rrs1.resource_road_tenure.update_user IS 'update_user is an audit column that indicates the user that updated the record.';

COMMENT ON column app_rrs1.resource_road_tenure.update_date IS 'update_date is the date and time the row of data was updated.';
