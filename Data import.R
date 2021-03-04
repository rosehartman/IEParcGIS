#Import all the shapefiles for IEP surveys and turn them into sf objects

library(sf)
library(rgeos)
library(tidyverse)
library(ggmap)

waterways = read_sf("DeltaShapefile/hydro_delta_marsh.shp")

emp_benthic = read_sf("benthicmonthly.shp")
FMWT = read_sf("FWMT/FMWT_Fish_2014.shp")
FMWTzoop = read_sf("FWMT/FMWT_Zooplankton_2014.shp")
x20mm = read_sf("20mm/20mmMay2020.shp")
BayStudy = read_sf("Bay Study/Bay_Study_2014.shp")
SKT = read_sf("SKT/skt_MAY2020.shp")
emp_zoops = read_sf("zoopstudy.shp")
#DJFMP_seines = read_sf("USFWS Beach Seine/Beach_Seine_Sites.shp")
UCD_Suisun = read_sf("UC Davis SuisunMarsh Coverage/UCDavisFisheries.shp")
YBFMP = read_sf("yolobypass.shp")
STN = read_sf("STN/STN_2014.shp")
SuisunBoundary = read_sf("Suisun_Marsh_Boundary/Suisun_Marsh_Boundary.shp")
FloodBoundary = read_sf("Flood_bypasses-shp/Flood_Bypasses.shp")
DeltaBoundary = read_sf("Legal_Delta_Boundary/Legal_Delta_Boundary.shp")
EDSMRegions = read_sf("C:/Users/rhartman/OneDrive - California Department of Water Resources/climate change PWT/TempSynthesis/EDSM_Subregions/Regions/Phase1Regions.shp")
EDSMstrata = read_sf("C:/Users/rhartman/OneDrive - California Department of Water Resources/climate change PWT/TempSynthesis/EDSM_Subregions/Strata_1Dec2018_31Mar2019/Strata_1Dec2018_31Mar2019.shp")
EDSMsubregions = read_sf("C:/Users/rhartman/OneDrive - California Department of Water Resources/climate change PWT/TempSynthesis/EDSM_Subregions/Subregions Phase 1/Subregions_1Dec2018_present.shp")
SamEDSMRegions = read_sf("C:/Users/rhartman/OneDrive - California Department of Water Resources/climate change PWT/TempSynthesis/EDSM_Subregions/EDSM_Subregions_03302020.shp")

EMP_WQ = read.csv("EMP_Discrete_Water_Quality_Stations_1975-2020.csv")
EMP_WQ = filter(EMP_WQ, !is.na(Latitude))
EMP_WQ = st_as_sf(EMP_WQ, coords = c("Longitude", "Latitude"),  crs = 4326)

DJFMP = read.csv("USFWS Beach Seine/DJFMP_Site_Locations.csv")
DJFMP_seines = filter(DJFMP, MethodCode == "SEIN") %>%
  st_as_sf(coords = c("Longitude_location", "Latitude_location"),  crs = 4326)
DJFMP_trawls = filter(DJFMP, MethodCode != "SEIN" )%>%
  st_as_sf(coords = c("Longitude_location", "Latitude_location"),  crs = 4326)


CDEC = read.csv("CDEC_Stations2.csv")
CDEC2 = pivot_longer(CDEC, cols = c(Sensor1:X.2), names_to = "colnames", values_to = "SensorNum")
CDEC2 = filter(CDEC2, !is.na(SensorNum))

CDECnums = read.csv("CDECsensornums.csv")
CDEC3 = merge(CDEC2, CDECnums)

CDEC4 = pivot_wider(CDEC3, id_cols = c(STA, Station.Name, Elevation, Latitude, Longitude, Nearby.City, Owner, County.Name), 
                    names_from = SENSOR, values_from = SensorNum,  values_fn = length)
CDECshp = st_as_sf(CDEC4, coords = c("Longitude", "Latitude"),  crs = 4326)

save(FMWT, BayStudy, FMWTzoop, SKT, UCD_Suisun, emp_zoops, STN, waterways, x20mm, YBFMP, 
     DJFMP_seines, EMP_WQ, CDECshp, emp_benthic,
           file = "IEPsites.RData")
