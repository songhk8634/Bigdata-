install.packages('dplyr')
library(dplyr)
library(ggplot2)
data(mpg)
mpg <- as.data.frame(ggplot2::mpg)
head(mpg)
summary(mpg)

df_raw <- data.frame(var1 = c(1, 2, 1), var2 = c(2, 3, 2))
df_raw
df_new <- df_raw

df_new <- rename(df_new, v2 = var2)
df_new

# Q1. mpg data를 불러와서 복사
mpg <- as.data.frame(ggplot2::mpg)
mpg_new <- mpg
mpg_new
# Q2. 복사한 데이터 프레임의 cty컬럼을 city, hwy 컬럼을 highway 로 변경
mpg_new <- rename(mpg_new, city = cty, highway = hwy)

# Q3. 데이터 일부를 출력
head(mpg_new)


## 파생변수
df <- data.frame(var1 = c(4, 3, 8), var2 = c(2, 6, 1))
df

df$var_sum <- df$var1 + df$var2
df

df$var_mean <- (df$var1 + df$var2) / 2
df

mpg$total <- (mpg$cty + mpg$hwy) / 2
head(mpg)
summary(mpg$total)
hist(mpg$total)


## 조건문 사용
ifelse(mpg$total >= 20, "pass",'fail')
mpg$test <- ifelse(mpg$total >= 20, 'pass', 'fail')

## 빈도 구하기
table(mpg$test)
qplot(mpg$test)

# A등급 : 30이상 B등급 : 20~29 C등급 : 20미만
mpg$grade <- ifelse(mpg$total >=30, 'A', 
                    ifelse(mpg$total >= 20, 'B','C'))
head(mpg)
table(mpg$grade)
qplot(mpg$grade)

mpg$grade2 <- ifelse(mpg$total >= 30, 'A',
                     ifelse(mpg$total >= 25, 'B',
                            ifelse(mpg$total >= 20, 'C', 'D')))
qplot(mpg$grade2)

## 정리
# 1. 데이터준비, 패키지준비
mpg <- as.data.frame(ggplot2::mpg) # data
library(dplyr)
library(ggplot2)

# 2. 데이터 파악(탐색)
head(mpg)
tail(mpg)
View(mpg)
dim(mpg)
str(mpg)
summary(mpg)

# 3. 컬럼명 수정
mpg <- rename(mpg, city = cty)

# 4. 파생변수 생성
mpg$total <- (mpg$city + mpg$hwy) /2
mpg$test <- ifelse(mpg$total >= 20, 'pass', 'fail')

# 5. 빈도 확인
table(mpg$test)
qplot(mpg$test)


### 분석도전
# 1.
library(ggplot2)
midwest <- as.data.frame(ggplot2::midwest)
midwest
head(midwest)
str(midwest)
dim(midwest)

# 2.
midwest <- rename(midwest, total = poptotal, asian = popasian)

# 3.
midwest$asian_100 <- (midwest$asian / midwest$total) * 100
hist(midwest$asian_100)
midwest$asian_100

# 4.
mean(midwest$asian_100)
midwest$asian_test <- ifelse(midwest$asian_100 > mean(midwest$asian_100), 'large', 'small')

# 5.
table(midwest$asian_test)
qplot(midwest$asian_test)
                             