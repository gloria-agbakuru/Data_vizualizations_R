
rm(list=ls())                   # Delete all variables
Sys.setenv(LANG = "en")         # Set language to English

library(ggplot2)
# if needed:
# install.packages("corrplot")
library(corrplot)
# if needed:
# install.packages("GGally")
library(GGally)

## The data set
load("StudentUSI.RData")

# 6 relevant correlations:

gradeNum <- grade[,c("math","stat","econ","art")]

ggplot(data = grade, aes(x = math, y = stat)) + geom_point()
ggplot(data = grade, aes(x = math, y = econ)) + geom_point()
ggplot(data = grade, aes(x = math, y = art)) + geom_point()
ggplot(data = grade, aes(x = stat, y = econ)) + geom_point()
ggplot(data = grade, aes(x = stat, y = art)) + geom_point()
ggplot(data = grade, aes(x = econ, y = art)) + geom_point()

# Adding a linear model to data:

ggplot(data = grade, aes(x = math, y = stat)) + geom_point() + geom_smooth(method = "lm", se = FALSE)
ggplot(data = grade, aes(x = math, y = econ)) + geom_point() + geom_smooth(method = "lm", se = FALSE)
ggplot(data = grade, aes(x = math, y = art)) + geom_point() + geom_smooth(method = "lm", se = FALSE)
ggplot(data = grade, aes(x = stat, y = econ)) + geom_point() + geom_smooth(method = "lm", se = FALSE)
ggplot(data = grade, aes(x = stat, y = art)) + geom_point() + geom_smooth(method = "lm", se = FALSE)
ggplot(data = grade, aes(x = econ, y = art)) + geom_point() + geom_smooth(method = "lm", se = FALSE)

# Computing correlations/2 variables:
cor(gradeNum$math,gradeNum$stat)

# Computing correlations/correlation matrix:
myCorr <- cor(gradeNum) 
cor(gradeNum)

# Visualizing correlations: 

# 1) Library corrplot
# correlation matrix must be supplied to corrplot() and not the data itself
corrplot(myCorr)

# by default method = "circle" is plotted in upper and in lower triangle
corrplot(myCorr, method="circle")

# method can be "pie", "ellipse", "number"...
corrplot(myCorr, method="number") 

# by setting type = "upper" or "lower" only upper or lower triangle is plotted
corrplot(myCorr, method = "ellipse", type = "upper")

# to plot different objects in lower and upper, use corrplot.mixed()
corrplot.mixed(myCorr) # lower = "number" and upper = "circle" by default

# change the color of lower or upper: supply one or two colors
corrplot.mixed(myCorr, lower.col = "black")

# change upper
corrplot.mixed(myCorr,lower.col="black",upper="ellipse")


# 2) ggpairs from the library GGally
# Here, again, we specify the data (and not the correlation matrix)

# ggpairs calcualtes facets for all combinations of variables, i.e. n^2 facets for n variables
# Every facet depicts *one pair* of variables. There are three possible cases
# - continuous ... both variables are continuous (e.g. math and stat)
# - discrete ... both variables are discrete (e.g. country and gender)
# - combo ... one variable is discrete, one continuous (e.g. math and gender)

ggpairs(data = grade, columns = 1:6, aes(color=gender, alpha = 0.4))
# The default plot produces
# 1) upper triangle: continuous = cor, combo = box_no_facet, discrete = facetbar
# 2) diag: continuous = densityDiag and discrete = barDiag (obviously no combo)
# 3) lower: continuous = points, combo = facethist and discrete = facetbar

?ggpairs # see the options on how to change upper, lower and diagonal
# We can specify the diagrams we want in 
# - the upper triangle
# - the lower triangle
# - the diagonal
# This has to be specified as list

# A custom diagram
ggpairs(data = grade, 
        columns = 1:6,
        aes(color=gender, alpha = 0.4),
        upper = list(continuous = "smooth", combo = "box", discrete = "ratio"),
        diag = list(continuous = "densityDiag", discrete = "barDiag"), # not many options just desity and bar
        lower = list(continuous = "density", combo = "facethist", discrete = "facetbar"))


# Analysis of grades only/continuous data

# specify data and columns to be ploted separately, so you don't need to plot all the data:
ggpairs(data = grade, 
        columns = c("math", "stat", "econ", "art"),
        diag = list(continuous = "densityDiag"),
        lower = list(continuous = "points"),
        upper = list(continuous = "cor"))

# add a linear model:
ggpairs(data = grade, 
        columns = c("math", "stat", "econ", "art"),
        diag = list(continuous = "densityDiag"),
        lower = list(continuous = "smooth"),
        upper = list(continuous = "cor"))

# supply color aesthetic and add legend:
ggpairs(data = grade, aes(color = gender),
        columns = c("math", "stat", "econ", "art"),
        diag = list(continuous = "densityDiag"),
        lower = list(continuous = "smooth"),
        upper = list(continuous = "cor"), legend = c(1,1) )


# ** 3) Library ggcorrplot:
# Somewhat similar to corrplot(), however only lower is plotted
# default: geom = "tile", colors red&blue
# if needed:
# install.packages("ggcorrplot")
library(ggcorrplot)
ggcorr(gradeNum)

# changing color:
ggcorr(gradeNum, low = "skyblue", mid = "steelblue4", high = "navy")

# changing geom:
ggcorr(gradeNum, low = "skyblue", mid = "steelblue4", high = "navy", 
       min_size = 1, max_size = 20, geom = "circle")

# add correlation coefficients:
ggcorr(gradeNum, low = "skyblue", mid = "steelblue4", high = "navy", 
       geom = "tile", label = TRUE, label_size = 9, label_round = 2, label_color = "white")

#4) Parallel coordinate plot (separate file)
