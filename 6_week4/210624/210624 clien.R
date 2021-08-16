# 크롤링 작업
# 1. 제목, 조회수, 게시글 URL 수집
# 2. 게시글 내용 수집

# 1. 게시판 목록에서 제목, 글 url파싱 작업
url <- 'https://www.clien.net/service/group/community?&od=T31&category=0&po=0'
b <- readLines(url, encoding = 'UTF-8')
head(b,20)

# 제목
library(stringr)
title <- gsub('\t', '', b[which(str_detect(b, 'subject_fixed')) + 1])
title

# url
title_index <- which(str_detect(b, 'subject_fixed')) - 3
ul <- b[title_index]
ul2 <- str_extract(ul, "(?<=href).*(?=data)")
str_sub(ul2, 4,-3)
url_list <- paste0('https://www.clien.net/',str_sub(ul2, 4, -3))

page_data <- cbind(title, url_list)
page_data[c(1:4),]
dim(page_data)

# 페이지별 url 생성
for(i in 1:10){
  url <- paste0('https://www.clien.net/service/group/community?&od=T31&category=0&po=',i-1)
  print(url)
}

# 게시글 목록 수집 최종 소스 정리
library(stringr)
final <- NULL
for(i in 1:5){
  url <- paste0('https://www.clien.net/service/group/community?&od=T31&category=0&po=',i-1)
  b <- readLines(url, encoding = 'UTF-8')
  title <- gsub('\t', '', b[which(str_detect(b, 'subject_fixed')) + 1])
  ul <- b[which(str_detect(b, 'subject_fixed'))-3]
  ul2 <- str_extract(ul, "(?<=href).*(?=data)")
  url_list <- paste0('https://www.clien.net/',str_sub(ul2, 3, -3))
  page_data <- cbind(title, url_list)
  final <- rbind(final, page_data)
}
dim(final)
final
write.csv(final, 'pagedata.csv', row.names=F)

### 2. 게시글 내용 가져오기 작업
data <- read.csv('pagedata.csv')
data
url_list <- as.character(data[, 2])
head(url_list)
b <- readLines(url_list[1], encoding = 'UTF-8')
head(b, 50)
which(str_detect(b, '<body>'))
which(str_detect(b, '</body>'))

which(str_detect(b, 'post_content'))
which(str_detect(b, 'post_ccls'))

index1 <- which(str_detect(b, 'post_content'))
index2 <- which(str_detect(b, 'post_ccls'))
b[index1:index2]
paste(b[index1:index2], collapse = ' ')

con3 <- str_trim(gsub('<.*?>|/t', '', paste(b[index1:index2], collapse = ' ')))

url_list <- as.character(data[, 2])
final_con <- c()
for(i in 1:length(url_list)){
  b <- readLines(url_list[i], encoding = 'UTF-8')
  index1 <- which(str_detect(b, 'post_content'))
  index2 <- which(str_detect(b, 'post_ccls'))
  con3 <- str_trim(gsub('<.*?>|/t', '', paste(b[index1:index2], collapse = ' ')))
  final_con[i] = con3 
  Sys.sleep(1)
  
}
clien <- cbind(final, final_con)

write.csv(clien, 'clien.csv', row.names=F)

