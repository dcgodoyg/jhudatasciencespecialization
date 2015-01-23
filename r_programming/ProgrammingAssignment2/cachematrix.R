#This function creates a special "matrix" object that can cache its inverse.

makeCacheMatrix <- function(x = numeric()) {
		#set the initial value of the m element
		m <- NULL
        set <- function(y) {
                x <<- y
                m <<- NULL
        }
        #get the matrix
		get <- function() x
        #solve the matrix (find inverse)
		setsolve <- function(solve) m <<- solve
        #get the inverse of the matrix
		getsolve <- function() m
        list(set = set, get = get,
             setsolve = setsolve,
             getsolve = getsolve)
}

#This functions calculate inverse of matrix.

cachesolve <- function(x, ...) {
        m <- x$getsolve()
        #check if inverse of matrix has already
		#been calculated. If yes, return cached
		#value. If no, calculate inverse of matrix.
		if(!is.null(m)) {
                message("getting cached data")
                return(m)
        }
        data <- x$get()
        #calculate inverse of matrix.
		m <- solve(data, ...)
        x$setsolve(m)
        #return inverse matrix
		m
}
#end
