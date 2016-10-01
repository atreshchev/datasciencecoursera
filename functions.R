## Functions
myfunc <- function(x) {
  y <- 55 + mean(x)
  y # functions does not edit global environment!
}
myfunc(4)
myfunc(4:1000)

above <- function(x, n = 15) { # default value for n if we'll not specify it
  use <- x > n
  x[use]
}

columnmean <- function(y) {
  nc <- ncol(y)
  means <- numeric(nc) # init empty numeric vector with length = nc
  for(i in 1:nc) {
    means[i] <- mean(y[,i])
  }
  means
}

columnmean <- function(y, removeNA = TRUE) {
  nc <- ncol(y)
  means <- numeric(nc) # init empty numeric vector with length = nc
  for(i in 1:nc) {
    means[i] <- mean(y[,i], na.rm = removeNA) # na.rm is standard arg for mean()
  }
  means
}


## The ... argument
myplotfunc <- function(x, y, type = "l", ...) { # change type default value
  plot(x, y, type = type, ...)
}


## Lexical scoping 
# The values of free variables are searched for in the environment
# in which the function was defined
make.power <- function(n) {
  pow <- function(x) { # external (free) arg x! from environment where func defined
                        # (= the same where called often (parent environment!)
    x^n
  }
  pow
}

square <- make.power(2) # argument used as n
cube <- make.power(3)
square(10) # argument used as x
cube(10)

## Lexical & Dynamic scoping 
y <- 10
g <- function(x) {
  x + y # y value will depend on environment where defined (= the same where called at this case)
}
f <- function(x) {
  y <- 2
  y^2 + g(x) # y = 2 in func g as value of calling environment
}
g(1) # y = 10 (in global environment)
f(1) # y = 2 (in calling environment)


## Function closure = environment (symbol-values pairs)
ls(environment(anyfunc)) # get local vars of anyfunc
get("varname", environment(anyfunc)) # get local var's value 


## Scoping - Optimization example (optional: DS C2 (R programming) Week 2)
# Maximizing a Normal Likelihood 
# Pdf: https://d3c33hcgiwev3.cloudfront.net/_76f13b90448a0c20d6772ea5c282fb57_scoping_optimization.pdf?Expires=1474934400&Signature=aahbF0Ax2sTg~KG3WziPcTQEDeDl~Nh9FN0BDp-xjg9~0935q30ChV2sfyr7uiS4FGHST~5CBg~euTXAUzI7ixdMBtw-UH-SEmTNegKGopgFg6tfIhvdawkFJvSG51EuvW9595YAMSLE0QR4dP5L019NSE5qFiwV3m8Sj2wInS4_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A
make.NegLogLik <- function(data, fixed=c(FALSE,FALSE)) { # write a “constructor” function
  params <- fixed
  function(p) {
    params[!fixed] <- p
    mu <- params[1]
    sigma <- params[2]
    a <- -0.5*length(data)*log(2*pi*sigma^2)
    b <- -0.5*sum((data-mu)^2) / (sigma^2)
    -(a+b)
  }
}

set.seed(1)
normals <- rnorm(100, 1, 2) # setting mu = 1 & sigma = 2 for input dataset
nLL <- make.NegLogLik(normals) # create func exemplar
nLL
ls(environment(nLL))

optim(c(mu = 0, sigma = 1), nLL)$par # finding approximated (приближенные к исходным) mu & sigma values

nLL <- make.NegLogLik(normals, c(1, FALSE)) # func exemplar with fixed (известн.) mu = 1
optimize(nLL, c(1e-6, 10))$minimum # finding approximated sigma value

nLL <- make.NegLogLik(normals, c(FALSE, 2)) # func exemplar with fixed (известн.) sigma = 2
optimize(nLL, c(-1, 3))$minimum # finding approximated mu value

# Plotting Likelihood
nLL <- make.NegLogLik(normals, c(1, FALSE)) x <- seq(1.7, 1.9, len = 100)
y <- sapply(x, nLL)
plot(x, exp(-(y - min(y))), type = "l")
nLL <- make.NegLogLik(normals, c(FALSE, 2)) x <- seq(0.5, 1.5, len = 100)
y <- sapply(x, nLL)
plot(x, exp(-(y - min(y))), type = "l")


## Invisible result
printmessage <- function(x) {
  if(is.na(x)) {
    print("x is a missing value!")
  } else if(x > 0) {
    print("x is greater than zero")
  } else {
    print("x is less than or equal to zero")
  }
  invisible(x) # return x value with no printing x
}

result <- printmessage(10)


## Debugging
# traceback() - print out the function call stack after an error! occurs
mean(asdsadasd) # object not found
traceback()

# recover - automatic traceback after any error
options(error = recover) # global settings while R session is not over
read.csv("nosuchfile")

# debug() - "debug mode": step through execution of a function one line at a time (press n to next line)
debug(lm) # argument must be R func (R coded!)
lm(y ~ x)

# browser() - activate "debug mode" wherever it is called (in R code - lika a print)
# ...

# trace() - allows you to insert debugging code into a function a specific places
# ...

# message("Message...") - get red message in console wherever it is called
# ...

