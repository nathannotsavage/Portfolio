#data cleaning us_household_income

SELECT *
FROM us_household_income
;
SELECT *
FROM us_household_income_statistics
;

ALTER TABLE us_household_income_statistics RENAME COLUMN `ï»¿id` TO `id` ;
;

SELECT COUNT(id)
FROM us_household_income
;
SELECT COUNT(id)
FROM us_household_income_statistics
;


SELECT id, COUNT(id)
FROM us_household_income 
GROUP BY id
HAVING COUNT(id) > 1
;
SELECT * 
FROM(
SELECT row_id,
id,
ROW_NUMBER() OVER(PARTITION BY ID ORDER BY ID) row_num
FROM us_household_income 
) duplicates
WHERE row_num > 1

;

DELETE FROM us_household_income_statistics
WHERE id IN(SELECT id
				FROM(
				SELECT id,
				ROW_NUMBER() OVER(PARTITION BY ID ORDER BY ID) row_num
				FROM us_household_income_statistics 
				) duplicates
		WHERE row_num > 1)
        ;


SELECT DISTINCT state_name
FROM us_household_income
ORDER BY state_name
;

UPDATE us_household_income
SET State_name = 'Alabama'
WHERE state_name = 'alabama'
;


SELECT *
FROM us_household_income
;

UPDATE us_household_income
SET PLace = 'Autaugaville'
WHERE county = 'Autauga County'
AND city = 'Vinemont'
;

SELECT Type, COUNT(Type)
FROM us_household_income
GROUP BY Type
;

UPDATE us_household_income
SET type = 'Borough'
WHERE type = 'Boroughs'
;



