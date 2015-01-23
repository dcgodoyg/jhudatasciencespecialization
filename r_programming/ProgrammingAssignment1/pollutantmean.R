pollutantmean <- function(directory, pollutant, id = 1:332){
        
        data = numeric()
        for(i in id){
                base = read.csv(paste(directory, "/", formatC(i, width = 3, flag = "0"), 
                                      ".csv", sep = ""))
                data = c(data, base[[pollutant]])
        }
        return(mean(data, na.rm = TRUE))
}