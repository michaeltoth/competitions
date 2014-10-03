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

# Family size variable as sum of siblings, spouses, children, parents, self
combi$FamilySize <- combi$SibSp + combi$Parch + 1

# Surnames created with regular expressions and strsplit function
combi$Surname <- sapply(combi$Name, FUN=function(x) 
    {strsplit(x, split='[,.]')[[1]][1]})

# Attempting to uniquely identify families by family size and surname
combi$FamilyID <- paste(as.character(combi$FamilySize), combi$Surname, sep="")

# Consolidating small families (hypothesis is larger families may have trouble)
combi$FamilyID[combi$FamilySize <= 2] <- 'Small'

# Cleaning up family groups (some small families slipped in).  Convert to factor
famIDs <- data.frame(table(combi$FamilyID))
famIDs <- famIDs[famIDs$Freq <= 2,]
combi$FamilyID[combi$FamilyID %in% famIDs$Var1] <- 'Small'
combi$FamilyID <- factor(combi$FamilyID)

# Side note: Behind the scenes, factors are basically stored as integers, but 
# masked with their text names for us to look at. If you create the above factors 
# on the isolated test and train sets separately, there is no guarantee that both 
# groups exist in both sets.
# 
# For instance, the family ‘3Johnson’ previously discussed does not exist in the 
# test set. We know that all three of them survive from the training set data. If 
# we had built our factors in isolation, there would be no factor ‘3Johnson’ for 
# the test set. This would upset any machine learning model because the factors 
# between the training set used to build the model and the test set it is asked 
# to predict for are not consistent. ie. R will throw errors at you if you try.
# 
# Because we built the factors on a single dataframe, and then split it apart 
# after we built them, R will give all factor levels to both new dataframes, even 
# if the factor doesn’t exist in one. It will still have the factor level, but no 
# actual observations of it in the set.


# Split train and test back apart now:
train <- combi[1:891,]
test <- combi[892:1309,]

# New decision tree based on feature engineered variables:
fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + 
                 Title + FamilySize + FamilyID, data=train, method="class")

# Plot fit and create new submission
fancyRpartPlot(fit)
Prediction <- predict(fit, test, type = "class")
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "engineeredtree.csv", row.names = FALSE)
