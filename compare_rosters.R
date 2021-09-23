get_assets <- function(roster_id,min_value){
  df = get_full_roster_data(roster_id)
  return(filter(df,value >= min_value) %>%
         select(player_id,player_name,position,team_nfl,value,birthdate))
}

get_total_by_position <- function(pos,player_list){
  # DO STUFF HEREx
  if(FALSE) {
    return(data.frame(
      
    ))
  }
  return(filter(player_list, position == pos) %>%
           group_by(position) %>%
           summarize(total = sum(value)))
}

render_plot_data <- function(team_1_data, team_2_data) {
  return(data.frame(rbind(team_1_data, team_2_data)))
}

