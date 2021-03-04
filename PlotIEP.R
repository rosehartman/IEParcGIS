# Let's plot all of IEP's surveys!

#first load some libraries:


library(sf)
library(rgeos)
library(tidyverse)
library(ggmap)
#devtools::install_github("InteragencyEcologicalProgram/deltamapr")
library(deltamapr)
library(GISTools)
library(ggsn)


load("IEPsites.RData")

#plot IEP sites and waterways
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

#plot DJFMP trawls
ednatrawls = filter(DJFMP_trawls, Location %in% c("Sherwood Harbor", "Mossdale", "Chipps Island"))
ggplot() +
  geom_sf(data = waterways, fill = "lightblue", color = "darkslategray4") +
  geom_sf_label(data = ednatrawls, aes(label = Location), nudge_y = 0.05) +
  geom_sf(data = ednatrawls)+
  coord_sf(xlim = c(-122, -121.2), ylim = c(37.75, 38.6)) +
  theme_bw() 

#Example of how to plot x-y data

#Data has a "latitude" and "longitude column. First
#we read in the data from the csv
EMP = read.csv("EMP_Discrete_Water_Quality_Stations.csv" )

#Get rid of the "EZ" stations with variable locations
EMP = filter(EMP, Latitude != "Variable") %>%
  mutate(Latitude = as.numeric(Latitude), Longitude = as.numeric(Longitude))

#now convert to a spatial data frame. "crs" stands for
#"coordinate reference systems". 4326 is USGS 1984

EMP2= st_as_sf(EMP, coords = c("Longitude", "Latitude"), crs = 4326)


###############################################
#Melinda's points

split = read_excel("Splittail Map Locations.xlsx")

split = filter(split, !is.na(Easting))

split2 = st_as_sf(split, coords = c("Easting", "Northing"), crs = 26910)

basemap = get_stamenmap(bbox = c(left = -122.6, 
                                 right = -121.0, bottom = 37.5, top = 38.6),
                        maptype = "terrain")

ggplot() +
  geom_sf(data = waterways) +
  geom_sf(data = split2) +
  scalebar(data = EMP2, dist = 20, dist_unit = "km",
           transform = TRUE, st.dist = .1) +
  scale_color_discrete(guide = FALSE) +
  north(data = waterways, symbol = 2) + 
  theme_bw()
 
ggmap(basemap) +
 #  geom_polygon(data = waterways) +
   geom_point(data = split, aes(x = Northing, y = Easter, color = Station))+
  map.scale(xc = -121.5, yc = 37.6, len = 2, units = "km", ndivs = 5, subdiv = 0.5)
