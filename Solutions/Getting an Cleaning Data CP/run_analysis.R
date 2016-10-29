## Assignment DS_C3_W4:
## Getting and Cleaning Data Course Project
## Human Activity Recognition Using Smartphones

data_path <- "data/UCI HAR Dataset/"

cleaning_data <- function(data_path) {
## 1. Read and get united rows of input data (train & test measurements' raw data, activity codes, subjetcs)
  raw_data <- unlist(lapply(c(paste0(data_path, "train/X_train.txt"),
                              paste0(data_path, "test/X_test.txt")), readLines))
  activity <- unlist(lapply(c(paste0(data_path, "train/y_train.txt"),
                              paste0(data_path, "test/y_test.txt")), readLines))
  subjects <- unlist(lapply(c(paste0(data_path, "train/subject_train.txt"),
                              paste0(data_path, "test/subject_test.txt")), readLines))

## 2. Read activity labels & features of measurements' names
  activity_labels <- read.csv("data/UCI HAR Dataset/activity_labels.txt", sep = " ", header = FALSE)
  features_names <- read.csv("data/UCI HAR Dataset/features.txt", sep = " ", header = FALSE)

## 3. Parse raw data (chr strings) of measurements' by each feature and save as common numeric values data set
  # Delete first spaces of strings and split by another spaces, convert chr vectors to numeric
  features <- lapply(sapply(raw_data, function(x) strsplit(sub("^( )+", "", x), "( )+"), USE.NAMES = FALSE), as.numeric)
  # Fill numeric data set of features' measures
  DF <- as.data.frame(do.call("rbind", features))
  colnames(DF) <- features_names[, 2] # apply real features' names
  # Attach subjects & activity labels information
  DF <- cbind(Subject = as.numeric(subjects), Activity = sapply(as.numeric(activity), function(x) {activity_labels[x, 2]}), DF)

## 4. Extract only the measurements on the mean and standard deviation of the data set
  mean_std_features_names <- colnames(DF)[grep("mean|std", colnames(DF))]
  mean_std_DF <- DF[, c("Subject", "Activity", mean_std_features_names)]

## 5. Extract the data set with the average of each variable for each activity and each subject
  library(dplyr)
  subjects_avg_mean_std_DF <- summarize_each(group_by(mean_std_DF, Subject, Activity), funs(mean))
  colnames(subjects_avg_mean_std_DF) <- c("Subject", "Activity", mean_std_features_names)
  
## 6. Write output tidy data sets' files
  write.table(mean_std_DF, "mean_std_DF.txt", row.name=FALSE)
  write.table(subjects_avg_mean_std_DF, "subjects_avg_mean_std_DF.txt", row.name=FALSE) 
  list(DF, mean_std_DF, subjects_avg_mean_std_DF)
}
