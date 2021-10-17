get_roster_by_player_id <- function(id) {
  return(filter(rosters, player_id == id) %>%
           select(team_id))
}

get_full_roster_ids <- function(roster_id) {
  return(filter(rosters,team_id == roster_id) %>%
           select(player_id)) 
}

get_full_roster_names <- function(roster_id) {
  df = get_full_roster_ids(roster_id)
  return(merge(players,df,all.x = FALSE) %>%
           select(player_id,player_name))
}

get_full_roster_values <- function(roster_id) {
  df = get_full_roster_ids(roster_id)
  return(merge(values,df,all.x = FALSE) %>%
           select(player_id,value))
}

get_player_name_by_id <- function(id) {
  df = filter(players, player_id == id) %>%
    select(player_name)
  return(df$player_name)
}

display_full_roster <- function(id){
  df1 = get_full_roster_names(id)
  df2 = get_full_roster_values(id)
  return(merge(df1,df2))
}

get_full_roster_data <- function(id){
  df1 = get_full_roster_ids(id)
  df2 = merge(players,df1,all.x = FALSE)
  df3 = get_full_roster_values(id)
  return(merge(df2,df3))
}

get_team_names <- function(){
  return(teams %>%
           select(team_id, team_name))
}

get_team_name_by_id <- function(id){
  df = filter(teams,team_id == id) %>%
    select(team_name)
  return(df$team_name)
}

get_team_id_by_team_name <- function(name){
  df = filter(teams,team_name == name) %>%
    select(team_id)
  return(df$team_id)
}

get_current_users_team <- function(){
  return(filter(teams, is_user))
}


calc_dynasty_value <- function(position,value,age){
  age_multiplier <- 
    ifelse(position == "QB",1.25,
         ifelse(position == "RB",0.75,
                ifelse(position == "WR",2,
                       ifelse(position == "TE",3,99))))
    return((value * age_multiplier) + age)
  }

calc_dynasty_value_threeyr <- function(position,value,age){
  age_multiplier_threeyr <-
    ifelse(position == "QB" & age < 30, 3.5,
           ifelse(position == "QB" & age < 33, 3,
                  ifelse(position == "QB" & age >= 33, 2,
                         ifelse(position == "RB" & age < 23, 3.2,
                                ifelse(position == "RB" & age < 25, 3,
                                       ifelse(position == "RB" & age >= 25, 2,
                                              ifelse(position == "WR" & age < 26, 3.5,
                                                     ifelse(position == "WR" & age < 28, 3,
                                                            ifelse(position == "WR" & age >= 28, 2,
                                                                   ifelse(position == "TE" & age < 27, 3.2,
                                                                          ifelse(position == "TE" & age < 31, 2.8,
                                                                                 ifelse(position == "TE" & age >= 31, 2.5,0))))))))))))
  return((value * age_multiplier_threeyr))
}

