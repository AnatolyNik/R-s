# обработка данны эксперимента
# загрузка библиотек 
library("ggplot2")  # графики

d_ <- read.csv("data.csv")
head(d_)
summary(d_)

t <- d_[2]
l <- d_[3]
l_curve <-  d_[3]

ggplot(data = d_, aes(x = t, y = l_curve))  + 
  geom_point() + 
  geom_smooth(se = TRUE)
#  geom_hline(yintercept = 0) +
#  stat_qq(aes(sample = .stdresid)) +
#  geom_errorbar(aes(ymin = lower, ymax = upper), width = 0.2)

ggplot(data = d_, aes(x = t, y = l_curve, color = l_curve))  + stat_identity() + 
  xlab("Время испытания, сек") +
  ylab("Значение, Ра") +
  scale_color_continuous("Значение") +
  ggtitle("Зависимость давления от времени") 

ggplot(data = d_, aes(x = t > 5, y = l_curve))  + 
  geom_boxplot() 


qplot(t, l_curve, data=d_, geom=c("point", "smooth"))
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"))