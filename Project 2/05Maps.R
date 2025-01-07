
rm(list = ls())
graphics.off()

# Using the following packages
# Remember: if a package is not installed, use install.packages()
library(tidyverse)
library(ggplot2)
library(ggmap)
library(maptools)
library(maps)


# Work with maps form the internet
?geocode
?get_map


# Map of Switzerland
# (1) Where is Switzerland?
CHloc <- geocode("Switzerland")
print(CHloc)

# (2a) Download a *base map* of Switzerand ...
CHmap <- ggmap(get_map(location=as.numeric(CHloc), scale = 1, zoom=7, 
                       source="google", maptype="terrain"))
# (2b) and display it (why 2 steps? To reduce the downloads/API accesses)
CHmap

# MANY options for basemaps
maptypes = c("terrain", "terrain-background", "satellite", "roadmap", "hybrid", "toner",
            "watercolor", "terrain-labels", "terrain-lines", "toner-2010",
            "toner-2011", "toner-background", "toner-hybrid", "toner-labels",
            "toner-lines", "toner-lite")

MapExamples <- list(NA)
for (k in 1:length(maptypes))
  {
  MapExamples[[k]] <- ggmap(get_map(location=as.numeric(CHloc), scale = 2, zoom=7, 
                      maptype=maptypes[k]))
  }

MapExamples[[15]]

## ------- Dot map -----
# Add the USI to the Switzerland map
# (1) location of USI
HSGloc <- geocode("Università della Svizzera italiana")
# (2) Place a dot on the map ... use the ggplot2 logic!!
CHmap + geom_point(data=HSGloc, aes(x=lon,y=lat), size=5, color="orange")
# (3) Now add more univiersities
# Remember: c() creates a list!
UNIloc <- geocode( c("Università della Svizzera italiana", "University of Zurich", "Universität St. Gallen") )
CHmap + geom_point(data=UNIloc, aes(x=lon,y=lat), 
                   size=5, color=c("orange","dodgerblue","darkgreen"))

# Exercise: make a map of all <universities/airports/...> in <switzerland/germany/...>
# see below
airports <- geocode( c("ZRH airport","GVA airport", "Lugano airport") )
CHmap + geom_point(data = airports, aes(x=lon, y=lat), size=5, shape=17)

## ---- Custom map symbol
# This depends on YOUR computer!!
# Step 1: find unicode symbol https://unicode-table.com/
# Step 2: import fonts (once)
library(extrafont)
font_import()          # takes a moment
# Step 3: find a font with unicode in the name, for example "Arial Unicode MS"
fonts()
# Step 4: use geom_text(), not geom_pont()
CHmap + geom_text(data = airports, aes(x=lon, y=lat), 
                  size=15, family="Arial Unicode MS", label="\u2708")

# Exercise: draw a map of the USI 
# (hint: you need to change the "zoom" parameter in order to zoom in)
usi <- as.numeric(UNIloc[1,])
ggmap(get_googlemap(center=usi, size = c(640,640), zoom=17), extent="normal")


# Map of Europe -----------------------------------------------------------
EUR <- geocode("Europe")
EURmap <- ggmap(get_map(location=as.numeric(EUR), zoom = 4), extent="normal")
EURmap

# Adding to the map
load("Rosling.RData")
EUR_2015 <- filter(dataToPlot, region == "EUR" & year == "2015" &
                     !country %in% c("Russian Federation","Iceland","Georgia","Azerbaijan","Greenland","Armenia")
                    )
# So many geodoces
EUR_2015
geocodes <- geocode(as.character(EUR_2015$country))

# Create one big data frame
EUR_2015 <- cbind(EUR_2015,geocodes)

# plot EU population per country
ggmap(get_map(location=as.numeric(EUR), zoom = 4), extent="normal") +
  geom_point(data = EUR_2015, aes(x = lon, y = lat,size = population), color = "red", alpha = 0.3) +
  scale_size(guide='none', range = c(1,20))
  # The last line removes the legend


## ------ Working with Shapefiles
load("Maps.RData")
# Lets have a look at dataToMap
head(dataToMap)

ggplot(data = dataToMap, aes(x = long, y = lat, group = group)) + 
  geom_polygon(fill = "white", color = "black") + coord_fixed()

# How can we just plot 1 country?
# Filter!
dataCH = filter(dataToMap, country == "Switzerland")
ggplot(data = dataCH, aes(x = long, y = lat, group = group)) + 
  geom_polygon(fill = "white", color = "black") + coord_fixed()

# Exercise: now plot Germany
dataDE = filter(dataToMap, country == "Germany")
ggplot(data = dataDE, aes(x = long, y = lat, group = group)) + 
  geom_polygon(fill = "white", color = "black") + coord_fixed()

# Our first choropleth: color by region
ggplot(data = dataToMap, aes(x = long, y = lat, group = group)) + 
  geom_polygon(aes(fill = region), color = "black")+ coord_fixed()

ggplot(data = dataToMap, aes(x = long, y = lat, group = group)) + 
  geom_polygon(aes(fill = life_expectancy), color = "black") +
  scale_fill_gradient(low = "pink", high = "darkred")+ coord_fixed()

# Map of Europe
euro_data <- filter(dataToMap, region == "EUR")
euro_data <- select(euro_data, -region, -X)
euro_data <- euro_data[order(euro_data$country),]

ggplot(data = euro_data, aes(x = long, y = lat, group = group)) + 
  geom_polygon(fill = "white", color = "black")+ coord_fixed()

# Take away Russia,...
euro_data <- filter(euro_data, !(country %in% c("Russia","Iceland","Georgia",
                                    "Azerbaijan","Greenland","Armenia","Greenland"))) 

ggplot(data = euro_data, aes(x = long, y = lat, group = group)) + 
  geom_polygon(fill = "white", color = "black")+ coord_fixed()

# Lower latitude
euro_data <- filter(euro_data, lat < 72)

euro_data$order <- 1:length(euro_data$country)

ggplot(data = euro_data, aes(x = long, y = lat, group = group)) + 
  geom_polygon(fill = "white", color = "black")+ coord_fixed()

ggplot(data = euro_data, aes(x = long, y = lat, group = group)) + 
  geom_polygon(aes(fill = country), color = "black")+ coord_fixed()


ggplot(data = euro_data, aes(x = long, y = lat, group = group)) + 
  geom_polygon(aes(fill = life_expectancy), color = "black") +
  scale_fill_gradient(low = "orange", high = "brown")  + coord_fixed()

ggplot(euro_data, aes(x = long, y = lat, group = group)) + 
  geom_polygon(aes(x = long, y = lat, group = group, fill = gdp_per_capita), color = "black") +
  scale_fill_gradient(low = "skyblue", high = "darkblue")




# Statebins ---------------------------------------------------------------
# install.packages("socviz")
library(socviz)

# election results of 2016 presidential election
# from socviz
US_election <- election

# map_data form ggplot2
us_states <- map_data("state")

ggplot(data = us_states, aes(x = long, y = lat, group = group)) + 
  geom_polygon(fill = "white", color = "black")+ coord_fixed()

ggplot(data = us_states, aes(x = long, y = lat, group = group)) + 
  geom_polygon(aes(fill = region), color = "black")+ coord_fixed()

election$region <- tolower(election$state)
us_states_elec <- left_join(us_states, election)

ggplot(data = us_states_elec, aes(x = long, y = lat, group = group)) + 
  geom_polygon(aes(fill = party), color = "black") +
  scale_fill_manual("Party", values = c("dodgerblue1", "firebrick"))

# install.packages("statebins")
library(statebins)
library(RColorBrewer)
statebins(state_data = election, state_col = "state",
                      value_col = "pct_trump",
                     font_size = 5) 

# Airports ----------------------------------------------------------------
AIR = read.csv("airports.csv", header = FALSE, sep=";", dec=",")
colnames(AIR) <- c("IATA_code", "passengers")

AIR$IATA_code <- as.character(AIR$IATA_code)
AIR$geoReference <- as.character(paste(AIR$IATA_code,"Airport"))
euro <- as.numeric(geocode("Europe"))
EUbasemap <- ggmap(get_map(location=euro, zoom = 4))
# >>> Following lines work, but are very slow <<<
# >>> Replace by loading the savefile instead
# geocode_AIR <- geocode(AIR$geoReference)
# AIR$long <- geocode_AIR$lon
# AIR$lat <- geocode_AIR$lat
# save(geocode_AIR,file="airportGeocodes.Rda")
load("airportGeocodes.Rda")
# Add to dataframe
AIR$lon <- geocode_AIR$lon
AIR$lat <- geocode_AIR$lat

EUbasemap +
  geom_point(data = AIR, 
             aes(x = lon, y = lat),
             color = "black", alpha = 0.3) 

EUbasemap +
  geom_point(data = AIR, 
             aes(x = lon, y = lat, size = passengers),
             color = "red", alpha = 0.3) +
  scale_size(name = "Passengers in Mio.") 


AIRlarge <- filter(AIR, lon > -10.5 & lon < 41 & lat > 35 & lat < 68 & passengers>5)

EUbasemap +
  geom_point(data = AIRlarge, 
             aes(x = long, y = lat, size = passengers),
             color = "red", alpha = 0.3) +
  scale_size(name = "Passengers in Mio.") +
  geom_text(data=AIRlarge, aes(x=long, y=lat, label=IATA_code),
            color = "black", size = 4, hjust = 0.5, vjust = 0.5,
            nudge_x=1.5)
