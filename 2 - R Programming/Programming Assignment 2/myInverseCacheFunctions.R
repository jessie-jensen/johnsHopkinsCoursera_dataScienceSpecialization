## makeCacheMatrix function creates a special "matrix" object that can cache its inverse
## Created matrix should be stored in order to cache inverse matrices
##
## For example: B <- makeCacheMatrix(A)
## where A is a square invertable 

makeCacheMatrix <- function(x = matrix()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  
  get <- function() x
  setinverse <- function(solve) m <<- solve
  getinverse <- function() m
  
  list(set = set, 
       get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}


## cacheSolve function computes the inverse of the special "matrix" returned by makeCacheMatrix above. 
## If the inverse has already been calculated, cacheSolve will retrieve the inverse from the cache.
## Will utilize previously stored matrices from makeCacheMAtrix
## 
## For example:
## B <- makeCacheMatrix(A)
## cacheSolve(B)
## where A is a square invertable 

cacheSolve <- function(x, ...) {
  m <- x$getinverse()
  if(!is.null(m)) {
        message("getting cached data")
        return(m)
  }
  else {
        data <- x$get()
        m <- solve(data, ...)
        x$setinverse(m)
        m  
  }
}

# Below is a test case for the functions:
# 
A = matrix(c(2, 4, 3, 1), nrow=2, ncol=2) 
A

solve(A)
B <- makeCacheMatrix(A)
cacheSolve(B)

cacheSolve(B)
