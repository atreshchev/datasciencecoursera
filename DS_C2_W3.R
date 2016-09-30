## DS_C2_W3 Assignment

## Example 1: func creates a special list ("vector") containing 4 exemplars of functions to:
# 1) set the value of the vector in the func env.!
# 2) get the value of the vector
# 3) set the value of the mean
# 4) get the value of the mean
makeVector <- function(x = numeric()) {
  m <- NULL # func env
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setmean <- function(mean) m <<- mean
  getmean <- function() m
  
  list(set = set, get = get, setmean = setmean, getmean = getmean)
}

## Example 2: func calculates the mean of the special list created with the above func.
# Func first checks to see if the mean has already been calculated. 
# If so, gets the mean from the cache and skips the computation.
# Otherwise, calculates the mean of the data and sets the value of the mean in the cache via the setmean function.
cachemean <- function(x, ...) {
  m <- x$getmean()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- mean(data, ...)
  x$setmean(m)
  m
}

f <- makeVector(1:10)
f$get()
# f$set(34) # change func environment
f$getmean()
# f$setmean(23) # change func environment
cachemean(f)