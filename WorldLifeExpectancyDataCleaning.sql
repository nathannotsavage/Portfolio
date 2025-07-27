#DATA CLEANINGï»

DELETE FROM world_life_expectancy
WHERE Row_id IN(
    SELECT row_id
	FROM(
	SELECT Row_id, 
	CONCAT(country, year),
	ROW_NUMBER() OVER(PARTITION BY CONCAT(country, year) ORDER BY CONCAT(country, year)) as Row_Num
	FROM world_life_expectancy) AS Row_table WHERE row_num > 1) 
  ;  

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
ON t1.country = t2.country
SET t1.status = 'Developing'
WHERE t1.status= ''
AND t2.status <> ''
AND t2.status = 'Developing'
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
ON t1.country = t2.country
SET t1.status = 'Developed'
WHERE t1.status= ''
AND t2.status <> ''
AND t2.status = 'Developed'
;


SELECT 
t1.country, t1.Year, t1.`Life expectancy`, 
t2.country, t2.Year, t2.`Life expectancy`, 
t3.country, t3.Year, t3.`Life expectancy`,
ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
	FROM world_life_expectancy t1
		JOIN world_life_expectancy t2
			ON t1.country = t2.country
			AND t1.year = t2.year - 1
		JOIN world_life_expectancy t3
			ON t1.country = t3.country
			AND t1.year = t3.year + 1
WHERE t1.`Life expectancy` = ''
;



UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.country = t2.country
	AND t1.year = t2.year - 1
JOIN world_life_expectancy t3
	ON t1.country = t3.country
	AND t1.year = t3.year + 1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
WHERE t1.`Life expectancy` = ''
;






















