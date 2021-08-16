library(ggplot2)
mpg

# 1. 배경 설정
ggplot(data = mpg, aes(x = displ, y = hwy))

# 2. 그래프 설정
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3, 6)

ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  xlim(3, 6) + 
  ylim(10, 30)

# qplot() = matplotlib 전처리시 신속히 시각화할때

# ggplot() = seaborn 최종보고용 분석결과 이쁘게

# x축 cty, y축 hwy 산점도
ggplot(data = mpg, aes(x = cty, y = hwy)) + geom_point()

ggplot(data = midwest, aes(x = poptotal, y = popasian)) + 
  geom_point() + 
  ylim(0, 10000) +
  xlim(0, 500000)

## 집단간 평균 막대 그래프
df_mpg <- mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))

ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + 
  geom_col()

## histogram
ggplot(data = mpg, aes(x = drv)) + geom_bar()
ggplot(data = mpg, aes(x = hwy)) + geom_bar()

## 평균 막대 그래프 : 데이터를 요약한 표를 먼저 만들고 그래프 생성 geom_col()
## 빈도 막대 그래프 : 별도로 표를 만들지 않고 그래프 생성 geom_bar()

# Q1. suv 차종에서 어떤 회사가 도시 연비가 높은지 알아보자.상위 5개
suv_cty <- mpg %>%
  filter(class == 'suv') %>%
  group_by(manufacturer) %>%
  summarise(mean_cty = mean(cty)) %>%
  arrange(desc(mean_cty)) %>%
  head(5)
ggplot(data = suv_cty, aes(x = reorder(manufacturer, -mean_cty), y = mean_cty)) + 
  geom_col()

# Q2. 자동차종류(class) 빈도 그래프
ggplot(data = mpg, aes(x = class)) + 
  geom_bar()

# 선 그래프
# 시계열 데이터를 표현할때
economics
ggplot(data = economics, aes(x = date, y = unemploy)) + 
  geom_line()
str(economics)

# 개인 저축률(psavert) 데이터를 선그래프로 표현
ggplot(data = economics, aes(x = date, y = psavert)) +
  geom_line()

# 상자그림, boxplot
ggplot(data = mpg, aes(x = drv, y = hwy)) + 
  geom_boxplot()

# 차 종류가 compact, subcompact, suv인 도시연비 비교
class_mpg <- mpg %>%
  filter(class %in% c('compact','subcompact','suv'))

ggplot(data = class_mpg, aes(x = class, y = cty)) + 
  geom_boxplot()


## geom_point() : 산점도(분포, 방향성)
## geom_col() : 막대그래프 - 요약표
## geom_bar() : 막대그래프 - 원자료
## geom_line() :  선 그래프(시계열)
## geom_boxplot() : 상자 그림(데이터분포, 이상치, 편향)

### 지도 차트
install.packages('ggiraphExtra')
library(ggiraphExtra)
str(USArrests)
dim(USArrests)

library(tibble)
crime <- rownames_to_column(USArrests, var = 'state')
crime$state <- tolower(crime$state)

library(ggplot2)
install.packages('maps')
library(maps)
states_map <- map_data('state')
states_map
ggChoropleth(data = crime,         # 지도에 표현할 데이터
             aes(fill = Murder,    # 색으로 표현할 컬럼
                 map_id = state),  # 지역 기준 컬럼
             map = states_map)     # 지도 데이터

### 한국 시도별 인구, 결핵 환자 수 지도 그래프프
install.packages('stringi') # 문자열 처리 패키지
library(stringi)
install.packages('devtools')
library(devtools)

devtools::install_github('cardiomoon/kormaps2014')
library(kormaps2014)
###  한국행정지도 데이타
# 1. kormap1 : 2014년 한국행정지도(시도별)
# 2. kormap2 : 2014년 한국행정지도(시군구별)
# 3. kormap3 : 2014년 한국행정지도(읍면동별)

### 지역별 인구총조사데이타(2015)
# 1.korpop1 : 2015년 센서스데이터(시도별)
# 2.korpop2 : 2015년 센서스데이터(시군구별)
# 3.korpop3 : 2015년 센서스데이터(읍면동)

library(dplyr)
korpop1 <- rename(korpop1,
                  pop = 총인구_명,
                  name = 행정구역별_읍면동)
str(changeCode(korpop1))
library(ggiraphExtra)
ggChoropleth(data = korpop1,
             aes(fill = pop,
                 map_id = code,
                 tooltip = name),
             map = kormap1,
             interactive = T)

## 결핵 환자 수 단계 구분 지도
ggChoropleth(data = tbc,
             aes(fill = NewPts,
                 map_id = code,
                 tooltip = name),
             map = kormap1,
             interactive = T)
