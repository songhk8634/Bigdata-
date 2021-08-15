## mpg 데이터를 이용한 기술 통계 함수 사용
library(ggplot2)
mpg <- as.data.frame(ggplot2::mpg)
head(mpg)

summary(mpg)
str(mpg)
dim(mpg)
summary(mpg)
boxplot(mpg$hwy)
