## Human Activity Recognition Using Smartphones - Getting and Cleaning Data Project <br />/ How it works & how to reproduce ##

This project contains only one R code script: **run_analysis.R**


### Including & Running Code ###

You can include R code on your machine as follows:

```{r code, echo=FALSE}
source("https://github.com/atreshchev/datasciencecoursera/blob/master/Getting%20an%20Cleaning%20Data%20CP/run_analysis.R")
```

For starting analysis just call the function `cleaning_data(data_path)` described in R code.

**Note** that the argument 'data_path' addressed UCI HAR Project's input data set directory is presetted as `"data/UCI HAR Dataset/"`.
You should change it before starting `cleaning_data(data_path)` in case of difference.


### Viewing results ###

The result of the function is a list that contains:
* `DF` - common data set (all measurements' features included) referred to subjects and activities
* `mean_std_DF` - tidy data set (only mean & std measurements' features included)
* `subjects_avg_mean_std_DF` - aggregated by subjects and activities tidy data set
and also 2 files **mean_std_DF.csv** & **subjects_avg_mean_std_DF.csv** containing `mean_std_DF` & `subjects_avg_mean_std_DF` data sets.

You can use results as usual working with any list objects and .csv files.

> Good luck! <br />
> **AT**
