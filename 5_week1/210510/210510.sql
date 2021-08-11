
CREATE TABLE TITANIC_REF(
SURVIVED VARCHAR2(50)
,PCLASS VARCHAR2(50)
,SEX VARCHAR2(50)
,AGE NUMBER(10)
,SIBSP VARCHAR2(50)
,PARCH VARCHAR2(10)
,FARE NUMBER(10,3)
,EMBARKED VARCHAR2(10)
,CLASS VARCHAR2(50)
,WHO VARCHAR2(50)
,ADULT_MALE VARCHAR2(10)
,DECK VARCHAR2(10)
,EMBARK_TOWN VARCHAR2(50)
,ALIVE VARCHAR2(10)
,ALONE VARCHAR2(10)
);


SELECT *
FROM TITANIC;

SELECT*
FROM TITANIC_REF;

SELECT SURVIVED,SIBSP
FROM TITANIC_REF
WHERE AGE>=20;

SELECT COUNT(*)
FROM BOSTON_MASTER;


SELECT COUNT(*)
FROM BOSTON_SLAVE;


SELECT COUNT(*)
FROM
(SELECT BOSTON_MASTER.SEQ,
       BOSTON_MASTER.CRIM,
       BOSTON_SLAVE.DIS,
       BOSTON_MASTER.ZN
FROM BOSTON_MASTER, BOSTON_SLAVE);


SELECT A.SEQ,
       A.CRIM,
       B.DIS,
       A.ZN
FROM BOSTON_MASTER A,BOSTON_SLAVE B
WHERE A.SEQ=B.SEQ;   --A, B�� Ű���� ����  *�� ������ ���� ��� 506*506 = �� 25���� ������ ����


/* ���� BOSTON_MASTER���� ��� ���̺��� ���� 
   BOSTON_SLAVE���� RAD�� 5�� CRIM, ZN, CHAS, DIS, RAD, AGE�� �����Ͽ� ��� ���̸� ���϶�
*/

SELECT A.CRIM,
       A.ZN,
       A.CHAS,
       B.RAD,
       A.AGE,
       ROUND((SELECT AVG(AGE) FROM BOSTON_MASTER),4) AS AVG_AGE
FROM BOSTON_MASTER A, BOSTON_SLAVE B
WHERE A.SEQ=B.SEQ 
AND A.AGE> (SELECT AVG(AGE) FROM BOSTON_MASTER)
AND B.RAD=5;


/*
    ��ȥ�� ���ڿ� ��ȥ���� ���� ������ ���� �� ������?
*/
SELECT *
FROM TITANIC;

SELECT COUNT(*)
FROM TITANIC
WHERE NAME LIKE '%Mrs%';

SELECT COUNT(*)
FROM TITANIC
WHERE NAME LIKE '%Miss%';

SELECT
(SELECT COUNT(*)
FROM TITANIC
WHERE LOWER(NAME) NOT LIKE '%mrs%'
      AND SEX= 'female') AS UNMARRIED,
(SELECT COUNT(*)
FROM TITANIC
WHERE LOWER(NAME) LIKE '%mrs%') AS MARRIED
FROM TITANIC
WHERE ROWNUM<2;

SELECT * 
FROM TITANIC_REF;

-- TITANIC_REF : PCLASS, SEX, FARE, EMBARKED
-- TITANIC   :  CLASS, SEX, FARE, EMBARKED

SELECT COUNT(DISTINCT NAME)
FROM TITANIC  ;

SELECT COUNT(B.PASSENGERID)
FROM TITANIC_REF A, TITANIC B
WHERE A.PCLASS=B.CLASS
AND A.SEX= B.SEX
AND A.FARE= B.FARE
AND A.EMBARKED=B.EMBARKED;




SELECT *
FROM TITANIC_DESC;

CREATE TABLE TITANIC_MASTER AS
SELECT PASSENGERID,
       PASSENGERS
FROM TITANIC;
     
CREATE TABLE TITANIC_PERSON AS   
SELECT PASSENGERID,
       NAME,
       SEX,
       AGE
FROM TITANIC;

CREATE TABLE TITANIC_DESC AS 
SELECT PASSENGERID,
       CLASS,
       SIBSP,
       PARCH,
       TICKET,
       FARE,
       CABIN,
       EMBARKED
FROM TITANIC;


SELECT *
FROM TITANIC_DESC;

----------------------------------------------------------
-- �� ���� �װ� �� ���� ��Ҵ���

SELECT DISTINCT PASSENGERS
FROM TITANIC_MASTER;

SELECT COUNT(*)
FROM TITANIC_MASTER
WHERE PASSENGERS='Survived';

SELECT COUNT(*)
FROM TITANIC_MASTER
WHERE PASSENGERS='Perished';

SELECT PASSENGERS, COUNT(*)
FROM TITANIC_MASTER
GROUP BY PASSENGERS;

----------------------------------------------------------
-- ���� �� �� ���� �� ��
SELECT * FROM TITANIC_PERSON;

SELECT SEX,COUNT(*)
FROM TITANIC_PERSON
GROUP BY SEX;

--------------------------------------------------------
--���ڴ� �� �� ��Ұ� ���ڴ� �� �� ��Ҵ���

SELECT SEX, PASSENGERS, COUNT(*)
FROM TITANIC 
GROUP BY SEX, PASSENGERS;


SELECT C.PASSENGERS, C.SEX, COUNT(*)
FROM
(SELECT A.PASSENGERS, B.SEX
FROM TITANIC_MASTER A, TITANIC_PERSON B
WHERE A.PASSENGERID=B.PASSENGERID) C
GROUP BY C.PASSENGERS, C.SEX;

SELECT *
FROM TITANIC_DESC;

SELECT PASSENGERS, SEX, COUNT(*)
FROM TITANIC
WHERE CLASS=3
GROUP BY PASSENGERS, SEX;

-----------------------------------------------------------
--3��ǿ� ź ��� �߿��� ����, ������ ����� ���� ���� ���Ͻÿ�


SELECT A.PASSENGERS, B.SEX, COUNT(*)
FROM TITANIC_MASTER A, TITANIC_PERSON B, TITANIC_DESC C
WHERE A.PASSENGERID=B.PASSENGERID AND B.PASSENGERID=C.PASSENGERID
AND C.CLASS=3
GROUP BY A.PASSENGERS, B.SEX;



SELECT A.PASSENGERS, B.SEX, COUNT(*)
FROM TITANIC_MASTER A, TITANIC_PERSON B
WHERE A.PASSENGERID = B.PASSENGERID 
      AND A.PASSENGERID IN (SELECT PASSENGERID FROM TITANIC_DESC WHERE CLASS = 3)
GROUP BY A.PASSENGERS, B.SEX;

----------------------------------------------------------------------------
-- ����� ��� �� ��ȥ�� ���, ��ȥ���� ���� ������� ����� �հ踦 ���Ͻÿ�.

SELECT SUM(FARE)
FROM TITANIC
WHERE PASSENGERS='Perished'
AND (NAME LIKE '%Mr%' OR NAME LIKE '%Mrs%' OR NAME LIKE '%Miss%');


--------------------------------------------------------------
-- ��ȥ�� ��� �� ����� ����� ������ ��
SELECT SUM(B.FARE)
FROM (SELECT *
      FROM TITANIC_PERSON
      WHERE NAME LIKE '%Mr%' 
            AND PASSENGERID IN -- ��ȥ�� ���
                            (SELECT PASSENGERID
                            FROM TITANIC_MASTER
                            WHERE PASSENGERS = 'Perished')) A,
      TITANIC_DESC B --����� ���
WHERE A.PASSENGERID = B.PASSENGERID ;  


--------------------------------------------------------------
-- ��ȥ���� ���� ��� �� ����� ����� ������ ��

SELECT SUM(B.FARE)
FROM (SELECT *
      FROM TITANIC_PERSON
      WHERE NAME NOT LIKE '%Mr%' 
            AND PASSENGERID IN -- ��ȥ���� ���� ���
                            (SELECT PASSENGERID
                            FROM TITANIC_MASTER
                            WHERE PASSENGERS = 'Perished')) A,
      TITANIC_DESC B --����� ���
WHERE A.PASSENGERID = B.PASSENGERID ;




SELECT A.MARRIED, SUM( B.FARE)
FROM (SELECT PASSENGERID,'M' AS MARRIED
      FROM TITANIC_PERSON
      WHERE NAME LIKE '%Mr%'
      UNION 
      SELECT PASSENGERID,'U' AS MARRIED
      FROM TITANIC_PERSON
      WHERE NAME NOT LIKE '%Mr%')A,                -- ��ȥ���� ���̺� ���� ����
      TITANIC_DESC B                               -- FARE ���ϱ� ����
WHERE A.PASSENGERID = B.PASSENGERID
AND A.PASSENGERID IN (SELECT PASSENGERID 
                      FROM TITANIC_MASTER
                      WHERE PASSENGERS='Perished')  -- ����� ���
GROUP BY A.MARRIED;

----------------------------------------------------------------

SELECT EMBARKED, COUNT(*)
FROM TITANIC_DESC
GROUP BY EMBARKED;

----------------------------------------------------------------
-- ������ (EMBARKED) ���� ����, ���� (�������� ����� �� �� ���� ���� ����)

SELECT A.EMBARKED, B.SEX, COUNT(B.SEX)
FROM TITANIC_DESC A, TITANIC_PERSON B
WHERE A.PASSENGERID = B.PASSENGERID
AND A.EMBARKED IS NOT NULL
GROUP BY A.EMBARKED, B.SEX;


-----------------------------------------------
-- ����,������ ���� ����� ���

SELECT  B.EMBARKED,A.SEX,COUNT('A.SEX') 
FROM (SELECT PASSENGERID,'M' AS SEX
      FROM TITANIC_PERSON
      WHERE SEX = 'male'
      UNION 
      SELECT PASSENGERID,'F' AS SEX
      FROM TITANIC_PERSON
      WHERE SEX='female')A, 
      TITANIC_DESC B
WHERE A.PASSENGERID = B.PASSENGERID
      AND B.EMBARKED IS NOT NULL
      AND A.PASSENGERID IN (SELECT PASSENGERID 
                            FROM TITANIC_MASTER
                            WHERE PASSENGERS='Perished')
GROUP BY A.SEX, B.EMBARKED;



SELECT D.EMBARKED, C.SEX, C.MAX_VALUE
FROM 
(SELECT C.SEX, MAX(C.CNT) AS MAX_VALUE
FROM 
(SELECT A.EMBARKED, B.SEX, COUNT(B.SEX) AS CNT
FROM TITANIC_DESC A, TITANIC_PERSON B
WHERE A.PASSENGERID = B.PASSENGERID
AND A.EMBARKED IS NOT NULL
AND A. PASSENGERID IN (SELECT PASSENGERID FROM TITANIC_MASTER WHERE PASSENGERS = 'Survived')
GROUP BY A.EMBARKED, B.SEX) C;





-------------------------------------------------------
-- ���� �� �����

SELECT A.PASSENGERS, B.SEX, COUNT(*)
FROM TITANIC_MASTER A, TITANIC_PERSON B
WHERE A.PASSENGERID = B.PASSENGERID
      AND A.PASSENGERID IN (SELECT PASSENGERID
                            FROM TITANIC_MASTER
                            WHERE PASSENGERS='Perished')
GROUP BY A.PASSENGERS, B.SEX;


-------------------------------------------------------------
--


SELECT SUBSTR(AGE,1,1),COUNT(*)  --���ڸ��� ������
FROM TITANIC_REF
WHERE AGE>=10 AND AGE<100 AND AGE IS NOT NULL
GROUP BY SUBSTR(AGE,1,1)
HAVING COUNT(*)>20         --COUNT 20�̻��ΰ�
ORDER BY COUNT(*);

