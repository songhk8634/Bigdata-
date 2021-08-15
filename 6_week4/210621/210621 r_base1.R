a = 1
b <- 2
4 -> c
# 연산자
a + b
a - b
a * b
a / b
a %% b

# 여러 데이터로 구성된 변수 선언
var <- c(1,2,3,4,5)
var
var1 <- c(1:5) # 연속된 값을 선언하고자 할땐 :를 이용한다.
var1
var2 <- seq(1,5) # python의 range 함수와 같음
var2
var3 <- seq(1,10,2)
var3

var
var + 2
var + var2

# 문자열
str <- 'a'
str
str2 <- 'text'
str2
str3 <- c('a','b','c')
str3
str4 <- c('Hello', 'World', 'is', 'Good')
str4

# 함수 적용
x <- c(1,2,3)
mean(x)
max(x)
min(x)
sd(x)
var(x)

str4
paste(str4, collapse = ',')
paste(str4, collapse = ' ')

x_mean <- mean(x)
x_mean

str5_paste <- paste(str4, collapse = ' ')
str5_paste

# 패키지 설치
# 패키지 로드
# 함수 사용
# ggplot2 패키지 사용 예시
install.packages('ggplot2')
library(ggplot2)

x <- c('a', 'b', 'c', 'd', 'a', 'd')
x
qplot(x)

# Q1. 다섯 명의 학생이 시험을 봤다. 시험 점수를 담을 변수 선언
# 80, 60, 70, 50, 90
score <- c(80, 60, 70, 50, 90)
# Q2. 전체 평균을 구하여 출력하시오.
mean(score)
# Q3. 전체 평균을 담을 변수를 선언하고 변수를 출력하시오.
aver <- mean(score)
print(aver)

# DataFrame
english <- c(90, 80, 60, 70)
english
math <- c(50, 60, 100, 20)
math

df_midterm <- data.frame(english, math)
df_midterm

class <- c(1, 1, 2, 2)
class
df_midterm <- data.frame(english, math, class)
df_midterm

mean(df_midterm$english)
mean(df_midterm$math)

df_midterm <- data.frame(english = c(90, 80),
                         math = c(50, 60),
                         class = c(1, 2))
df_midterm


# Q1. data.frame()과 c()를 조합해서 데이터프레임 만들기
df_fruit <- data.frame(제품 = c('사과', '딸기', '수박'),
                         가격 = c(1800, 1500, 3000),
                         판매량 = c(24, 38, 13))

df_fruit
# Q2. 앞에서 만든 데이터프레임에서 과일 가격 평균, 판매량 평균을 구하시오.
mean(df_fruit$가격)
mean(df_fruit$판매량)

# 외부 데이터 이용
install.packages('readxl')
library(readxl)
df_exam <- read_excel('./data/excel_exam.xlsx')
df_exam
mean(df_exam$english)
mean(df_exam$science)

df_exam <- read_excel('C:\\Users\\admin\\Documents\\R\\r-base\\Data\\excel_exam.xlsx')
df_exam

# excel 파일 첫번째 행이 컬럼명이 아닐경우
df_exam_novar <- read_excel('./data/excel_exam_novar.xlsx', col_names = FALSE)
df_exam_novar

# excel 파일에 시트가 여러개 있는 경우
df_exam_sheet <- read_excel('./data/excel_exam_sheet.xlsx', sheet = 3)
df_exam_sheet

# CSV 파일 읽어오기
df_csv_exam <- read.csv('./data/csv_exam.csv')
df_csv_exam

# 문자가 들어있는 파일을 불러 올때는 stringAsFactors = F
df_csv_exam <- read.csv('./data/csv_exam.csv', stringAsFactors = F)
df_csv_exam

write.csv(df_midterm, file = './data/df_midterm.csv')


# Rdata 파일 활용
save(df_midterm, file = './data/df_midterm.rda')
rm(df_midterm)
load('./data/df_midterm.rda')
df_midterm


exam <- read.csv('./data/csv_exam.csv')
head(exam)
head(exam, 3)
View(exam)
dim(exam)
str(exam)
summary(exam)

