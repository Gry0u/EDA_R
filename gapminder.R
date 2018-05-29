library(ggplot2)
library(dplyr)
library(gridExtra)
library(xlsx)

energy <- read.xlsx('energy use total.xlsx', sheetIndex = 1 )
str(energy)
internet_users <- read.xlsx('Internet user total.xlsx', sheetIndex = 1)

ggplot(aes(x))