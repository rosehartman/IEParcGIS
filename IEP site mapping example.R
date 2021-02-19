
library(sf)
library(rgeos)
library(tidyverse)
library(ggmap)
library(GISTools)
library(ggsn)


load("IEPsites.RData")

#This data file includes a bunch of shapefiles of various sampling programs
#CDECshp - all of the CDEC stations and the sensors they contain. Check https://cdec.water.ca.gov/reportapp/javareports?name=SensList 

#DJFMP_seines - DJFMP's seine sites. From 

#EMP_WQ - EMP's discrete WQ stations https://portal.edirepository.org/nis/mapbrowse?packageid=edi.458.4
#emp_zoops - EMP's zooplanktnon survey sites
#emp_benthic - EMP's benthic stations

#FMWT - Fall Midwater Trawl sites https://iep.ca.gov/Science-Synthesis-Service/Monitoring-Programs/Fall-Midwater-Trawl
#FMWTzoops - fall midwter trawll sites that include zooplankton

#SKT - Spring Kodiak Trawl sites https://iep.ca.gov/Science-Synthesis-Service/Monitoring-Programs/Spring-Kodiak or
#https://portal.edirepository.org/nis/mapbrowse?packageid=edi.527.2

#UCD_Suisun - UC Davis Suisun Marsh fish survey trawl/seine sites https://iep.ca.gov/Science-Synthesis-Service/Monitoring-Programs/Suisun-Marsh

#x20mm - 20mm survey fish/zoopalnkton sites

#YBFMP - Yolo Bypass fish monitoring program sein and trap sites: https://portal.edirepository.org/nis/mapbrowse?packageid=edi.233.2

#STN - Summer Townet Survey sites https://iep.ca.gov/Science-Synthesis-Service/Monitoring-Programs/Summer-Townet 

#waterways - channels and bays

#plot some of the IEP sites and waterways
ggplot() +
  geom_sf(data = waterways, fill = "aquamarine", color = "lightblue") +
  theme_bw()+
  geom_sf(data = FMWT, color = "blue") +
  geom_sf(data = x20mm, color = "yellow")+
  geom_sf(data = SKT, color = "purple")+
  geom_sf(data = BayStudy, color = "yellow")


#plot CDEC stations (all stations)
ggplot() +
  geom_sf(data = waterways, fill = "aquamarine", color = "lightblue") +
  theme_bw()+
  geom_sf(data = CDECshp, color = "blue") 

#plot CDEC stations (and highlight ones with chlorophyull)
ggplot() +
  geom_sf(data = waterways, fill = "aquamarine", color = "lightblue") +
  theme_bw()+
  geom_sf(data = CDECshp, aes(color = as.factor(CHLORPH))) 
