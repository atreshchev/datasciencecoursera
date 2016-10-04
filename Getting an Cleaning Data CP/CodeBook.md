## Human Activity Recognition Using Smartphones - Getting and Cleaning Data Project / Understanding of code ##

This project contains only one R code script: **run_analysis.R**


### Data ###

For running this code you should get UCI HAR Dataset:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Full description of UCI HAR Project is obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


### Variables ###

The R code describes `cleaning_data()` function which convert raw data of UCI HAR measurements to tidy data sets and save it as .csv files.
Yo should use the function with argument `data_path` addressed UCI HAR Project's data set directory which is presetted as `"data/UCI HAR Dataset/"`.

Common variables you should know:
* `raw_data`, `activity`, `subjects` - united vectors (train + test = 10299 obs.) of measurements' features, activity codes and subjects values
* `activity_labels`, `features_names` - input descriptive activity labels (6 values in matrix) and features' of measurements names (561 values in vector)
* `features` - the temporary list of features' of measurements values (10299 x 561 numeric values)
* `DF` - the common data set (data frame) of subjects (the 1st column), activity labels (the 2nd column) and values of all features of measurements (3:563 columns) 
* `mean_std_features_names` - the temporary vector of features based on the mean and standard deviation values (79 chr values)
* `mean_std_DF` - the tidy data set (data frame) of subjects (the 1st column), activity labels (the 2nd column) and values of features based on the mean and standard deviation values (3:81 columns)
* `subjects_avg_mean_std_DF` - the aggregated by subjects and activities (30 x 6 rows) tidy data set (data frame) of subjects (the 1st column), activity labels (the 2nd column) and average for each subject/activity values of features based on the mean and standard deviation values


### Transformations ###

Common transformations you should know: <br />
1. Reading and getting united rows of input data (train & test measurements' raw data, activity codes, subjects) <br />
2. Reading activity labels & features of measurements' names <br />
3. Parsing raw data (chr strings) of measurements' by each feature and save as common numeric values data set <br />
4. Extracting only the measurements on the mean and standard deviation of the data set <br />
5. Extracting the data set with the average of each variable for each activity and each subject <br />
6. Writing output tidy data sets' .txt files

