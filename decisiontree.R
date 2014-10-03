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

# Let's begin feature engineering.  We'll start by combining both data sets into
# one to perform the same operations on both.  Need to fill Survived for test set
test$Survived <- NA
combi <- rbind(train, test)

# Creating titles variable.  Convert name field from factor to character for manipulations:
combi$Name <- as.character(combi$Name)

# Extracting titles from Name variable:
combi$Title <- sapply(combi$Name, FUN=function(x) 
    {strsplit(x, split='[,.]')[[1]][2]})

# Stripping spaces from beginning of title field:
combi$Title <- sub(' ', '', combi$Title)

# Combining obscure titles into groups.  May need to combine col/doctor after
combi$Title[combi$Title %in% c('Mme', 'Mrs')] <- 'Mrs'
combi$Title[combi$Title %in% c('Mlle', 'Ms', 'Miss')] <- 'Miss'
combi$Title[combi$Title %in% c('Capt', 'Don', 'Major', 'Jonkheer', 'Sir')] <- 'Sir'
combi$Title[combi$Title %in% c('Dona', 'the Countess', 'Lady')] <- 'Lady'

# Convert titles back into factors for prediction
combi$Title <- factor(combi$Title)
