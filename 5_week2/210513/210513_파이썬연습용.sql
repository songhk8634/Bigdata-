SELECT SEX,SUM(FARE)
FROM TITANIC
GROUP BY SEX;


SELECT * 
FROM ALCHOL_CONSUMPTION;

SELECT SUBSTR(A.COUNTRY,1,1), 
       SUM(A.BEER_SERVINGS) 
FROM 
(SELECT COUNTRY,
       BEER_SERVINGS,
       WINE_SERVINGS
FROM ALCHOL_CONSUMPTION
WHERE BEER_SERVINGS > (
        SELECT AVG(BEER_SERVINGS)
        FROM ALCHOL_CONSUMPTION)) A
GROUP BY SUBSTR(A.COUNTRY,1,1)       
;       

SELECT EMBARKED, SEX, COUNT(*), SUM(FARE)
FROM TITANIC
WHERE PASSENGERS = 'Perished' 
GROUP BY EMBARKED, SEX;



