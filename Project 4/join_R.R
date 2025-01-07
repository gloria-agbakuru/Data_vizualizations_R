
name <- c('Reuben','Deandre','Jagger','Conrad','Luna','Laura','Elias','Kaya','Curtis','Arianna')
country <- c('CH','EU','EU','EU','CH','EU','CH','EU','CH','US')
student <- data.frame(name,country)

country <- c('CH','EU','US')
fee <- c(1000,2000,4000)
pricelist <- data.frame(country,fee)

# simple inner join
merge(student,pricelist,by='country')
merge(pricelist,student,by='country')

## What if some data is missing?
# Let us add George from RU
name <- c('Reuben','Deandre','Jagger','Conrad','Luna','Laura','Elias','Kaya','Curtis','Arianna','George')
country <- c('CH','EU','EU','EU','CH','EU','CH','EU','CH','US','RU')
student <- data.frame(name,country)

# INNER JOIN (order is not relevant)
merge(student,pricelist,by='country')       # George is missing
merge(pricelist,student,by='country')       # George is missing

# LEFT OUTER JOIN (order is important)
merge(student,pricelist,by='country', all.x=T)       # George has NA

## ========== triple join
rm(list=ls())
name <- c('Reuben','Deandre','Jagger','Conrad','Luna','Laura','Elias','Kaya','Curtis','Arianna','George')
country <- c('CH','DE','FR','AT','DE','FR','FR','AT','CH','US','RU')
student <- data.frame(name,country)

country <- c('CH','DE','FR','AT','US')
region  <- c('CH','EU','EU','EU','US')
regionList <- data.frame(country,region)

country <- c('CH','EU','US')
fee <- c(1000,2000,4000)
priceList <- data.frame(country,fee)

# First merge
student02 <- merge(student, regionList, by='country',all.x=T)
student02

# careful: key is called 
#     "region" in student02
#     "country" in priceList

merge(student02,priceList, by.x="region", by.y="country", all.x=T)

## ========== Outer Join
name <- c('Reuben','Deandre','Jagger','Conrad','Elias','Kaya','Curtis','Arianna','George')
grade <- c(7,8,7,6,9,10,8,7,7)
econ <- data.frame(name,grade)

name <- c('Reuben','Conrad','Luna','Laura','Kaya','Curtis','Arianna','George')
grade <- c(7,9,10,8,7,7,8,7)
stat <- data.frame(name,grade)

# INNER JOIN
merge(econ,stat,by="name")     # common list

# LEFT OUTER JOIN
merge(econ,stat,by="name", all.x=T)     # based on econ

# RIGHT OUTER JOIN
merge(econ,stat,by="name", all.y=T)     # based on stat

# OUTER JOIN
merge(econ,stat,by="name", all=T)       # full list

