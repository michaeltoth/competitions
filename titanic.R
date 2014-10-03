# Name: Michael Toth
# Date: 10/1/2014
# Summary: A script for analyzing the Titanic Kaggle competition data in R


# Set working directory and load train and test files
setwd("~/Documents/Projects/Kaggle/Titanic")
train <- read.csv("~/Documents/Projects/Kaggle/Titanic/train.csv")
test <- read.csv("~/Documents/Projects/Kaggle/Titanic/test.csv")

# Predict that all died
test$Survived <- rep(0,418)
submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = "theyalldie.csv", row.names = FALSE)
