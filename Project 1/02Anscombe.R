

data01<-read.csv("anscombe01.csv")
data02<-read.csv("anscombe02.csv")
data03<-read.csv("anscombe03.csv")
data04<-read.csv("anscombe04.csv")

print("Mean x and y values" )
c(mean(data01$x),mean(data02$x),mean(data03$x),mean(data04$x))
c(mean(data01$y),mean(data02$y),mean(data03$y),mean(data04$y))

print("Standard deviations of x and y" )
c(sd(data01$x),sd(data02$x),sd(data03$x),sd(data04$x))
c(sd(data01$y),sd(data02$y),sd(data03$y),sd(data04$y))

print("Correlations" )
c(cor(data01$x, data01$y),cor(data02$x, data02$y),
  cor(data03$x, data03$y),cor(data04$x, data04$y))

# Linear models
model01 <- lm(y ~ x, data=data01)
print(model01)
model02 <- lm(y ~ x, data=data02)
print(model02)
model03 <- lm(y ~ x, data=data03)
print(model03)
model04 <- lm(y ~ x, data=data04)
print(model04)

# Now add four scatter plots with regression line
library(ggplot2)
ggplot(data = data01, aes(x = x, y = y)) +
  geom_point(size=4) + geom_smooth(method = "lm", se = FALSE) +
  xlim(4,19)+ylim(3,13)
ggplot(data = data02, aes(x = x, y = y)) +
  geom_point(size=4) + geom_smooth(method = "lm", se = FALSE) +
  xlim(4,19)+ylim(3,13)
ggplot(data = data03, aes(x = x, y = y)) +
  geom_point(size=4) + geom_smooth(method = "lm", se = FALSE) +
  xlim(4,19)+ylim(3,13)
ggplot(data = data04, aes(x = x, y = y)) +
  geom_point(size=4) + geom_smooth(method = "lm", se = FALSE) +
  xlim(4,19)+ylim(3,13)

