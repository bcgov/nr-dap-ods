create table app_rrs1.road_submission 
   (	road_submission_guid bytea not null, 
	road_submission_id bigint not null, 
	road_submission_type_code varchar(10) not null, 
	submission_status_code varchar(10) not null, 
	submission_date timestamp(0) not null, 
	submitted_by varchar(32), 
	road_external_submsn_sdw_guid bytea, 
	nrsos_smart_form_id bigint, 
	number_application_submitted smallint default 1 not null, 
	comments varchar(2000), 
	last_status_date timestamp(0), 
	revision_count bigint default 0 not null, 
	create_user varchar(32) not null, 
	create_date timestamp(0) default current_timestamp(0) not null, 
	update_user varchar(32) not null, 
	update_date timestamp(0) default current_timestamp(0) not null
   ) 
 ;

comment on table app_rrs1.road_submission is 'a road submission record holds the generic key information about a request or report submission to the rrs system. a submission could be a spatial submission for a new permit or an amendment to an existing permit. a submission could also be a notification request or a report. each and every rrs request or report, including notification are received to the rrs system has to have  an entry record in road submission. ';
comment on column app_rrs1.road_submission.road_submission_guid is 'road_submission_guid is a unique identifier for the record.';
comment on column app_rrs1.road_submission.road_submission_id is 'a system generated sequence number used to uniquely identify a road submission record. ';
comment on column app_rrs1.road_submission.road_submission_type_code is 'road_submission_type_code: is a foreign key to road_submission_type_code: a road submission type code record represents pre-defined and known submission codes and descriptions used in rrs system. valid values include: rp road permit        notification (probably needs to expand to enumerate different (non-generic) notifications         construction report         srl	special access roads - linear   srp	special access roads - polygonal  ';
comment on column app_rrs1.road_submission.submission_status_code is 'submission_status_code: is a foreign key to submission_status_code: this code table stores the possible statuses of each rrs submission. each submission status code record contains a code and description of applicable status to a road request that is submitted to the rrs system. valid values include: submitted      in review      on hold      accepted      withdrawn      rejected      canceled     ';
comment on column app_rrs1.road_submission.submission_date is 'a date recording the date (and time) when a road submission entry is received or created internally.';
comment on column app_rrs1.road_submission.submitted_by is 'user id (idir/bceid) of the user who submitted the application/request.';
comment on column app_rrs1.road_submission.road_external_submsn_sdw_guid is 'road_external_submsn_sdw_guid: is a foreign key to road_external_submsn_sdw: resource road system (rrs) may received requests from one or more external / common submission applications. a record contains needed information from these external submission systems.';
comment on column app_rrs1.road_submission.nrsos_smart_form_id is 'system generated sequence assigned to an nrsos smart form. the number is generated and assigned to a smart form and passes on to the rrs system if the form is a road request. the number is used for tracking information between rrs and nrsos systems. ';
comment on column app_rrs1.road_submission.number_application_submitted is 'a numeric value indicating the number of application(s) that have been submitted via one submission.';
comment on column app_rrs1.road_submission.comments is 'a free format text records additional notes and comments providing more detail to a submission instance.';
comment on column app_rrs1.road_submission.last_status_date is 'a date representing the date and time when the status of submitted record has been changed. ';
comment on column app_rrs1.road_submission.revision_count is 'revision_count is the number of times that the row of data has been changed. the column is used for optimistic locking via application code.';
comment on column app_rrs1.road_submission.create_user is 'create_user is an audit column that indicates the user that created the record.';
comment on column app_rrs1.road_submission.create_date is 'create_date is the date and time the row of data was created.';
comment on column app_rrs1.road_submission.update_user is 'update_user is an audit column that indicates the user that updated the record.';
comment on column app_rrs1.road_submission.update_date is 'update_date is the date and time the row of data was updated.';
