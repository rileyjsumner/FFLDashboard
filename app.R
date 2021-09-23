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
library(rjson)


# Define UI for application that draws a histogram

ui <- fluidPage(
  
  titlePanel("League Report for Team"),
  sidebarLayout(
    sidebarPanel(
      textInput("min_player_value","MIN PLAYER VALUE", value = 100),
      br(),
      selectInput("team_1","TEAM ONE", get_team_names()$team_name, get_current_users_team()),
      selectInput("team_2","TEAM TWO", get_team_names()$team_name, get_team_names()$team_name[2])
    ),
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Team One",tableOutput("full_team_one")),
                  tabPanel("Team Two",tableOutput("full_team_two")),
                  tabPanel("Values",
                           tableOutput("value_table"),
                           plotOutput("value_plot")
                      )
                  )
               )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  assets_t1 = eventReactive(c(input$team_1,input$min_player_value),get_assets(
      get_team_id_by_team_name(input$team_1),
      as.numeric(input$min_player_value)
    ) %>% 
        select(position, player_name, team_nfl, value, birthdate) %>%
    arrange(position, desc(value))
    )
  
  assets_t2 = eventReactive(c(input$team_2,input$min_player_value),get_assets(
      get_team_id_by_team_name(input$team_2),
      as.numeric(input$min_player_value)
  ) %>% 
      select(position, player_name, team_nfl, value, birthdate) %>%
      arrange(position, desc(value))
  )
  
  qb_val_t1 = eventReactive(
    c(input$team_1,input$min_player_value),
    get_total_by_position("QB",assets_t1())
  )
  rb_val_t1 = eventReactive(
    c(input$team_1,input$min_player_value),
    get_total_by_position("RB",assets_t1())
  )
  wr_val_t1 = eventReactive(
    c(input$team_1,input$min_player_value),
    get_total_by_position("WR",assets_t1())
  )
  te_val_t1 = eventReactive(
    c(input$team_1,input$min_player_value),
    get_total_by_position("TE",assets_t1())
  )
  
  qb_val_t2 = eventReactive(
      c(input$team_2,input$min_player_value),
      get_total_by_position("QB",assets_t2())
  )
  rb_val_t2 = eventReactive(
      c(input$team_2,input$min_player_value),
      get_total_by_position("RB",assets_t2())
  )
  wr_val_t2 = eventReactive(
      c(input$team_2,input$min_player_value),
      get_total_by_position("WR",assets_t2())
  )
  te_val_t2 = eventReactive(
      c(input$team_2,input$min_player_value),
      get_total_by_position("TE",assets_t2())
  )
  
  output$value_table = renderTable(
      render_plot_data(
          rbind(
              cbind(team = input$team_1, qb_val_t1()), 
              cbind(team = input$team_1, rb_val_t1()), 
              cbind(team = input$team_1, wr_val_t1()), 
              cbind(team = input$team_1, te_val_t1())
          ),
          rbind(
              cbind(team = input$team_2, qb_val_t2()), 
              cbind(team = input$team_2, rb_val_t2()), 
              cbind(team = input$team_2, wr_val_t2()), 
              cbind(team = input$team_2, te_val_t2())
          )
      )
  )
  output$value_plot = renderPlot(
      render_plot_data(
          rbind(
              cbind(team = input$team_1, qb_val_t1()), 
              cbind(team = input$team_1, rb_val_t1()), 
              cbind(team = input$team_1, wr_val_t1()), 
              cbind(team = input$team_1, te_val_t1())
          ),
          rbind(
              cbind(team = input$team_2, qb_val_t2()), 
              cbind(team = input$team_2, rb_val_t2()), 
              cbind(team = input$team_2, wr_val_t2()), 
              cbind(team = input$team_2, te_val_t2())
          )
      ) %>% 
      pivot_wider(names_from = position, values_from = total) %>%
      ggradar(
        values.radar = c("0","2000", "4000"),
        grid.max = 4000,
        grid.min = 0,
        grid.mid = 2000
      )
  )
  
  output$full_team_one = renderTable(assets_t1())
  output$full_team_two = renderTable(assets_t2())

}


# Run the application 
shinyApp(ui = ui, server = server)
