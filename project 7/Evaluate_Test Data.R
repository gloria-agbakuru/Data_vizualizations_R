#Evaluate on Test Data
# Load necessary libraries
library(caret)
library(pROC)
library("car")

# The model
logistic_model <- glm( ~ , 
                      data = training_set, 
                      family = binomial)
summary(logistic_model)

# compute Odds Ratio (OR) Coefficients
exp(cbind(OR = coef(logistic_model), confint(logistic_model)))
# Compute the Variance Inflation Factor (VIF)

vif<-vif()
print(vif)
# Predict on the test set
predicted_probabilities <- predict(logistic_model, newdata = test_set, type = "response")
predicted_classes <- ifelse(predicted_probabilities > 0.5, 1, 0)

# Create a confusion matrix
confusion <- confusionMatrix(factor(predicted_classes), factor(test_set$Purchased))

# Print confusion matrix and evaluation metrics
print(confusion)
# Compute the ROC curve
roc_curve <- roc(test_set$Purchased, predicted_probabilities)

# Plot the ROC curve
plot(roc_curve, col = "blue", lwd = 2, main = "ROC Curve")
abline(a = 0, b = 1, lty = 2, col = "red") # Reference line

# Compute the AUC (Area Under the Curve)
auc_value <- auc(roc_curve)
cat("AUC:", auc_value, "\n")

# create a given values table
df.new <- data.frame(
  Gender = c("Female", "Male", "Female", "Male"),
  Age = c(19, 25, 30, 40),
  EstimatedSalary = c(20000, 40000, 40000, 75000)
)

# Predict probability of purchasing for all rows
predictions <- predict(logistic_model, newdata = df.new, type = "response")
predictions

