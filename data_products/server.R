library(shiny)
library(stringr)

#Define server logic required to plot various variables against mpg

shinyServer(function(input, output) {
      
      output$table <- renderDataTable({
            
            dataset <- read.csv("./data/todos.csv",
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
            
            dataset <- cbind(dataset, homegoals = as.numeric(str_sub(dataset$FT, 1, 1)),
                          awaygoals = as.numeric(str_sub(dataset$FT, 3, 3)))
            
            dataset$type <- ifelse(dataset$homegoals > dataset$awaygoals, "home",
                                ifelse(dataset$homegoals == dataset$awaygoals,
                                       "tie", "away"))
            if(input$type != "ALL"){
                  dataset <- dataset[dataset$type == input$type, ]}
            
            dataset <- dataset[dataset$Team.1 == input$Team.1, ]
            dataset <- dataset[dataset$Team.2 == input$Team.2, ]
            dataset
            
            
      })
})