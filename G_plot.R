# Обработка данных эксперимента

# загрузка библиотек 
library("ggplot2")  # графики
#setwd("E:/GitHub/R/Curve") # рабочая директория

# чтение исходного файла
d <- read.csv("data.csv")
head(d)
summary(d)

t <- d$t
l <- d$l
l_curve <-  d$l_curve

ggplot(data = d, aes(x = t, y = l_curve, color = l_curve))  + stat_identity() + 
  xlab("Время испытания, сек") +
  ylab("Значение, Ра") +
  scale_color_continuous("Значение") +
  ggtitle("Зависимость давления от времени") 

ggplot(data = d, aes(x = t, y = l_curve))  + 
  geom_point() + 
  geom_smooth(se = TRUE)
#  geom_hline(yintercept = 0) +
#  stat_qq(aes(sample = .stdresid)) +
#  geom_errorbar(aes(ymin = lower, ymax = upper), width = 0.2)

ggplot(data = d, aes(x = t > 5, y = l_curve))  + 
  geom_boxplot() 

# примеры на встроенном датасете
#qplot(t, l_curve, data=d, geom=c("point", "smooth"))
#qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"))