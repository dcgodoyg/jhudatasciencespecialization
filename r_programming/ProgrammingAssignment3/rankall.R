rankall <- function(outcome, rank_input){
        
        outcome_base <- data.frame()
        outcome_base <- read.csv("outcome-of-care-measures.csv", na.strings = "Not Available", colClasses = "character")
       
        state_list <- as.list(sort(unique(outcome_base[ , 7])))
        outcome_list <- list("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
        
        outcome_status <- outcome %in% names(outcome_list)
        
        
        
        if (outcome_status == "TRUE") {
             
               d <- data.frame(stringsAsFactors=FALSE)
               
                for(state in state_list) {
                       
                        subset_base <- outcome_base[complete.cases(outcome_base$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia), ]
                        subset_base <- subset(subset_base, subset_base[ , 7] == state)
                        subset_base <- subset_base[order(subset_base[ , 2]), ]
                        
                      
                        
                        outcome_number <- get(outcome, outcome_list)                        
                        ranking <- rank(as.numeric(subset_base[ , outcome_number]), ties.method = "first")
                        
                        len_ranking <- length(ranking)
                        
                        
                        if (rank_input == "best") {
                                rank_input2 = 1
                        }
                        if (rank_input == "worst") {
                                rank_input2 = len_ranking
                        } else {
                                rank_input2 = rank_input
                        }
                        
                        if (len_ranking >= rank_input2) {
                        position <- which(ranking %in% rank_input2)
                        hospital <- sort(subset_base[position, 2])
                        hospital <- hospital[[1]]
                        d <- rbind(d, data.frame(hospital, state))
                } else {
                        d <- rbind(d, data.frame(hospital = NA, state))                   
                }
                }
               
                return (d)
        
                
                } else {
                        
               
                if (outcome_status == !TRUE) {
                        stop("invalid outcome")
                } else {
                        return (NA)
        }
}
}
