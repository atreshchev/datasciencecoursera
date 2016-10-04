## R commands here.
## to submit changes via Rstudio use -> Commit -> Push

getwd() # my directory
dir()   # files in directory
ls()    # environment (objects)
list.files("./datadir")
rm(list = ls()) # clean environment

setwd("/Users/aleksandr/Documents/R") # full path in Mac OS X
setwd("C\\Users\\aleksandr\\Documents/R") # full path in Windows
setwd("../") # relative path: go 1 level up
setwd("./datadir") # relative path: go to datadir

?anyfunc # HELP
??anyfunc # deep searching
anyfunc # show fixed arguments and ... arguments (and environment of func)
args(anyfunc) # show function's arguments
str(anyfunc) # show function's arguments too
search() # show loaded packages (environments)

object.size(x) # get data object size in bytes
print(object.size(x), units = "Mb") # size in Mb

library(pack) # load package
detach("package:pack") # unload package

## Files
file.create("filename")
file.exists("filename")
file.info("mytest.R")$mode
file.rename("mytest.R", "mytest2.R")
file.path("myfolder","mytest3.R") # platform-independent relative pathname 

dir.create("testdir")
dir.create(file.path('testdir2', 'testdir3'), recursive = TRUE)

if (!file.exists("datadir")) {
  dir.create("datadir")
}

unlink("testdir", recursive = TRUE) # recursive folders deleting


## Basic
sqrt()
abs()
max()
mean()

# cos()  sin()  exp()
# log() log2()  log10()

ceiling(3.475) # round to 4
floor(3.475) # round to 3
round(3.475, digits = 2) # round to 3.48 (digits after '.')
signif(13.475, digits = 4) # round to 13.48 (significant digits in number)

all(x > 0) # check condition for each element and get TRUE/FALSE
colSums(x < 0) # get result for each column
all(colSums(x < 0))

quantile(x, na.rm = TRUE) # 'карта вероятностей' 0, 25, 50, 75, 100% (по количеству упорядоченных наблюдений -- e.g. 50% of our selection < some value!)
quantile(x, probs = c(0.5, 0.7, 0.9)) # fixed probabilities

table(x) # get counts of each value in vector
table(DF[, 3]) # for 3rd column of DF
table(x, useNA = "ifany") # useNA = ifany checks missing of values in logical order of values

logicalvect <- DF$col1 == 3 & DF$col2 > 6 # get matches/mismatches TRUE/FALSE vector
table(DF$col %in% c("aaa", "bbb")) # get count of matches/mismatches (TRUE: n, FALSE: n - table)

table(DF$restname, DF$zipcode) # 2dim table of counts of intersections (different var1 for fixed var2)
xt <- xtabs(Freq ~ Male + Admit, data = DF) # get counts (variable?) for different combinations of values of Male & Admit variables of DF

xt <- (breaks ~ ., data = DF) # get counts by combinations of different values all ('.') variables (> 2dim)
ftable(xt) # print flat table (as 2dim view)

x <- 5 # numeric
x <- 5L # integer
c(1, 2) # numeric
c(4, TRUE) #numeric
x <- 1:6 # integer
class(x)
str(x) # more detailed var info

x <- c(1, 9, 4, 8, 2, 3, 6, 0, 7, 5)
sort(x) # get values in right order
order(x) # get vector of true indexes! of sorted elements
order(x, decreasing = TRUE)
sort(x, na.last = TRUE) # set NA at the end of vector

x[order(x[, 2], decreasing = TRUE), ] # order by values of 2nd column
x[, order(x[2, ], decreasing = TRUE)] # order by values of 2nd row!

sortedDF <- DF[order(DF[, orderedcol]), ] # order data frame by orderedcol values
sortedDF <- DF[order(DF$col1), ]
sortedDF <- DF[order(DF$col1, DF$col2), ] # order by multiple! variables
sortedDF <- DF[do.call("order", DF[c(col1, col2)]), ] # the same

library(plyr) # can be used 'dplyr' package because of more fast functions -- BUT 'dplyr' delete rownames (shold be added previously as special column!)
arrange(DF, col1) # the same as order for data frames! -- 'dplyr' delete rownames!!!
arrange(DF, desc(col1)) # order by decreasing values
arrange(DF, col1, col2) # multiple order

x <- c(TRUE, FALSE, TRUE, FALSE, FALSE, FALSE, TRUE)
which(x) # get TRUE elements' indexes!

x <- c(1, 2, 2, 3, 3, 3, 3, 4, 5)
unique(x) # get only unique values

x <- c(1, 2, 2, 3, 3, 3, 3, 4, 5)
y <- c(4, 5, 6, 7, 8, 8, 9, 9, 0)
intersect(x, y)

x <- rep(1, 10) # get vector with 1 repeated 10 times

x <- vector("numeric", length = 10)
x <- c("a", "b", "c") # T, F == TRUE=1, FALSE=0; 5+4i == complex number...
x <- c(x, "d") # vector addition
x <- 1:10
x <- print(x)

summary(x) # get simple statistics of vector values  - min, 1st qu., median, mean, 3rd qu., max

x <- seq(1.7, 1.9, length = 100) # get 100 values in interval (min = 1.7, max = 1.9)
x <- seq(1, 10, by = 2) # get seq by step = 2 (while less than max)
y <- c("a", "b", "e", "d", "f")
x <- seq(along = y) # get vector of indexes for elements of y

y <- (1:10)
x <- ifelse(y < 5, TRUE, FALSE) # get vector of epression's results (user specified)
table(DF$zipWrong, DF$zipCode < 0) # get count of values for variables' combinations (with given condition for one variable)

library(Hmisc)
zipGroups <- cut2(DF$zipCode, g = 4) # some different wat -- get factor variable with values which represent 4 intervals [ , ), [ , ]
table(zipGroups) 

x <- gl(3, 10) # get vector of factor levels - 3 levels each with 10 replications (ordered)
x <- gl(3, 1, 3*10, labels = c("M", "F", "NA")) # 3 levels with 1 replication repeating each for 10 times (cycled)

x <- sapply(list(a = 1:10, b = 55:88, c = 99:20), mean)
str(x)
attributes(x) # get names of nums

as.integer(x)
as.logical(x)
as.character(x)

as.numeric(gsub(",", "", numvect)) # ignore ',' in numbers and convert to numeric variables


## Matrices
x <- list(1, "a", TRUE, 1+4i) # every element in list is a vector!
unlist(x) # convert list to the vector of uniform ('однородные') values

m <- matrix(nrow = 2, ncol = 3)
dim(m) # dimensions (size) of matrix
m <- matrix(1:6, nrow = 2, ncol = 3)

m <- 1:10
dim(m) <- c(2, 5)

x <- 1:3
y <- 4:6
m <- cbind(x, y)
m <- rbind(x, y)


## Randomization
x <- rnorm(100) # generate random vector of 100 values of Normal distribution
x <- rnorm(100, 1, 2) # mean = 1, standard deviation = 2 (default m = 0, sd = 1)

dnorm() # evaluate the Normal probobility density ('плотность распр.') (with m, sd) at a point/vector of points
pnorm() # evaluate probabilities of values - cumulative distribution function ('функция распр.') for Normal distribution
qnorm() # evaluate quantiles -- pnorm(q) = f(q) <-> qnorm(p) = f^-1(p)

x <- runif(100) # get vector of 100 elements in the range [0;1] as normal distribution
x <- runif(100, min = 0, max = 10) # the range [0;10]

rpois(100, 1) # generate 100 random Poisson variables with a given rate = 1 ('коэффициент' = m)
ppois(2, 3) # get the probability of variable < 2 if rate = 3

rbinom(100, 1, 0.5) # generate 100 random Binomial variables (binary values!)
rexp() # Exponential distribution
rgamma() # Gamma distribution

vect <- c(1000:1)
set.seed(42) # set some seed for reproduce the same pseudo random values
use <- sample(1000, 10) # get 10 random values of 1000
print(vect[use])

sample(letters, 5) # get 5 random symbols from letters array
sample(1:10) # permutation ('перестановка - без повторений')
sample(letters)
sample(1:10, replace = TRUE) # replacement ('размещение - с повторениями')
sample(letters, replace = TRUE)
sample(c("yes", "no"), 10, replace = TRUE)

# simple linear model
set.seed(20)
x <- rnorm(100)
e <- rnorm(100, 0, 2) # some noise - Epsilon
b0 <- 0.5
b1 <- 2
y <- b0 + b1 * x + e # linear model
summary(y) # simple statistics
plot(x, y)

# simple linear model based on Binomial
set.seed(20)
x <- rbinom(100, 1, 0.5)
e <- rnorm(100, 0, 2) # some noise - Epsilon
y <- 0.5 + 2 * x + e # linear model

# complicated model combinated linear and Poisson
set.seed(20)
x <- rnorm(100)
log.mu <- 0.5 + 0.3 * x
y <- rpois(100, exp(log.mu))


## Factors
x <- factor(c("yes", "yes", "no", "yes", "no"))
x <- factor(c("yes", "yes", "no", "yes", "no"), levels = c("yes", "no")) 

x <- relevel(x, ref = "no") # get factor with reordered levels

table(x)
unclass(x)
as.numeric(x) # get factor variable as 1,2,... (numeric) values' vector

attributes(x) # get all attributes
attr(x,"levels") # get specfic attributes values

x <- 1:10
attr(x,"dim") <- c(2, 5) # set! specfic attributes with name "dim"


## Testing to missing values (NA includes NaN!)
x <- c(1, 2, NA, NaN, 5, 6)
is.na(x)
is.nan(x) # NA includes NaN! but not vice verse


## Data Frames (matrices with row and column names & different types of values in each column/row)
DF <- data.frame(a = 1:4, b = c(T, F, T, F), c = 5:8, d = 4:1)
dim(DF)
nrow(DF)
ncol(DF)
rownames(DF) <- rownames(someDF) # copy rownames to DF
colnames(DF)

DF$a # get elements of one column
DF[, c(1,3:4)] # get elements of columns with specific numbers
DF[, c("a", "c")] # get elements of named columns

DF[!is.na(DF[,"colname1"]),] # get rows with no NA colname1 values
DF[!is.na(DF[,"colname"]),"colname2"] # get column2 values of rows with no NA colname1 values
length(DF$a[!is.na(DF$a) & DF$a == 555]) # get count of colname elements with specific conditions

i <- match("colnameX", names(DF)) # get index of 'colnameX' variable
j <- match("colnameZ", names(DF))
DF[, i:j]
DF[, -(i:j)] # get all columns except of specified columns

DF <- data.frame(col1 = character(), col2 = character())

DF$newcol <- rnorm(5) # adding new column
DF <- cbind(DT, rnorm(5)) # adding new column to the right
DF <- cbind(rnorm(5), X) # adding new column to the left of DT
DF <- rbind(DF, data.frame(col1 = "val1", col2 = "val2"))
DF <- rbind(data.frame(col1 = "val1", col2 = "val2"), DF) # add row to the top of DF

library(plyr) # can be used 'dplyr' package because of more fast functions -- BUT 'dplyr' may delete rownames (shold be added previously as special column!)
newDF <- mutate(DF, newCol) # add new column to DF (can be used to replacing existing columns) -- 'dplyr' delete rownames!!!
newDF <- mutate(DF, newCol = existColX - mean(exisColX, na.rm = TRUE))
rename(DF, c("col_oldname" = "col_newname")) # rename variable of DF -- 'dplyr' has other syntacsis!!!
arrange() # like order function (see example in ## Basic subsection) -- 'dplyr' delete rownames!!!

library(dplyr)
select(DF, colX) # return a subset of the columns of DF (does not delete rownames =)
select(DF, colX:colZ)
select(DF, -(colX:colZ)) # show columns except specified columns
filter(DF, colX < 22 & colZ > 15) # extract a subset of rows based on logical conditions -- 'dplyr' delete rownames (shold be added previously as special column!)
rename(mtcars, col_newname = col_oldname) # rename variable of DF (does not delete rownames =)
rename(mtcars, col1_newname = col1_oldname, col2_newname = col2_oldname) 
summarize(group_by(DF, aggregatecol)) # agregate (by 'group_by') and show different values of variable
summarize(group_by(DF, aggregatecol), min(colX), max(colX), mean(colX)) # agregate (by 'group_by') and evaluate expressions

tempDF <- mutate(DF, year = as.POSIXlt(datecol)$year + 1900)
DF <- summarize(group_by(tempDF, year), min(colX), max(colX), spec_colname = mean(colX)) # agregate data by year value extracted from 'datacol' variable
DF <- summarize_each(group_by(tempDF, aggrCol1, aggrCol2), funs(mean)) # summarize function for each columns except of columns aggregated by
# 'pipeline' instructions provided by 'dplyr'
DF %>% mutate(month = as.POSIXlt(datecol)$mon + 1) %>% group_by(month) %>% summarize(col1 = min(colX), col2 = max(col2), col3 = mean(colX)) # get from DF 'month' & 'col1', 'col2', 'col3' (by aggregation) as data frame

mydata.averages <- aggregate(mydata[,4:89],list(mydata$Subject_ID,mydata$Activity), mean) # yet another way to aggregate

library(reshape2)
moltenDF <- melt(DF, id = c("carname", "gear", "cyl"), measure.vars = c("mpg", "hp")) # get DF with rows where 'carname - gear - cyl' are duplicated & 'variable - value' are different ("mpg" in top rows, "hp" in lower)
cylData <- dcast(moltenDF, cyl ~ variable) # agregate molten data frame and count! of different values of varibles ("mpg" & "hp") for dufferent values of "cyl"
cylData <- dcast(moltenDF, cyl ~ variable, mean) # evaluate mean values of variables ("mpg" & "hp") for dufferent values of "cyl"
acast() # use for casting as multi-dimensional arrays

library(tidyr)
# ... evolution of 'reshape2' and using 'dplyr' pipelines -- see swirl of DS_C3_W3 (lesson 3)!

data.matrix() # convert data frame to matrix

with(DF, func(col1, col2)) # evaluate func in data environments (no need to use DF$... names)


## Data Tables (much more faster than data frames)
library(data.table)
DT = data.table(x = numeric(0), y = character(0)) # initialize empty data table
DT = data.table(x = rnorm(9), y = rep(c("a", "b", "c"), each = 3), z = rnorm(9))
head(DT, 3) # get 3 first rows (6 rows by default   )
tail(DT, 3) # get 3 last rows
summary(DT) # counts variables (if character!) and simple statistics for num

DT <- rbind(DT, list(x = 10, y = "d", z = 10)) # adding the new row
tables() # see all data tables in memory

# Subsetting
DT[c(2,3)] # subsetting rows
DT[2,]
DT[DT$y == "a",]

DT[, 2:3, with = FALSE] # get columns with specific numbers
DF[, c("a", "c"), with = FALSE] # get elements of named columns
DT[, .(a, c)] # get elements of named columns too - where .() is alias of list()

DT[, list(min(x), sum(z), max(y))] # get values matched to 'expression'!
DT[, table(y)] # get count! of y elements by different values

subset(DF, col1name == "col1val")$col2 # filter by col1 value to get col2

set.seed(123) # init random number generator with some state
DT <- data.table(y = sample(letters[1:3], 1E5, TRUE)) # random generate large data
DT[, .N, by = y] # get count! of y elements by different values -- more slowly: DT[, table(y)] 

# Adding columns
DT[, newcol := z^2] # adding new column
# 'expression' may be set as function or in curley brackets (collection of statements)
DT[, newcol2 := {tmp <- (x + z); log2(tmp + 5)}] # multioperations: first statement does not generate data!
DT[, newcol3 := x > 0] # adding column values as logical statement result (TRUE, FALSE)
DT[, newcol4 := mean(x + z), by = a] # set newcol4 values equally calculated for rows agregated by 'a' coulmn values

# Keys
DT <- data.table(x = rep(c("a", "b", "c"), each = 100), y = rnorm(300), z = rep(c("a", "b", "c")))
setkey(DT, z) # set up! future expressions on z column
DT['a'] # get rows with z == 'a' -- more slowly: DT[DT$z == "a"]

# Joins
DT1 <- data.table(x = c('a', 'a', 'b', 'dt1'), y = 1:4)
DT2 <- data.table(x = c('a', 'b', 'dt2'), z = 5:7)
merge(DT1, DT2, by = "x", all = TRUE) # join tables on shared column "x" with NA values

setkey(DT1, x) # for speeding up join operations
setkey(DT2, x)
merge(DT1, DT2) # join tables without NA values
merge(DT1, DT2, all = TRUE) # join tables with NA values

merge(activity_nums, activity_labels, by.x = 1, by.y="V1",sort = FALSE) # filling chr labels (activity_labels$V2) for any mathing activity_labels$V2 <-> activity_nums[1] number


# Fast reading
big_df <- data.frame(x = rnorm(1E6), y = rnorm(1E6))
file <- tempfile()
write.table(big_df, file = file, row.names = FALSE, col.names = FALSE, sep = "\t", quote = FALSE)
system.time(fread(file)) # very fast reading!
system.time(read.table(file, header = TRUE, sep = "\t")) # slower reading

# Find the fastest calculating way
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time({mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)})
system.time({rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]})
system.time(DT[,mean(pwgtp15),by=SEX]) # very fast calculating average value of the var 'pwgtp15' broken by 'SEX' (с разбивкой по значениям SEX)
system.time(mean(DT$pwgtp15,by=DT$SEX)) 


## Names of objects
x <- 1:3
names(x) <- c("aa", "bb", "cc")

x <- list(a = 1, b = 2, c = 3) # $a, $b, $c == vector objects' names in list

m <- matrix(1:4, nrow = 2, ncol = 2)
dimnames(m) <- list(c("a", "b"), c("c", "d")) 


## Subsetting: [] -- element with the same (!) type of object (excluding matrix type), [[]] -- with inner object type, $ -- for named object
x <- c("a", "b", "c", "d")
x[1]
x[1:3]
x[x > a] # 'computed index' - условие

u <- x > "a" # logical indexes' vector: TRUE, FALSE

y <- 1:10
use <- y == 1 # TRUE & FALSE vector
use <- y >= 5 # TRUE & FALSE vector
y[use] # subsetted vector!

y <- c(TRUE, FALSE, FALSE, FALSE, TRUE, FALSE)
use <- y == TRUE
y[use]

x <- matrix(1:9, 3, 3)
x[x[, 2] >= 5, ] # get rows with col2 >= 5
x[which(x[, 2] >= 5), ] # the same

x[x[, 2] == 4 & x[, 3] == 9, ] # AND
x[x[, 2] == 4 | x[, 3] == 9, ] # OR

## subsetting 2
x <- list(foo = 1:4, bar = 0.6)
x[1] # get the 1st of the list element = sublist!!! with element name
x[[1]] # get the vector
x[[1]][7000] # get the 7000th value of vector

x["bar"] # get the list-element!!! with element name ('computed index')
x$bar # simple object
x[["bar"]] # the same simple object 

x <- list(foo = 1:4, bar = 0.6, baz = "hello")
x[c(1, 3)] # list of two elements: 1st & 3rd

x <- list(a = list(10, 12, 14), b = c(3.14, 2.81))
x[[c(1, 3)]] # get 3rd element of 1st element
x[[1]][[3]] # the same of above
x[[c(2, 1)]] # get the 1st element of 2nd element

## subsetting 3 (Matrix / DF)
x <- matrix(1:6, 2, 3) # i = 2 rows, j = 3 columns
x[1,2] # get element (not matrix!) from 1st row & 2nd column
x[1,] # vector
x[,2] # vector
x[1, 2, drop=FALSE] # get matrix with 1 element!
x[1, , drop=FALSE] # get matrix with 1 row 

x[1:2,] # get few rows
x[(nrow(x))-1:nrow(x),] # get 2 last rows
x[nrow(x)-1:nrow(x),] # get rows in reverced order

x <- c(3,5,1,10,12,6)
x[x %in% 1:5] # get elements of occurance of given integer diaposon

DF[DF$col %in% c("aaa", "bbb"), ] # get specific rows 

## Partial matching
x <- list(var = 1:5)
x$va # first symbols matching
x[["va", exact = FALSE]] # first symbols matching


## NA accounting & removing
sum(is.na(x)) # get count of NAs
any(is.na(x)) # at least one NA (get TRUE/FALSE)

colSums(is.na(DF)) # get result for each column
all(colSums(is.na(DF) == 0))

length(z[,"Ozone"][is.na(z[,"Ozone"])]) # number of NA elements in column "Ozone" of matrix z
z[ (!is.na(z[,"Ozone"]) & z[,"Ozone"] > 41) & (z[,"Temp"] > 91), ] # filter rows by two columns' values

x <- c(1, 2, NA, 4, NA, 5)
bad <- is.na(x)
x[!bad]

y <- c("a", "b", NA, "c", NA, "d")
good <- complete.cases(x, y) # there is no NA elements,ALSO: works with matrix name analyzing rows' data 
y[good]


## Vectors and Matrix operations
x <- 1:4
y <- 5:8
x * y # per element operation
x %*% y # true vector/xmatrix operation (result is matrix!)

x <- c(0,0,1,1,2,2)
y <- c(1,1)
x <- 1:6
y <- 2:3
x + y # get integer! vector by multiple - 3x (length(x)/length(y)) adding y to x with shifting y from left to right


## Spliting vector/data frame considering factor levels
# 1 factor
x <- c(rnorm(10), rnorm(10), rnorm(10))
f <- gl(3, 1, 3*10, labels = c("M","F","NA"))
splitted <- split(x, f) # get list of vectors (for $M, $F, $NA elements)
splitted$M

sapply(split(x, f), mean) # evaluate expression for each element (vector) of input list which is created by split()
unlist(lapply(split(x, f), mean)) # the same result (convert all list elements to one vector)

s <- split(DF, DF$factorcol) # split data frame considering Month value (for example)
lapply(s, function(m) colMeans(m[, c("Ozone", "Solar.R", "Wind")]))
sapply(s, function(m) colMeans(m[, c("Ozone", "Solar.R", "Wind")], na.rm = TRUE)) # simplified result table

# 2 and more factors
x <- rnorm(10)
f1 <- gl(2, 5)
f2 <- gl(5, 2)
interaction(f1, f2) # combinate all values

result <- split(x, list(f1, f2))
result <- split(x, list(f1, f2), drop = TRUE) # drop objects for empty factor levels
str(result) # show detailed objects' info

zipGroups <- cut(DF$zipCode, breaks = quantile(DF$zipCode)) # get factor variable with values which represent 4 intervals ( , ] (as clusters of DF$zipCode)
split(DF$zipCode, zipGroups)
table(zipGroups) # get common size (count of elements) of each 'cluster' (groups)
table(zipGroups, DF$zipCode) # get count of different DF$zipCode's values complies to 'clusters' (groups)


## Merging data
mergedDF <- merge(DFx, DFy, by.x = "solution_id", by.y = "id", all = TRUE) # get common DF based on link columns (all = TRUE means including NA values)
head(mergedDF) # if DFx & DFy have columns with equals names, then the will be named as .x and .y

intersect(names(DF1), names(DF2)) # get column's names intersection (as name values vector)
mergedDF <- merge(DFx, DFy, all = TRUE) # merge based on all intersection columns' combinations & fill empty values as NA

library(dplyr) # or 'plyr'
DF1 <- data.frame(id = sample(1:10), x = rnorm(10))
DF2 <- data.frame(id = sample(1:10), y = rnorm(10))
DF3 <- data.frame(id = sample(1:10), z = rnorm(10))
DF <- join(DF1, DF2) # join 2 data frames by 'id' value by default (as equal column's names)
DF <- join(DF1, DF2, by = "id")
DF <- join_all(list(DF1, DF2, DF3)) # join more than 2 data frames
arrange(DF, id) # order by 'id'


## Loop/agregate functions
# lapply - loop over the list (always!) and evaluate function on each element
x <- 1:10
result <- lapply(x, factorial)
result <- lapply(x, runif) # get the list of 10 objects - vectors of 1-10 random values
result <- lapply(x, runif, min = 0, max = 10) # the same using arguments of runif (min, max)
result[[1]]

x <- list(a = 1:10, b = 50:35, c = rnorm(20, 1), d = rnorm(100, 5))
lapply(x, mean) # get the list of 4 objects (named $a, $b, $c, $d)

x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2))
lapply(x, function(m) m[,2]) # extract 2nd column of matrices with own ('anonymous') func

# sapply - same as lapply but try to convert the result to vector/matrix/array
result <- sapply(list(a = 1:10, b = 55:88, c = 99:20), mean) # get vector! of 3 (named!) elements
result["a"] # equals to result[1]

# apply - evaluating over the margins of an array (return vectors & matrices)
x <- matrix(rnorm(200), 20, 10) # 1st margin of matrix - 20 rows, 2nd margin - 10 columns
result <- apply(x, 2, sum) # apply func for each column (as 2nd margin of x) and get a vector
result <- apply(x, 1, sum) # for each row

rowMeans(x) # optimezed (more fast) functions for matrices
rowSums(x)
colMeans(x)
colSums(x)

x <- matrix(rnorm(200), 20, 10)
apply(x, 1, quantile, probs = c(0.25, 0.75)) # apply func for each row and get 2-rows (25%, 75% percentiles) matrix with 20 cols 

apply(x[,1:4], 2, mean) # evaluate func for each 1-4 first columns of x

x <- array(rnorm((2*2)*10), c(2, 2, 10)) # get 3-dimensioan array (as 10 matrices 2x2)
apply(x, c(1,2), mean) # apply func crossing 1st and 2nd margins (for 3rd dimension)  

rowMeans(x, dims = 2) # optimezed (more fast)

# mapply - multivariate version of lapply (for multiple input lists/vectors arguments)
mapply(rnorm, 1:5, 1:5, 2) # evaluate func 5 times with 1 by 1 values of arguments' vectors (last arg's value is fixed)

# tapply - apply a function over subsets of a vector (incl. splitting 'x' by factor levels from another vector)
x <- c(rnorm(10), rnorm(10), rnorm(10))
f <- gl(3, 1, 3*10, labels = c("M","F","NA"))
tapply(x, f, mean) # agregate by factors 'f' and evaluate mean values of appropriate 'x' -- equals to sapply(split(x, f), mean)

sapply(split(x, f), mean) # another way to tapply
unlist(lapply(split(x, f), mean))

library(plyr)
ddply(DF, .(f), summarize, sum = sum(x)) # another way to agregate and evaluate expression (f, x - factor and val columns of DF)
ddply(DF, .(f), summarize, sum = ave(x, FUN = sum)) # using ave() if needs to duplicate sum result for each element of every factor group

DF <- as.data.frame(do.call("rbind", ListOfChrVect))


## Dates & Times
d <- as.Date("1970-01-11")
unclass(x) # the number of days after 1970-01-01!

d <- date() # example: "Sun Oct  2 23:31:01 2016" - get character variable

d <- Sys.Date() # example: "2016-10-02"
d # date as string (POSIXct format)
format(d, "%d.%m.%y") # example: "02.10.16" (%a - abbr. weekday, %A - unabbr. weekday, %b - abbr. month, $B - unabbr. month, %Y - 4-digit year)

dates <- as.Date(c("1янв2000", "16фев1990", "30июл1960"), "%d%b%Y")
as.numeric(dates[1] - dates[2]) # get numeric of 'difftime' variable (dont forget units!)

weekdays(dates)
months(dates)
julian(dates) # get difference by 'origin' date 1970-01-01 (as attribute)

t <- Sys.time() # example: "2016-10-02 23:31:13 MSK"
t # time as string (POSIXct format)
unclass(t) # seconds after 1970-01-01!

t1 <- as.POSIXlt(t) # time as list!
t1 # time as string too (POSIXct format the same as t)
unclass(t1) # show time's list objects (sec, min, hour, mday, mon, year, ...) and values
names(unclass(t1)) # show time's list objects' names
t1$year

Sys.getlocale(category = "LC_ALL")
Sys.setlocale("LC_TIME", "en_US.UTF-8") # for correct full day/month names parsing
timestring <- c("January 10, 2012 10:40", "December 9, 2011 9:10")
t2 <- strptime(timestring, "%B %d, %Y %H:%M")
t2
Sys.setlocale("LC_TIME", "ru_RU.UTF-8")
# Sys.setlocale(category = "LC_MESSAGES", "en_US.UTF-8")

t_gap <- as.POSIXct(Sys.time()) - as.POSIXct(t) # get time difference in maximal difference time units -- equals as using as.POSIXlt()
t_gap # example: Time difference of 0.01375794 secs - as 'difftime' variable
attributes(t_gap)$units # as secs, mins, hours, days, ...
as.numeric(t_gap)

library(lubridate)
ymd("20160130") # get date object considering any splitting symbols -- see many more combinations! of func names
mdy("08/04/2013")
dmy("02-12-2001")
ymd_hms("2011-08-03 10:15:03")
ymd_hms("2011-08-03 10:15:03", tz = "Pacific/Auckland") # use specified timezone
Sys.timezone()

x <- dmy("05-12-2001")
wday(x) # get numeric value of weekday (by order: Sun < Mon < Tues < Wed < Thurs < Fri < Sat) -- see many more func names
wday(x, label = TRUE)
wday(x) <- 5 # set weekday


## Control Structures
## if
if(y > 3) {
  x <-10
} else {
  x <- 0
}

x <- if(y > 3) {10} else {0} # the same

## for
for (i in 1:10) {
  print(i)
}

for (i in 1:10) print(i) # the same

x <- c("a", "b", "c", "d")
for(i in 1:4) {
  print(x[i])
}

for(i in seq_along(x)) {  # print while is not the end
  print(x[i])
}

for(letter in x) {
  print(letter)
}

x <- matrix(1:6, 2, 3) # 2 rows and 3 columns
for(i in seq_len(nrow(x))) {
  for(j in seq_len(ncol(x))) {
    print(x[i,j])
  }
}

## while
count <- 0
while (count < 10) {
  print(count)
  count <- count + 1
}

## repeat/break!
x <- 1
y <- 1e-8
repeat { # infinite loop!
  z <- compute_something_func()
  if(z < y) {
    break # only way to exit repeat loop!
  } else {
    x <- z
  }
}

## next
for (i in 1:100) {
  if(i <= 20) {
    next # skip first steps to next loop iterations 
  }
  print(i)
}


### INPUT/OUTPUT DATA INTERFACES
readLines() # text files
source("file.R")  # run script/load environment/functions - inverse of dump
dget() # code - inverse of doubt
load() # saved workspace
unserialize() # single R objects from binary
gzfile() # unarchive file
bzfile()

unzip(zipfile="./data/Dataset.zip", exdir="./data")

download.file("https://site.com/rows.csv?accessType=DOWNLOAD", destfile = "./data/file.csv", method = "curl")
downloadDate <- date() # current time & date

## Webpages 1
url <- "http://www.jhsph.edu"
con <- url(url, "r") # getting content needs to close content after work!
htmlCode <- readLines(con)
close(con)
head(htmlCode)
htmlCode

##  Webpages 2
library(httr)
html <- GET(url) # doesn't need to close content after work!
html
names(html) # names of objects associated with webpage (url, status_code, cookies, content, ...)

site <- handle("http://google.com")
html1 <- GET(handle = site, path = "/")
html2 <- GET(handle = site, path = "search")

con <- content(html, as = "text")
library(XML)
parsedHtml <- htmlParse(con, asText = TRUE)
xpathSApply(parsedHtml, "//title", xmlValue) # get webpage title

## Webpages with passwords (when status 401)
url <- "http://httpbin.org/basic-auth/user/passwd"
html <- GET(url, authenticate("user", "passwd"))
html

## Web API
myapp <- oauth_app("myAppName", key = "yourConsumerKey", secret = "yourConsumerSecret")
sig <- sign_oauth1.0(myapp, token = "yourToken", token_secret = "yourTokenSecret")
homeTL <- GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)
library(jsonlite)
jsonData <- fromJSON(toJSON(content(homeTL))) # get data frame from json
jsonData[1, 1:4]

## Other sources
con <- file("file.txt", "rw")
data <- read.csv(con)
close(con)

DF <- read.table("./data/file.csv", sep = ",", header = TRUE, quote="") # default separator = space
DF <- read.table(textConnection(gsub("-", "\t", readLines(url))), header = TRUE, skip = 2) # change '-' to white space & skip first strings
head(DF) # 1st 6 text strings

DF <- read.csv("file.csv", header = TRUE) # default separator = comma: "," -- download.file() at first!
DF <- read.csv2() # default separator = semicolon: ";"

library(xlsx)
read.xlsx("./data/file.xlsx", sheetIndex = 1, header = TRUE)
colIndex <- 2:3
rowIndex <- 1:10
read.xlsx("./data/file.xlsx", sheetIndex = 1, header = TRUE, colIndex = colIndex, rowIndex = rowIndex)
read.xlsx2() # more speed but unstable

library(XML)
doc <- xmlTreeParse("file.xml", useInternal = TRUE) # allows to use url as filepath
rootNode <- xmlRoot(doc)
xmlName(rootNode) # root node name
names(rootNode) # main nodes names
xmlSApply(rootNode, xmlSize) # get count of all nodes
rootNode[[1]] # get all! exemplars of 1st main node
rootNode[[1]][[1]] # get the 1st exemplar of 1st main node
xmlSApply(rootNode[[1]][[1]], xmlName) # get names of node's elements

xmlSApply(rootNode, xmlValue) # get every single node values
xpathSApply(rootNode, "//name", xmlValue) # get specific nodes values
# with XPath launguage: 
# /nodename - top level node
# //nodename - node at any level
# nodename[@attr-name] - node with specific attribute
# nodename[@attr-name='bob'] - node with specific attribute value (TRUE or FALSE answers)

doc <- htmlTreeParse("http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens", useInternal = TRUE)
scores <- xpathSApply(doc, "//li[@class='score']", xmlValue)

library(jsonlite)
jsondata <- fromJSON("https://site.com/repos")
names(jsondata)
names(jsondata$objname)
names(jsondata$objname$obj)

myjson <- toJSON(iris, pretty = TRUE) # convert data frame to JSON object
cat(myjson) # concatenate a lot of elements and print

## Speeding of reading
# 1 - if there are no comments strings in file
x <- read.table("datatable.txt", comment.char = "")

# 2 - specifying classes of objects
initial <- read.table("datatable.txt", nrows = 50)
classes <- sapply(initial, class)
x <- read.table("datatable.txt", colClasses = classes)

## MySQL
library(RMySQL)
DB <- dbConnect(MySQL(), user = "genome",
                host = "genome-mysql.cse.ucsc.edu") # get handle of server's DBs
allDBs <- dbGetQuery(DB, "show databases;")
dbDisconnect(DB)

DB <- dbConnect(MySQL(), user = "genome", db = "hg19",
                host = "genome-mysql.cse.ucsc.edu") # get handle of specific DB
allTables <- dbListTables(DB)
length(allTables)
allTables[1:5]
dbListFields(DB, "affyU133Plus2") # get fields of DB's specific table
dbGetQuery(DB, "select count(*) from affyU133Plus2")

tabData <- dbReadTable(DB, "affyU133Plus2") # read from table
head(tabData)

query <- dbSendQuery(DB, "select * from affyU133Plus2 where misMatches between 1 and 3")
tabData <- fetch(query) # read subset from table by SQL query
quantile(tabData$misMatches)

tabData <- fetch(query, n = 10) # get first 10 matches of query
dbClearResult(query)
dim(tabData) # dimensions (size) of data
dbDisconnect(DB)

## HDF5 (hdfgroup.org)
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")

library(rhdf5)
h5file <- "example.h5"
created <- h5createFile(h5file)
created

created <- h5createGroup(h5file, "aaa") # create groups in the file
created <- h5createGroup(h5file, "bbb")
created <- h5createGroup(h5file, "aaa/ccc")
h5ls(h5file) # show groups and files in the .h5 file

A <- matrix(1:10, 5, 2)
h5write(A, h5file, "aaa/A")
B <- array(seq(0.1, 2.0, by = 0.1), dim = c(5, 2, 2))
attr(B, "scale") <- "liter"
h5write(B, h5file, "aaa/ccc/B")
DF <- data.frame(1L:5L, seq(0, 1, length.out = 5),
                 c("ab", "cde", "fghi", "a", "s"), stringsAsFactors = FALSE)
h5write(DF, h5file, "DF")
h5ls(h5file)

B <- h5read(h5file, "aaa/ccc/B")

h5write(c(12, 13, 14), h5file, "aaa/A", index = list(1:3, 1)) # rewrite 1-3 elements of 1st column in file A
h5read(h5file, "aaa/A")

## Writing data
write.table()
writeLines()
dput() # for 1 object only -- reconstruct R object as R code text
dump() # dget() for multiple objects
save()
serialize()

write.xlsx() # use the same arguments as in read.xlsx()

y <- data.frame(a = 1, b = "a")
dput(y) # print y as R code
dput(y, file = "y.R") 
new.y <- dget("y.R") 

x <- "aaa"
y <- data.frame(a = 1, b = "a")
dump(c("x", "y"), file = "vars.R") > rm(x, y)
source("vars.R")


## Text Processing
tolower(c("Hello", "World!")) # get character values in lower register
toupper(c("Hello", "World!"))

splittedList <- strsplit("Hello.World.!", "\\.") # get the list of vectors of splitted words (by specified symbol '.')

sub("_", "", "aaa_bbb_ccc") # single! replacement
data <- gsub("-", " ", "aaa bbb ccc ddd eee-fff") # multiple! replacement '-' to white space (" " or "\t" for read.csv)
con <- textConnection(data, open = "r", encoding = c("", "bytes", "UTF-8")) # open input/output text connection

textvect <- c("aaa", "bbb", "Who is theeree? bbb")
grep("bbb", textvect) # search string in character vector's elements and get their (elements') indexes
grep("bbb", textvect, value = TRUE) # get the vector of elements only that matched!
grepl("bbb", textvect) # get match/mismatch as TRUE/FALSE for every element of vector
table(grepl("bbb", textvect))

newtextvect <- textvect[!grepl("bbb", textvect)] # filter textvector by string entry

library(stringr)
nchar("Hello World!") # get count of characters

substr("Hello World!", 1, 5) # extract symbols from start = 1 to stop = 5

paste("Hello", "World!") # get concatinated string -- default separator = " "!
paste("Hello", "World!", sep = "_")
paste0("Hello", "World!") # no separator!

str_trim("Hello      ") # delete last! space symbols

sprintf("%03d", ID) # specific formatting: adding zeros up to 3-symbols number

## Regular Expressions -- useful in sub/gsub/grep/grepl
# ^ - represent the start of a line
# $ - represent the end of a line
# [Bb][Uu][Ss][Hh] - is the set of characters we accept
# ^[0-9][a-zA-Z]
# [^?.]$ - use "^" to not accept symbols, "?" - one symbol, "." - any punctuation symbol???)
# ^$ - for metacharacter "" catching???
# flood|fire|coldfire - use "|" as "or"
# ^[Gg]ood|[Bb]ad - to catch "Good" at the beginning of the line and catch "Bad" in any position of the line!
# ^([Gg]ood|[Bb]ad) - to catch "Good"/"Bad" at the beginning of the line
# [Gg]eorge( [Ww]\.)? [Bb]ush - "()?" as optional condition ("\." - to catch "." symbol)
# (.*) - "*" as repeat any times ("." - any character) to cath any text in ( ) - it catchs the longest matched variant
# (.*?) - to catch the smaller variant
# [0-9]+ - "+" as at least one symbol
# Bush( +[^ ]+ +){1,5} debate - {1,5} as from 1 to 5 times ({5} as exactly 5 times, {5,} as at least 5 times)
#  +([a-zA-Z]+) +\1 + - '\1' as one repeat of previous expression (at this case is to catch repeated words)
# [^^]( )+ - greedy spaces but ignore one in the beginning of a string

### PROFILING
# return user.self (charged time resource to all CPUs for expression/'пользователь') &
#        elapsed (wall clock - user waiting/'прошло') time in seconds
system.time({
  # any expression here
})

# profiling based on function call stack
Rprof(tmp <- tempfile()) # DO NOT use together with system.time()!
f <- myFUNCTION(x) # the function to profile
Rprof()
report <- summaryRprof(tmp) # summarizes the output from Rprof()
unlink(tmp)
report$by.self

Rprof(tmp <- tempfile(), memory.profiling = TRUE) # profiling of both time and memory
f <- myFUNCTION(x) # the function to profile
Rprof()
report <- summaryRprof(tmp, memory="both")
unlink(tmp)

Rprofmem() # profile memory allocation only
