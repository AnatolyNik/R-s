# Обработка данных эксперимента

# загрузка библиотек 
library("ggplot2")  # графики
#setwd("E:/GitHub/R/Curve") # рабочая директория

# чтение исходного файла
d <- read.csv("data.csv")
head(d)
summary(d)
tgc <- summarySE(d, measurevar="l_curve")

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

ggplot(data = d, aes(x=t, y=l_curve)) + 
  geom_errorbar(aes(ymin=l_curve-tgc$se, ymax=l_curve+tgc$se), width=.1) +
  geom_smooth(se = TRUE) +
  geom_line() +
  geom_point()


# http://www.cookbook-r.com/Manipulating_data/Summarizing_data/
## Summarizes data.
## Gives count, mean, standard deviation, standard error of the mean, and confidence interval (default 95%).
##   data: a data frame.
##   measurevar: the name of a column that contains the variable to be summariezed
##   groupvars: a vector containing names of columns that contain grouping variables
##   na.rm: a boolean that indicates whether to ignore NA's
##   conf.interval: the percent range of the confidence interval (default is 95%)
summarySE <- function(data=NULL, measurevar, groupvars=NULL, na.rm=FALSE,
                      conf.interval=.95, .drop=TRUE) {
  library(plyr)
  
  # New version of length which can handle NA's: if na.rm==T, don't count them
  length2 <- function (x, na.rm=FALSE) {
    if (na.rm) sum(!is.na(x))
    else       length(x)
  }
  
  # This does the summary. For each group's data frame, return a vector with
  # N, mean, and sd
  datac <- ddply(data, groupvars, .drop=.drop,
                 .fun = function(xx, col) {
                   c(N    = length2(xx[[col]], na.rm=na.rm),
                     mean = mean   (xx[[col]], na.rm=na.rm),
                     sd   = sd     (xx[[col]], na.rm=na.rm)
                   )
                 },
                 measurevar
  )
  
  # Rename the "mean" column    
  datac <- rename(datac, c("mean" = measurevar))
  
  datac$se <- datac$sd / sqrt(datac$N)  # Calculate standard error of the mean
  
  # Confidence interval multiplier for standard error
  # Calculate t-statistic for confidence interval: 
  # e.g., if conf.interval is .95, use .975 (above/below), and use df=N-1
  ciMult <- qt(conf.interval/2 + .5, datac$N-1)
  datac$ci <- datac$se * ciMult
  
  return(datac)
}
