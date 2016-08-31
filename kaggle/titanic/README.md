#Kaggle - Titanic Competition

This repository contains code and files used for the [Titanic competition](http://www.kaggle.com/c/titanic-gettingStarted) on Kaggle.  I will start my analysis in R by following [Trevor Stephens' walkthrough](http://trevorstephens.com/post/72916401642/titanic-getting-started-with-r) and may expand on the analysis afterward.

###Descriptions of Files

####Data Files
*train.csv*: Labeled training data  
*test.csv*: Unlabeled test data  

####Files associated with the tutorial
*titanic.R*: R code for simple predictions and exporatory analysis  
*theyalldie.csv*: Created in titanic.R.  Simple prediction that all passengers die  
*onlymendie.csv*: Created in titanic.R.  All men die and all women survive  
*femalesclassfare*: Created in titanic.R. All men die. Women in third class who paid more than $20 for a ticket also die.  
*decisiontree.R*: R code for decision tree predictions using rpart  
*firstdtree.csv*: First simple decision tree output based on variables already in file  
*engineeredtree.csv*: More sophisticated tree built with engineered features  
*firstforest.csv*: Random forest model  
*conditionalinference.csv*: Forest of conditional inference trees model  

####Further exploration on my own  
*logisticregression.R*: R code for logistic regression models  
*logisticregression.csv*: First logistic regression using only provided variables  
*logisticregressionengineered.csv*: Logistic regression with engineered features  
