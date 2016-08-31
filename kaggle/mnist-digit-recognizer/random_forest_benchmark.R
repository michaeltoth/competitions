# Creates a simple random forest benchmark

library(randomForest)
library(readr)
setwd('~/Github/kaggle-digitrecognizer/')

set.seed(0)

raw_train <- read_csv("input/train.csv")
test <- read_csv("input/test.csv")

rows <- sample(1:nrow(raw_train), numTrain) # Randomly sample numTrain rows of the training set to subset below

train <- raw_train[rows, ] # Subset training set based on row sample
train_labels <- as.factor(raw_train[rows, ]$label) # List of labels for training set stored as factor

cv <- raw_train[-rows, ] # Subset cross-validation set as the remaining raw_train - numTrain rows
cv_labels <- as.factor(raw_train[-rows, ]$label) # List of labels for cross-validation set stored as factor

get_score <- function(predictions, labels) {
  output <- data.frame(predicted=predictions, actual=labels)
  output$match = ifelse(output$predicted == output$actual, 1, 0)
  pct_correct = sum(output$match) / dim(output)[1]
  pct_correct
}

# Set Random Forest Parameters
numTrain <- 30000
numTrees <- 25

# Fit Random Forest Model
modelFit <- randomForest(as.factor(label) ~ ., data = train, ntree = numTrees)
train_prediction <- predict(modelFit, train)
cv_prediction <- predict(modelFit, cv)
test_prediction <- predict(modelFit, test)

# Get accuracy scores for train and cross validation data sets
get_score(train_prediction, train_labels)
get_score(cv_prediction, cv_labels)

result <- data.frame(ImageId=1:nrow(test), Label=test_prediction)
write_csv(result, "output/rf_large_train.csv") 

numTreesList <- c(10, 20, 30, 40, 50, 75, 100)

scores <- data.frame(trees=integer(), score=numeric())

for(n_trees in numTreesList) {
  print(paste("Running Random Forest with", n_trees, "trees"))
  modelFit <- randomForest(as.factor(label) ~ ., data = train, ntree = n_trees)
  cv_prediction <- predict(modelFit, cv)
  my_score <- get_score(cv_prediction, cv_labels)
  scores <- rbind(scores, data.frame(n_trees, my_score))
  print(paste(n_trees, "gives a cross-validation accuracy of", my_score))
}

modelFit <- randomForest(as.factor(label) ~ ., data = train, ntree = 100)
test_prediction <- predict(modelFit, test)

result <- data.frame(ImageId=1:nrow(test), Label=test_prediction)
write.csv(result, "output/rf_large_train_100_trees.csv", row.names = F)
