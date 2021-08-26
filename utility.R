get_roster_by_player_id <- function(player_id){
  return(rosters$team_id[rosters$player_id == player_id])
}

