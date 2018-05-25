setwd("C:\\Users\\thb0f6\\Documents\\Digitalization\\DAND\\7.EDA_with_R\\eda-course-materials\\lesson2")
reddit <- read.csv('reddit.csv')
str(reddit)
table(reddit$employment.status)
summary(reddit)
levels(reddit$age.range)

library(ggplot2)

?qplot
qplot(data = reddit, x=relevel(age.range, 'Under 18'))

reddit$income.range <- factor(reddit$income.range, levels=c('Under $20,000','$20,000-$29,999','$30,000-39,999',
                                                             '$40,000-$49,999','$50,000-$69,999','$70,000-$99,999',
                                                             '$100,000-$149,999','$150,000 or more', 'NA'))
qplot(data = reddit, x=income.range)
