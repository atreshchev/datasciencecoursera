## Assignment DS_C2_W3:
## Caching the Inverse of a Matrix.
## Assuming that the matrix supplied is always invertible.

# 1.1: Func creates a special "matrix" object that can cache its inverse.
makeCacheMatrix <- function(x = matrix()) {
  m <- NULL # inversed matrix
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x # input matrix
  setinvers <- function(solve) m <<- solve
  getinvers <- function() m
  
  list(set = set, get = get, setinvers = setinvers, getinvers = getinvers)
}

# 1.2: Func computes the inverse of the special "matrix" returned by
# makeCacheMatrix function. If the inverse has already been calculated
# (and the matrix has not changed), then retrieves the inverse from the cache.
cacheSolve <- function(x, ...) {
  m <- x$getinvers() 
  if(!is.null(m)) {
    message("getting cached inversed matrix")
    return(m)
  }
  m <- solve(x$get(), ...)
  x$setinvers(m)
  m # return a matrix that is the inverse of 'x'
}

# Test
x <- matrix(rnorm(25), 5, 5)
f <- makeCacheMatrix(x)
cacheSolve(f)


## Example
# Example 1.1: func creates a special list ("vector") containing 4 exemplars of functions to:
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

# Example 1.2: func calculates the mean of the special list created with the above func.
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

# Test
f <- makeVector(1:10)
f$get()
# f$set(34) # change func environment
f$getmean()
# f$setmean(23) # change func environment
cachemean(f)