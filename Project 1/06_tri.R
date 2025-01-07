
rm(list = ls())
graphics.off()

library(ggtern)
library(ggplot2)

# A triangular or ternary plot
# Three sectors of an economy, data from here:
# https://en.wikipedia.org/wiki/List_of_countries_by_GDP_sector_composition#List_by_Alphabetical_Order
# SOM = Somalia, IDN = Indonesia, TCD=Tchad
agri <-  c(0.12, 0.13, 0.147, 0.602, 0.527)
indus <- c(0.192, 0.275, 0.472, 0.074, 0.067)
srvc = 1-agri-indus   # add up to one
country <- c("USA", "CH", "IDN", "SOM", "TCD")

# Combine to data frame
myData <- data.frame(agri, indus, srvc, country)

# A first triangle plot
ggtern(data=myData,aes(x=agri,y=indus,z=srvc)) 

# make sense of the coordinates
# e.g. on the base of the triangle, we have 
# service as percentage of the total economy from left to right
ggtern(data=myData,aes(x=agri,y=indus,z=srvc)) + 
  geom_point() + theme_showarrows()

# Improve this plot by adding labels
# Hit: make the graphics window large
ggtern(data=myData,aes(agri,indus,srvc)) + 
  geom_point(fill="white",shape=21,size=12) +
  geom_text(aes(label=country),color="black") +
  theme_nomask() + theme_showarrows()

# Let us define "developing countries" as more than 50% agriculture
# These are the borders of "developing country"
agri <- c(1, 0.5, 0.5)
indus <- c(0, 0.5, 0)
srvc <- 1-agri-indus
myDevelop <- data.frame(agri,indus,srvc)
ggtern(data=myDevelop,aes(x=agri,y=indus,z=srvc)) + 
  geom_point(color="red", size=6) +
  theme_nomask() + theme_showarrows()

# Make a polygon -- exactly the same command as previously,
# onyl replace geom_point with geom_polygon
# Remember: alpha means transparency
ggtern(data=myDevelop,aes(x=agri,y=indus,z=srvc)) + 
  geom_polygon(fill="red", alpha=0.2) +
  theme_nomask() + theme_showarrows()

# Combine the two
# labs() defines the labels i.e. makes them nicer
ggtern(data=myData,aes(x=agri,y=indus,z=srvc)) + 
  geom_point(fill="white",shape=21,size=11) +
  geom_text(aes(label=country),color="black") +
  geom_polygon(data=myDevelop, fill="red", alpha=0.2) +
  theme_showarrows() + theme_nomask() +
  labs(title="Identification of developing countries",
       x="Agriculture",
       y="Industry",
       z="Service") 
