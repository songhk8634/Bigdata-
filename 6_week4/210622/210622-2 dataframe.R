## 조건에 맞는 데이터만 추출하기
library(dplyr)
exam <- read.csv('./data/csv_exam.csv')
head(exam)
dim(exam)

exam %>% filter(class==1)
filter(exam, class==1)

exam %>% filter(math > 50 & class == 1)
filter(exam, math > 50 & class == 1)

exam %>% filter(class == 1 | class == 3 | class == 5)
exam %>% filter(class %in% c(1,3,5))
class1 <- exam %>% filter(class == 1)
class1


## 혼자서 해보기
mpg <- as.data.frame(ggplot2::mpg)

# Q1.
head(mpg)
displ4 <- mpg %>% filter(displ <= 4)
displ5 <- mpg %>% filter(displ >= 5)

mean(displ4$hwy)
mean(displ5$hwy)

# Q2.
head(mpg)
audi <- mpg %>% filter(manufacturer == 'audi')
toyota <- mpg %>% filter(manufacturer == 'toyota')

mean(audi$cty)
mean(toyota$cty)

# Q3.
chevrolet <- mpg %>% filter(manufacturer == 'chevrolet')
ford <- mpg %>% filter(manufacturer == 'ford')
honda <- mpg %>% filter(manufacturer == 'honda')
mean(chevrolet$hwy)
mean(ford$hwy)
mean(honda$hwy)

new <- mpg %>% filter(manufacturer %in% c('chevrolet','ford','honda'))
mean(new$hwy)


### 필요한 컬럼만 추출

exam %>% select(math)
select(exam, math)
exam %>% select(-math)
select(exam, -math)
exam %>% select(math,english)
select(exam,math,english)

## filter, select 조합

exam %>% 
  filter(class==1) %>% 
  select(math)

exam %>%
  select(id, math) %>%
  head


# Q1. 컬럼 선택 (cty, class)
mpg <- as.data.frame(ggplot2::mpg)
df <- mpg %>% select(class, cty)
head(df, 3)

# Q2. 
df_suv <- df %>% filter(class == 'suv')
df_compact <- df %>% filter(class == 'compact')

mean(df_suv$cty)
mean(df_compact$cty)


### 정렬하기
exam %>% 
  arrange(math) %>% 
  head

exam %>% 
  arrange(desc(math)) %>% 
  head

exam %>%
  arrange(class, math) %>%
  head

exam %>% 
  arrange(math, class) %>%
  head


##
mpg <- as.data.frame(ggplot2::mpg)
head(mpg)
audi <- mpg %>% 
  filter(manufacturer == 'audi')
audi %>% 
  arrange(desc(hwy)) %>% 
  head(5)

mpg %>%
  filter(manufacturer == 'audi') %>%
  arrange(desc(hwy)) %>%
  head(5)

exam %>% 
  mutate(total = math + english + science) %>%
  head
exam %>%
  mutate(total = math + english + science,
         mean = (math + english + science) / 3) %>%
  head(3)
exam %>%
  mutate(total = math + english + science,
         mean = (math + english + science) / 3,
         test = ifelse(science >= 60, 'pass','fail')) %>%
  arrange(desc(total)) %>%
  head(3)


### 혼자 해보기

# Q1.
mpg <- as.data.frame(ggplot2::mpg)
mpg2 <- mpg
mpg2$sum <- mpg2$cty + mpg2$hwy

# Q2.
mpg2$mean <- mpg2$sum / 2

# Q3.
mpg2 %>%
  arrange(desc(mean)) %>%
  head(3)

# Q4.
mpg %>%
  mutate(sum = cty + hwy,
         mean = sum / 2) %>%
  arrange(desc(mean)) %>%
  head(3)


### 집단별로 요약하기
exam %>% 
  summarise(mean(math))

exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math))
exam %>%
  group_by(class) %>%
  summarise(mean_math = mean(math),
            sum_math = sum(math),
            median_math = median(math),
            min_math = min(math),
            max_math = max(math),
            sd_math = sd(math),
            n = n())

mpg %>%
  group_by(manufacturer, drv) %>%
  summarise(mean_cty = mean(cty)) %>%
  arrange(desc(mean_cty)) %>%
  head

head(mpg)

mpg %>%
  group_by(manufacturer) %>%
  filter(class == 'suv') %>%
  mutate(sum = cty + hwy) %>%
  summarise(mean = mean(sum)) %>%
  arrange(desc(mean)) %>%
  head(5)


#### 혼자서 해보기

# Q1. subcompact, compact 자동차 차종의 연비 비교
mpg %>%
  group_by(class) %>%
  summarise(mean_cty = mean(cty))

# Q2. 알파벳순 정렬, 도시 연비가 높은 순서
mpg %>%
  group_by(class) %>%
  summarise(mean_cty = mean(cty)) %>%
  arrange(desc(mean_cty))

# Q3. 고속도로연비 가장 높은 회사
mpg %>%
  group_by(manufacturer) %>%
  summarise(mean_hwy = mean(hwy)) %>%
  arrange(desc(mean_hwy))

# Q4. 경차 차종을 가장 많이 생산하는 회사
mpg %>%
  filter(class == 'compact') %>%
  group_by(manufacturer) %>%
  summarise(count = n()) %>%
  arrange(desc(count))


### dataframe 합치기
test1 <- data.frame(id = c(1,2,3,4,5),
                    midterm = c(60, 80, 70, 90, 85))
test1

test2 <- data.frame(id = c(1,2,3,4,5),
                    final = c(70, 83, 65, 95, 80))
test2

# id 기준으로 합치기
total <- left_join(test1, test2, by = 'id')
total

# 담임선생님
name <- data.frame(class = c(1, 2, 3, 4, 5),
                   teacher = c('kim', 'lee', 'park', 'choi', 'jung'))
exam_new <- left_join(exam, name, by = 'class')
exam_new

### 세로 합치기
# 학생 1~5번 시험 데이터
group_a <- data.frame(id = c(1, 2, 3, 4, 5),
                      test = c(60, 80, 70, 90, 85))
# 학생 6~10번 시험 데이터
group_b <- data.frame(id = c(6, 7, 8, 9, 10),
                      test = c(70, 83, 65, 95, 80))

group_all <- bind_rows(group_a, group_b)
group_all


### 혼자서 해보기
# mpg 데이터에 연료 가격 합치기
mpg <- as.data.frame(ggplot2::mpg)

fuel <- data.frame(fl = c('c','d','e','p','r'),
                   price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
                   stringsAsFactors = F)
fuel
mpg_new <- left_join(mpg,fuel,by = 'fl')
head(mpg_new,3)

mpg_new %>%
  select(model, fl, price_fl) %>%
  head(3)

## 정리 
# 1. 조건에 맞는 데이터 row 만 추출
exam %>% filter(english >= 80)
exam %>% filter(english >= 80 & math >= 50)
exam %>% filter(english >= 80 | math >= 50)
exam %>% filter(english %in% c(60, 70, 80))

# 2. 필요한 컬럼만 추출
exam %>% select(math)
exam %>% select(math, english)

# 3. 함수 조합하기, 일부만 출력
exam %>% select(id, math) %>% head(3)

# 4. 순서대로 정렬
exam %>% arrange(math) # 오름차순
exam %>% arrange(desc(math)) # 내림차순

# 5. 파생변수 추가하기
exam %>% mutate(total = math + english + science)
exam %>% mutate(test = ifelse(science >= 60, 'pass','fail'))

# 6. 집단별 요약
exam %>%
  group_by(class) %>%
  summarise(mean_math = mean(math))

# 7. 데이터 프레임 합치기
# 가로로 합치기 
total <- left_join(test1, test2, by = 'id')
# 세로로 합치기
group_all <- bind_rows(group_a, group_b)


### 분석 도전
midwest <- as.data.frame(ggplot2::midwest)

# Q1.
midwest$teen100 <- 100 - ((midwest$popadults / midwest$poptotal) * 100)
midwest$teen100

# Q2.
midwest %>%
  arrange(desc(teen100)) %>%
  select(county, teen100) %>%
  head(5)

# Q3.
midwest_new <- midwest %>%
  mutate(grade = ifelse(teen100 >= 40, 'large',
                        ifelse(teen100 >= 30, 'middle', 'small')))
midwest_new %>%
  group_by(grade) %>%
  summarise(count = n())

# Q4.
midwest$asian100 <- (midwest$popasian / midwest$poptotal) * 100

midwest %>%
  arrange(asian100) %>%
  head(10) %>%
  select(state, county, asian100)
