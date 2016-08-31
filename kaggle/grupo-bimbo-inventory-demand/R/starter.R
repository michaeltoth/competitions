library(readr)
library(dplyr)
library(ggplot2)
library(scales)
library(treemap)

setwd('~/dev/kaggle/bimbo/R')
train <- read_csv("../input/train.csv")
test <- read_csv("../input/test.csv")
client <- read_csv("../input/cliente_tabla.csv")
products <- read_csv("../input/producto_tabla.csv")
town <- read_csv("../input/town_state.csv")
sample <- read_csv("../input/sample_submission.csv")


# Product Classification -------------------------------------------------------

library(tm)
library(SnowballC)
library(skmeans)

products <- read_csv('../input/producto_tabla.csv')

extract_shortname <- function(product_name) {
    # Split the name
    tokens <- strsplit(product_name, " ")[[1]]
    
    # Delete ID
    tokens <- head(tokens, length(tokens) - 1)
    
    # Delete Brands (name till the last token with digit)
    digit_indeces <- grep("[0-9]", tokens)
    
    # Product names without digits
    digit_index <- ifelse(length(digit_indeces) == 0, 1,
                          max(digit_indeces))
    paste(tokens[1:digit_index], collapse = " ")
}

# Delete product with no name
products <- products[2:nrow(products),]

products$product_shortname <- unlist(lapply(products$NombreProducto, extract_shortname))

# Short Names Preprocessing
CorpusShort <- Corpus(VectorSource(products$product_shortname))
CorpusShort <- tm_map(CorpusShort, tolower)
CorpusShort <- tm_map(CorpusShort, PlainTextDocument)

# Remove Punctuation
CorpusShort <- tm_map(CorpusShort, removePunctuation)

# Remove Stopwords
CorpusShort <- tm_map(CorpusShort, removeWords, stopwords("es"))

# Stemming
CorpusShort <- tm_map(CorpusShort, stemDocument, language="es")

# Create DTM
CorpusShort <- Corpus(VectorSource(CorpusShort))
dtmShort <- DocumentTermMatrix(CorpusShort)

# Delete Sparse Terms (all the words now)
sparseShort <- removeSparseTerms(dtmShort, 0.9999)
ShortWords <- as.data.frame(as.matrix(sparseShort))

# Create valid names
colnames(ShortWords) <- make.names(colnames(ShortWords))

# Spherical k-means for product clustering (30 clusters at the moment)
set.seed(123)
mod <- skmeans(as.matrix(ShortWords), 10, method = "genetic")
products$product_cluster <- mod$cluster



# Mean / Median by various dimensions ------------------------------------------
library(data.table)

# Input data files are available in the "../input/" directory.

# Read in only required columns and force to numeric to ensure that subsequent 
# aggregation when calculating medians works
train <- fread('../input/train.csv', 
               select = c('id', 'Agencia_ID', 'Cliente_ID', 'Producto_ID', 'Demanda_uni_equil'),
               colClasses=c(id="numeric", Agencia_ID="numeric", Cliente_ID="numeric",Producto_ID="numeric",Demanda_uni_equil="numeric"))

# set a table key to enable fast aggregations
setkey(train, Producto_ID, Agencia_ID, Cliente_ID)

#calculate the overall median
median <- train[, median(Demanda_uni_equil)]

#calculate the product overall mean; call it M2
mean_Prod <- train[, exp(mean(log(Demanda_uni_equil+1)))*0.57941, by = .(Producto_ID, Agencia_ID)]
setnames(mean_Prod,"V1","M2")


#calculate the agent and product  mean; call it M3
mean_Agent_Prod <- train[, exp(mean(log(Demanda_uni_equil+1)))-0.91,by = .(Producto_ID,Agencia_ID,Cliente_ID)]
setnames(mean_Agent_Prod,"V1","M3")

###################################################################################################
#  
# That's the 'modeling' done now need to apply scoring to test set
# 
###################################################################################################

# Read in Test data 
# Read in only required columns and force to numeric
test <- fread('../input/test.csv', 
             select = c('id', 'Agencia_ID', 'Cliente_ID', 'Producto_ID'),
             colClasses=c(Agencia_ID="numeric", Cliente_ID="numeric",Producto_ID="numeric"))


get_predictions <- function(data) {
    submit <- merge(data, mean_Agent_Prod, by = c("Producto_ID","Agencia_ID","Cliente_ID"), all.x = TRUE)
    
    # add column M2 that contains mean by Product
    submit <- merge(submit, mean_Prod, by = c("Producto_ID", "Agencia_ID"), all.x = TRUE)
    
    # Now create Predictions column; intially set to be M3 which contains mean by product and agent
    submit$Pred <- round(submit$M3,4)
    
    # where mean by product and agent is null use mean by product (M2)
    submit[is.na(M3)]$Pred <- round(submit[is.na(M3)]$M2)
    
    # where median by product is null use overall median
    submit[is.na(Pred)]$Pred <- median
    
    submit
}

submit <- get_predictions(test)
setnames(submit,"Pred","Demanda_uni_equil")
submit <- select(submit, id, Demanda_uni_equil)

# Write out submission file.
# Any results you write to the current directory are saved as output.
write.csv(submit, "../output/submit_med_by_Agency_Client_Product_from_script.csv", row.names = FALSE)

train_predictions <- get_predictions(train)
train_predictions <- mutate(train_predictions, inside = (log(Pred + 1) - log(Demanda_uni_equil + 1))^2)
score = sqrt((1/length(train_predictions$inside)) * sum(train_predictions$inside))

evaluate <- function(predictions, actuals) {
    # Calculate Root Mean Squared Logarithmic Error
    n = length(predictions)
    sqrt((1 / n) * sum((log(predictions + 1) - log(actuals + 1))^2))
}











# All Demand = 2 ---------------------------------------------------------------
results <- select(test, id)
results$Demanda_uni_equil <- 2
write.csv(results, "../output/all_2.csv", row.names = F)


# Linear Regression ------------------------------------------------------------
fit <- lm(Demanda_uni_equil ~ Semana + Agencia_ID + Canal_ID + Ruta_SAK + Cliente_ID + Producto_ID, data=train)
summary(fit)

results <- select(test, id)
results$Demanda_uni_equil <- round(predict(fit, test))
results[results$Demanda_uni_equil < 0, ]$Demanda_uni_equil <- 0
write.csv(results, "../output/simple_linear_regression.csv", row.names = F)


# Linear Regression with Product Classification --------------------------------
products_for_merge <- select(products, Producto_ID, product_cluster) %>% mutate(product_cluster = factor(product_cluster))
train <- left_join(train, products_for_merge)
test <- left_join(test, products_for_merge)
train$Canal_ID <- factor(train$Canal_ID)
test$Canal_ID <- factor(test$Canal_ID)
train$Semana <- factor(train$Semana)
test$Semana <- factor(test$Semana)


fit <- lm(Demanda_uni_equil ~ Semana, data=train)
fit <- lm(Demanda_uni_equil ~ Canal_ID, data=train)
fit <- lm(Demanda_uni_equil ~ product_cluster, data=train)
fit <- lm(Demanda_uni_equil ~ Canal_ID + product_cluster, data=train)
summary(fit)

results <- select(test, id)
results$Demanda_uni_equil <- round(predict(fit, test))
results[results$Demanda_uni_equil < 0, ]$Demanda_uni_equil <- 0
write.csv(results, "../output/canalid_productcluster_linear_regression.csv", row.names = F)


# Linear Regression with Product Classification & Log Dependent Variable -------
products_for_merge <- select(products, Producto_ID, product_cluster) %>% mutate(product_cluster = factor(product_cluster))
train <- left_join(train, products_for_merge)
test <- left_join(test, products_for_merge)
train$Canal_ID <- factor(train$Canal_ID)
test$Canal_ID <- factor(test$Canal_ID)
train$Semana <- factor(train$Semana)
test$Semana <- factor(test$Semana)
train$log_demanda_uni_equil = log1p(train$Demanda_uni_equil)

save.image()

fit <- lm(log_demanda_uni_equil ~ Canal_ID + product_cluster, data=train)
summary(fit)

results <- select(test, id)
results$log_demanda_uni_equil <- predict(fit, test)
results$Demanda_uni_equil = expm1(results$log_demanda_uni_equil)
results <- select(results, -log_demanda_uni_equil)
write.csv(results, "../output/linear_regression_log_demand.csv", row.names = F)

train$pred_log_demanda_uni_equil <- predict(fit, train)
train$pred_demanda_uni_equil = expm1(train$pred_log_demanda_uni_equil)
train <- mutate(train, inside = (log(pred_demanda_uni_equil + 1) - log(Demanda_uni_equil + 1))^2)
sqrt((1/length(train$inside)) * sum(train$inside))
