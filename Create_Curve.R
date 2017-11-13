# Cоздание примера кривой
#setwd("E:/GitHub/R/Curve") # рабочая директория

# создание базовой кривой
t <- seq(from = 1 , to = 10, by = 0.05 )
l <- log2(t)
plot(t,l,type = "l")

# введение помехи с нормальным распределением и дисперсией 1/25 от текущего значения
l_curve <-  rnorm(t, mean = l, sd = l/25)
plot(t,l_curve,type = "l")

# запись файла
d <- data.frame(t, l, l_curve)
write.csv(d, file = "data.csv")