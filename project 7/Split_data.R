# Load necessary library
library(caTools)
library(dplyr)
Social_Network_Ads<- Social_Network_Ads%>%
  mutate(Gender = as.factor(Gender),
         Purchased = as.factor(Purchased)) %>%
  # remove User ID
  select(-'User ID')


# Set a random seed for reproducibility
set.seed(123)

# Split the dataset into training and test sets (80% train, 20% test)
split <- sample.split(Social_Network_Ads$Purchased, SplitRatio = 0.8)

# Create the training set
training_set <- subset(Social_Network_Ads, split == TRUE)

# Create the test set
test_set <- subset(Social_Network_Ads, split == FALSE)
# define 1 as fist level
test_set$Purchased <- relevel(test_set$Purchased, ref = "1")

# Check the dimensions of the datasets
cat("Training Set Size:", nrow(training_set), "\n")
cat("Test Set Size:", nrow(test_set), "\n")
