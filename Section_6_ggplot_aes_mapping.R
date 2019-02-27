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

#----------------------------------------------------
# Mapping x setting

# mapping
p + geom_point(aes(size=budget.millions))

# setting
p + geom_point(size=10, colour="Darkgreen")

# histograms and Desnity plots
s <- ggplot(data=movies, aes(x=budget.millions))

# mapping the color of the histogram
s + geom_histogram(binwidth = 10, aes(fill=genre), color="White")
# adds a border

#-------------------------------------------------
# Statistical transformations


# Smooth 
g <- ggplot(data = movies, aes(x=critic.rating, y=audience.rating, colour=genre))
g + geom_point() + geom_smooth(fill=NA)

# Box plots
bp <- ggplot(data = movies, aes(x=genre, y=audience.rating, color=genre))
bp + geom_boxplot(size=1.2)

bp + geom_boxplot(aes(y=critic.rating))

bp2 <- ggplot(data = movies, aes(x=genre, y=critic.rating, color=genre))
bp2 + geom_boxplot()




