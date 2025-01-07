
rm(list=ls())                   # Delete all variables
Sys.setenv(LANG = "en")         # Set language to English

# --> FIRST: set the working directory! 
# Session/Set Working Directory/To Source File Location

library(ggplot2)

# === Our dataset ===
load("StudentUSI.RData")

# 1) The Boxplot
ggplot(data=grade, aes(x=1, y=math)) + geom_boxplot()
ggplot(data=grade, aes(x=1, y=math)) + geom_boxplot(width=2)+coord_fixed() 
ggplot(data=grade, aes(x=1, y=math)) + geom_boxplot(width=2) + stat_boxplot(geom ='errorbar') +
    theme(axis.title.x = element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank() ) +
    coord_fixed()
ggplot(data=grade, aes(x=math, y=1)) + geom_boxplot() + stat_boxplot(geom ='errorbar') 

ggplot(data=grade, aes(x=math, y=gender)) + geom_boxplot() + stat_boxplot(geom ='errorbar') 

ggplot(data=grade, aes(x=math, y=1)) + geom_violin()
ggplot(data=grade, aes(x=math, y=1)) + geom_violin() + geom_boxplot(width=0.1)
ggplot(data=grade, aes(x=math, y=1)) + geom_violin() + geom_boxplot(width=0.1) + 
  stat_summary(fun.y=mean, geom="point", shape=23, size=4)

ggplot(data=grade, aes(x=math, y=1)) + geom_violin() +
  stat_summary(fun.y=mean, geom="point", shape=23, size=4) +
  stat_summary(fun.y=median, geom="point", size=4, color="red")

ggplot(data=grade, aes(x=math, y=gender)) + geom_violin() +
  stat_summary(fun.y=mean, geom="point", shape=23, size=4) +
  stat_summary(fun.y=median, geom="point", size=4, color="red")

ggplot(data=grade, aes(x=gender, y=math)) + geom_violin() +
  geom_dotplot(binaxis='y', stackdir='center', dotsize=1)

ggplot(data=grade, aes(x=gender, y=math)) + geom_violin() +
  geom_jitter(position=position_jitter(0.1))


# 2) The histogram
ggplot(data=grade, aes(x=math)) + geom_histogram()
ggplot(data=grade, aes(x=math)) + geom_histogram(binwidth = 1)
ggplot(data=grade, aes(x=math)) + geom_histogram(binwidth = 1,fill="black", col="white")
ggplot(data=grade, aes(x=math)) + geom_histogram(binwidth = 1,center = 0.5,fill="black", col="white")
ggplot(data=grade, aes(x=math)) + geom_histogram(binwidth = 1,boundary = 0,fill="black", col="white")

ggplot(data=grade, aes(x=math)) + geom_freqpoly(binwidth = 1)
ggplot(data=grade, aes(x=math, color=gender)) + geom_freqpoly(binwidth = 1, center = 0) + xlim(2,10)

ggplot(data=grade, aes(x=math)) + geom_dotplot(binwidth = 0.5)

# 3) The density
ggplot(data=grade, aes(x=math, color=gender)) + geom_density()
ggplot(data=grade, aes(x=math, color=gender, fill=gender)) + geom_density(alpha=0.5)
ggplot(data=grade, aes(x=math, color=gender, fill=gender)) + geom_density(alpha=0.5, position="stack")
ggplot(data=grade, aes(x=math, color=gender, fill=gender)) + geom_density(alpha=0.5, position="fill")

x <- seq(2,10,by=0.1)
y <- dnorm(x,mean=7.5, sd=2)
lineData <- data.frame(x,y)
ggplot(data=grade, aes(x=math)) + geom_density() +
  geom_line(data=lineData, aes(x=x, y=y), color="red")

# combine histogram and density
# use "..density.." for y-values to tell the histogram not to show count
# numbers, but density values
ggplot(data=grade, aes(x=math, y=..density..)) + geom_histogram() + geom_density()


# 4) The qqplot
# compare to normal distribution with mean, std from sample
# if nothing is specified, distribution=qnorm
ggplot(data=grade, aes(sample = econ)) + 
  stat_qq() +
  stat_qq_line()

# compare to uniform distribution with mean, std from sample 
ggplot(data=grade, aes(sample = econ)) +
  stat_qq(distribution=qunif) +
  stat_qq_line(distribution=qunif)

# compare to exponential distribution with mean, std from sample 
ggplot(data=grade, aes(sample = econ)) +
  stat_qq(distribution=qexp) +
  stat_qq_line(distribution=qexp)

# compare to normal distribution with *given* mean, std 
ggplot(data=grade, aes(sample = econ)) + 
  stat_qq(distribution=qnorm, dparams=list(7.5,1)) +
  stat_qq_line(distribution=qnorm, dparams=list(7.5,1))

# compare to uniform distribution with given parameters 
ggplot(data=grade, aes(sample = econ)) +
  stat_qq(distribution=qunif, dparams=list(5,10)) +
  stat_qq_line(distribution=qunif, dparams=list(5,10))

