## DS_C3_W4_quiz

## 1. The American Community Survey.
# Download the 2006 microdata survey about housing for the state of Idaho.
# Apply strsplit() to split all the names of the data frame on the characters "wgtp". 
# What is the value of the 123 element of the resulting list?
DF <- read.csv("./data/AmericanCommunitySurvey.csv", header = TRUE)

strsplit(names(DF), "wgtp")


## 2. Load the Gross Domestic Product data for the 190 ranked countries.
# Remove the commas from the GDP numbers in millions of dollars and average them. 
# What is the average?
dfGDP <- read.csv("./data/getdata-data-GDP.csv", header = FALSE, skip = 5, nrows = 190) # see only 190 countries rows
dfGDP[, 5] <- as.numeric(gsub(",", "", dfGDP[, 5])) # ignore ',' in numbers and convert to numeric variables
mean(dfGDP[, 5])


## 3. In the data set from Question 2 what is a regular expression that would allow you 
# to count the number of countries whose name begins with "United"? 
# Assume that the variable with the country names in it is named countryNames. 
# How many countries begin with United?
dfGDP <- read.csv("./data/getdata-data-GDP.csv", header = FALSE, skip = 5, nrows = 190) # see only 190 countries rows
grep("^United", dfGDP[, 4]) # get indexes of elements begins! with United
length(grep("^United", dfGDP[, 4]))


## 4. Load the Gross Domestic Product data for the 190 ranked countries.
# Match the data based on the country shortcode.
# Of the countries for which the end of the fiscal year is available, how many end in June?
dfGDP <- read.csv("./data/getdata-data-GDP.csv", header = FALSE, skip = 5, nrows = 190) # see only 190 countries rows
dfBASE <- read.csv("./data/getdata-data-EDSTATS_Country.csv", header = TRUE)

correctcodes <- intersect(dfGDP[, 1], dfBASE[, 1])
filteredGDP <- dfGDP[dfGDP[, 1] %in% correctcodes, ] # get specific rows 
rownames(filteredGDP) <- NULL

mergedDF <- merge(filteredGDP[, c(1,4,5)], dfBASE[, c(1,10)], by.x = 1, by.y = 1, all = FALSE) # col10 of dfBASE is Special.Notes
colnames(mergedDF) <- c("Code", "Name", "GDP", "Special.Notes")

length(grep("Fiscal year end: June", mergedDF$Special.Notes))


## 5. You can use the quantmod (http://www.quantmod.com/) package to get 
# historical stock prices for publicly traded companies on the NASDAQ and NYSE. 
# Use the following code to download data on Amazon's stock price and get the times the data was sampled.
# How many values were collected in 2012? How many values were collected on Mondays in 2012?
library(quantmod)
amzn = getSymbols("AMZN", auto.assign = FALSE)
sampleDates = index(amzn)

length(grep("2012-", as.character(sampleDates)))
table(weekdays(sampleDates[grep("2012-", as.character(sampleDates))]) == "понедельник")


