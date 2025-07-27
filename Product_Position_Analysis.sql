SELECT * 
FROM project_product_positioning
;
-- Fixing column name, import was incorrect
ALTER TABLE project_product_positioning RENAME COLUMN `ï»¿Product_ID` TO `Product_id` ;


-- Total records
SELECT COUNT(*) FROM project_product_positioning;


-- Product position counts
SELECT Product_Position, COUNT(*) AS Count
FROM project_product_positioning
GROUP BY Product_Position;


-- Top-selling product categories
SELECT Product_Category, AVG(Sales_volume) AS Avg_Sales
FROM project_product_positioning
GROUP BY Product_Category
ORDER BY Avg_Sales DESC;


-- Foot traffic distribution
SELECT Foot_Traffic, COUNT(*) AS Count
FROM project_product_positioning
GROUP BY Foot_Traffic;

SELECT 
  MIN(Price) AS Min_Price, MAX(Price) AS Max_Price, AVG(Price) AS Avg_Price, STDDEV(Price) AS Std_Price,
  MIN(Competitors_Price) AS Min_Comp_Price, MAX(Competitors_Price) AS Max_Comp_Price, 
  AVG(Competitors_Price) AS Avg_Comp_Price, STDDEV(Competitors_Price) AS Std_Comp_Price
FROM project_product_positioning;

-- Sales volume stats
SELECT MIN(Sales_volume), MAX(Sales_volume), AVG(Sales_volume), STDDEV(Sales_volume)
FROM project_product_positioning;

-- Seasonal effect on sales
SELECT Seasonal, AVG(Sales_volume) AS Avg_Sales
FROM project_product_positioning
GROUP BY Seasonal;


-- Sales by product position
SELECT Product_Position, AVG(Sales_volume) AS Avg_Sales
FROM project_product_positioning
GROUP BY Product_Position
ORDER BY Avg_Sales DESC;

-- Sales by position and category
SELECT Product_Category, Product_Position, AVG(Sales_volume) AS Avg_Sales
FROM project_product_positioning
GROUP BY Product_Category, Product_Position
ORDER BY Product_Category, Avg_Sales DESC;

-- Promotion vs. average sales
SELECT Promotion, AVG(Sales_volume) AS Avg_Sales
FROM project_product_positioning
GROUP BY Promotion;

-- Price by promotion
SELECT Promotion, AVG(Price) AS Avg_Price
FROM project_product_positioning
GROUP BY Promotion;

-- Promotion counts by product position
SELECT Product_Position, Promotion, COUNT(*) AS Count
FROM project_product_positioning
GROUP BY Product_Position, Promotion;

-- Sales by consumer demographic
SELECT Consumer_Demographic, AVG(Sales_volume) AS Avg_Sales
FROM project_product_positioning
GROUP BY Consumer_Demographic;

-- Foot traffic & product position effect on sales
SELECT Foot_Traffic, Product_Position, AVG(Sales_volume) AS Avg_Sales
FROM project_product_positioning
GROUP BY Foot_Traffic, Product_Position
ORDER BY Foot_Traffic, Avg_Sales DESC;

-- Best combination of category, position, promotion, and traffic
SELECT Product_Category, Product_Position, Promotion, Foot_Traffic, AVG(Sales_volume) AS Avg_Sales
FROM project_product_positioning
GROUP BY Product_Category, Product_Position, Promotion, Foot_Traffic
ORDER BY Avg_Sales DESC
LIMIT 10;

-- Seasonal products combined with promotion and position
SELECT Seasonal, Promotion, Product_Position, AVG(Sales_volume) AS Avg_Sales
FROM project_product_positioning
GROUP BY Seasonal, Promotion, Product_Position
ORDER BY Avg_Sales DESC;

SELECT
  CASE
    WHEN Price < Competitors_Price THEN 'Underpriced'
    WHEN Price > Competitors_Price THEN 'Overpriced'
    ELSE 'Same Price'
  END AS Price_Comparison,
  AVG(Sales_volume) AS Avg_Sales
FROM project_product_positioning
GROUP BY Price_Comparison;