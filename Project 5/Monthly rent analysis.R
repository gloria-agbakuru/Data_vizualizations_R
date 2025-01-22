# Load the car package
#library("tidyverse")
library("moderndive")
library("car")
library(lmtest)
library(openxlsx)


# Scatterplots for different variables against Monthly_Rent
scatterplot(Monthly_Rent~Area_SqFt, regLine=FALSE, smooth=FALSE, 
            boxplots=FALSE, data=housing_data)
scatterplot(Monthly_Rent~Distance_CityCenter, regLine=FALSE, smooth=FALSE, 
            boxplots=FALSE, data=housing_data)
scatterplot(Monthly_Rent~Num_Bedrooms, regLine=FALSE, smooth=FALSE, 
            boxplots=FALSE, data=housing_data)
scatterplot(Monthly_Rent~Amenities_Score, regLine=FALSE, smooth=FALSE, 
            boxplots=FALSE, data=housing_data)
scatterplot(Monthly_Rent~Age_Building, regLine=FALSE, smooth=FALSE, 
            boxplots=FALSE, data=housing_data)

# Correlation Matrices
Cormat<-cor(housing_data[,c("Age_Building","Amenities_Score","Area_SqFt",
                            "Distance_CityCenter","Monthly_Rent","Num_Bedrooms")], use="complete")
Cormat<-data.frame(Cormat)

# Fit the linear model
model1 <- lm(Monthly_Rent ~ ., data = housing_data)
model2 <- lm()

# Display the model summary
summary(model1)
summary(model2)
# Compute the Variance Inflation Factor (VIF)
vif_values<-vif(model2)
# Convert the VIF values to a data frame
vif_table<- data.frame(x = names(vif_values), VIF = vif_values)
# Export the VIF data frame to an Excel file
write.xlsx(vif_table, "vif_table.xlsx")
#Durbin-Watson test
dwtest(model2, alternative="two.sided", data=housing_data)
#Breusch-Pagan test
bptest(model2, varformula = ~ fitted.values(model2), studentize=FALSE, data=housing_data)

# Normality test
shapiro.test(residuals(model2))
# create a set to x specific values
new_data <- data.frame(Area_SqFt=1000, Distance_CityCenter=5,
                       Num_Bedrooms=4,Age_Building=5,
                       Amenities_Score=3)
#plot all assumptions
oldpar <- par(oma=c(0,0,3,0), mfrow=c(2,2))

plot(model2)

par(oldpar)

# Prediction 
PreValue<- predict(model2, newdata = new_data)
# Prediction interval
PreInterval<- predict(model2, newdata = new_data,interval = "prediction")
print(PreInterval)

#verification using the given values 

# Prediction interval for verification


