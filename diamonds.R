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

ggplot(aes(carat, price), data=subset(diamonds, diamonds$price <= 0.99*max(diamonds$price) & diamonds$carat <= 0.99*max(diamonds$carat)) +
         geom_point()

max(diamonds$price)


?geom_point()