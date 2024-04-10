-- finds best fit for place names with multiple points
WITH generalized_geographic_places AS (
    SELECT
        geographical_name,
        AVG(latitude) AS average_lat,
        AVG(longitude) AS average_lon
    FROM
         geometry.bc_geographical_names
    GROUP BY
        geographical_name
)
SELECT     
    ministry,
    business_area,
    source_system_acronym,
    permit_id,
    authorization_type,
    cutting_permit_id,
    harvest_auth_status,
    authorization_id,
    auth_status,
    status_date,
    issue_date,
    current_expiry_date_calc,
    location,
    harvest_area,
    received_date,
    app_decision_date,
    app_issuance_date,
    project_name,
    project_description,
    property_subclass,
    project_location,
    project_id,
    accepted_date,
    rejected_date,
    adjudication_date,
    permit_status,
    map_feature_id,
    road_section_id,
    road_section_status,
    organization_unit_name,
    nrsos_smart_form_id,
    update_date,
    ats_region_name,
    hva_skey,
    road_section_guid,
    age,
    nr_region,
    nr_district,
    -- takes the geometry center or best fit point
    COALESCE(point_lat, average_lat) AS latitude,
    COALESCE(point_lon, average_lon) AS longitude
FROM
	(SELECT *,
	 	-- takes ATS nr_region where available otherwise use calculated nr_region 
		COALESCE(nr_region_boundary, ats_region_name) AS nr_region,
	 	nr_district_boundary as nr_district
		FROM 
		(SELECT with_geom.*,
		 -- returns centroid if within shape, otherwise returns point on surface 
		 -- converts BC Albers (3005) to lat/lon (4326)
		  ST_X(ST_Transform(CASE 
			  WHEN (ST_Contains(geometry, ST_Centroid(geometry))) IS TRUE THEN ST_Centroid(geometry)
			  ELSE ST_PointOnSurface(geometry)
				END, 4326)) AS point_lon,
		  ST_Y(ST_Transform(CASE 
			  WHEN (ST_Contains(geometry, ST_Centroid(geometry))) IS TRUE THEN ST_Centroid(geometry)
			  ELSE ST_PointOnSurface(geometry)
				END, 4326)) AS point_lat
			FROM 
		 		(SELECT nrs_vw.*,
				 	-- merge FTA and RRS geometry to 1 column
					COALESCE(fta.geometry, rrs.geometry) AS geometry
				FROM rrs_replication.x_nrs_consolidated_vw AS nrs_vw
				 -- join with x_nrs_consolidated_vw
				LEFT JOIN geometry.harvest_authority_geom AS fta ON nrs_vw.hva_skey = fta.hva_skey
				LEFT JOIN geometry.road_section_geometry AS rrs ON encode(nrs_vw.road_section_guid, 'hex'::text) = LOWER(rrs.road_section_guid))
				AS with_geom)
		AS with_lat_lon
	LEFT JOIN geometry.natural_resource_boundaries AS nr_boundaries
	-- determines which shapes are contained in which NR boundaries
	ON ST_Contains(nr_boundaries.geom, with_lat_lon.geometry))
	AS with_nr_boundaries
-- matches ATS free text to BC place names
LEFT JOIN generalized_geographic_places AS geo_names 
ON with_nr_boundaries.location ILIKE geo_names.geographical_name;
