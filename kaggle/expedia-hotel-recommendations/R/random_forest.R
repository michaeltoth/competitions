## R version of most popular local hotels
library(readr)
library(randomForest)

expedia_train <- read_csv('~/dev/kaggle/expedia/input/train.csv')
expedia_test <- read_csv('~/dev/kaggle/expedia/input/test.csv')

str(expedia_train)

fit <- randomForest(as.factor(hotel_cluster) ~ site_name + posa_continent + user_location_country + user_location_region + user_location_city + is_mobile + is_package + channel + srch_adults_cnt + srch_children_cnt + srch_rm_cnt + srch_destination_id +
                    srch_destination_type_id + is_booking + cnt + hotel_continent + hotel_country + hotel_market, data=expedia_train, importance=TRUE, ntree=100)

Prediction <- predict(fit, test)
submit <- data.frame(id = test$id, hotel_cluster = Prediction)





dest_id_hotel_cluster_count <- expedia_train %>% 
    group_by(srch_destination_id, hotel_cluster) %>%
    summarize(count = n()) %>%
    data.table

overall_rank <- expedia_train %>% group_by(hotel_cluster) %>% summarize(count = n()) %>% arrange(desc(count)) %>% select(hotel_cluster)

get_top_five <- function(cluster, count) {
    hotel_cluster_sorted <- cluster[order(count, decreasing=TRUE)]                  # First order by top local hotel clusters
    hotel_cluster_sorted <- c(hotel_cluster_sorted, overall_rank$hotel_cluster)     # Append top global hotel clusters to address cases where local clusters have fewer than 5 values
    paste(hotel_cluster_sorted[1:5], collapse=" ")                                  # Get top 5 values (first local then global if local < 5)
}

dest_top_five <- dest_id_hotel_cluster_count[,get_top_five(hotel_cluster,count),by=srch_destination_id]

out <- merge(expedia_test, dest_top_five, by="srch_destination_id", all.x=TRUE)
out <- select(out, id, V1)

setnames(out, c("id", "hotel_cluster"))

write.csv(out, file='~/dev/kaggle/expedia/output/submission_2.csv', row.names=FALSE)