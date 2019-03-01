
#-------------------------------------
# Homework

library(tidyverse)
library(dplyr)
library(magrittr)



getwd()
list.files()

moviesgross <- read.csv("Section6-Homework-Data.csv")
View(moviesgross)

str(moviesgross)
# tentei mudar o nome da coluna, mas não funcionou
names(moviesgross)[names(moviesgross) == "Gross..US"] <- "Gross.US"

# filtrando o dataset
moviesfiltro <-  moviesgross %>%
                 filter(Studio %in% c("Buena Vista Studios", "Fox", "Paramount Pictures", "Sony", "Universal", "WB")) %>%
                 filter(Genre %in% c("action", "adventure", "animation", "comedy", "drama"))  

moviesfiltro[, c("Studio", "Genre", "Budget...mill.", "Gross...US")]



# Let's build our plot

g <-  ggplot(data = moviesfiltro, aes(x=Genre, y=Gross...US, size=Budget...mill.))


g + geom_jitter(aes(color=Studio)) + geom_boxplot(size=1.2, alpha=0.7)















