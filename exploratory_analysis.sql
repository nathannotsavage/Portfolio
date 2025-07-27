
-- 1. Overview of the table
SELECT * FROM WorldLifeExpectancy LIMIT 10;

-- 2. Check for missing values
SELECT
  SUM(CASE WHEN `Status` IS NULL THEN 1 ELSE 0 END) AS Missing_Status,
  SUM(CASE WHEN `Life expectancy` IS NULL THEN 1 ELSE 0 END) AS Missing_LifeExpectancy
FROM WorldLifeExpectancy;

-- 3. List distinct countries and total years of data per country
SELECT
  Country,
  COUNT(DISTINCT Year) AS Available_Years
FROM WorldLifeExpectancy
GROUP BY Country
ORDER BY Available_Years DESC;

-- 4. Global average life expectancy by year
SELECT
  Year,
  ROUND(AVG(`Life expectancy`), 2) AS Avg_LifeExpectancy
FROM WorldLifeExpectancy
WHERE `Life expectancy` IS NOT NULL
GROUP BY Year
ORDER BY Year;

-- 5. Compare life expectancy by 'Developed' vs 'Developing' status
SELECT
  Status,
  ROUND(AVG(`Life expectancy`), 2) AS Avg_LifeExpectancy,
  COUNT(*) AS Record_Count
FROM WorldLifeExpectancy
WHERE `Life expectancy` IS NOT NULL
GROUP BY Status;

-- 6. Top 10 countries with highest average life expectancy
SELECT
  Country,
  ROUND(AVG(`Life expectancy`), 2) AS Avg_LifeExpectancy
FROM WorldLifeExpectancy
WHERE `Life expectancy` IS NOT NULL
GROUP BY Country
ORDER BY Avg_LifeExpectancy DESC
LIMIT 10;

-- 7. Correlation-like exploration: Life expectancy vs GDP
SELECT
  Country,
  Year,
  `Life expectancy`,
  GDP
FROM WorldLifeExpectancy
WHERE `Life expectancy` IS NOT NULL AND GDP IS NOT NULL
ORDER BY Year;

-- 8. Country with the highest increase in life expectancy from earliest to latest year
WITH ranked_years AS (
  SELECT
    Country,
    Year,
    `Life expectancy`,
    ROW_NUMBER() OVER (PARTITION BY Country ORDER BY Year ASC) AS rn_asc,
    ROW_NUMBER() OVER (PARTITION BY Country ORDER BY Year DESC) AS rn_desc
  FROM WorldLifeExpectancy
  WHERE `Life expectancy` IS NOT NULL
)
SELECT
  start.Country,
  (end.`Life expectancy` - start.`Life expectancy`) AS LifeExpectancy_Gain
FROM ranked_years start
JOIN ranked_years end ON start.Country = end.Country AND start.rn_asc = 1 AND end.rn_desc = 1
ORDER BY LifeExpectancy_Gain DESC
LIMIT 10;

-- 9. Avg BMI vs Life Expectancy per country
SELECT
  Country,
  ROUND(AVG(`BMI`), 2) AS Avg_BMI,
  ROUND(AVG(`Life expectancy`), 2) AS Avg_LifeExpectancy
FROM WorldLifeExpectancy
WHERE `Life expectancy` IS NOT NULL AND `BMI` IS NOT NULL
GROUP BY Country
ORDER BY Avg_LifeExpectancy DESC;
