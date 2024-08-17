CREATE TABLE app_rrs1.road_submission (
	road_submission_guid bytea NOT NULL,
	road_submission_id bigint NOT NULL,
	road_submission_type_code VARCHAR(10) NOT NULL,
	submission_status_code VARCHAR(10) NOT NULL,
	submission_date TIMESTAMP(0) NOT NULL,
	submitted_by VARCHAR(32),
	road_external_submsn_sdw_guid bytea,
	nrsos_smart_form_id bigint,
	number_application_submitted SMALLINT DEFAULT 1 NOT NULL,
	comments VARCHAR(2000),
	last_status_date TIMESTAMP(0),
	revision_count bigint DEFAULT 0 NOT NULL,
	create_user VARCHAR(32) NOT NULL,
	create_date TIMESTAMP(0) DEFAULT current_timestamp(0) NOT NULL,
	update_user VARCHAR(32) NOT NULL,
	update_date TIMESTAMP(0) DEFAULT current_timestamp(0) NOT NULL
);

COMMENT ON TABLE app_rrs1.road_submission IS 'a road submission record holds the generic key information about a request or report submission to the rrs system. a submission could be a spatial submission for a new permit or an amendment to an existing permit. a submission could also be a notification request or a report. each and every rrs request or report, including notification are received to the rrs system has to have  an entry record in road submission. ';

COMMENT ON column app_rrs1.road_submission.road_submission_guid IS 'road_submission_guid is a unique identifier for the record.';

COMMENT ON column app_rrs1.road_submission.road_submission_id IS 'a system generated sequence number used to uniquely identify a road submission record. ';

COMMENT ON column app_rrs1.road_submission.road_submission_type_code IS 'road_submission_type_code: is a foreign key to road_submission_type_code: a road submission type code record represents pre-defined and known submission codes and descriptions used in rrs system. valid values include: rp road permit        notification (probably needs to expand to enumerate different (non-generic) notifications         construction report         srl	special access roads - linear   srp	special access roads - polygonal  ';

COMMENT ON column app_rrs1.road_submission.submission_status_code IS 'submission_status_code: is a foreign key to submission_status_code: this code table stores the possible statuses of each rrs submission. each submission status code record contains a code and description of applicable status to a road request that is submitted to the rrs system. valid values include: submitted      in review      on hold      accepted      withdrawn      rejected      canceled     ';

COMMENT ON column app_rrs1.road_submission.submission_date IS 'a date recording the date (and time) when a road submission entry is received or created internally.';

COMMENT ON column app_rrs1.road_submission.submitted_by IS 'user id (idir/bceid) of the user who submitted the application/request.';

COMMENT ON column app_rrs1.road_submission.road_external_submsn_sdw_guid IS 'road_external_submsn_sdw_guid: is a foreign key to road_external_submsn_sdw: resource road system (rrs) may received requests from one or more external / common submission applications. a record contains needed information from these external submission systems.';

COMMENT ON column app_rrs1.road_submission.nrsos_smart_form_id IS 'system generated sequence assigned to an nrsos smart form. the number is generated and assigned to a smart form and passes on to the rrs system if the form is a road request. the number is used for tracking information between rrs and nrsos systems. ';

COMMENT ON column app_rrs1.road_submission.number_application_submitted IS 'a numeric value indicating the number of application(s) that have been submitted via one submission.';

COMMENT ON column app_rrs1.road_submission.comments IS 'a free format text records additional notes and comments providing more detail to a submission instance.';

COMMENT ON column app_rrs1.road_submission.last_status_date IS 'a date representing the date and time when the status of submitted record has been changed. ';

COMMENT ON column app_rrs1.road_submission.revision_count IS 'revision_count is the number of times that the row of data has been changed. the column is used for optimistic locking via application code.';

COMMENT ON column app_rrs1.road_submission.create_user IS 'create_user is an audit column that indicates the user that created the record.';

COMMENT ON column app_rrs1.road_submission.create_date IS 'create_date is the date and time the row of data was created.';

COMMENT ON column app_rrs1.road_submission.update_user IS 'update_user is an audit column that indicates the user that updated the record.';

COMMENT ON column app_rrs1.road_submission.update_date IS 'update_date is the date and time the row of data was updated.';
