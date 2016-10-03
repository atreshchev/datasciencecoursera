## Assignment DS_C2_W3:
## Caching the Inverse of a Matrix.
## Assuming that the matrix supplied is always invertible (e.g. square numeric).

## 1. Func creates a special "matrix" object that can cache its inverse.
makeCacheMatrix <- function(x = matrix()) {
  m <- NULL # init the inversed matrix
  set <- function(y) {
    x <<- y
    m <<- NULL # init the inversed matrix after setting new input matrix
  }
  get <- function() x # get input matrix
  setinvers <- function(solve) m <<- solve
  getinvers <- function() m
  
  list(set = set, get = get, setinvers = setinvers, getinvers = getinvers)
}

## 2. Func computes the inverse of the special "matrix" returned by
## makeCacheMatrix function. If the inverse has already been calculated
## (and the matrix has not changed), then retrieves the inverse from the cache.
cacheSolve <- function(x, ...) {
  m <- x$getinvers() 
  if(!is.null(m)) {
    message("getting cached inversed matrix")
    return(m)
  }
  m <- solve(x$get(), ...) # get the matrix that is the inverse of 'x'
  x$setinvers(m)
  m
}

## Test
x <- matrix(rnorm(25), 5, 5)
f <- makeCacheMatrix(x)
cacheSolve(f)