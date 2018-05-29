library(ggplot2)
library(dplyr)
library(gridExtra)
library(xlsx)

energy <- read.xlsx('energy use total.xlsx', sheetIndex = 1 )
energy <- stack(energy)
internet_users <- read.xlsx('Internet user total.xlsx', sheetIndex = 1)
internet_users <- stack(internet_users)

energy$ind <- charenergy$ind
table(energy$ind)
sapply(energy, class)
