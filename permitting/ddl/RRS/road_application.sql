create table app_rrs1.road_application 
   (	road_application_guid bytea not null, 
	road_application_id bigint not null, 
	primary_line_of_business_code varchar(10) not null, 
	road_submission_guid bytea, 
	resource_road_client_sdw_guid bytea not null, 
	road_application_status_code varchar(10) not null, 
	cascade_split_code varchar(10), 
	metadata_org_unit_sdw_guid bytea not null, 
	geo_road_org_unit_sdw_guid bytea, 
	resource_road_tenure_guid bytea, 
	submission_date timestamp(0) not null, 
	description varchar(300), 
	road_forest_mgt_unit_sdw_guid bytea, 
	management_unit_type_code varchar(10), 
	management_unit_block_id varchar(4), 
	adjudicated_by varchar(30), 
	adjudication_ind varchar(1) default 'n' not null, 
	adjudication_date timestamp(0), 
	adjudication_comment varchar(2000), 
	adjudication_requested_ind varchar(1) default 'n' not null, 
	spatial_ind varchar(1) default 'n' not null, 
	map_report_created_ind varchar(1) default 'n' not null, 
	file_created_ind varchar(1) default 'n' not null, 
	image_create_in_progress_ind varchar(1) default 'n' not null, 
	image_created_ind varchar(1) default 'n' not null, 
	image_create_requested_by varchar(30), 
	image_create_requested_date timestamp(0), 
	application_decision_message varchar(1000), 
	tenure_amendment_id bigint, 
	business_amendment_id varchar(10), 
	clearance_status_request_uri varchar(2000), 
	dependent_submission_reference varchar(100), 
	revision_count bigint default 0 not null, 
	create_user varchar(32) not null, 
	create_date timestamp(0) default current_timestamp(0) not null, 
	update_user varchar(32) not null, 
	update_date timestamp(0) default current_timestamp(0) not null, 
	decision_date timestamp(0), 
	issuance_date timestamp(0)
   ) 
 ;
 
comment on table app_rrs1.road_application is 'each road application record holds information submitted by the proponents applying for road permit (new construction, amendment or ownership/use).';
comment on column app_rrs1.road_application.road_application_guid is 'road_application_guid is a unique identifier for the record.';
comment on column app_rrs1.road_application.road_application_id is 'a system generated sequence number used to uniquely identify a road application  instance. ';
comment on column app_rrs1.road_application.primary_line_of_business_code is 'primary_line_of_business_code: is a foreign key to primary_line_of_business_code: a primary line of business code record contains code and description of a known line of business. line of business are different ministry sectors/branches that are submitting application to rrs or in some way they are sharing or action on an rrs tenure. valid values include: a	ministry of agriculture and fisheries     b	bc assessment authority     c	cross reference no./previous file no.     d	ministry of regional and economic dev     e	ministry of energy, mines and petrol     f	forest tenure system (ftas)     h	ministry of transportation and highway     k	orcs     l	land titles office     m	municipal     n	ministry of native affairs     o	order in council (oic)     p	ministry of lands and parks     r	regional district     s	silviculture     v	ministry of environment     w	water management branch     x	external client reference     y	federal fisheries and oceans    ';
comment on column app_rrs1.road_application.road_submission_guid is 'road_submission_guid: is a foreign key to road_submission: a road submission record holds the generic key information about a request or report submission to the rrs system. a submission could be a spatial submission for a new permit or an amendment to an existing permit. a submission could also be a notification request or a report. each and every rrs request or report, including notification are received to the rrs system has an recording entry record. ';
comment on column app_rrs1.road_application.resource_road_client_sdw_guid is 'resource_road_client_sdw_guid: is a foreign key to resource_road_client_sdw: a resource road client record represents a party who is doing business with the province resource road.   please note, until  common client become available, the source of records will be forest client, client location and client contact.  this entity is used as an interface to the current client data and will be replaced/point with/to the common client once it become available.';
comment on column app_rrs1.road_application.road_application_status_code is 'road_application_status_code: is a foreign key to road_application_status_code: identifies the process state of the road submission.  valid values include: app	approved  fai	failed  inb	inbox  lob	lobby  rej	rejected  ret	retired ';
comment on column app_rrs1.road_application.cascade_split_code is 'cascade_split_code: is a foreign key to cascade_split_code: code to indicate the administrative split for the timber mark, east or west of the cascade mountains, for tracking timber volume information.                   valid values include: e east  w west ';
comment on column app_rrs1.road_application.metadata_org_unit_sdw_guid is 'metadata_org_unit_sdw_guid: is a foreign key to road_org_unit_sdw: a road organization unit record contains road organization unit records consumed by resource road system (rrs).  the organization records are used to keep the managing hierarchy as well as geographical.   the source records are external to the resource road system. so, the rrs will be updated via a service, either on demand or based on an scheduled synchronization process.  definition (from the fta system): records codes for ministry organizational units (offices), such as branch, region, or district office. codes are currently defined to the office, section/program, and subsection level. ';
comment on column app_rrs1.road_application.geo_road_org_unit_sdw_guid is 'geo_road_org_unit_sdw_guid: is a foreign key to road_org_unit_sdw: a road organization unit record contains road organization unit records consumed by resource road system (rrs).  the organization records are used to keep the managing hierarchy as well as geographical.   the source records are external to the resource road system. so, the rrs will be updated via a service, either on demand or based on an scheduled synchronization process.  definition (from the fta system): records codes for ministry organizational units (offices), such as branch, region, or district office. codes are currently defined to the office, section/program, and subsection level. ';
comment on column app_rrs1.road_application.resource_road_tenure_guid is 'resource_road_tenure_guid: is a foreign key to resource_road_tenure: each resource road tenure  record contains information about the rights granted to a client (legal or individual) under which the client can construct/extend/maintain various type of activities other than only use.  each record eventually can end up to a road permit, for example there are submission and application that created for preparation, (such as declaration, gazette and dedication), or real property project. also, non-status-road while existing don''t have any road tenure/permit records but kept in as resource road tenure till their status are changed.  contains granting permission information for purposes of constructing a road.   notes taken from: https://www.for.gov.bc.ca/hth/timber-tenures/agreements/road-permit.htm  a road permit is needed to construct, use and maintain a road if the access is not a forest service road or under another tenure.   if necessary, the road permit may include cutting authority for the timber within the road right of way.   a road permit authorizing construction can only be applied for after frpa planning requirements have been met.   if the road is an existing, non-status road (an older, abandoned road with no active tenure), a road permit is required for industrial use and maintenance.  the road permit document has provisions that:    define the legal area of interest (the permit area described on the exhibit a map)                                      define the rights granted (including, if necessary, the harvest of timber within clearing area)                                     set the term (beginning date and criteria for termination)                                     establish that permit rights are non-exclusive, (other than timber authorized for harvesting within the clearing area).                                     link any timber harvesting under the permit with the cut control specifications and waste assessment requirements of specific agreements.                                     identify the timber mark(s) for any timber harvested from the clearing area.                                   a road permit  that includes cutting authority is always associated with at least one agreement for cut control purposes, but technically is considered a stand-alone agreement under the forest act.';
comment on column app_rrs1.road_application.submission_date is 'a date value representing the date when an application has been submitted.';
comment on column app_rrs1.road_application.description is 'a user defined description for the exhibit a rollup. (e.g. john''s lake recreation site).';
comment on column app_rrs1.road_application.road_forest_mgt_unit_sdw_guid is 'road_forest_mgt_unit_sdw_guid is the primary key of road_forest_mgt_unit_sdw.';
comment on column app_rrs1.road_application.management_unit_type_code is 'a code / abbreviation enumerating type of forest management unit type.  valid values include: a	agricultural land reserve b	blue mountain forest reserve c	community forest d	dominion government block e	e & n land belt f	woodlot g	gulf islands h	organizational unit designation j	ecological reserve k	provincial forest l	wilderness area m	first nations woodlands tenure n	treaty settlement lands o	public sustained yield unit p	parks & wilderness conserv. q	range management unit r	recreational area s	special sale area t	tree farm licence u	timber supply area v	timber supply block w	watershed lease or reserve x	certified tree farm z	outside managed units';
comment on column app_rrs1.road_application.management_unit_block_id is 'number/identifier specific to the block of the management unit.';
comment on column app_rrs1.road_application.adjudicated_by is 'the user id of the person who adjudicated the exhibit a.';
comment on column app_rrs1.road_application.adjudication_ind is 'a flag to indicate if the exhibit a submission has been adjudicated.';
comment on column app_rrs1.road_application.adjudication_date is 'date when the adjudication flag was set.';
comment on column app_rrs1.road_application.adjudication_comment is 'a comment to clarify the overall outcome of an adjudication.';
comment on column app_rrs1.road_application.adjudication_requested_ind is 'a one character flag indicating whether an adjudication has been requested or not.';
comment on column app_rrs1.road_application.spatial_ind is 'indicates that the spatial data has been created at msrm. needed for synchronization.';
comment on column app_rrs1.road_application.map_report_created_ind is 'indicates whether or not the map report has been generated and stored.';
comment on column app_rrs1.road_application.file_created_ind is 'indicates that the file has been created prior to submission of the tenure application.';
comment on column app_rrs1.road_application.image_create_in_progress_ind is 'identifies if a given road application image is in the process of being created.';
comment on column app_rrs1.road_application.image_created_ind is 'indicates whether or not the image has been generated and stored.';
comment on column app_rrs1.road_application.image_create_requested_by is 'the unique id of the user who requested the exhibit a image regeneration.';
comment on column app_rrs1.road_application.image_create_requested_date is 'the date and time of the exhibit a image regeneration request.';
comment on column app_rrs1.road_application.application_decision_message is 'a free format text explaining the application processing results in detail.';
comment on column app_rrs1.road_application.tenure_amendment_id is 'contains the number of approved amendments done on a specific tenure. although the number can be calculated, it needs to be saved and persistent because there can be scenario in which two applications can be submitted against one tenure. if the one that was submitted later gets approved first the assigned amendment id won''t be correct. it needs to wait until the status of the second application becomes known. if first application also approved the next amendment id should be assigned to the it and the one that was approved before it going to have an amendment id equal to the first one plus one. the amendment id is and update-able column and will be updated if needed.';
comment on column app_rrs1.road_application.business_amendment_id is 'an integer representing the amendment id a licensee referencing with regards to a section.  rrs increments road amendment id by one when received a new application for a resource road tenure. there are cases that application get rejected or failed and re-submitted application again results in incrementing the road amendment id by 1. so, the amendment id referenced by the licensees and rrs staff get out of synch. this data item would help the licensees to reference their specific amendment id that they will use when communicating with the rrs staff.';
comment on column app_rrs1.road_application.clearance_status_request_uri is 'a universal reference identifier to the record''s status request entry in the status and clearance system.';
comment on column app_rrs1.road_application.dependent_submission_reference is 'a submission can have dependency on other submissions (those that already submitted or will be submitted in feature). the value would help the technical staff who working on resolving the overlap issues to get more info about the application being handled. there is another entity which provide the dependencies at detail level (feature) for the same purpose which is a child entity of the road application map feature.';
comment on column app_rrs1.road_application.revision_count is 'revision_count is the number of times that the row of data has been changed. the column is used for optimistic locking via application code.';
comment on column app_rrs1.road_application.create_user is 'create_user is an audit column that indicates the user that created the record.';
comment on column app_rrs1.road_application.create_date is 'create_date is the date and time the row of data was created.';
comment on column app_rrs1.road_application.update_user is 'update_user is an audit column that indicates the user that updated the record.';
comment on column app_rrs1.road_application.update_date is 'update_date is the date and time the row of data was updated.';
