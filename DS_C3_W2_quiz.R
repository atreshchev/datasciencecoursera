### DS_C3_W2 quiz

### 1. Working with GitHub API
library(httr)
# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("repoGrubber",
                   key = "1fd7424c25425ccdc984", # Client ID
                   secret = "b05f0ca9ff403f0609a30f89ee24061ab8077822")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
# url <- "https://api.github.com/rate_limit"
url <- "https://api.github.com/users/jtleek/repos"
data <- GET(url, gtoken)
stop_for_status(data)
content(data)

library(jsonlite)
jsonData <- fromJSON(toJSON(content(data))) # get data frame from json
sort(names(jsonData))
jsonData[, c("full_name", "created_at")]


### 2. Practice SQL queries in R
library(sqldf)
library(tcltk)
DF <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", header = TRUE) # default separator = comma: ","
acs <- DF # data frame name as required in assignment
sqldf("select pwgtp1 from acs where AGEP < 50") # allow to use SQL queries for data frames

unique(acs$AGEP)
sqldf("select distinct AGEP from acs") # get the same result


### 3. Get the quantity of characters in HTML strings
url <- "http://biostat.jhsph.edu/~jleek/contact.html"
con <- url(url, "r")
htmlCode <- readLines(con)
close(con)
nchar(htmlCode[10]) # get the number of characters in 10th string
nchar(htmlCode[20])
nchar(htmlCode[30])
nchar(htmlCode[100])


### 4. Parse data set (table) from txt
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
DF <- read.table(textConnection(gsub("-", "\t", readLines(url))), header = TRUE, skip = 2) # default separator = space
sum(DF[,4])