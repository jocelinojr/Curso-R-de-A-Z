#--------------------------------------------------
# Seção 6

library(ggplot2)

list.files()

movies <- read.csv("2_page_s6_file_2.csv")

names(movies) <- c("film", "genre", "critic.rating", "audience.rating", "budget.millions", "year.release" )

str(movies)

# converts year to a factor
movies$year.release <- factor(movies$year.release)
str(movies)
summary(movies)


# Creates our plot object
p <- ggplot(data=movies, aes(x=critic.rating, y=audience.rating, colour=genre, size=budget.millions))

# working with layers
p + geom_point()
p + geom_line()
p + geom_point() + geom_line()
p + geom_point() + geom_line()





