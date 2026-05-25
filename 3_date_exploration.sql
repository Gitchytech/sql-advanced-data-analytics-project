/*
===============================================================================
Date Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/

-- Determine the first and last order date and the total duration in months
SELECT 
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS order_range_months
FROM gold.fact_sales;

-- Find the youngest and oldest customer based on birthdate
SELECT
    MIN(birthdate) AS oldest_birthdate,
    DATEDIFF(YEAR, MIN(birthdate), GETDATE()) AS oldest_age,
    MAX(birthdate) AS youngest_birthdate,
    DATEDIFF(YEAR, MAX(birthdate), GETDATE()) AS youngest_age
FROM gold.dim_customers;

-- Find the average shipping duration in days for each month
SELECT 
MONTH(order_date) order_date,
AVG(DATEDIFF(day, order_date, shipping_date)) AS Avg_shipping_duration
FROM gold.fact_sales
GROUP BY MONTH(order_date);

-- TIME GAP ANALYSIS
-- Find the number of days between each order and the previous order
SELECT
order_number,
order_date CurrentOrderDate,
LAG(order_date) OVER(ORDER BY order_date) PreviousOrderDate,
DATEDIFF(day, LAG(order_date) OVER(ORDER BY order_date), order_date) NrOfDays 
FROM gold.fact_sales;
