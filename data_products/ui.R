library(shiny)

#Read dataset to get the list of teams
dataset <- read.csv("./data/todos.csv",
                    header = TRUE)

#Create 
shinyUI(
      fluidPage(
            titlePanel("English Premier League Results 2000-2014"),
            
            selectInput("type", "Select type of match",
                        choices = c("ALL", "home", "tie", "away")),
            fluidRow(
                  column(4,
                         selectInput("Team.1",
                                     "Team.1",
                                     unique(as.character(dataset$Team.1)))
                  ),
                  column(4, selectInput("Team.2",
                                        "Team.2",
                                        unique(as.character(dataset$Team.2)))
                  ),
                  fluidRow(dataTableOutput(outputId = "table")
                  )
            )
      )
)
      
      