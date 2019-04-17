library(dplyr)
library(odbc)
library(ggplot2)
library(scales)
library(ggrepel)


#############################################
# Financial Project
# Advanced R programming - UDEMY

# prepara o caminho e a pasta
my_path <- file.path(getwd(), "Udemy-Advanced-R")
setwd(my_path)

# jeito falho de importar...deixa os campos em branco serem importados sem ser NA
# fin <- read.csv("P3-Future-500-The-Dataset.csv")

fin <- read.csv("P3-Future-500-The-Dataset.csv", na.strings = c(""))

head(fin)
str(fin)
summary(fin)


# Leading with the factors

# there are many variables as factors that we don't want them to be..let's change their type

# ID (it's just a identification and we don't need it as numerical)

# change the type
fin$ID <- factor(fin$ID)
fin$Inception <- factor(fin$Inception)

# by doing this we converted the numbers into categories,it makes more sense
summary(fin)

###################################################################
# The factor Variable Trap(FVT)
# It is a pitfall when you try to convert a factor variable into another type
# How to avoid this pitfall?

#
a <- c("alto", "baixo", "alto", "medio", "alto", "medio")
b <- factor(a)
levels(b)


###############################################################
# We can convert using levels(x)[x]
d <- c("12", "13", "12", "14", "12", "12", "13")
f <- factor(d)

x <- as.numeric(levels(f)[f])
x

head(fin)

# to convert right from a factor to a number, we have to folow some steps

# get rid of some undesirable characters using sub() or gsub() functions

# Removing the "Dollars" word
fin$Expenses <- gsub(" Dollars", "", fin$Expenses)
# removing the ","
fin$Expenses <- gsub(",", "", fin$Expenses)

############################################
# IMPORTANT $ IS AS SPECIAL CHARACTER. WE NEED TO USE A SCAPE CHAR "\\"
fin$Revenue <- gsub("\\$", "", fin$Revenue)
fin$Revenue <- gsub(",", "", fin$Revenue)
fin$Growth <- gsub("%", "", fin$Growth)


# After we have converted to characters, we can convert it to numerics
fin$Revenue <- as.numeric(fin$Revenue)
fin$Expenses <- as.numeric(fin$Expenses)
fin$Growth <- as.numeric(fin$Growth)


# makes a plot 
dados <- fin %>% group_by(State, Industry) %>%
        summarize(receita= sum(Revenue,na.rm=TRUE)) %>%
        arrange(receita)

dados[dados$State == "VA",]

p <- ggplot(data = dados, mapping = aes(x=reorder(State, receita) , y = receita, fill=Industry))
p + geom_col() + coord_flip() + facet_grid(~Industry) +
 labs(title="Revenue per state per Industry", caption="Data Set: financial") +   guides(fill=FALSE) + theme_light()  + scale_y_continuous(label=dollar)

str(fin)

# NA é uma valor lógico, que não é igual a nenhum 
TRUE == 2
TRUE == FALSE
TRUE == 1
TRUE == TRUE
NA == 0
NA == NA
is.na(NA)
is.na(1)


# Uma maneira elegante de localizar NAs (missing data)
# An elegant way to locate missing data

# checando os valores NA do dataset
complete.cases(fin)
# subset our dataset with just the rows with NAs values
fin[!complete.cases(fin), ]

str(fin)

# <NA>versus NA
#  <NA> para factors 

# Evitar fazer assim os subsets
fin[fin$Revenue == 9254614, ]

# Podemos usar o filter ou o which
# which retorna o índice da linha
filter(fin, fin$Revenue==9254614)
fin[which(fin$Revenue == 9254614), ]

head(fin)

# pega apenas as despesas que tem NA
fin[!is.na(fin$Expenses), ]

summary(fin)

# verifica quais são as linhas que tem NA na indústria
fin[is.na(fin$Industry), ]

nrow(fin)

# faz um back up do datset
fin_bck <- fin

rownames(fin_bck)

View(fin)

# "remove" do dataset as linhas que tem NA na indústria
fin <-  filter(fin, !is.na(fin$Industry))


rownames(fin) <- NULL

rownames(fin)


# Lidando com dados faltantes
filter(fin, is.na(fin$State))

fin[is.na(fin$State) & fin$City %in% "San Francisco", "State"] <- "CA"

# verifica se os valores foram preenchidos corretamente
fin[c(82, 265),]




# reseta o número das linhas
rownames(fin2) <- NULL


# pega a mediana do número de empregados
median(fin$Employees, na.rm = TRUE)
# a média é bem maior (afetada por outliers)
mean(fin$Employees, na.rm = TRUE)

a <- fin %>%
     subset(Industry == "Retail")  %>%
     select(Employees)

# pega a mediana dos empregados retail
employ_median_retail <-  median(a$Employees, na.rm = TRUE)

b <- fin %>%
     subset(Industry == "Financial Services")  %>%
     select(Employees)
View(b)
# pega a mediana dos empregados financial services
employ_median_finan <-  median(b$Employees, na.rm = TRUE)

fin[is.na(fin$Employees) & fin$Industry == "Retail", "Employees"] <- employ_median_retail
fin[is.na(fin$Employees) & fin$Industry == "Financial Services", "Employees"] <- employ_median_finan

# Olhando o que ainda temos a completar
fin[!complete.cases(fin), ]

# completa o estado NY
fin[is.na(fin$State) & fin$City == "New York", "State"] <- "NY"


#############################################################
# Gráfico

# Pega os valores máximos de empregados e de revenue de cada grupo

fin_group_max <- fin %>% 
                  group_by(Industry) %>%
                  summarize(max_employee=max(Employees, na.rm = TRUE), max_revenue=max(Revenue, na.rm = TRUE))

# pega as empresas com valores máximos de empregados
empr_maximos <- subset(fin, fin$Employees %in% fin_group_max$max_employee)
revenue_max <- subset(fin, fin$Revenue %in% fin_group_max$max_revenue)

p <- ggplot(fin, mapping = aes(x = Employees, y=Revenue, color=Industry))
# sem alteração de escala
p + geom_point() + geom_smooth(se = FALSE)

# escala logarítimca no eixo y
p + geom_point() + scale_y_log10(labels=dollar) + geom_smooth(se = FALSE)

# destaca as empresas com maior quantidade de empregados em cada ramo
p + geom_point() + scale_y_log10(labels=dollar) + scale_x_log10() + 
  geom_text_repel(data = empr_maximos, mapping = aes(label=Name)) + 
  geom_text_repel(data = revenue_max, mapping = aes(label=Name), color="black") 
  








