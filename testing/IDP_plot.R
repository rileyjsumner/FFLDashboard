rm(list =ls())

install.packages("tidyverse")
library(tidyverse)
library(magrittr)

dlfranks <- read.csv("./DLF_IDP_Rankings_080721.csv", header = TRUE)
head(dlfranks)
str(dlfranks)

dlfranks <- dlfranks[,1:10]
tail(dlfranks)

dlfranks.tbl <- as_tibble(dlfranks)

?ggplot2


dlfranks$Pos <- factor(dlfranks$Pos, levels = unique(dlfranks$Pos))
str(dlfranks)

library(ggplot2)

ggplot(dlfranks, aes(dlfranks$Age, dlfranks$AVG, colour = dlfranks$Pos)) + geom_point()
