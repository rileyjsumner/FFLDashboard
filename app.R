#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(dplyr)


# Define UI for application that draws a histogram

ui <- fluidPage(
  
  titlePanel("League Report for Team: "),
  textOutput("team_id")
 )



# Define server logic required to draw a histogram
server <- function(input, output) {
 output$team_id = renderText({get_roster_by_player_id(10001)})
}

# Run the application 
shinyApp(ui = ui, server = server)
