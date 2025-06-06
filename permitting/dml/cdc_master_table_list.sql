INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'RRS',
		NULL,
		'app_rrs',
		'RESOURCE_ROAD_TENURE',
		'rrs_replication',
		'RESOURCE_ROAD_TENURE',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		1,
		NULL,
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'RRS',
		NULL,
		'app_rrs',
		'ROAD_APPLICATION',
		'rrs_replication',
		'ROAD_APPLICATION',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		1,
		NULL,
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'HARVESTING_AUTHORITY',
		'fta_replication',
		'HARVESTING_AUTHORITY',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		1,
		NULL,
		'Y',
		'SELECT HVA_SKEY, FOREST_FILE_ID, CUTTING_PERMIT_ID, HARVESTING_AUTHORITY_ID, FOREST_DISTRICT, DISTRICT_ADMN_ZONE, GEOGRAPHIC_DISTRICT, MGMT_UNIT_ID, MGMT_UNIT_TYPE_CODE, LICENCE_TO_CUT_CODE, HARVEST_TYPE_CODE, HARVEST_AUTH_STATUS_CODE, TENURE_TERM, TO_CHAR(STATUS_DATE, ''YYYY-MM-DD HH24:MI:SS'') AS STATUS_DATE, TO_CHAR(ISSUE_DATE, ''YYYY-MM-DD HH24:MI:SS'') AS ISSUE_DATE, TO_CHAR(EXPIRY_DATE, ''YYYY-MM-DD HH24:MI:SS'') AS EXPIRY_DATE, TO_CHAR(EXTEND_DATE, ''YYYY-MM-DD HH24:MI:SS'') AS EXTEND_DATE, EXTEND_COUNT, HARVEST_AUTH_EXTEND_REAS_CODE, QUOTA_TYPE_CODE, CROWN_LANDS_REGION_CODE, SALVAGE_TYPE_CODE, CASCADE_SPLIT_CODE, CATASTROPHIC_IND, CROWN_GRANTED_IND, CRUISE_BASED_IND, DECIDUOUS_IND, BCAA_FOLIO_NUMBER, LOCATION, HIGHER_LEVEL_PLAN_REFERENCE, HARVEST_AREA, TO_CHAR(RETIREMENT_DATE, ''YYYY-MM-DD HH24:MI:SS'') AS RETIREMENT_DATE, REVISION_COUNT, ENTRY_USERID, TO_CHAR(ENTRY_TIMESTAMP, ''YYYY-MM-DD HH24:MI:SS'') AS ENTRY_TIMESTAMP, UPDATE_USERID, TO_CHAR(UPDATE_TIMESTAMP, ''YYYY-MM-DD HH24:MI:SS'') AS UPDATE_TIMESTAMP, IS_WASTE_ASSESSMENT_REQUIRED, IS_CP_EXTENSN_APPL_FEE_WAIVED, IS_CP_EXTENSION_APPL_FEE_PAID, IS_WITHIN_FIBRE_RECOVERY_ZONE, HARVESTING_AUTHORITY_GUID
FROM THE.HARVESTING_AUTHORITY',
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'FILE_TYPE_CODE',
		'fta_replication',
		'FILE_TYPE_CODE',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		1,
		NULL,
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'HARVEST_TYPE_CODE',
		'fta_replication',
		'HARVEST_TYPE_CODE',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		1,
		NULL,
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'HARVEST_AUTH_STATUS_CODE',
		'fta_replication',
		'HARVEST_AUTH_STATUS_CODE',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		1,
		NULL,
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'TENURE_APPLICATION_STATE_CODE',
		'fta_replication',
		'TENURE_APPLICATION_STATE_CODE',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		1,
		NULL,
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'TENURE_APPLICATION_TYPE_CODE',
		'fta_replication',
		'TENURE_APPLICATION_TYPE_CODE',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		1,
		NULL,
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'RRS',
		NULL,
		'app_rrs',
		'ROAD_SUBMISSION',
		'rrs_replication',
		'ROAD_SUBMISSION',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		1,
		NULL,
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'RRS',
		NULL,
		'app_rrs',
		'ROAD_TENURE_TYPE_CODE',
		'rrs_replication',
		'ROAD_TENURE_TYPE_CODE',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		1,
		NULL,
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'TENURE_APPLICATION',
		'fta_replication',
		'TENURE_APPLICATION',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		1,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'TENURE_STATUS_CODE',
		'fta_replication',
		'TENURE_STATUS_CODE',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		2,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'TENURE_APPLICATION_MAP_FEATURE',
		'fta_replication',
		'TENURE_APPLICATION_MAP_FEATURE',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		2,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'PROV_FOREST_USE',
		'fta_replication',
		'PROV_FOREST_USE',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		2,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'RRS',
		NULL,
		'app_rrs',
		'ROAD_TENURE_STATUS_CODE',
		'rrs_replication',
		'ROAD_TENURE_STATUS_CODE',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		2,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'RRS',
		NULL,
		'app_rrs',
		'ROAD_FEATURE_CLASS_SDW',
		'rrs_replication',
		'ROAD_FEATURE_CLASS_SDW',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		2,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'RRS',
		NULL,
		'app_rrs',
		'ROAD_ORG_UNIT_SDW',
		'rrs_replication',
		'ROAD_ORG_UNIT_SDW',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		2,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'RRS',
		NULL,
		'app_rrs',
		'ROAD_APPLICATION_STATUS_CODE',
		'rrs_replication',
		'ROAD_APPLICATION_STATUS_CODE',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		2,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'RRS',
		NULL,
		'app_rrs',
		'ROAD_SECTION',
		'rrs_replication',
		'ROAD_SECTION',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		1,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'ATS',
		NULL,
		'ats',
		'ATS_PROJECTS',
		'ats_replication',
		'ATS_PROJECTS',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		3,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'ATS',
		NULL,
		'ats',
		'ATS_ATHN_CLOSE_REASON_CODES',
		'ats_replication',
		'ATS_ATHN_CLOSE_REASON_CODES',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		1,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'ATS',
		NULL,
		'ats',
		'ATS_AUTHORIZATION_INSTRUMENTS',
		'ats_replication',
		'ATS_AUTHORIZATION_INSTRUMENTS',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		1,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'ATS',
		NULL,
		'ats',
		'ATS_AUTHORIZATION_STATUS_CODES',
		'ats_replication',
		'ATS_AUTHORIZATION_STATUS_CODES',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		1,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'ATS',
		NULL,
		'ats',
		'ATS_AUTHORIZATIONS',
		'ats_replication',
		'ATS_AUTHORIZATIONS',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		1,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'ATS',
		NULL,
		'ats',
		'ATS_MANAGING_FCBC_REGIONS',
		'ats_replication',
		'ATS_MANAGING_FCBC_REGIONS',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		1,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'ATS',
		NULL,
		'ats',
		'ATS_PARTNER_AGENCIES',
		'ats_replication',
		'ATS_PARTNER_AGENCIES',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		2,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'ORG_UNIT',
		'fta_replication',
		'ORG_UNIT',
		'Y',
		'',
		'',
		'UPDATE_DATE',
		'N',
		1,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'ATS',
		NULL,
		'ats',
		'ATS_PROJ_PROJ_TYPE_CODE_XREF',
		'ats_replication',
		'ATS_PROJ_PROJ_TYPE_CODE_XREF',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		2,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'ATS',
		NULL,
		'ats',
		'ATS_PROJECT_STATUS_CODES',
		'ats_replication',
		'ATS_PROJECT_STATUS_CODES',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		2,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'ATS',
		NULL,
		'ats',
		'ATS_PROJECT_TYPE_CODES',
		'ats_replication',
		'ATS_PROJECT_TYPE_CODES',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		2,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'AAC_ALLOCATION_AMOUNT',
		'fta_replication',
		'AAC_ALLOCATION_AMOUNT',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'N',
		2,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'CLIENT_LOCATION',
		'fta_replication',
		'CLIENT_LOCATION',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'N',
		1,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'HAULING_AUTHORITY',
		'fta_replication',
		'HAULING_AUTHORITY',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'N',
		2,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'PRIVATE_MARK_CERTIFICATE',
		'fta_replication',
		'PRIVATE_MARK_CERTIFICATE',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		1,
		' where P_OF_C_OR_LEGAL not like ''%'' || chr(0) || ''%''',
		'Y',
		'SELECT CERTIFICATE, FOREST_FILE_ID, TIMBER_MARK, FOREST_DISTRICT, MGMT_UNIT_ID, MGMT_UNIT_TYPE_CODE, PRIVATE_MARK_APPLICATION_DATE, PRIVATE_MARK_STATUS_CODE, PRIVATE_MARK_TENURE_TERM, PRIVATE_MARK_STATUS_DATE, PRIVATE_MARK_ISSUE_DATE, PRIVATE_MARK_EXPIRY_DATE, PRIVATE_MARK_EXTEND_DATE, PRIVATE_MARK_EXTEND_COUNT, PRIVATE_MARK_EXTEND_REAS_CODE, PRIVATE_MARK_AMEND_DATE, PRIVATE_MARK_CANCEL_DATE, PRIVATE_MARK_ACTIVATED_USERID, PRIVATE_MARK_AMENDED_USERID, BCAA_FOLIO_NUMBER, CASCADE_SPLIT_CODE, QUOTA_TYPE_CODE, CROWN_GRANTED_ACQ_DESC, GRANTED_ACQRD_DATE, CROWN_GRANTED_IND, MAP_TYPE_CODE, MAP_DATABASE_ID, MAP_REFERENCE_ID, PERMIT_BLOCK_LOCN, PERMIT_BLOCK_AREA, P_OF_C_OR_LEGAL, REVISION_COUNT, ENTRY_USERID, ENTRY_TIMESTAMP, UPDATE_USERID, UPDATE_TIMESTAMP
FROM THE.PRIVATE_MARK_CERTIFICATE WHERE P_OF_C_OR_LEGAL not like ''%'' || chr(0) || ''%''',
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'RRS',
		NULL,
		'app_rrs',
		'ROAD_APPL_MAP_FEATURE',
		'rrs_replication',
		'ROAD_APPL_MAP_FEATURE',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		3,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'RRS',
		NULL,
		'app_rrs',
		'ROAD_SECTION_STATUS_CODE',
		'rrs_replication',
		'ROAD_SECTION_STATUS_CODE',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		2,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'ATS',
		NULL,
		'ats',
		'ATS_REGIONAL_USERS',
		'ats_replication',
		'ATS_REGIONAL_USERS',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		3,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'ATS',
		NULL,
		'ats',
		'ATS_SECONDARY_OFFICES',
		'ats_replication',
		'ATS_SECONDARY_OFFICES',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		3,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'ATS',
		NULL,
		'ats',
		'ATS_SUBREGIONAL_OFFICES',
		'ats_replication',
		'ATS_SUBREGIONAL_OFFICES',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		3,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'TIMBER_TENURE',
		'fta_replication',
		'TIMBER_TENURE',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'N',
		1,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'CUT_BLOCK',
		'fta_replication',
		'CUT_BLOCK',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'N',
		1,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'TENURE_APPLICATION_PURP_CODE',
		'fta_replication',
		'TENURE_APPLICATION_PURP_CODE',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'N',
		1,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'FOREST_CLIENT',
		'fta_replication',
		'FOREST_CLIENT',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'N',
		2,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'FILE_CLIENT_TYPE_CODE',
		'fta_replication',
		'FILE_CLIENT_TYPE_CODE',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'N',
		2,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'FILE_SOURCE_CODE',
		'fta_replication',
		'FILE_SOURCE_CODE',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'N',
		2,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'FILE_STATUS_CODE',
		'fta_replication',
		'FILE_STATUS_CODE',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'N',
		2,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'HARVESTING_HAULING_XREF',
		'fta_replication',
		'HARVESTING_HAULING_XREF',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'N',
		2,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'FOREST_FILE_CLIENT',
		'fta_replication',
		'FOREST_FILE_CLIENT',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'N',
		2,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'HARVEST_SALE',
		'fta_replication',
		'HARVEST_SALE',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'N',
		2,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'TENURE_TERM',
		'fta_replication',
		'TENURE_TERM',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'N',
		2,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'TENURE_FILE_STATUS_CODE',
		'fta_replication',
		'TENURE_FILE_STATUS_CODE',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'N',
		2,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'TIMBER_MARK',
		'fta_replication',
		'TIMBER_MARK',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'N',
		1,
		' ',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'RRS',
		NULL,
		'app_rrs',
		'ROAD_EXTERNAL_SUBMSN_SDW',
		'rrs_replication',
		'ROAD_EXTERNAL_SUBMSN_SDW',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		1,
		NULL,
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'RRS',
		NULL,
		'app_rrs',
		'SUBMISSION_STATUS_CODE',
		'rrs_replication',
		'SUBMISSION_STATUS_CODE',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		1,
		NULL,
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'LEXIS',
		NULL,
		'the',
		'EXPORT_PERMIT_DETAIL',
		'lexis_replication',
		'EXPORT_PERMIT_DETAIL',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		1,
		'',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'LEXIS',
		NULL,
		'the',
		'EXPORT_PERMIT_STATUS_CODE',
		'lexis_replication',
		'EXPORT_PERMIT_STATUS_CODE',
		'Y',
		NULL,
		NULL,
		'UPDATE_TIMESTAMP',
		'Y',
		1,
		'',
		'N',
		NULL,
		'oracle'
	);

INSERT INTO
	ods_data_management.cdc_master_table_list
VALUES
	(
		NULL,
		'FTA',
		NULL,
		'the',
		'TENURE_APPLICATION_PURP_CODE',
		'fta_replication',
		'TENURE_APPLICATION_PURP_CODE',
		'Y',
		NULL,
		NULL,
		'UPDATE_DATE',
		'Y',
		2,
		' ',
		'N',
		NULL,
		'oracle'
	);