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