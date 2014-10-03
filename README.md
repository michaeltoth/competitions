##Kaggle - Titanic Competition

This repository contains code and files used for the [Titanic competition](http://www.kaggle.com/c/titanic-gettingStarted) on Kaggle.  I will start my analysis in R by following [Trevor Stephens' walkthrough](http://trevorstephens.com/post/72916401642/titanic-getting-started-with-r) and may expand on the analysis afterward.

####Descriptions of Files
*train.csv*: Labeled training data  
*test.csv*: Unlabeled test data  

*titanic.R*: R code for simple predictions and exporatory analysis  
*theyalldie.csv*: Created in titanic.R.  Simple prediction that all passengers die  
*onlymendie.csv*: Created in titanic.R.  Slightly more advanced prediction that all men die and all women survive  
*femalesclassfare*: Created in titanic.R.  Prediction that all men die, and women in third class who paid more than $20 for a ticket also die.  This results in a slight accuracy increase  

*decisiontree.R*: R code for decision tree predictions using rpart  
*firstdtree.csv*: First simple decision tree output based on variables already in file  
