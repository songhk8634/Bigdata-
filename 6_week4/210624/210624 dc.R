library(stringr)
url <- 'https://gall.dcinside.com/board/lists/?id=superidea&page=1'
b <- readLines(url, encoding = 'UTF-8')
index <- which(str_detect(b, 'gall_tit ub-word'))
b2 <- b[index+1]
b2
title <- str_trim(str_extract(b2, ("(?<=</strong>).*(?=</a>)")))
title

str_extract(b2, ("(?<=  a  ).*(?=   b )"))  ## a와 b사이에 있는 문자열

con_url <- str_sub(str_extract(b2, ("(?<=href).*(?=view)")), 3, end = -3)
con_url2 <- paste0('https://gall.dcinside.com',con_url)

data <- cbind(title, con_url2)
data

## 최종버전 소스 원하는 페이지까지 글제목, 글URL, 조회수
url <- 'https://gall.dcinside.com/board/lists/?id=superidea&page=1'
b2

dc_list_data <- NULL
for(i in 1:5){
  url <- paste0('https://gall.dcinside.com/board/lists/?id=superidea&page=',i)
  b <- readLines(url, encoding = 'UTF-8')
  index <- which(str_detect(b, 'gall_tit ub-word'))
  b2 <- b[index+1]
  title <- str_trim(str_extract(b2, ("(?<=</strong>).*(?=</a>)")))
  con_url <- str_sub(str_extract(b2, ("(?<=href).*(?=view)")), 3, end = -3)
  con_url2 <- paste0('https://gall.dcinside.com',con_url)
  
  nickname <- str_extract(b[which(str_detect(b, 'nickname'))], ('(?<=<em>).*(?=</em>)'))
  count <- gsub('<.*?>|\t', '', b[which(str_detect(b, 'gall_count'))])
  recommend <- gsub('<.*?>|\t', '', b[which(str_detect(b, 'gall_recommend'))])
  
  pagedata <- cbind(title[-1], con_url2[-1], nickname, count[-1], recommend[-1])
  dc_list_data <- rbind(dc_list_data, pagedata)
}
dc_list_data
write.csv(dc_list_data, 'dc.csv', row.names=F)


