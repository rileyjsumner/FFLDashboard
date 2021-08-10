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

players <- data.frame(read.csv("./player_rankings.csv", header = TRUE))
players.qb <- data.frame(filter(players, Position == "QB"))
players.rb <- data.frame(filter(players, Position == "RB"))


# Define UI for application that draws a histogram

ui <- fluidPage(
  
  titlePanel("RESE Draft Board - 2021"), 
  selectInput("QB1", "Quarterbacks", c(players.qb$Name, ""), ""),
  selectInput("QB2", NULL, c(players.qb$Name, ""), ""),
  selectInput("QB3", NULL, c(players.qb$Name, ""), ""),
  selectInput("QB4", NULL, c(players.qb$Name, ""), ""),
  selectInput("RB1", "Running Backs", c(players.rb$Name, ""), ""),
  selectInput("RB2", NULL, c(players.rb$Name, ""), ""),
  selectInput("RB2", NULL, c(players.rb$Name, ""), ""),
  selectInput("RB3", NULL, c(players.rb$Name, ""), ""),
  selectInput("RB4", NULL, c(players.rb$Name, ""), ""),
  selectInput("RB5", NULL, c(players.rb$Name, ""), ""),
)



# Define server logic required to draw a histogram
server <- function(input, output) {
  player_library = data.frame(players)
  player_library
}

# Run the application 
shinyApp(ui = ui, server = server)
