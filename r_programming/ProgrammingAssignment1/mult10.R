mult10 <- function(x){
        if(is.character(x)){
                result <- apply(sapply(x, rep, 10), 2, paste, collapse ="")
                names(result) <- NULL
        } 
        else {
                result <- x*10
        }       
return(result)
}