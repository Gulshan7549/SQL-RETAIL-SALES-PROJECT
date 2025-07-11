-- Create the table
CREATE TABLE retail_sales (
    transactions_id INT,
    sale_date DATE,
    sale_time TIME,
    customer_id INT, 
    gender VARCHAR(15),
    age INT, 
    category VARCHAR(15),
    quantiy INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

-- View first 10 rows
SELECT * FROM retail_sales
LIMIT 10;

-- Count total records
SELECT COUNT(*) FROM retail_sales;

-- Check for NULLs in individual columns
SELECT * FROM retail_sales WHERE transactions_id IS NULL;
SELECT * FROM retail_sales WHERE sale_date IS NULL;
SELECT * FROM retail_sales WHERE sale_time IS NULL;

-- Data Cleaning: find all rows with any NULLs
SELECT * FROM retail_sales
WHERE 
    transactions_id IS NULL OR
    sale_date IS NULL OR
    sale_time IS NULL OR
    customer_id IS NULL OR
    gender IS NULL OR
    age IS NULL OR
    category IS NULL OR
    quantiy IS NULL OR
    price_per_unit IS NULL OR
    cogs IS NULL OR
    total_sale IS NULL;
----- 

select * from retail_sales
limit 10
 ----------- 
select
     count(*)
from retail_sales
-----

select * from retail_sales
WHERE transactions_id IS NULL
-----
select * from retail_sales
WHERE sale_date IS NULL
-----
select * from retail_sales
WHERE sale_time IS NULL
---- DATA CLEANING ----
select * from retail_sales
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR
    sale_time IS NULL
    OR
    customer_id IS NULL
    OR
    gender IS NULL
    OR
    age IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL 
    OR
    price_per_unit IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
    select *
    from retail_sales
    where sale_date = '2022-11-05'
    ---- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022    
SELECT * 
FROM retail_sales
WHERE category = 'clothing'
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
  AND
  quantiy>= 4

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT  
     category,
     sum(total_sale) as net_sale,
     COUNT(*) as total_order
FROM retail_sales
GROUP BY 1 
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT 
     ROUND(AVG(age), 2) as avg_ag
FROM retail_sales
WHERE category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sales
WHERE total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
category,
gender,
COUNT(*) as total_trans
FROM retail_sales
GROUP BY category,
gender
ORDER BY 1
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
    year,
    month,
    avg_sale
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS `rank`
    FROM retail_sales
    GROUP BY year, month
) AS t1
WHERE `rank` = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select 
  customer_id,
  sum(total_sale) as total_sales
 FROM retail_sales
 group by 1
 order by 2 desc
 LIMIT 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select 
  category,
  COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category
 
 -- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) <= 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 13 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)

SELECT 
    shift,
    COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;


SELECT EXTRACT(HOUR FROM CURRENT_TIME)
     

----- END PROJECT ------ 