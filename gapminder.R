#import libraries
library(ggplot2)
library(dplyr)
library(gridExtra)
library(xlsx)
library(reshape2)

#load excel files
energy <- read.xlsx('energy use total.xlsx', sheetIndex = 1, stringsAsFactors=FALSE)
internet_users <- read.xlsx('Internet user total.xlsx', sheetIndex = 1, stringsAsFactors=FALSE)

#Reshape files
energy <- melt(energy)
internet_users <- melt(internet_users)

# Rename columns
names(energy) <- c("Country", "Year", "Energy_use")
names(internet_users) <- c("Country", "Year", "Internet_users")

#Change year column type
energy$Year <- gsub('X','', energy$Year)
energy$Year <- as.numeric(energy$Year)

internet_users$Year <- gsub('X','', internet_users$Year)
internet_users$Year <- as.numeric(internet_users$Year)
#Merge files

energy_internet_users <- merge(energy, internet_users, by=c("Country", "Year"))

#summarise
eiu_by_country <- energy_internet_users %>%
  group_by(Country) %>%
  summarise(mean_energy=mean(Energy_use), mean_iu=mean(Internet_users),
            median_energy=median(Energy_use), median_iu=median(Internet_users),
            n=n())
#Plot Energy vs Internet users
ggplot(aes(x=mean_energy, y=mean_iu), data=eiu_by_country) +
  geom_point() +
  xlim(0, 5.0e+08) +
  ylim(0, 4.5e+07)

ggplot(data=subset(energy_internet_users, energy_internet_users$Country=='France'),
       aes(Year, Energy_use)) +
  geom_line() +
  labs(title='France energy use')

#Plot Internet users France
p1 <-ggplot(data=subset(energy_internet_users, energy_internet_users$Country=='France'),
       aes(Year, Internet_users)) +
  geom_line(aes(colour='France')) +
  geom_line(aes(colour='Mean'),
            data=energy_internet_users, stat='summary', fun.y=mean) +
  geom_line(data=energy_internet_users,
            aes(colour='Quantile10'),
            stat='summary',
            fun.y=quantile, fun.args=list(probs=0.1), linetype=2) +
  geom_line(data=energy_internet_users,
            aes(colour='Quantile90'),
            stat='summary',
            fun.y=quantile, fun.args=list(probs=0.9), linetype=2) +
  labs(title='France internet users') +
  scale_colour_manual(name='Data', values=c(Quantile10='blue', Quantile90='blue', Mean='red', France='black'))

#Plot Energy Use France
p2 <- ggplot(data=subset(energy_internet_users, energy_internet_users$Country=='France'),
       aes(Year, Energy_use)) +
  geom_line(aes(colour='France')) +
  geom_line(aes(colour='Mean'),
            data=energy_internet_users, stat='summary', fun.y=mean) +
  geom_line(data=energy_internet_users,
            aes(colour='Quantile10'),
            stat='summary',
            fun.y=quantile, fun.args=list(probs=0.1), linetype=2) +
  geom_line(data=energy_internet_users,
            aes(colour='Quantile90'),
            stat='summary',
            fun.y=quantile, fun.args=list(probs=0.9), linetype=2) +
  labs(title='France Energy use') +
  scale_colour_manual(name='Data', values=c(Quantile10='blue', Quantile90='blue', Mean='red', France='black'))

grid.arrange(p1, p2, ncol=1)
