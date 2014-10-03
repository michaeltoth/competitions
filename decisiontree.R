# Import rpart (Recursive Partitioning and Regression Trees)
library(rpart)

# rpart graphs alone don't look very good.  Let's add some packages.
# First install if they are not already installed on your computer:
# install.packages('rattle')
# install.packages('rpart.plot')
# install.packages('RColorBrewer')
library(rattle)
library(rpart.plot)
library(RColorBrewer)

# Set working directory and load train and test files
setwd("~/Documents/Projects/Kaggle/Titanic")
train <- read.csv("~/Documents/Projects/Kaggle/Titanic/train.csv")
test <- read.csv("~/Documents/Projects/Kaggle/Titanic/test.csv")

# Use rpart to create a decision tree based on variables in training set file
fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, 
             data=train, method="class")

# Display results of decision tree:
fancyRpartPlot(fit)

# Make a prediction from the tree results:
Prediction <- predict(fit, test, type = "class")
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "firstdtree.csv", row.names = FALSE)