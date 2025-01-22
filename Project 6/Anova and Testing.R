summary(employee_data)
boxplot(Productivity ~ Department, data = employee_data, main = "Productivity by Department")
#Calculate mean and standard deviation for each group

Av_Dep <- numSummary(employee_data[, "Productivity", drop = FALSE], 
                     groups = employee_data$Department, 
                     statistics = c("mean", "sd"))
print(Av_Dep)




# normality test
shapiro.test(employee_data$Productivity)

#Perform ANOVA
Model1 <- aov( ~ , data = employee_data)
summary(Model1)


#To identify which groups are different
TukeyHSD(result)
library(multcomp)

# Convert Department to a factor
employee_data$Department <- as.factor(employee_data$Department)
employee_data$Gender <- as.factor(employee_data$Gender)
employee_data$JobLevel <- as.factor(employee_data$JobLevel)
result <- aov(Productivity ~ Department, data = employee_data)

posthoc <- glht(result, linfct = mcp(Department = "Tukey"))
summary(posthoc)

#Durbin-Watson test
dwtest((Model1, alternative="two.sided", data=employee_data)
#Breusch-Pagan test
bptest(model2, varformula = ~ fitted.values(model2), studentize=FALSE, data=housing_data)

