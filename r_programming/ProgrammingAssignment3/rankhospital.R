rankhospital <- function(state, outcome, rank_input){
        
        outcome_base <- data.frame()
        outcome_base <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        outcome_base 
        state_list <- (unique(outcome_base[ , 7]))
        outcome_list <- list("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
        
        state_status <- state %in% state_list
        outcome_status <- outcome %in% names(outcome_list)
        
        subset_base <- subset(outcome_base, outcome_base[ , 7] == state)
        subset_base[subset_base == "Not Available"] <- NA
        subset_base <- na.omit(subset_base)
        len_ranking <- nrow(na.omit(subset_base))
        
        if (rank_input == "best") {
                rank_input2 <- 1
        }
        
        if (rank_input == "worst") {
                rank_input2 <- len_ranking
        }
        
        if (state_status == "TRUE" && outcome_status == "TRUE" && rank_input2 <= len_ranking) {
             
               
                outcome_number <- get(outcome, outcome_list)
                ranking <- rank(as.numeric(subset_base[ , outcome_number]), na.last = NA, ties.method = "random")
                
                
                
                position <- which(ranking %in% rank_input2)
                hospital <- sort(subset_base[position, 2])
                return (hospital[[1]])
                
                } else {
                        
                if (state_status == !TRUE) {
                        stop("invalid state")
                } else {
                if (outcome_status == !TRUE) {
                        stop("invalid outcome")
                } else {
                        return (NA)
        }
}
}
}