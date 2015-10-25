library(shiny)
library(datasets)

#Define server logic required to plot various variables against mpg

shinyServer(function(input, output) {
      
      output$table <- renderDataTable({
            
            data <- read.csv("./data/todos.csv",
                             header = TRUE)
                        
            #CALCULATE and create new column based on scores. The new column
            #will identify the match as a home win, tie, or away wins.
            
            datasetInput <- reactive({
                  switch(input$type, 
                         "home" = home,
                         "tie" = tie,
                         "away" = away
                  )
            })
            
            data <- cbind(data, homegoals = as.numeric(str_sub(data$FT, 1, 1)),
                          awaygoals = as.numeric(str_sub(data$FT, 3, 3)))
            
            data$type <- ifelse(data$homegoals > data$awaygoals, "home",
                                ifelse(data$homegoals == data$awaygoals,
                                       "tie", "away"))
            if(input$type != "ALL"){
                  data <- data[data$type == input$type, ]}
            
            data
            data <- data[data$Team.1 == input$Team.1, ]
            data <- data[data$Team.2 == input$Team.2, ]
            data
            
            
      })
})