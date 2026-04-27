-- Databricks notebook source
SELECT * FROM `practical-3-big-query-493610.Retail_Sales.Data` LIMIT 10;

--- Q1: WHERE CLAUSE
SELECT *
FROM `practical-3-big-query-493610.Retail_Sales.Data`
WHERE EXTRACT (YEAR FROM `Date`) = 2023;

--- Q2: FILTERING & CONDITIONS 
SELECT *
FROM `practical-3-big-query-493610.Retail_Sales.Data`
WHERE `Total Amount` > ( SELECT AVG(`Total Amount`)
  FROM `practical-3-big-query-493610.Retail_Sales.Data`
); --- can't use aggregate functions in WHERE clause; need to use a sub-query which calculates the inner query 1st then filters rows based on the value

--- Q3: AGGREGATE FUNCTIONS
SELECT 
      SUM(`Total Amount`) AS Total_Revenue
FROM `practical-3-big-query-493610.Retail_Sales.Data`;

--- Q4: DISTINCT
SELECT DISTINCT `Product Category` AS Product_Category
FROM `practical-3-big-query-493610.Retail_Sales.Data`;

--- Q5: GROUP BY
SELECT `Product Category` AS Product_Category,
        SUM(`Quantity`) AS Total_Quantity
FROM `practical-3-big-query-493610.Retail_Sales.Data`
GROUP BY `Product Category`;

--- Q6: CASE STATEMENTS
SELECT `Customer ID` AS Customer_ID,
      `Age`,
   CASE 
    WHEN `Age` < 30 THEN 'Youth'
    WHEN `Age` BETWEEN 30 AND 59 THEN 'Adult'
    ELSE 'Senior'
  END AS Age_Group
FROM `practical-3-big-query-493610.Retail_Sales.Data`;

--- Q7: CONDITIONAL AGGREGATION
SELECT `Gender`,
        COUNT(CASE WHEN `Total Amount` > 500 THEN 1 END) AS High_Value_Transactions --- returns a value only when condition is true
FROM `practical-3-big-query-493610.Retail_Sales.Data`
GROUP BY `Gender`;

--- Q8: HAVING CLAUSE
SELECT `Product Category` AS Product_Category,
        SUM(`Total Amount`) AS Total_Revenue
FROM `practical-3-big-query-493610.Retail_Sales.Data`
GROUP BY `Product Category`
HAVING SUM(`Total Amount`) > 5000;

--- Q9: CALCULATED FIELDS
SELECT `Transaction ID` AS Transaction_ID,
        `Price per Unit` AS Price_per_Unit,
      CASE 
        WHEN `Price per Unit` < 50 THEN 'Cheap'
        WHEN `Price per Unit` BETWEEN 50 AND 200 THEN 'Moderate'
        ELSE 'Expensive'
      END AS Unit_Cost_Category
FROM `practical-3-big-query-493610.Retail_Sales.Data`;

--- Q10: COMBINING WHERE & CASE STATEMENTS
SELECT `Customer ID` AS Customer_ID,
       `Age`,
       `Total Amount` AS Total_Amount,
      CASE 
        WHEN `Total Amount` > 1000 THEN 'High'
        ELSE 'Low'
      END AS Spending_Level
FROM`practical-3-big-query-493610.Retail_Sales.Data`
WHERE `Age` >= 40;
