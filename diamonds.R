library(ggplot2)
data("diamonds")
names(diamonds)
ggplot(aes(x, price), data=diamonds) +
  xlim(3,9) +
  geom_jitter(alpha=0.1) +
  scale_y_sqrt()

with(diamonds, cor(x, price))
with(diamonds, cor(y, price))
with(diamonds, cor(z, price))

ggplot(aes(x = depth, y = price),data=diamonds) + 
  geom_point(alpha=0.01) +
  scale_x_continuous(breaks=seq(56,66,2), limits=c(56,66))

with(diamonds, cor(depth, price))


ggplot(aes(carat, price), data=diamonds) + 
  geom_point(alpha=0.01) +
  geom_line(stat='summary', fun.y=quantile, fun.args=list(probs=0.99)) +
  labs(title='Price vs carat and 0.99 quantile line')

diamonds$volume <- diamonds$x * diamonds$y * diamonds$z
ggplot(aes(volume, price), data=diamonds) + 
  geom_point() +
  labs(title='Prive vs Volume')

library(plyr)
count(diamonds$volume == 0)
detach("package:plyr", unload=TRUE)  

round(with(subset(diamonds, diamonds$volume <= 800 & diamonds$volume != 0), cor(price, volume)), 2)

ggplot(aes(volume, price), data=subset(diamonds, diamonds$volume <= 800 & diamonds$volume != 0)) + 
  geom_point(alpha=0.01) +
  labs(title='Prive vs Volume') +
  geom_smooth(method='lm') +
  ylim(0,2000)

?geom_smooth

library(dplyr)

diamondsByClarity <- diamonds %>%
  group_by(clarity) %>%
  summarise(mean_price=mean(price),
            median_price=median(price),
            min_price=min(price),
            max_price=max(price),
            n=n())


diamonds_by_clarity <- group_by(diamonds, clarity)
diamonds_mp_by_clarity <- summarise(diamonds_by_clarity, mean_price = mean(price))

diamonds_by_color <- group_by(diamonds, color)
diamonds_mp_by_color <- summarise(diamonds_by_color, mean_price = mean(price))

library(gridExtra)
diamonds_mp_by_color$color <- factor(diamonds_mp_by_color$color,
                                     levels=c('J', 'I', 'H', 'G', 'F', 'E', 'D'))
p1 <- ggplot(diamonds_mp_by_color, aes(x=color, y=mean_price)) + geom_bar(stat='sum')
p2 <- ggplot(diamonds_mp_by_clarity, aes(x=clarity, y=mean_price)) + geom_bar(stat='sum')
grid.arrange(p1, p2, ncol=1)


##Lesson 8 Problem set: Explore many variables
ggplot(data=diamonds,aes(price)) +
  geom_histogram(aes(fill=cut)) +
  facet_wrap(~color) +
  scale_x_log10() +
  scale_fill_brewer(type='qual')

ggplot(data=diamonds, aes(x=table, y=price)) +
  geom_point(aes(color=cut)) +
  scale_x_continuous(breaks=seq(50,80,2), limits=c(50,80)) +
  scale_color_brewer(type='qual')


ggplot(data=subset(diamonds, diamonds$x*y*z < quantile(diamonds$x*y*z, 0.99)),
       aes(x=x*y*z, y=price)) +
  geom_point(aes(color=clarity)) +
  scale_y_log10() +
  scale_color_brewer(type='div')

ggplot(data=diamonds, aes(x=cut, y=price/carat)) +
  geom_jitter(aes(color=color)) +
  facet_wrap(~clarity) +
  scale_color_brewer(type = 'div')


