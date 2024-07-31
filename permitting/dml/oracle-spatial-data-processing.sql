SELECT 
TA.TENURE_APP_ID AS TENURE_APP_ID,

CASE WHEN SDO_CONTAINS(HAG.GEOMETRY, SDO_GEOM.SDO_CENTROID(HAG.GEOMETRY)) = 'TRUE' THEN (SDO_CS.TRANSFORM(SDO_GEOM.SDO_CENTROID(HAG.GEOMETRY), 4326)).SDO_POINT.Y
ELSE (SDO_CS.TRANSFORM(SDO_GEOM.SDO_POINTONSURFACE(HAG.GEOMETRY), 4326)).SDO_POINT.Y
	END AS LAT,

CASE WHEN SDO_CONTAINS(HAG.GEOMETRY, SDO_GEOM.SDO_CENTROID(HAG.GEOMETRY)) = 'TRUE' THEN (SDO_CS.TRANSFORM(SDO_GEOM.SDO_CENTROID(HAG.GEOMETRY), 4326)).SDO_POINT.X
ELSE (SDO_CS.TRANSFORM(SDO_GEOM.SDO_POINTONSURFACE(HAG.GEOMETRY), 4326)).SDO_POINT.X
	END AS LON,

REPLACE(OU.ORG_UNIT_NAME, ' Natural Resource District', '') AS NR_DISTRICT,
CASE WHEN OU.ORG_UNIT_NAME IN ('North Island - Central Coast Natural Resource District','South Island Natural Resource District','Campbell River Natural Resource District', 'Haida Gwaii Natural Resource District') THEN 'West Coast'
     WHEN OU.ORG_UNIT_NAME IN ('Chilliwack Natural Resource District', 'Sea to Sky Natural Resource District','Sunshine Coast Natural Resource District') THEN 'South Coast'
     WHEN OU.ORG_UNIT_NAME IN ('Prince George Natural Resource District','Mackenzie Natural Resource District', 'Stuart Nechako Natural Resource District') THEN 'Omineca'
     WHEN OU.ORG_UNIT_NAME IN ('Coast Mountains Natural Resource District', 'Nadina Natural Resource District', 'Skeena Stikine Natural Resource District') THEN 'Skeena'
     WHEN OU.ORG_UNIT_NAME IN ('Cariboo-Chilcotin Natural Resource District', '100 Mile House Natural Resource District', 'Quesnel Natural Resource District') THEN 'Cariboo'       
     WHEN OU.ORG_UNIT_NAME IN ('Cascades Natural Resource District', 'Okanagan Shuswap Natural Resource District', 'Thompson Rivers Natural Resource District') THEN 'Thompson-Okanagan'
     WHEN OU.ORG_UNIT_NAME IN ('Rocky Mountain Natural Resource District', 'Selkirk Natural Resource District') THEN 'Kootenay-Boundary'
     WHEN OU.ORG_UNIT_NAME IN ('Peace Natural Resource District', 'Fort Nelson Natural Resource District') THEN 'Northeast'
     ELSE 'Unknown'
  END AS NR_REGION
  
FROM THE.HARVESTING_AUTHORITY HVA
LEFT JOIN THE.HARVEST_AUTHORITY_GEOM HAG ON HVA.HVA_SKEY = HAG.HVA_SKEY
LEFT JOIN TENURE_APPLICATION_MAP_FEATURE TAMF ON TAMF.MAP_FEATURE_ID = HAG.MAP_FEATURE_ID
LEFT JOIN TENURE_APPLICATION TA ON TA.TENURE_APP_ID = TAMF.TENURE_APP_ID
LEFT JOIN ORG_UNIT OU ON (OU.ORG_UNIT_NO = TA.ORG_UNIT_NO);

SELECT
MF.MAP_FEATURE_ID,

CASE WHEN SDO_CONTAINS(RSG.GEOMETRY, SDO_GEOM.SDO_CENTROID(RSG.GEOMETRY)) = 'TRUE' THEN (SDO_CS.TRANSFORM(SDO_GEOM.SDO_CENTROID(RSG.GEOMETRY), 4326)).SDO_POINT.Y
ELSE (SDO_CS.TRANSFORM(SDO_GEOM.SDO_POINTONSURFACE(RSG.GEOMETRY), 4326)).SDO_POINT.Y
	END AS LAT,

CASE WHEN SDO_CONTAINS(RSG.GEOMETRY, SDO_GEOM.SDO_CENTROID(RSG.GEOMETRY)) = 'TRUE' THEN (SDO_CS.TRANSFORM(SDO_GEOM.SDO_CENTROID(RSG.GEOMETRY), 4326)).SDO_POINT.X
ELSE (SDO_CS.TRANSFORM(SDO_GEOM.SDO_POINTONSURFACE(RSG.GEOMETRY), 4326)).SDO_POINT.X
	END AS LON,

REPLACE(OU.ORGANIZATION_UNIT_NAME, ' Natural Resource District', '') AS NR_DISTRICT,
CASE WHEN OU.ORGANIZATION_UNIT_NAME IN ('North Island - Central Coast Natural Resource District','South Island Natural Resource District','Campbell River Natural Resource District', 'Haida Gwaii Natural Resource District') THEN 'West Coast'
     WHEN OU.ORGANIZATION_UNIT_NAME IN ('Chilliwack Natural Resource District', 'Sea to Sky Natural Resource District','Sunshine Coast Natural Resource District') THEN 'South Coast'
     WHEN OU.ORGANIZATION_UNIT_NAME IN ('Prince George Natural Resource District','Mackenzie Natural Resource District', 'Stuart Nechako Natural Resource District') THEN 'Omineca'
     WHEN OU.ORGANIZATION_UNIT_NAME IN ('Coast Mountains Natural Resource District', 'Nadina Natural Resource District', 'Skeena Stikine Natural Resource District') THEN 'Skeena'
     WHEN OU.ORGANIZATION_UNIT_NAME IN ('Cariboo-Chilcotin Natural Resource District', '100 Mile House Natural Resource District', 'Quesnel Natural Resource District') THEN 'Cariboo'
     WHEN OU.ORGANIZATION_UNIT_NAME IN ('Cascades Natural Resource District', 'Okanagan Shuswap Natural Resource District', 'Thompson Rivers Natural Resource District') THEN 'Thompson-Okanagan'
     WHEN OU.ORGANIZATION_UNIT_NAME IN ('Rocky Mountain Natural Resource District', 'Selkirk Natural Resource District') THEN 'Kootenay-Boundary'
     WHEN OU.ORGANIZATION_UNIT_NAME IN ('Peace Natural Resource District', 'Fort Nelson Natural Resource District') THEN 'Northeast'
     ELSE 'Unknown'
  END AS NR_REGION

FROM APP_RRS.RESOURCE_ROAD_TENURE t
INNER JOIN APP_RRS.ROAD_APPLICATION ra ON ra.RESOURCE_ROAD_TENURE_GUID = t.RESOURCE_ROAD_TENURE_GUID
INNER JOIN APP_RRS.ROAD_APPL_MAP_FEATURE mf ON mf.ROAD_APPLICATION_GUID = ra.ROAD_APPLICATION_GUID
INNER JOIN APP_RRS.ROAD_SECTION rs ON mf.FEATURE_RECORD_GUID=rs.ROAD_SECTION_GUID
INNER JOIN APP_RRS.ROAD_SECTION_GEOMETRY rsg ON rs.GEOMETRY_ROAD_SECTION_GUID = rsg.ROAD_SECTION_GUID
INNER JOIN APP_RRS.ROAD_FEATURE_CLASS_SDW fc ON mf.ROAD_FEATURE_CLASS_SDW_GUID = fc.ROAD_FEATURE_CLASS_SDW_GUID
INNER JOIN APP_RRS.ROAD_ORG_UNIT_SDW ou ON ou.ROAD_ORG_UNIT_SDW_GUID = ra.METADATA_ORG_UNIT_SDW_GUID;