get_roster_by_player_id <- function(id) {
  return(filter(rosters, player_id == id) %>%
           select(team_id))
}

get_full_roster_ids <- function(roster_id) {
  return(filter(rosters,team_id == roster_id) %>%
           select(player_id)) 
}

get_full_roster_names <- function(roster_id) {
  return(filter(rosters, team_id == roster_id) %>%
           mutate(player_name = 'Tom Brady'))
}

get_player_name_by_id <- function(id) {
  df = filter(players, player_id == id) %>%
    select(player_name)
  return(df$player_name)
}

