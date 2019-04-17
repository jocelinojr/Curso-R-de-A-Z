############################################
# Apply Functions
# Wheather data Challenge

my_fun <- function(x){
  print(x[1])
  cat("Qde de Elementos:", length(x), "\n")
  return(x+2)
}

matriz <- matrix(1:20, 4, 5)

apply(matriz, MARGIN = 1, my_fun)

apply(matriz, MARGIN = 1, mean)




getwd()
setwd(file.path(getwd(), "Udemy-Advanced-R/Weather Data"))

list.files()

###############################################
# Carregando os arquivos que iremos trabalhar
# IMPORTANTE: temos que indicar que a primeira coluna contém os rownames, senão ela será importada
# como uma coluna no dataframe
chicago <- read.csv("Chicago-F.csv", row.names = 1)
new_york <- read.csv("NewYork-F.csv", row.names=1)
houston <- read.csv("Houston-F.csv", row.names = 1)
san_fran <- read.csv("SanFrancisco-F.csv", row.names = 1)



# convertendo os data frames para matrizes para facilitar nosso trabalho mais a frente
chicago <- as.matrix(chicago)
new_york <- as.matrix(new_york)
houston <- as.matrix(houston)
san_fran <- as.matrix(san_fran)


# coloca as matrizes numa lista
weather <- list(chicago=chicago, new_york=new_york, houston=houston, san_fran=san_fran)


# usando a função Apply para obter as médias das métricas nos dataframes
apply(chicago, 1, mean)
apply(houston, 1, mean)
apply(new_york, 1, mean)
apply(san_fran, 1, mean)

# Função que retorna a média das linhas de uma matriz
rowMeans(chicago)

# usando lapply para pegar de uma vez só a médias das linhas com rowMeans
m <- lapply(weather, rowMeans)
d <- as.data.frame(m)
d
################################################
# Awesome functions to use with lapply

# rowMeans()
# colMeans()
# rowSums()
# colSums()

  














