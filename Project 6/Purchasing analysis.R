# Exploratory Data Analysis
# 1)Summary Statistics:


#Proportion of Purchased (Target Variable)
table(Social_Network_Ads$Purchased)
prop.table(table(Social_Network_Ads$Purchased)) 

#Distribution of Numerical v.a
hist(Social_Network_Ads$Age, main = "Distribution of Age", col = "skyblue")
hist(Social_Network_Ads$EstimatedSalary, main = "Distribution of Salary", col = "lightgreen")

#Relationship Between Features and Target
# Boxplot for Salary by Purchase Status
boxplot(EstimatedSalary ~ Purchased, data = Social_Network_Ads, 
        main = "Salary vs Purchase", col = c("red", "green"))

# Age distribution by Purchase Status
boxplot(Age ~ Purchased, data = Social_Network_Ads, 
        main = "Age vs Purchase", col = c("orange", "purple"))
#Correlation Between Numericalv.a
cor_values<- cor(Social_Network_Ads[, c("Age", "EstimatedSalary","Purchased")],use="complete") 
# Convert the cor_values to a data frame
cor_table<- data.frame(cor_values)
# Export the cor_valuesdata frame to an Excel file
library(openxlsx)
write.xlsx(cor_table, "cor_table.xlsx")

