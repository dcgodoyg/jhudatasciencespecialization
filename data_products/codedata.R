install.packages("shiny")
library(shiny)
library(stringr)

lista <- list.files("C:/Users/Daniel/Desktop/todos")

todosdf <- NULL
path <- "C:/Users/Daniel/Desktop/todos"

for (i in lista){
      
      df <- read.csv(paste(path, "/", i, sep = ""), header = TRUE)
      todosdf <- rbind(todosdf, df)
}

# todosdf <- cbind(todosdf, homegoals = as.numeric(str_sub(todosdf$FT, 1, 1)),
#             awaygoals = as.numeric(str_sub(todosdf$FT, 3, 3)))
# 
# todosdf$type <- ifelse(todosdf$homegoals > todosdf$awaygoals, "home",
#                   ifelse(todosdf$homegoals == todosdf$awaygoals, "tie", "away"))

write.csv(todosdf, paste(path, "/", "todos.csv", sep = ""))
            
            
            
            