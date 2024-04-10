## DEMO: Spatial Data Processing & Geocoding for X-NRS Dashboard 
library(dplyr)
library(fuzzyjoin)
library(bcdata)
library(sf)
library(jsonlite)
library(ggplot2)
library(stringr)

## Reference Data Sets ## 

# ID dfc492c0-69c5-4c20-a6de-2c9bc999301f = natural-resource-nr-regions
nr_region <- bcdc_get_data("dfc492c0-69c5-4c20-a6de-2c9bc999301f") %>%
  rename("NR_REGION" = "REGION_NAME") %>%
  select(c("NR_REGION", "geometry"))

# ID 0bc73892-e41f-41d0-8d8e-828c16139337 = natural-resource-nr-district
nr_district <- bcdc_get_data("0bc73892-e41f-41d0-8d8e-828c16139337") %>%
  rename("NR_DISTRICT" = "DISTRICT_NAME") %>%
  select(c("NR_DISTRICT", "geometry"))

# ID 43805524-4add-4474-ad53-1a985930f352 = bc-geographical-names
geo_data <- bcdc_get_data("43805524-4add-4474-ad53-1a985930f352") %>% 
  select(c("GEOGRAPHICAL_NAME", "LATITUDE", "LONGITUDE")) %>%
  rename("PROJECT_LOCATION" = "GEOGRAPHICAL_NAME") %>%
  group_by(PROJECT_LOCATION) %>%
  slice(1)

# 4cf233c2-f020-4f7a-9b87-1923252fbc24 = parcelmap-bc-parcel-fabric
parcel_map <- bcdc_get_data('4cf233c2-f020-4f7a-9b87-1923252fbc24', resource = '6dd5db5c-c080-474c-9a8d-631a42e5b1d1') %>% 
  select(c("PID", "SHAPE")) %>%
  group_by(PID) %>%
  slice(1)

# Map for fun 
ggplot() +
  geom_sf(data = nr_region) +
  geom_sf(data = nr_district) +
  geom_sf(data = geo_data) +
  theme_minimal()

# Function to find centroid within feature
st_centroid_within <- function(geometry) {
  centroid <- geometry %>% st_centroid()
  in_poly <- st_within(centroid, geometry, sparse = F)[[1]] 
  if (in_poly) return(centroid)
  point_on_surface <- st_point_on_surface(geometry)
  return(point_on_surface)
  }

## FTA & RRS Data Processing ##

file <- file.choose()
fta_data <- fromJSON(file)

file <- file.choose()
rrs_data <- fromJSON(file)

# Make sure SQL query is run with SDO_UTIL.TO_WKTGEOMETRY(GEOMETRY)
fta_data_sf <- st_as_sf(fta_data, wkt = "GEOMETRY", crs = st_crs(nr_region))

# Find centriod 
fta_data_sf$centroid <- st_centroid_within(fta_data_sf$GEOMETRY)

# Remove polygons and lines (too big to pull into Power BI)
fta_data_sf$GEOMETRY <- NULL

# Determine NR region and NR district
fta_data_sf <- fta_data_sf %>% 
  st_as_sf() %>%
  st_join(nr_region, join = st_within) %>% 
  st_join(nr_district, join = st_within) 

# Convert from BC Albers to LAT/LON
fta_data_sf <- fta_data_sf %>%
  st_transform(4326)

## ATS Geocoding ## 
file <- file.choose()
ats_data <- fromJSON(file)

# Filter exact matches to Bc Geographical Names 
exact_matches <-  left_join(ats_data, geo_data, by = "PROJECT_LOCATION") %>% 
  filter(!is.na(LATITUDE)) %>%
  mutate(match_type = "exact") 

# Find non-matches using anti join
anti_join <- anti_join(ats_data, exact_matches, by = "AUTHORIZATION_ID")

# Join fuzzy matches with Jaro-Winkler matching algorithm
fuzzy_matches <- stringdist_join(
  anti_join, geo_data,
  by           = "PROJECT_LOCATION",
  mode         = "left",
  ignore_case  = TRUE, 
  method       = "jw", 
  max_dist     = 0.05, 
  distance_col = "jaro_winkler") %>%
  filter(!is.na(jaro_winkler)) %>%
  mutate(match_type = "fuzzy") %>%
  group_by(AUTHORIZATION_ID) %>%
  slice_min(order_by = jaro_winkler, n = 1) %>%
  slice(1)

# Match Parcel IDs to BC Parcel Map
parcel_map_match <- anti_join %>% 
  mutate(extracted_PID = str_match(anti_join$PROJECT_LOCATION, "Private Land - Parcel ID:\\s*(.*?)\\s*- Legal Description:")) %>% 
  mutate(PID = str_replace_all(extracted_PID[,2], "-", "")) %>%
  filter(!is.na(PID)) %>% 
  filter((nchar(PID)) == 9) %>% 
  mutate(PID = as.integer(PID)) %>% 
  left_join(parcel_map, by = "PID")
