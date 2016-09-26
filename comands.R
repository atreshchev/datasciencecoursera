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
anyfunc # show fixed arguments and ... arguments (and environment of func)
args(anyfunc) # show function's arguments
str(anyfunc) # show function's arguments too

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

paste("Hello", "World!", sep = " ") # get concatinated string
sprintf("%03d", ID) # specific formatting: adding zeros up to 3- symbols number

x <- 5 # numeric
x <- 5L # integer
c(1, 2) # numeric
c(4, TRUE) #numeric
x <- 1:6 # integer
class(x)

x <- c(1, 9, 4, 8, 2, 3, 6, 0, 7, 5)
sort(x) # get values in right order

x <- vector("numeric", length = 10)
x <- c("a", "b", "c") # T, F == TRUE=1, FALSE=0; 5+4i == complex number...
x <- c(x, "d") # vector addition
x <- 1:10
print(x)

x <- seq(1.7, 1.9, len = 100)

as.integer(x)
as.logical(x)
as.character(x)


## Matrices
x <- list(1, "a", TRUE, 1+4i) # every element in list is a vector!

m <- matrix(nrow = 2, ncol = 3)
dim(m)
m <- matrix(1:6, nrow = 2, ncol = 3)

m <- 1:10
dim(m) <- c(2, 5)

x <- 1:3
y <- 4:6
m <- cbind(x,y)
m <- rbind(x,y)

# Randomization
x <- rnorm(100) # get vector of 100 values rnorm

vect <- c(1000:1)
set.seed(42)
use <- sample(1000, 10)
print(vect[use])

# Dates & Times
d <- as.Date("1970-01-11")
unclass(x) # the number of days after 1970-01-01!

d <- Sys.Date()
d # date as string (POSIXct format)

t <- Sys.time()
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
t <- strptime(timestring, "%B %d, %Y %H:%M")
t
Sys.setlocale("LC_TIME", "ru_RU.UTF-8")

t_gap <- as.POSIXct(Sys.time()) - as.POSIXct(t2) # get time difference in maximal difference time units -- equals as using as.POSIXlt()


## Factors
x <- factor(c("yes", "yes", "no", "yes", "no"))
x <- factor(c("yes", "yes", "no", "yes", "no"), levels = c("yes", "no")) 

table(x)
unclass(x)

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
nrow(DF)
ncol(DF)
colnames(DF)
rownames(DF)

DF$a # get elements of one column
DF[, c(1,3:4)] # get elements of columns with specific numbers
DF[, c("a", "c")] # get elements of named columns

DF[!is.na(DF[,"colname1"]),] # get rows with no NA colname1 values
DF[!is.na(DF[,"colname"]),"colname2"] # get column2 values of rows with no NA colname1 values
length(DF$a[!is.na(DF$a) & DF$a == 555]) # get count of colname elements with specific conditions

data.matrix() # convert data frame to matrix


## Data Tables (much more faster than data frames)
library(data.table)
DT = data.table(x = numeric(0), y = character(0)) # initialize empty data table
DT = data.table(x = rnorm(9), y = rep(c("a", "b", "c"), each = 3), z = rnorm(9))
head(DT, 3) # get 3 first rows

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


## Interfaces to different sources
file()
gzfile()
bzfile()
url()

download.file("https://site.com/rows.csv?accessType=DOWNLOAD", destfile = "./data/file.csv", method = "curl")
downloadDate <- date() # current time & date

con <- file("file.txt", "rw")
data <- read.csv(con)
close(con)

con <- url("http://www.jhsph.edu", "r")
x <- readLines(con)
head(x)


## Reading Data
DF <- read.table("./data/file.csv", sep = ",", header = TRUE, quote="") # default separator = space
head(DF) # 1st textstring

DF <- read.csv("file.csv", header = TRUE) # default separator = comma: ","
DF <- read.csv2() # default separator = semicolon: ";"

readLines() # text files
source("file.R")  # run script/load environment/functions - inverse of dump
dget() # code - inverse of doubt
load() # saved workspace
unserialize() # single R objects from binary

library(xlsx)
read.xlsx("./data/file.xlsx", sheetIndex = 1, header = TRUE)
colIndex <- 2:3
rowIndex <- 1:10
read.xlsx("./data/file.xlsx", sheetIndex = 1, header = TRUE, colIndex = colIndex, rowIndex = rowIndex)
read.xlsx2() # more speed but unstable

library(XML)
doc <- xmlTreeParse("file.xml", useInternal = TRUE)
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


## Writing Data
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

## subsetting 2
x <- list(foo = 1:4, bar = 0.6)
x[1] # get the list-element!!! with element name
x[[1]] # get the vector

x["bar"] # get the list-element!!! with element name ('computed index')
x$bar # simple object
x[["bar"]] # the same simple object 

x <- list(foo = 1:4, bar = 0.6, baz = "hello")
x[c(1, 3)] # list of two elements: 1st & 3rd

x <- list(a = list(10, 12, 14), b = c(3.14, 2.81))
x[[c(1, 3)]] # get 3rd element of 1st element
x[[1]][[3]] # the same of above
x[[c(2, 1)]] # get the 1st element of 2nd element

## subsetting 3 (Matrix)
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
x[x %in% 1:5] # occurance of x to integer diaposon


# Partial matching
x <- list(var = 1:5)
x$va # first symbols matching
x[["va", exact = FALSE]] # first symbols matching


# NA removing
x <- c(1, 2, NA, 4, NA, 5)
bad <- is.na(x)
x[!bad]

y <- c("a", "b", NA, "c", NA, "d")
good <- complete.cases(x, y) # there is no NA elements,ALSO: works with matrix name analyzing rows' data 
y[good]


## NA accounting
length(z[,"Ozone"][is.na(z[,"Ozone"])]) # number of NA elements in column "Ozone" of matrix z
z[ (!is.na(z[,"Ozone"]) & z[,"Ozone"] > 41) & (z[,"Temp"] > 91),] # filter rows by two columns' values


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





