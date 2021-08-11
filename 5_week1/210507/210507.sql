create table titanic2(
PassengerId number(10,5),
Passengers varchar2(100),
Class number(10,5),
Name varchar2(100),
Sex varchar2(50),
Age varchar2(50),
SibSp number(10,5),
Parch number(10,5),
Ticket varchar2(50),
Fare number(10,5),
Cabin varchar2(50),
Embarked varchar2(50)
);
-- 1. 먼저 titanic2 테이블 만들기


-- 3. titanic2 테이블 확인
select * from titanic2
order by passengerid;

drop table titanic2 purge;




SELECT SYSDATE
FROM DUAL;

SELECT NAME, SUBSTR(NAME,1,10),INSTR(NAME,',')
FROM TITANIC;

SELECT NAME,LTRIM(SUBSTR(NAME,INSTR(NAME,',')+1)) AS LASTNAME
FROM TITANIC;

SELECT BEER_SERVINGS + SPIRIT_SERVINGS + WINE_SERVINGS, BEER_SERVINGS
FROM ALCOHOL_CONSUMPTION
WHERE COUNTRY = 'Afghanistan';

SELECT ROUND((BEER_SERVINGS + SPIRIT_SERVINGS + WINE_SERVINGS)/3,2) AS MEAN
FROM ALCOHOL_CONSUMPTION;

SELECT TO_CHAR(SYSDATE,'YYYY-MM')
FROM DUAL;

SELECT TO_NUMBER('3') AS NUM_TYPE,'3' AS STR_TYPE FROM DUAL;

SELECT COUNTRY, 
       CASE 
       WHEN BEER_SERVINGS<100 THEN 'A'
       ELSE 'B'
       END
FROM ALCOHOL_CONSUMPTION;

SELECT NAME,
       CASE SEX
       WHEN 'male' THEN '남자'
       ELSE '여자'
       END AS 한글
FROM TITANIC;





