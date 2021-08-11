SELECT * FROM TAB;
--------------------------------------------------------------
-- ���� �ִ� �������� ����(TABLE)�� ��ȸ

SELECT * FROM ALCOHOL_CONSUMPTION;

--------------------------------------------------------------
-- Ư�� COLUMN�� ���� ��ɾ�

DESC ALCOHOL_CONSUMPTION;

SELECT COUNTRY, BEER_SERVINGS
FROM ALCOHOL_CONSUMPTION;

--------------------------------------------------------------
-- ������ ���� ���͸�

SELECT COUNTRY, BEER_SERVINGS
FROM ALCOHOL_CONSUMPTION
WHERE BEER_SERVINGS>100 
      AND COUNTRY LIKE 'u%';

--------------------------------------------------------------
-- GROUP �Լ�

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
-- FARE�� ��պ��� ���� ����� GROUP BY �Լ��� ���� ������ FARE�� �հ踦 Ŀ���غ���

SELECT SEX,SUM(FARE)
FROM TITANIC
WHERE FARE > (SELECT AVG(FARE)
              FROM TITANIC)
GROUP BY SEX
ORDER BY SUM(FARE) DESC;

--------------------------------------------------------------
-- ���̺��� ������� GROUP BY

SELECT AGE,PASSENGERS,COUNT(*)
FROM TITANIC
GROUP BY AGE, PASSENGERS
ORDER BY AGE;
--------------------------------------------------------------
-- 3��ĭ ź����� ���̺��� ������� GROUP BY

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
-- ���ڿ� query LIKE
-- Mr. �� �� ���ڿ��� ã�ƿ���

SELECT NAME
FROM TITANIC
WHERE NAME LIKE '%Mr.%';

SELECT COUNTRY
FROM ALCOHOL_CONSUMPTION
WHERE COUNTRY LIKE 'a%';

SELECT COUNTRY
FROM ALCOHOL_CONSUMPTION
WHERE SUBSTR(COUNTRY,1,1)='a';    -- SUBSTR (COLUMN, ����, ��)

--------------------------------------------------------------
-- ���ĺ��� ù���ڰ� ���� ������ ��

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
-- �پ��� ���ڿ� �Լ� INSTR SUBSTR TRIM LENGTH

SELECT NAME, 
       SUBSTR(NAME,1,10),
       LENGTH(NAME),
       INSTR(NAME,'.'),   -- �ش� ���ڰ� ���°�� �ִ��� ��Ÿ����
       SUBSTR(NAME,INSTR(NAME,'.')+1,LENGTH(NAME)),
       TRIM(NAME),
       LTRIM(NAME),
       RTRIM(NAME)
FROM TITANIC;

--------------------------------------------------------------
-- TITANIC DATA���� �̸��� ���̰� ���� �̸��� ��� �̸��� ���̺��� �� ��� �� ��Ƴ��� ����� �̱�
-- �����̸��� ��ձ��� () ���� �̸��� ���̰� �� ��� �߿��� ��Ƴ������

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

