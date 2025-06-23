CREATE VIEW bcts_reporting.v_forest_division AS
SELECT 
CASE
		WHEN d.divi_short_code IN ( 'TBA', 'TPL', 'TPG', 'TSK', 'TSN',
									'TCC', 'TKA', 'TKO', 'TOC' ) THEN
			'Interior'
		WHEN d.divi_short_code IN ( 'TCH', 'TST', 'TSG' ) THEN
			'Coast'
	END                                             AS business_area_region_category,
	CASE
		WHEN d.divi_short_code IN ( 'TBA', 'TPL', 'TPG', 'TSK', 'TSN' ) THEN
			'North Interior'
		WHEN d.divi_short_code IN ( 'TCC', 'TKA', 'TKO', 'TOC' ) THEN
			'South Interior'
		WHEN d.divi_short_code IN ( 'TCH', 'TST', 'TSG' ) THEN
			'Coast'
	END                                             AS business_area_region,
	CASE WHEN d.divi_division_name = 'Seaward' THEN 'Seaward-Tlasta' ELSE d.divi_division_name END
	|| ' ('
	|| d.divi_short_code
	|| ')'                                          AS business_area,
	d.divi_short_code                               AS business_area_code
FROM bcts_staging.forest_division d;
