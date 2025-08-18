def get_tsl_summary_lrm_query(licence_ids):
    """
    licence_ids: A tuple of licence IDs, e.g. ('12345, 67890')
    """
    return \
    f"""
    INSERT INTO bcts_staging.tsl_summary_lrm(
	licence_id, geographic_location, field_team, species)
    WITH RECURSIVE split_species AS (
        SELECT 
            LICENCE_ID,
            BLOCK_ID,
            BLOCK_VOLUME,
            GEOGRAPHIC_LOCATION,
            FIELD_TEAM,
            SPECIES_COMPOSITION,
            split_part(SPECIES_COMPOSITION, ';', 1) AS SPECIES_DETAIL,
            1 AS LEVEL
        FROM LRM_REPLICATION.SV_SALES_SCHEDULE

        UNION ALL

        SELECT 
            s.LICENCE_ID,
            s.BLOCK_ID,
            s.BLOCK_VOLUME,
            s.GEOGRAPHIC_LOCATION,
            s.FIELD_TEAM,
            s.SPECIES_COMPOSITION,
            split_part(s.SPECIES_COMPOSITION, ';', ss.LEVEL + 1),
            ss.LEVEL + 1
        FROM split_species ss
        JOIN LRM_REPLICATION.SV_SALES_SCHEDULE s
        ON s.BLOCK_ID = ss.BLOCK_ID AND s.LICENCE_ID = ss.LICENCE_ID
        WHERE split_part(s.SPECIES_COMPOSITION, ';', ss.LEVEL + 1) <> ''
    ),
    parsed_species AS (
        SELECT 
            LICENCE_ID,
            BLOCK_ID,
            BLOCK_VOLUME,
            regexp_matches(trim(SPECIES_DETAIL), '^([A-Z]+)')::text AS SPECIES_CD,
            (regexp_matches(SPECIES_DETAIL, '[0-9.]+'))[1]::numeric AS SPECIES_PCT
        FROM split_species
        WHERE BLOCK_VOLUME IS NOT NULL AND BLOCK_VOLUME > 0
    ),
    licence_volume AS (
        SELECT 
            LICENCE_ID,
            SUM(BLOCK_VOLUME) AS TOTAL_VOLUME
        FROM LRM_REPLICATION.SV_SALES_SCHEDULE
        WHERE BLOCK_VOLUME IS NOT NULL AND BLOCK_VOLUME > 0
        GROUP BY LICENCE_ID
    ),
    calc_weight AS (
        SELECT 
            p.LICENCE_ID,
            p.SPECIES_CD,
            SUM(p.BLOCK_VOLUME * p.SPECIES_PCT) AS WEIGHTED_PCT_NUMERATOR,
            lv.TOTAL_VOLUME,
            CASE 
                WHEN lv.TOTAL_VOLUME = 0 THEN 0 
                ELSE SUM(p.BLOCK_VOLUME * p.SPECIES_PCT) / lv.TOTAL_VOLUME
            END AS FINAL_PCT
        FROM parsed_species p
        JOIN licence_volume lv
            ON p.LICENCE_ID = lv.LICENCE_ID
        GROUP BY p.LICENCE_ID, p.SPECIES_CD, lv.TOTAL_VOLUME
    ),
    species AS (
        SELECT 
            LICENCE_ID,
            string_agg(
                SPECIES_CD || ' ' || ROUND(FINAL_PCT, 0)::text || '%', 
                ', ' ORDER BY FINAL_PCT DESC
            ) AS SPECIES
        FROM calc_weight
        WHERE ROUND(FINAL_PCT, 0) > 0
        GROUP BY LICENCE_ID
    )
    SELECT DISTINCT 
        auc_data.LICENCE_ID,
        ss.GEOGRAPHIC_LOCATION, 
        ss.FIELD_TEAM, 
        species.SPECIES
    FROM LRM_REPLICATION.SV_SALES_SCHEDULE ss
    LEFT JOIN species
        ON species.LICENCE_ID = ss.LICENCE_ID
    RIGHT JOIN (
        SELECT DISTINCT LICENCE_ID
        FROM LRM_REPLICATION.V_LICENCE_ACTIVITY_ALL
        WHERE LICENCE_ID IN ('{licence_ids}')
    ) auc_data
        ON auc_data.LICENCE_ID = ss.LICENCE_ID;
    """
