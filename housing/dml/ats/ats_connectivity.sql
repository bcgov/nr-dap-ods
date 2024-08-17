SELECT
	*
FROM
	(
		SELECT
			z.ministrycode,
			z.business_area,
			z.permit_type,
			CASE
				WHEN INSTR(z.project_description1, '', '', 1, 3) > 0 THEN SUBSTR(
					z.project_description1,
					INSTR(z.project_description1, '', '', 1, 3) + 1
				)
				ELSE NULL
			END project_id,
			z.application_id,
			z.project_name,
			z.project_description,
			z.project_location,
			z.RECEIVED_DATE,
			z.adjudication_date,
			z.region_name,
			SUBSTR(
				z.project_description1,
				0,
				INSTR(z.project_description1, '', '', 1, 1) -1
			) ESTIMATED_HOUSES_CONNECTED,
			NULL application_status,
			z.File_Number Business_Area_File_Number,
			'' ATS_EXTRACT_JOB '' AS RECORD_CREATED_BY,
			CURRENT_TIMESTAMP(0) AS RECORD_CREATED_DTTM
		FROM
			(
				SELECT
					'' FOR '' ministrycode,
					authorizations.business_area,
					authorizations.permit_type,
					projects.project_id project_id,
					authorizations.AUTHORIZATION_ID application_id,
					projects.project_name,
					projects.project_description,
					CASE
						WHEN INSTR(projects.project_description, '' te) '',
						1,
						1
					) > 0 THEN SUBSTR(
						projects.project_description,
						INSTR(projects.project_description, '' te) '',
						1,
						1
					) + 3
			)
			ELSE NULL
	END project_description1,
	projects.project_location,
	authorizations.RECEIVED_DATE,
	authorizations.adjudication_date,
	projects.region_name,
	authorizations.File_Number
FROM
	(
		SELECT
			prj.PROJECT_ID,
			prj.PROJECT_NAME,
			REPLACE(
				REPLACE(prj.DESCRIPTION, CHR(10), NULL),
				CHR(13),
				NULL
			) project_description,
			REPLACE(
				REPLACE(prj.LOCATION, CHR(10), NULL),
				CHR(13),
				NULL
			) project_location,
			psc.NAME project_status,
			ptc.NAME project_type,
			amfr.REGION_NAME,
			aso.SUBREGIONAL_OFFICE_NAME,
			aso2.SECONDARY_OFFICE_NAME,
			prj.WHO_CREATED,
			prj.WHEN_CREATED,
			prj.WHO_UPDATED,
			prj.WHEN_UPDATED
		FROM
			ats.ATS_PROJECTS prj,
			ats.ATS_PROJ_PROJ_TYPE_CODE_XREF pt,
			ats.ATS_PROJECT_STATUS_CODES psc,
			ats.ATS_PROJECT_TYPE_CODES ptc,
			ats.ATS_MANAGING_FCBC_REGIONS amfr,
			ats.ATS_SUBREGIONAL_OFFICES aso,
			ats.ATS_SECONDARY_OFFICES aso2
		WHERE
			prj.PROJECT_ID = pt.project_id
			AND pt.PROJECT_TYPE_CODE = ptc.PROJECT_TYPE_CODE
			AND prj.PROJECT_STATUS_CODE = psc.PROJECT_STATUS_CODE
			AND prj.MANAGING_FCBC_REGION_ID = AMFR.MANAGING_FCBC_REGION_ID
			AND prj.SUBREGIONAL_OFFICE_ID = aso.SUBREGIONAL_OFFICE_ID
			AND prj.SECONDARY_OFFICE_ID = aso2.SECONDARY_OFFICE_ID(+)
			AND prj.PROJECT_STATUS_CODE = 1
			AND pt.PROJECT_TYPE_CODE = 682
	) projects,
	(
		SELECT
			auth.PROJECT_ID,
			auth.AUTHORIZATION_ID,
			aai.AUTHORIZATION_INSTRUMENT_NAME permit_type,
			apa.AGENCY_NAME business_area,
			auth.APPLICATION_ACCEPTED_DATE accepted_date,
			auth.APPLICATION_RECEIVED_DATE received_date,
			auth.application_rejected_date rejected_date,
			auth.AUTHORIZATION_DUE_DATE,
			auth.AMENDMENT_RENEWAL_DATE,
			auth.target_days,
			auth.TECH_REVIEW_COMPLETION_DATE,
			auth.FIRST_NATION_START_DATE fn_consultn_start_date,
			auth.FIRST_NATION_COMPLETION_DATE fn_consultn_completion_date,
			auth.FIRST_NATION_COMMENT fn_consultn_comment,
			auth.ADJUDICATION_DATE,
			aasc.NAME auth_status,
			aasc.AUTHORIZATION_STATUS_CODE AUTHORIZATION_STATUS_CODE,
			AACRC.NAME close_reason,
			auth.FILE_NUMBER
		FROM
			ATS_AUTHORIZATIONS auth,
			ats.ATS_AUTHORIZATION_STATUS_CODES aasc,
			ats.ATS_ATHN_CLOSE_REASON_CODES aacrc,
			ats.ATS_MANAGING_FCBC_REGIONS amfr,
			ats.ATS_REGIONAL_USERS aru,
			ats.ATS_AUTHORIZATION_INSTRUMENTS aai,
			ats.ATS_PARTNER_AGENCIES apa
		WHERE
			auth.AUTHORIZATION_STATUS_CODE = aasc.AUTHORIZATION_STATUS_CODE (+)
			AND auth.ATHN_CLOSE_REASON_CODE = aacrc.ATHN_CLOSE_REASON_CODE (+)
			AND auth.managing_fcbc_region_id = AMFr.MANAGING_FCBC_REGION_ID (+)
			AND auth.REGIONAL_USER_ID = aru.REGIONAL_USER_ID (+)
			AND auth.AUTHORIZATION_INSTRUMENT_ID = aai.AUTHORIZATION_INSTRUMENT_ID(+)
			AND aai.PARTNER_AGENCY_ID = apa.PARTNER_AGENCY_ID
			AND aasc.AUTHORIZATION_STATUS_CODE = 1
	) authorizations
WHERE
	projects.project_id = authorizations.project_id
) z
) y
WHERE
	y.project_id IS NOT NULL
	AND APPLICATION_ID NOT IN (757503, 691223)
UNION
ALL
SELECT
	*
FROM
	(
		SELECT
			z.ministrycode,
			z.business_area,
			z.permit_type,
			CASE
				WHEN INSTR(z.project_description1, '', '', 1, 3) > 0 THEN SUBSTR(
					z.project_description1,
					INSTR(z.project_description1, '', '', 1, 3) + 1
				)
				ELSE NULL
			END project_id,
			z.application_id,
			z.project_name,
			z.project_description,
			z.project_location,
			z.RECEIVED_DATE,
			z.adjudication_date,
			z.region_name,
			SUBSTR(
				z.project_description1,
				0,
				INSTR(z.project_description1, '', '', 1, 1) -1
			) ESTIMATED_HOUSES_CONNECTED,
			NULL application_status,
			z.File_Number Business_Area_File_Number,
			'' ATS_EXTRACT_JOB '' AS RECORD_CREATED_BY,
			CURRENT_TIMESTAMP(0) AS RECORD_CREATED_DTTM
		FROM
			(
				SELECT
					'' FOR '' ministrycode,
					authorizations.business_area,
					authorizations.permit_type,
					projects.project_id project_id,
					authorizations.AUTHORIZATION_ID application_id,
					projects.project_name,
					projects.project_description,
					CASE
						WHEN INSTR(projects.project_description, '' te) '',
						1,
						1
					) > 0 THEN SUBSTR(
						projects.project_description,
						INSTR(projects.project_description, '' te) '',
						1,
						1
					) + 3
			)
			ELSE NULL
	END project_description1,
	projects.project_location,
	authorizations.RECEIVED_DATE,
	authorizations.adjudication_date,
	projects.region_name,
	authorizations.FILE_NUMBER
FROM
	(
		SELECT
			prj.PROJECT_ID,
			prj.PROJECT_NAME,
			REPLACE(
				REPLACE(prj.DESCRIPTION, CHR(10), NULL),
				CHR(13),
				NULL
			) project_description,
			REPLACE(
				REPLACE(prj.LOCATION, CHR(10), NULL),
				CHR(13),
				NULL
			) project_location,
			psc.NAME project_status,
			ptc.NAME project_type,
			amfr.REGION_NAME,
			aso.SUBREGIONAL_OFFICE_NAME,
			aso2.SECONDARY_OFFICE_NAME,
			prj.WHO_CREATED,
			prj.WHEN_CREATED,
			prj.WHO_UPDATED,
			prj.WHEN_UPDATED
		FROM
			ats.ATS_PROJECTS prj,
			ats.ATS_PROJ_PROJ_TYPE_CODE_XREF pt,
			ats.ATS_PROJECT_STATUS_CODES psc,
			ats.ATS_PROJECT_TYPE_CODES ptc,
			ats.ATS_MANAGING_FCBC_REGIONS amfr,
			ats.ATS_SUBREGIONAL_OFFICES aso,
			ats.ATS_SECONDARY_OFFICES aso2
		WHERE
			prj.PROJECT_ID = pt.project_id
			AND pt.PROJECT_TYPE_CODE = ptc.PROJECT_TYPE_CODE
			AND prj.PROJECT_STATUS_CODE = psc.PROJECT_STATUS_CODE
			AND prj.MANAGING_FCBC_REGION_ID = AMFR.MANAGING_FCBC_REGION_ID
			AND prj.SUBREGIONAL_OFFICE_ID = aso.SUBREGIONAL_OFFICE_ID
			AND prj.SECONDARY_OFFICE_ID = aso2.SECONDARY_OFFICE_ID(+)
			AND pt.PROJECT_TYPE_CODE = 682
	) projects,
	(
		SELECT
			auth.PROJECT_ID,
			auth.AUTHORIZATION_ID,
			aai.AUTHORIZATION_INSTRUMENT_NAME permit_type,
			apa.AGENCY_NAME business_area,
			auth.APPLICATION_ACCEPTED_DATE accepted_date,
			auth.APPLICATION_RECEIVED_DATE received_date,
			auth.application_rejected_date rejected_date,
			auth.AUTHORIZATION_DUE_DATE,
			auth.AMENDMENT_RENEWAL_DATE,
			auth.target_days,
			auth.TECH_REVIEW_COMPLETION_DATE,
			auth.FIRST_NATION_START_DATE fn_consultn_start_date,
			auth.FIRST_NATION_COMPLETION_DATE fn_consultn_completion_date,
			auth.FIRST_NATION_COMMENT fn_consultn_comment,
			auth.ADJUDICATION_DATE,
			aasc.NAME auth_status,
			aasc.AUTHORIZATION_STATUS_CODE AUTHORIZATION_STATUS_CODE,
			AACRC.NAME close_reason,
			auth.FILE_NUMBER
		FROM
			ATS_AUTHORIZATIONS auth,
			ats.ATS_AUTHORIZATION_STATUS_CODES aasc,
			ats.ATS_ATHN_CLOSE_REASON_CODES aacrc,
			ats.ATS_MANAGING_FCBC_REGIONS amfr,
			ats.ATS_REGIONAL_USERS aru,
			ats.ATS_AUTHORIZATION_INSTRUMENTS aai,
			ats.ATS_PARTNER_AGENCIES apa
		WHERE
			auth.AUTHORIZATION_STATUS_CODE = aasc.AUTHORIZATION_STATUS_CODE (+)
			AND auth.ATHN_CLOSE_REASON_CODE = aacrc.ATHN_CLOSE_REASON_CODE (+)
			AND auth.managing_fcbc_region_id = AMFr.MANAGING_FCBC_REGION_ID (+)
			AND auth.REGIONAL_USER_ID = aru.REGIONAL_USER_ID (+)
			AND auth.AUTHORIZATION_INSTRUMENT_ID = aai.AUTHORIZATION_INSTRUMENT_ID(+)
			AND aai.PARTNER_AGENCY_ID = apa.PARTNER_AGENCY_ID
	) authorizations
WHERE
	projects.project_id = authorizations.project_id
) z
) y
WHERE
	y.project_id IS NOT NULL
	AND y.APPLICATION_ID NOT IN (757503, 691223)
	AND y.adjudication_date > TO_DATE(
		'' 2023 -05 -01 00 :00 :00 '',
		'' YYYY - MM - DD HH24 :MI :SS ''
	)
