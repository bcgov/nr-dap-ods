CREATE TABLE app_rrs1.road_section_status_code (
	road_section_status_code VARCHAR(10) NOT NULL,
	description VARCHAR(200) NOT NULL,
	display_order SMALLINT,
	effective_date TIMESTAMP(0) DEFAULT date_trunc('day', current_timestamp(0)) NOT NULL,
	expiry_date TIMESTAMP(0) DEFAULT to_date('9999-12-31', 'yyyy-mm-dd') NOT NULL,
	create_user VARCHAR(32) NOT NULL,
	create_date TIMESTAMP(0) DEFAULT current_timestamp(0) NOT NULL,
	update_user VARCHAR(32) NOT NULL,
	update_date TIMESTAMP(0) DEFAULT current_timestamp(0) NOT NULL
);

COMMENT ON TABLE app_rrs1.road_section_status_code IS 'a road section status code record enumerates a status code of road section.   valid values include: hi	issued  hn	issued but not printed  pe	pending electronic ';

COMMENT ON column app_rrs1.road_section_status_code.road_section_status_code IS 'road_section_status_code is a unique identifier for the record.';

COMMENT ON column app_rrs1.road_section_status_code.description IS 'description is the display quality description of the code value.';

COMMENT ON column app_rrs1.road_section_status_code.display_order IS 'display order is to allow non alphabetic sorting e.g. m t w th f s s.';

COMMENT ON column app_rrs1.road_section_status_code.effective_date IS 'effective_date is the date code value becomes effective.';

COMMENT ON column app_rrs1.road_section_status_code.expiry_date IS 'expiry_date is the date code value expires.';

COMMENT ON column app_rrs1.road_section_status_code.create_user IS 'create_user is an audit column that indicates the user that created the record.';

COMMENT ON column app_rrs1.road_section_status_code.create_date IS 'create_date is the date and time the row of data was created.';

COMMENT ON column app_rrs1.road_section_status_code.update_user IS 'update_user is an audit column that indicates the user that updated the record.';

COMMENT ON column app_rrs1.road_section_status_code.update_date IS 'update_date is the date and time the row of data was updated.';
