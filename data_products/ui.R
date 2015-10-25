library(shiny)

#Define UI for miles per gallo app
shinyUI(
      fluidPage(
            titlePanel("English Premier League Results 2000-2014"),
            
            fluidRow(
                  column(3,
                         selectInput("Team.1",
                                     "Team.1",
                                     c(unique(as.character(df$Team.1))))
                  ),
                  column(3, selectInput("Team.2",
                                        "Team.2",
                                        c(unique(as.character(df$Team.2))))
                  ),
                  fluidRow(dataTableOutput(outputId = "table")
                  )
            )
      )
)
      
      