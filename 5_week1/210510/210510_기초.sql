SELECT * FROM TAB;
--------------------------------------------------------------
-- 관심 있는 데이터의 모음(TABLE)을 조회

SELECT * FROM ALCOHOL_CONSUMPTION;

--------------------------------------------------------------
-- 특정 COLUMN을 보는 명령어

DESC ALCOHOL_CONSUMPTION;

SELECT COUNTRY, BEER_SERVINGS
FROM ALCOHOL_CONSUMPTION;

--------------------------------------------------------------
-- 조건을 통한 필터링

SELECT COUNTRY, BEER_SERVINGS
FROM ALCOHOL_CONSUMPTION
WHERE BEER_SERVINGS>100 
      AND COUNTRY LIKE 'u%';

--------------------------------------------------------------
-- GROUP 함수

SELECT PASSENGERS,COUNT(*)
FROM TITANIC
GROUP BY PASSENGERS;

SELECT COUNT(CLASS)
FROM TITANIC
WHERE PASSENGERS='Perished';

SELECT PASSENGERS, SUM(FARE),AVG(FARE),STDDEV(FARE)
FROM TITANIC 
WHERE SEX = 'male'
GROUP BY PASSENGERS;

--------------------------------------------------------------
-- FARE의 평균보다 작은 사람만 GROUP BY 함수로 만들어서 성별로 FARE의 합계를 커리해보기

SELECT SEX,SUM(FARE)
FROM TITANIC
WHERE FARE > (SELECT AVG(FARE)
              FROM TITANIC)
GROUP BY SEX
ORDER BY SUM(FARE) DESC;

--------------------------------------------------------------
-- 나이별로 사망유무 GROUP BY

SELECT AGE,PASSENGERS,COUNT(*)
FROM TITANIC
GROUP BY AGE, PASSENGERS
ORDER BY AGE;
--------------------------------------------------------------
-- 3등칸 탄사람만 나이별로 사망유무 GROUP BY

SELECT AGE,PASSENGERS,COUNT(*)
FROM TITANIC
WHERE CLASS=3
GROUP BY AGE, PASSENGERS
ORDER BY AGE;

SELECT  AGE, COUNT(*)
FROM TITANIC
WHERE CLASS=3
GROUP BY AGE, CLASS
ORDER BY CLASS;

--------------------------------------------------------------
-- 문자열 query LIKE
-- Mr. 가 들어간 문자열을 찾아오기

SELECT NAME
FROM TITANIC
WHERE NAME LIKE '%Mr.%';

SELECT COUNTRY
FROM ALCOHOL_CONSUMPTION
WHERE COUNTRY LIKE 'a%';

SELECT COUNTRY
FROM ALCOHOL_CONSUMPTION
WHERE SUBSTR(COUNTRY,1,1)='a';    -- SUBSTR (COLUMN, 시작, 끝)

--------------------------------------------------------------
-- 알파벳의 첫글자가 같은 나라의 수

SELECT SUBSTR(COUNTRY,1,1),
              COUNT(*),
              SUM(BEER_SERVINGS),
              AVG(BEER_SERVINGS),
              SUM(WINE_SERVINGS),
              AVG(WINE_SERVINGS)
FROM ALCOHOL_CONSUMPTION
GROUP BY SUBSTR(COUNTRY,1,1)
ORDER BY SUBSTR(COUNTRY,1,1);

--------------------------------------------------------------
-- 다양한 문자열 함수 INSTR SUBSTR TRIM LENGTH

SELECT NAME, 
       SUBSTR(NAME,1,10),
       LENGTH(NAME),
       INSTR(NAME,'.'),   -- 해당 문자가 몇번째에 있는지 나타내줌
       SUBSTR(NAME,INSTR(NAME,'.')+1,LENGTH(NAME)),
       TRIM(NAME),
       LTRIM(NAME),
       RTRIM(NAME)
FROM TITANIC;

--------------------------------------------------------------
-- TITANIC DATA에서 이름의 길이가 여자 이름의 평균 이름의 길이보다 긴 사람 중 살아남은 사람만 뽑기
-- 여자이름의 평균길이 () 보다 이름의 길이가 긴 사람 중에서 살아남은사람

SELECT NAME,LENGTH(NAME),SEX,PASSENGERS,(SELECT AVG(LENGTH(NAME))
                                         FROM TITANIC
                                         WHERE SEX='female') AS AVERAGE_LENGTH_FEMALE
FROM TITANIC
WHERE SEX='female'
     AND LENGTH(NAME) > (SELECT AVG(LENGTH(NAME))
                         FROM TITANIC
                         WHERE SEX='female')
     AND PASSENGERS = 'Survived'
ORDER BY NAME;

