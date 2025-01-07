
rm(list=ls())                   # Delete all variables
Sys.setenv(LANG = "en")         # Set language to English

library(ggplot2)
library(GGally)
load("StudentUSI.RData")

# Remember: data structure
str(grade)

# Parallel coordinate plot for the variables number 3 (math) to 6 (arts)
ggparcoord(grade, columns = 4:7)

# Have a look at the y-axis
ggparcoord(grade, columns = 4:7, scale="globalminmax")

# Different oderdering, different insights
ggparcoord(grade, columns = c(7,4,5,6), scale="globalminmax")
ggparcoord(grade, columns = c(7,5,4,6), scale="globalminmax")
ggparcoord(grade, columns = c(7,4,6,5), scale="globalminmax")

# A few formatting options
ggparcoord(grade, columns = c(6,4,3,5), scale="globalminmax", showPoints = T)   # not a good idea
ggparcoord(grade, columns = c(6,4,3,5), scale="globalminmax", alphaLines=0.5)
ggparcoord(grade, groupColumn="gender", scale="globalminmax", columns = c(6,4,3,5)) 
