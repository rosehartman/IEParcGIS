#Make some shapefiles for Larry



library(sf)
library(rgeos)
library(tidyverse)
library(ggmap)
#devtools::install_github("InteragencyEcologicalProgram/deltamapr")
library(deltamapr)
library(GISTools)
library(ggsn)

SuisunBoundary = read_sf("Suisun_Marsh_Boundary/Suisun_Marsh_Boundary.shp")
SuisunBoundary2 = st_transform(SuisunBoundary, 4269)
Grizzly = read_sf("DeltaShapefile/SuisunGrizzly.shp")
Delta = read_sf("Legal_Delta_Boundary/Legal_Delta_Boundary.shp")

Suisunonly = st_difference(SuisunBoundary2, Grizzly)
SuisunMarsh = st_union(Suisunonly)

ggplot() + geom_sf(data = SuisunMarsh, fill = "coral")+
  geom_sf(data = Grizzly, fill = "aquamarine") + geom_sf(data = Delta, fill = "darkolivegreen2")+
  scale_color_discrete(guide = FALSE) +
  north(data = Delta, symbol = 2) + 
  theme_bw()



st_write(SuisunMarsh, dsn = "Suisun.shp", layer = "Suisun.shp", driver = "ESRI Shapefile")
