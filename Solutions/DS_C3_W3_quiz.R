## DS_C3_W3_quiz

## 1. The American Community Survey
# Create a logical vector that identifies the householdson greater than 10 acres 
# who sold more than $10,000 worth of agriculture products. Assign that logical vector
# to the variable agricultureLogical. Apply the which() function like this to identify 
# the rows of the data frame where the logical vector is TRUE.
DF <- read.csv("./data/AmericanCommunitySurvey.csv", header = TRUE)
names(DF)

library(dplyr)
filtDF <- filter(DF, ACR == 3 & AGS == 6)
dim(filtDF)

agricultureLogical <- DF$ACR == 3 & DF$AGS == 6
which(agricultureLogical)


## 2. Using the jpeg package read in the following picture of your instructor into R
# Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? 
# (some Linux systems may produce an answer 638 different for the 30th quantile)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", destfile = "./data/jeff.jpg")

library(jpeg)
data <- readJPEG("./data/jeff.jpg", native = TRUE) # if TRUE then the result is a native raster representation
quantile(data, c(0.3, 0.8))


## 3. Load the Gross Domestic Product data for the 190 ranked countries.
# Load the educational data from this data set.
# Match the data based on the country shortcode. How many of the IDs match? 
# Sort the data frame in descending order by GDP rank (so United States is last). 
# What is the 13th country in the resulting data frame?
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile = "./data/getdata-data-GDP.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile = "./data/getdata-data-EDSTATS_Country.csv")

dfGDP <- read.csv("./data/getdata-data-GDP.csv", header = FALSE, skip = 5, nrows = 190) # see only 190 countries rows
head(dfGDP)
dfGDP[, 1] # Column 1 contains Country Codes
dfGDP[, 5] <- as.numeric(gsub(",", "", dfGDP[, 5])) # ignore ',' in numbers and convert to numeric variables
sortedGDP <- dfGDP[order(dfGDP[, 5], decreasing = FALSE), c(1, 4, 5)]

dfBASE <- read.csv("./data/getdata-data-EDSTATS_Country.csv", header = TRUE)
dfBASE[, 1] # Country Codes

correctcodes <- intersect(dfGDP[, 1], dfBASE[, 1])
length(correctcodes) # get the count of Country Code's intersections
filteredGDP <- sortedGDP[sortedGDP[, 1] %in% correctcodes, ] # get specific rows 
filteredGDP <- mutate(filteredGDP, ranking = length(filteredGDP[,1]):1) # using input (descending GDP) Rankings!
rownames(filteredGDP) <- NULL
filteredGDP[13, ] # get the sought-for Country


## 4. What is the average GDP ranking for the "High income: OECD" 
# and "High income: nonOECD" group?
mergedDF <- merge(filteredGDP, dfBASE[, c(1,3)], by.x = 1, by.y = 1, all = FALSE) 
colnames(mergedDF) <- c("Code", "Name", "GDP", "Ranking", "Income.Group")
library(dplyr)
mergedDF <- arrange(mergedDF, desc(GDP))
mergedDF %>% group_by(Income.Group) %>% summarize(Ranking = mean(Ranking))


## 5. Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. 
# How many countries are Lower middle income but among the 38 nations with highest GDP?
quantile(mergedDF$GDP, c(0, 0.2, 0.4, 0.6, 0.8, 1))
groupsGDP <- cut(mergedDF$GDP, breaks = quantile(mergedDF$GDP, c(0, 0.2, 0.4, 0.6, 0.8, 1)))
table(groupsGDP)
table(mergedDF$Income.Group, groupsGDP)
