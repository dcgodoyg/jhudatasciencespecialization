corr <- function(directory, threshold = 0){
       
        filenames = list.files(directory, pattern = "*.csv", full.names = TRUE)
        id = numeric()
        id = 1:length(filenames)
        
        corrr = numeric()
        
        for(i in id){
        base = read.csv(paste(directory, "/", formatC(i, width = 3, flag = "0"), 
                              ".csv", sep = ""))
        complete = sum(complete.cases(base)*1)
        if (complete > threshold)
                { corrr = c(corrr, (cor(base$sulfate, base$nitrate, use = "complete.obs")))
               }
        } 
        return(corrr)
}