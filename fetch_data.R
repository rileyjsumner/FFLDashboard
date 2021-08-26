players <- data.frame(read.csv("./data/player.csv", header = TRUE))
rosters <- data.frame(read.csv("./data/fantasyteam.csv", header = TRUE))
teams <- data.frame(read.csv("./data/teams.csv", header = TRUE))
values <- data.frame(read.csv("./data/values.csv", header = TRUE))
util <- data.frame(read.csv("./data/util.csv", header = TRUE))

str(players)
class(players)

