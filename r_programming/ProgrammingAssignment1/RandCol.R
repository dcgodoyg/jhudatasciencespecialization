rand_col <- function(x, n){
                
        #        return (x[, as.integer(runif(n, min = 1, max = ncol(x)+1), replace = FALSE)])
        return (x[, sample(ncol(x), n, replace = FALSE)])
}
