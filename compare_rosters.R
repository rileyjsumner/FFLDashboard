get_assets <- function(roster_id,min_value){
  df = get_full_roster_data(roster_id)
  return(filter(df,value >= min_value) %>%
         select(player_id,player_name,position,team_nfl,value))
}

get_total_by_position <- function(pos,player_list){
  return(filter(player_list, position == pos) %>%
           group_by(position) %>%
           summarize(total = sum(value)))
}