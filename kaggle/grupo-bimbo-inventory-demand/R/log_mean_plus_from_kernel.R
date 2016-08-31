library(data.table)

train <- fread('../input/train.csv', 
               select = c('Canal_ID', 'Cliente_ID', 'Producto_ID', 'Agencia_ID', 'Ruta_SAK', 'Demanda_uni_equil'))

test <- fread('../input/test.csv', 
              select = c('id', 'Canal_ID', 'Cliente_ID', 'Producto_ID', 'Agencia_ID', 'Ruta_SAK'))

#transform target variable to log(1 + demand) - this makes sense since we're 
#trying to minimize rmsle and the mean minimizes rmse:
train$log_demand = log1p(train$Demanda_uni_equil) 
mean_total <- mean(train$log_demand) # overall mean

mean_C <-  train[, .(MC = mean(log_demand)), by = .(Canal_ID)]
mean_P <-  train[, .(MP = mean(log_demand)), by = .(Producto_ID)]
mean_PR <- train[, .(MPR = mean(log_demand)), by = .(Producto_ID, Ruta_SAK)]
mean_PCA <- train[, .(MPCA = mean(log_demand)), by = .(Producto_ID, Cliente_ID, Agencia_ID)]

predict <- function(data) {

    # Merge means from above with dataset
    data <- merge(data, mean_PCA, all.x = TRUE, by = c("Producto_ID", "Cliente_ID", "Agencia_ID"))
    data <- merge(data, mean_PR, all.x = TRUE, by = c("Producto_ID", "Ruta_SAK"))
    data <- merge(data, mean_P, all.x = TRUE, by = "Producto_ID")
    
    # Now create Predictions column;
    data$Pred <- expm1(data$MPCA)*0.81975+0.4625
    data[is.na(Pred)]$Pred <- expm1(data[is.na(Pred)]$MPR)*0.7647+0.155
    data[is.na(Pred)]$Pred <- expm1(data[is.na(Pred)]$MP)*0.761+1.58
    data[is.na(Pred)]$Pred <- expm1(mean_total) + 1.083
    
    return(data)
    
}

train_pred <- predict(train)
rmsle(train_pred$Demanda_uni_equil, train_pred$Pred)

# Merge means with test set
submit <- predict(test)

# now relabel columns ready for creating submission
setnames(submit,"Pred","Demanda_uni_equil")
# Any results you write to the current directory are saved as output.
write.csv(submit[,.(id,Demanda_uni_equil)],"../output/submit_mean_by_Agency_Ruta_Client_new_params.csv", row.names = FALSE)
