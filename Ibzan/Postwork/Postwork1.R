url_liga <- "https://www.football-data.co.uk/mmz4281/2021/SP1.csv"

setwd("c:/Users/ibzan/OneDrive/Documentos/Cursos/BEDU/Modulo2/1 - Introduccion a R y Software/Postwork/files/")

liga_19.20.df <- read.csv(url_liga)

head(liga_19.20.df, 1)

install.packages("dplyr")
library(dplyr)

df_fthg <- select(liga_19.20.df, "FTHG", "FTAG")
