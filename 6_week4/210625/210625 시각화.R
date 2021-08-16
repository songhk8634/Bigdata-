rm(list = ls())
data_cust = read.csv('./data/data_cust_1_1.csv', header=T)

## 연령대 별로 사기자 수가 달라지지 않을까? (AGE)
(count_by_age_gen <- table(subset(data_cust, select = AGE, 
                                 subset = (data_cust$SIU_CUST_YN == 1))))
names(count_by_age_gen) <- c('0대', '10대', '20대', '30대', '40대',
                             '50대', '60대', '70대대')
barplot(count_by_age_gen, main = '연령대별 사기자 수')

## 성별 별로 사기자 수가 달라지지 않을까? (SEX)
(count_by_sex <- table(subset(data_cust, select = SEX,
                              subset = (data_cust$SIU_CUST_YN == 1))))
names(count_by_sex) <- c('남성', '여성')
pie(count_by_sex,
    cex = 0.8,
    main = '성별에 따른 사기자 수',
    labels = paste(names(count_by_sex), '\n',
                   count_by_sex, '명', '\n',
                   round(count_by_sex/sum(count_by_sex)*100), '%'))

## 결혼 여부 별로 사기자 수가 달라지지 않을까? (WEDD_YN)
(count_by_WEDD <- table(subset(data_cust, select = WEDD_YN,
                               subset = (data_cust$SIU_CUST_YN == 1))))
names(count_by_WEDD) <- c('미혼', '기혼')
pie(count_by_WEDD,
    cex = 0.8,
    main = '결혼여부에 따른 사기자 수',
    labels = paste(names(count_by_WEDD), '\n',
                   count_by_WEDD, '명', '\n',
                   round(count_by_WEDD/sum(count_by_WEDD)*100), '%'))

## FP 경력 여부 별로 사기자 수가 달라지지 않을까? (FP_CAREER)
(count_by_FP <- table(subset(data_cust, select = FP_CAREER,
                             subset = (data_cust$SIU_CUST_YN == 1))))
names(count_by_FP) <- c('없음', '있음')
pie(count_by_FP,
    cex = 0.8,
    main = 'FP 경력여부에 따른 사기자 수',
    labels = paste(names(count_by_FP), '\n',
                   count_by_FP, '명', '\n',
                   round(count_by_FP/sum(count_by_FP)*100), '%'))

## 거주지 별로 사기자 수가 달라지지 않을까? (RESI_TYPE_CODE)
(count_by_ctpr <- table(subset(data_cust, select = CTPR,
                               subset = (data_cust$SIU_CUST_YN == 1))))
names(count_by_ctpr) <- c('기타', '서울', '부산', '대구', '인천', '광주',
                          '대전', '울산', '세종', '경기', '강원', '충북',
                          '충남', '전북', '전남', '경북', '경남')
barplot(count_by_ctpr, main = '거주지별 사기자 수')
pie(count_by_ctpr,
    cex = 0.8,
    main = '거주지별 사기자 수',
    labels = paste(names(count_by_ctpr), '\n',
                   count_by_ctpr, '명', '\n',
                   round(count_by_ctpr/sum(count_by_ctpr)*100), '%'))

## 본인 직업 별로 사기자 수가 달라지지 않을까? (OCCP_GRP_1)
# 1 주부 2 자영업 3 사무직 4 전문직 5 서비스 6 제조업 7 1차산업 8 기타
(count_by_occp <- table(subset(data_cust, select = OCCP_GRP_1,
                               subset = (data_cust$SIU_CUST_YN == 1))))
names(count_by_occp) <- c('무직', '주부', '자영업', '사무직', '전문직',
                          '서비스', '제조업', '1차산업', '기타')
pie(count_by_occp,
    cex = 0.8,
    main = '직업에 따른 사기자 수',
    labels = paste(names(count_by_occp), '\n',
                   count_by_occp, '명', '\n',
                   round(count_by_occp/sum(count_by_occp)*100), '%'))

## 배우자 직업 별로 사기자 수가 달라지지 않을까? (MATE_OCCP_GRP_1)
(count_by_mateoccp <- table(subset(data_cust, select = MATE_OCCP_GRP_1,
                               subset = (data_cust$SIU_CUST_YN == 1))))
names(count_by_mateoccp) <- c('무직', '주부', '자영업', '사무직', '전문직',
                          '서비스', '제조업', '1차산업', '기타')
pie(count_by_mateoccp,
    cex = 0.8,
    main = '배우자 직업에 따른 사기자 수',
    labels = paste(names(count_by_mateoccp), '\n',
                   count_by_mateoccp, '명', '\n',
                   round(count_by_mateoccp/sum(count_by_mateoccp)*100), '%'))

## 소득이 0인 사람의 데이터를 직업별 평균 (CUST_INCM)

table(subset(data_cust, select = OCCP_GRP_1,
             subset = (data_cust$CUST_INCM == 0)))
