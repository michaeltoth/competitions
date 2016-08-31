# Name: Michael Toth
# Date: 10/1/2014
# Summary: A script for analyzing the Titanic Kaggle competition data in R


# Set working directory and load train and test files
setwd("~/Documents/Projects/Kaggle/Titanic")
train <- read.csv("~/Documents/Projects/Kaggle/Titanic/train.csv")
test <- read.csv("~/Documents/Projects/Kaggle/Titanic/test.csv")

# Simple beginning.  Predict that all passengers died
test$Survived <- rep(0,418)
submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = "theyalldie.csv", row.names = FALSE)

# Next step.  Predict all women survived and all men died
test$Survived <- 0
test$Survived[test$Sex == 'female'] <- 1
submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = "onlymendie.csv", row.names = FALSE)

# Create categorical child variable to indicate passengers below 18
train$Child <- 0
train$Child[train$Age < 18] <- 1

# Create a table of proportions who survived based on sex and child status
aggregate(Survived ~ Child + Sex, data=train, FUN=function(x) {sum(x)/length(x)})
# Still we predict all men die and all women survive, regardless of age

# Next let's create bins for fare values:
train$Fare2 <- '30+'
train$Fare2[train$Fare < 30 & train$Fare >= 20] <- '20-30'
train$Fare2[train$Fare < 20 & train$Fare >= 10] <- '10-20'
train$Fare2[train$Fare < 10] <- '<10'

# Create another table based on sex, child status, and fare bucket
aggregate(Survived ~ Fare2 + Pclass + Sex, data=train, 
          FUN=function(x) {sum(x)/length(x)})
# This predicts women in 3rd class who pay 20-30 or 30+ dollars are more likely 
# to die.  This may not make sense, but we can try it out

# Predict all men die, and females in 3rd class with tickets more than $20 die
test$Survived <- 0
test$Survived[test$Sex == 'female'] <- 1
test$Survived[test$Sex == 'female' & test$Pclass == 3 & test$Fare >= 20] <- 0
submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = "femalesclassfare.csv", row.names = FALSE)
