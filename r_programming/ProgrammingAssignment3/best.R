best <- function(state, outcome){
        
        outcome_base <- data.frame()
        outcome_base <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        state_list <- (unique(outcome_base[ , 7]))
        outcome_list <- list("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
        
        state_status <- state %in% state_list
        outcome_status <- outcome %in% names(outcome_list)
        
        subset_base <- subset(outcome_base, outcome_base[ , 7] == state)
        
        if (state_status == "TRUE" && outcome_status == "TRUE") {
             
                outcome_number <- get(outcome, outcome_list)
                ranking <- rank(as.numeric(subset_base[ , outcome_number]))
                position <- which(ranking %in% min(ranking))
                hospital <- sort(subset_base[position, 2])
                return (hospital[[1]])
                
                } else {
                        
                if (state_status == !TRUE) {
                        stop("invalid state")
                } else {
                        stop("invalid outcome")
                }               
        }   
}