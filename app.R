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
library(ggradar)


# Define UI for application that draws a histogram

ui <- fluidPage(
  
  titlePanel("League Report for Team: "),
  selectInput("team_1","TEAM ONE", get_team_names()$team_name, get_current_users_team()),
  textInput("min_player_value","MIN PLAYER VALUE", value = 100),
  tableOutput("full_team"),
  verbatimTextOutput("Total Team Value"),
  textOutput("qb_value"),
  textOutput("rb_value"),
  textOutput("wr_value"),
  textOutput("te_value"),
  plotOutput("value_plot"),
  tableOutput("value_table")
 )



# Define server logic required to draw a histogram
server <- function(input, output) {
  assets = eventReactive(c(input$team_1,input$min_player_value),get_assets(
      get_team_id_by_team_name(input$team_1),
      as.numeric(input$min_player_value)
    ) %>% 
    select(position, player_name, team_nfl, value)
    )
  
  qb_val = eventReactive(
    c(input$team_1,input$min_player_value),
    get_total_by_position("QB",assets())
  )
  rb_val = eventReactive(
    c(input$team_1,input$min_player_value),
    get_total_by_position("RB",assets())
  )
  wr_val = eventReactive(
    c(input$team_1,input$min_player_value),
    get_total_by_position("WR",assets())
  )
  te_val = eventReactive(
    c(input$team_1,input$min_player_value),
    get_total_by_position("TE",assets())
  )
  output$value_table = renderTable(
    data.frame(rbind(cbind(input$team_1, qb_val()), cbind(input$team_1, rb_val()), cbind(input$team_1, wr_val()), cbind(input$team_1, te_val()))) %>%
     pivot_wider(names_from = position, values_from = total)
  )
  output$value_plot = renderPlot(
    data.frame(rbind(cbind(input$team_1, qb_val()), cbind(input$team_1, rb_val()), cbind(input$team_1, wr_val()), cbind(input$team_1, te_val()))) %>% 
      pivot_wider(names_from = position, values_from = total) %>%
      ggradar(
        grid.max = 4000
      )
  )
  
  output$full_team = renderTable(assets())
  output$qb_value = renderText(qb_val()$total)
  output$rb_value = renderText(rb_val()$total)
  output$wr_value = renderText(wr_val()$total)
  output$te_value = renderText(te_val()$total)
}


# Run the application 
shinyApp(ui = ui, server = server)
