### 결측치 정제 작업
# 결측치 만들기
df <- data.frame(sex = c('M', 'F', NA, 'M', 'F'),
                 score = c(5, 4, 3, 4, NA))
df

# 결측치 확인
is.na(df)
table(is.na(df))

table(is.na(df$sex))

mean(df$score)
sum(df$score)

## 결측치 행 제거
library(dplyr)
# 1
df %>% 
  filter(is.na(score) == FALSE) %>%
  filter(is.na(sex) == FALSE)
# 2
df %>%
  filter(!is.na(score)) %>%
  filter(!is.na(sex))
# 3
df %>%
  filter(!is.na(score) & !is.na(sex))

df_nomiss2 <- na.omit(df) # 모든 컬럼에 결측치 없는 데이터 추출
df_nomiss2

mean(df$score, na.rm = TRUE) # 결측치 제외하고 계산 (임시)

exam <- read.csv('./data/csv_exam.csv')
exam[c(3, 8, 15), 'math'] <- NA
exam %>%
  summarise(mean_math = mean(math, na.rm = T))

exam %>%
  summarise(mean_math = mean(math, na.rm = T),
            sum_math = sum(math, na.rm = T),
            median_math = median(math, na.rm = T))

# 결측치 대체법
# 대표값 (평균, 최빈값, 중앙값, 강중평균...)
# 통계분석 기법 적용, 예측값 추정해서 대체

# 평균 결측치 제거
mean(exam$math, na.rm = T)
exam$math <- ifelse(is.na(exam$math), 55.23529, exam$math)
mean(exam$math)


mpg <- as.data.frame(ggplot2::mpg)
mpg[c(65, 124, 131, 153, 212), 'hwy'] <- NA

# Q1. drv별로 hwy 평균이 어떻게 다른지 확인

# 결측치 있는지 확인
table(is.na(mpg$drv))
table(is.na(mpg$hwy))

# drv별로 hwy 평균 확인
# 방법1
mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy, na.rm = T))
# 방법2
mpg %>%
  filter(!is.na(hwy)) %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))


### 이상치 처리
outlier <- data.frame(sex = c(1, 2, 1, 3, 2, 1),
                      score = c(5, 4, 3, 4, 2, 6))

# 이상치 확인
table(outlier$sex)
table(outlier$score)

# 이상치 제거
outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)
outlier

# 이상치 제거 score 1~5범위가 아닌 값
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)
outlier

## 남여별 score 평균 구하기
outlier %>%
  filter(!is.na(sex) & !is.na(score)) %>%
  group_by(sex) %>%
  summarise(mean_score = mean(score))
   
boxplot(mpg$hwy)$stats

# 통계적 기준의 이상치 처리
mpg$hwy <- ifelse(mpg$hwy <12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg$hwy))

mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy, na.rm=T))

mpg <- as.data.frame(ggplot2::mpg)
mpg[c(10, 14, 58, 93), 'drv'] <- 'k'
mpg[c(29, 43, 129, 203), 'cty'] <- c(3, 4, 39, 42)

# Q1. drv에 이상치 확인 %in% 함수 사용, 이상치 처리
table(mpg$drv)
mpg$drv <- ifelse(mpg$drv %in% c('4', 'f', 'r'), mpg$drv, NA)


# Q2. boxplot 이용해서 cty 이상치 확인, 이상치 처리
boxplot(mpg$cty)$stats
mpg$cty <- ifelse(mpg$cty < 9 | mpg$cty > 26, NA, mpg$cty)
boxplot(mpg$cty)

# Q3. drv별 cty 평균 구하기
mpg %>%
  filter(!is.na(drv) & !is.na(cty)) %>%
  group_by(drv) %>%
  summarise(mean_cty = mean(cty))


###### 정리
### 1. 결측치 정제
# 결측치 확인
table(is.na(df$score))

# 결측치 제거
df_nomiss <- df %>%
  filter(!is.na(score))

# 여러 변수 동시에 결측치 제거
df_nomiss <- df %>%
  filter(!is.na(score) & !is.na(sex))

# 함수의 결측치 제외 기능
mean(df$score, na.rm=T)
sum(df$score, na.rm=T)

exam %>%
  summarise(mean_math = mean(math, na.rm=T))

### 2. 이상치 정제
# 이상치 확인
table(outlier$sex)

# 이상치 처리
outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)

# 통계적 이상치 확인
boxplot(mpg$hwy)$stats

# 통계적 이상치 처리
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
