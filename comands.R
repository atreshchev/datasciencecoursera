## R commands here.
## to submit changes via Rstudio use -> Commit -> Push

getwd() # my directory
dir()   # files in directory
ls()    # environment (objects)

setwd("dirname")

?anyfunc # HELP
args(anyfunc)

file.create("filename")
file.exists("filename")
file.info("mytest.R")$mode
file.rename("mytest.R", "mytest2.R")
file.path("myfolder","mytest3.R") # platform-independent relative pathname 

dir.create("testdir")
dir.create(file.path('testdir2', 'testdir3'), recursive = TRUE)

unlink("testdir", recursive = TRUE) # recursive folders deleting

rm(list = ls()) # clean environment

source("file.R")  # run script/load environment/functions
read.csv("file.csv")

##
sqrt()
abs()
max()

## Functions
myfunc <- function(x) {
  x <- rnorm(100)
  mean(x)
}

myfunc2 <- function(x) {
  x + rnorm(length(x))
}

myfunc2(4)
myfunc2(4:10)

## Basic
str(func_name) # show function's arguments

print()
x <- vector("numeric", length = 10)
x <- c("a", "b", "c") # T, F == TRUE=1, FALSE=0; 5+4i == complex number...
x <- 1:10
attributes()

x <- 5 # numeric
c(1, 2) # numeric
c(4, TRUE) #numeric
x <- 1:6 # integer
class(x)
as.integer(x)
as.logical(x)
as.character(x)

mean()

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

## Factors
x <- factor(c("yes", "yes", "no", "yes", "no"))
x <- factor(c("yes", "yes", "no", "yes", "no"), levels = c("yes", "no")) 

table(x)
unclass(x)

attr(x,"levels") # get specfic attributes

x <- 1:10
attr(x,"dim") <- c(2, 5) # set! specfic attributes with name "dim"

## Testing to missing values (NA includes NaN!)
x <- c(1, 2, NA, NaN, 5, 6)
is.na(x)
is.nan(x)

## Data Frames (matrices with row and column names & different types of values in each column/row)
x <- data.frame(foo = 1:4, bar = c(T, F, T, F))
nrow(x)
ncol(x)

## Names of objects
x <- 1:3
names(x) <- c("aa", "bb", "cc")

x <- list(a = 1, b = 2, c = 3) # $a, $b, $c == vector objects' names in list

m <- matrix(1:4, nrow = 2, ncol = 2)
dimnames(m) <- list(c("a", "b"), c("c", "d")) 

## Reading Data
read.table() # default separator = space
read.csv()
readLines() # text files
source() # code - inverse of dump
dget() # code - inverse of doubt
load() # saved workspace
unserialize() # single R objects from binary

# Speeding of reading
# 1 - if there are no comments strings in file
x <- read.table("datatable.txt", comment.char = "")

# 2 - specifying classes of objects
initial <- read.table("datatable.txt", nrows = 50)
classes <- sapply(initial, class)
x <- read.table("datatable.txt", colClasses = classes)

# Writing Data
write.table()
writeLines()
dput() # for 1 object only -- reconstruct R object as R code text
dump() # dget() for multiple objects
save()
serialize()

y <- data.frame(a = 1, b = "a")
dput(y) # print y as R code
dput(y, file = "y.R") 
new.y <- dget("y.R") 

x <- "aaa"
y <- data.frame(a = 1, b = "a")
dump(c("x", "y"), file = "vars.R") > rm(x, y)
source("vars.R")

## Interfaces to different sources
file()
gzfile()
bzfile()
url()

con <- file("file.txt", "rw")
data <- read.csv(con)
close(con)

con <- url("http://www.jhsph.edu", "r")
x <- readLines(con)
head(x)

## Subsetting: [] -- element with the same (!) type of object (excluding matrix type), [[]] -- with inner object type, $ -- for named object
x <- c("a", "b", "c", "d")
x[1]
x[1:3]
x[x > a] # 'computed index' условие

u <- x > "a" # logical indexes' vector: TRUE, FALSE

y <- 1:10
y == 1 # TRUE & FALSE vector
y >= 5 # TRUE & FALSE vector

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

# Removing NA
x <- c(1, 2, NA, 4, NA, 5)
bad <- is.na(x)
x[!bad]

y <- c("a", "b", NA, "c", NA, "d")
good <- complete.cases(x, y) # there is no NA elements,ALSO: works with matrix name analyzing rows' data 
y[good]

##
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
