# Let's plot all of IEP's surveys!

#first load some libraries:


library(sf)
library(rgeos)
library(tidyverse)
library(ggmap)

load("IEPsites.RData")


ggplot() +
  geom_sf(data = waterways) +
  geom_sf(data = FMWT, color = "blue") +
  geom_sf(data = x20mm, color = "yellow")+
  geom_sf(data = SKT, color = "purple")+
  geom_sf(data = BayStudy, color = "yellow")
