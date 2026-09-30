use ecommerce1;

#-----------------------------<--<<--<<<-- Display all rows and columns from ecommerce_sales table -->>>-->>-->-----------------------------------

select * from ecommerce_sales;

#-----------------------------<--<<--<<<-- Display the structure of ecommerce_sales table -->>>-->>-->----------------------------------------------

DESCRIBE ecommerce_sales;

#-----------------------------<--<<--<<<-- Count total number of rows in ecommerce_sales table -->>>-->>-->-------------------------------------------

select count(*) from ecommerce_sales;

#-----------------------------<--<<--<<<-- Count total non-NULL values from ecommerce_sales table -->>>-->>-->------------------------------------------


SELECT
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS order_id_nulls,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS customer_id_nulls,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS product_id_nulls,
    SUM(CASE WHEN category IS NULL THEN 1 ELSE 0 END) AS category_nulls,
    SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) AS price_nulls,
    SUM(CASE WHEN discount IS NULL THEN 1 ELSE 0 END) AS discount_nulls,
    SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS quantity_nulls,
    SUM(CASE WHEN payment_method IS NULL THEN 1 ELSE 0 END) AS payment_method_nulls,
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS order_date_nulls,
    SUM(CASE WHEN delivery_time_days IS NULL THEN 1 ELSE 0 END) AS delivery_time_days_nulls,
    SUM(CASE WHEN region IS NULL THEN 1 ELSE 0 END) AS region_nulls,
    SUM(CASE WHEN returned IS NULL THEN 1 ELSE 0 END) AS returned_nulls,
    SUM(CASE WHEN total_amount IS NULL THEN 1 ELSE 0 END) AS total_amount_nulls,
    SUM(CASE WHEN shipping_cost IS NULL THEN 1 ELSE 0 END) AS shipping_cost_nulls,
    SUM(CASE WHEN profit_margin IS NULL THEN 1 ELSE 0 END) AS profit_margin_nulls,
    SUM(CASE WHEN customer_age IS NULL THEN 1 ELSE 0 END) AS customer_age_nulls,
    SUM(CASE WHEN customer_gender IS NULL THEN 1 ELSE 0 END) AS customer_gender_nulls
FROM ecommerce_sales;

#----------------------------------------- This query displays all values from ecommerce_sales table-----------------------------------------------------------------

select order_id from ecommerce_sales;
select customer_id from ecommerce_sales;
select product_id from ecommerce_sales;
select category from ecommerce_sales;
select price from ecommerce_sales;
select discount from ecommerce_sales;
select quantity from ecommerce_sales;
select payment_method from ecommerce_sales;
select order_date from ecommerce_sales;
select delivery_time_days from ecommerce_sales;
select region from ecommerce_sales;
select returned from ecommerce_sales;
select total_amount from ecommerce_sales;
select shipping_cost from ecommerce_sales;
select profit_margin from ecommerce_sales;
select customer_age from ecommerce_sales;
select customer_gender from ecommerce_sales;

#-->>>-->>-->------------------------------------------ Check duplicate order_ids -->>>-->>-->------------------------------------------

SELECT order_id, COUNT(*)
FROM ecommerce_sales
GROUP BY order_id
HAVING COUNT(*) > 1;

#-----------------------------<--<<--<<<-- Change order_date datatype from TEXT to DATE  -->>>-->>-->------------------------------------------

ALTER TABLE ecommerce_sales
MODIFY COLUMN order_date DATE;

DESC ecommerce_sales;
select order_date from ecommerce_sales;

#-----------------------------<--<<--<<<-- Checking the number of unique orders. -->>>-->>-->------------------------------------------

SELECT COUNT(DISTINCT order_id) AS unique_orders
FROM ecommerce_sales;

#-----------------------------<--<<--<<<--  DATA QUALITY CHECK Identifying duplicate order IDs.-->>>-->>-->------------------------------------------ 

SELECT 
    order_id,
    COUNT(*) AS order_count
FROM ecommerce_sales
GROUP BY order_id
HAVING COUNT(*) > 1;

#-----------------------------<--<<--<<<-- Checking the total number of unique customers -->>>-->>-->------------------------------------------ 

SELECT 
    COUNT(DISTINCT customer_id) AS unique_customers
FROM ecommerce_sales;

#-----------------------------<--<<--<<<--  Checking the total number of unique products -->>>-->>-->------------------------------------------

SELECT 
    COUNT(DISTINCT product_id) AS unique_products
FROM ecommerce_sales;

#-----------------------------<--<<--<<<-- Identifying all product categories available in the dataset.-->>>-->>-->------------------------------------------


SELECT DISTINCT category
FROM ecommerce_sales
ORDER BY category;

#-----------------------------<--<<--<<<--CATEGORY DISTRIBUTION - Counting orders by product category.-->>>-->>-->------------------------------------------


SELECT 
    category,
    COUNT(*) AS total_orders
FROM ecommerce_sales
GROUP BY category
ORDER BY total_orders DESC;

#-----------------------------<--<<--<<<-- REGION ANALYSIS - Counting orders across different regions.-->>>-->>-->------------------------------------------


SELECT 
    region,
    COUNT(*) AS total_orders
FROM ecommerce_sales
GROUP BY region
ORDER BY total_orders DESC;

#-----------------------------<--<<--<<<-- PAYMENT METHOD ANALYSIS - Understanding customer payment preferences.-->>>-->>-->------------------------------------------

SELECT 
    payment_method,
    COUNT(*) AS total_orders
FROM ecommerce_sales
GROUP BY payment_method
ORDER BY total_orders DESC;

#-----------------------------<--<<--<<<--CUSTOMER DEMOGRAPHICS - Analyzing orders by customer gender.-->>>-->>-->------------------------------------------

SELECT 
    customer_gender,
    COUNT(*) AS total_orders
FROM ecommerce_sales
GROUP BY customer_gender
ORDER BY total_orders DESC;

 #-----------------------------<--<<--<<<-- NUMERICAL SUMMARY - Calculating basic statistics for key numerical columns.-->>>-->>-->------------------------------------------


SELECT
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    AVG(price) AS avg_price,

    MIN(quantity) AS min_quantity,
    MAX(quantity) AS max_quantity,
    AVG(quantity) AS avg_quantity,

    MIN(total_amount) AS min_sales,
    MAX(total_amount) AS max_sales,
    AVG(total_amount) AS avg_sales,

    MIN(profit_margin) AS min_profit,
    MAX(profit_margin) AS max_profit,
    AVG(profit_margin) AS avg_profit
FROM ecommerce_sales; 

#-----------------------------<--<<--<<<-- DATA QUALITY - INVALID VALUE CHECK - Checking for impossible or suspicious numerical values.-->>>-->>-->------------------------------------------

SELECT *
FROM ecommerce_sales
WHERE price < 0
   OR quantity <= 0
   OR total_amount < 0
   OR shipping_cost < 0
   OR customer_age <= 0
   OR delivery_time_days < 0;
   
   #-----------------------------<--<<--<<<--DATE RANGE - Checking the earliest and latest order dates.-->>>-->>-->------------------------------------------

SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS latest_order_date
FROM ecommerce_sales;

#-----------------------------<--<<--<<<-- BUSINESS ANALYSIS - OVERALL SALES - Calculate the total revenue generated from all orders.-->>>-->>-->------------------------------------------

SELECT 
    SUM(total_amount) AS total_sales
FROM ecommerce_sales;


   #-----------------------------<--<<--<<<-- TOTAL PROFIT - Calculate the total profit generated from all orders.-->>>-->>-->------------------------------------------
 

SELECT 
    SUM(profit_margin) AS total_profit
FROM ecommerce_sales;

#-----------------------------<--<<--<<<-- TOTAL QUANTITY SOLD - Calculate the total number of units sold.-->>>-->>-->------------------------------------------

SELECT 
    SUM(quantity) AS total_quantity_sold
FROM ecommerce_sales;

#-----------------------------<--<<--<<<--AVERAGE ORDER VALUE (AOV) - Calculate the average revenue generated per order.-->>>-->>-->------------------------------------------

SELECT 
     AVG(total_amount) AS average_order_value
FROM ecommerce_sales;

#-----------------------------<--<<--<<<-- SALES BY CATEGORY - Calculate total sales generated by each product category.-->>>-->>-->------------------------------------------

SELECT 
    category,
    SUM(total_amount) AS total_sales
FROM ecommerce_sales
GROUP BY category
ORDER BY total_sales DESC;

#-----------------------------<--<<--<<<-- PROFIT BY CATEGORY - Calculate total profit generated by each product category.-->>>-->>-->------------------------------------------

SELECT 
    category,
    SUM(profit_margin) AS total_profit
FROM ecommerce_sales
GROUP BY category
ORDER BY total_profit DESC;

#-----------------------------<--<<--<<<-- PROFIT BY REGION - Calculate total profit generated by each region. -->>>-->>-->------------------------------------------

SELECT 
    region,
    SUM(profit_margin) AS total_profit
FROM ecommerce_sales
GROUP BY region
ORDER BY total_profit DESC;

#-----------------------------<--<<--<<<-- MONTHLY SALES TREND - Analyze sales performance month by month.-->>>-->>-->------------------------------------------

SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(total_amount) AS monthly_sales
FROM ecommerce_sales
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    order_year,
    order_month;
    
 #-----------------------------<--<<--<<<-- MONTHLY PROFIT TREND  - Analyze profit performance month by month.-->>>-->>-->------------------------------------------

SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(profit_margin) AS monthly_profit
FROM ecommerce_sales
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    order_year,
    order_month;
    
  #-----------------------------<--<<--<<<-- SALES BY PAYMENT METHOD - Compare sales generated through different payment methods.-->>>-->>-->------------------------------------------

SELECT
    payment_method,
    SUM(total_amount) AS total_sales
FROM ecommerce_sales
GROUP BY payment_method
ORDER BY total_sales DESC;

#-----------------------------<--<<--<<<-- RETURN RATE - Calculate the percentage of orders that were returned.

SELECT
    ROUND(
        SUM(CASE WHEN returned = 'Yes' THEN 1 ELSE 0
		END) * 100.0 / COUNT(*),2
    ) AS return_rate_percentage
FROM ecommerce_sales;

#-----------------------------<--<<--<<<-- AVERAGE DELIVERY TIME - Calculate the average delivery time across all orders.-->>>-->>-->------------------------------------------

SELECT ROUND(AVG(delivery_time_days), 2) AS average_delivery_days
FROM ecommerce_sales;

#-----------------------------<--<<--<<<-- AVERAGE DELIVERY TIME - Calculate the average delivery time from each region across all orders. -->>>-->>-->------------------------------------------     

SELECT
    region,
    ROUND(AVG(delivery_time_days),2) AS avg_delivery_days
FROM ecommerce_sales
GROUP BY region
ORDER BY avg_delivery_days DESC;

#-----------------------------<--<<--<<<-- CUSTOMER SPENDING - Calculate the total amount spent by each customer.-->>>-->>-->------------------------------------------

SELECT customer_id,
SUM(total_amount) AS total_spent FROM ecommerce_sales
GROUP BY customer_id
ORDER BY total_spent DESC;

#-----------------------------<--<<--<<<--TOP 10 CUSTOMERS - Identify the top 10 customers based on total spending.-->>>-->>-->------------------------------------------

SELECT
    customer_id,
    SUM(total_amount) AS total_spent
FROM ecommerce_sales
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

#-----------------------------<--<<--<<<-- TOP PRODUCTS - Identify the top products based on total quantity sold.-->>>-->>-->------------------------------------------

SELECT
    product_id,
    SUM(quantity) AS total_quantity_sold
FROM ecommerce_sales
GROUP BY product_id
ORDER BY total_quantity_sold DESC
LIMIT 10;

#-----------------------------<--<<--<<<-- DISCOUNT VS SALES -Analyze how different discount levels are associated with total sales.-->>>-->>-->------------------------------------------

SELECT
    discount,
    SUM(total_amount) AS total_sales
FROM ecommerce_sales
GROUP BY discount
ORDER BY discount;

#-----------------------------<--<<--<<<-- CUSTOMER AGE ANALYSIS --->>>-->>-->------------------------------------------
#-----------------------------<--<<--<<<-- Group customers into age segments and calculate total sales generated by each age group.-->>>-->>-->------------------------------------------

SELECT
    CASE
        WHEN customer_age < 18 THEN 'Under 18'
        WHEN customer_age BETWEEN 18 AND 25 THEN '18-25'
        WHEN customer_age BETWEEN 26 AND 35 THEN '26-35'
        WHEN customer_age BETWEEN 36 AND 45 THEN '36-45'
        WHEN customer_age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '56+'
    END AS age_group,
    SUM(total_amount) AS total_sales
FROM ecommerce_sales
GROUP BY
    CASE
        WHEN customer_age < 18 THEN 'Under 18'
        WHEN customer_age BETWEEN 18 AND 25 THEN '18-25'
        WHEN customer_age BETWEEN 26 AND 35 THEN '26-35'
        WHEN customer_age BETWEEN 36 AND 45 THEN '36-45'
        WHEN customer_age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '56+'
    END
ORDER BY total_sales DESC;


#---------------------<--<<--<<<-- CATEGORY-WISE AVERAGE ORDER VALUE-->>>-->>-->------------------------------------------
#-----------------------------<--<<--<<<--Calculate the average order value for each category.-->>>-->>-->------------------------------------------

SELECT category,ROUND(AVG(total_amount), 2) AS average_order_value
FROM ecommerce_sales
GROUP BY category
ORDER BY average_order_value DESC;

#-----------------------------<--<<--<<<-- REGION-WISE RETURN RATE-->>>-->>-->------------------------------------------
#-----------------------------<--<<--<<<--Calculate the percentage of returned orders for each region.-->>>-->>-->------------------------------------------

SELECT region,
ROUND(SUM(CASE WHEN returned = 'Yes' THEN 1 ELSE 0 END ) * 100.0 / COUNT(*),2) AS return_rate_percentage
FROM ecommerce_sales
GROUP BY region
ORDER BY return_rate_percentage DESC;

#-----------------------------<--<<--<<<-- TOP 3 PRODUCTS IN EACH CATEGORY
#-----------------------------<--<<--<<<-- Rank products within each category based on quantity sold.
 

WITH product_sales AS (SELECT category,product_id,
	sUM(quantity) AS total_quantity_sold
    FROM ecommerce_sales
    GROUP BY category, product_id), 
ranked_products AS (SELECT category,product_id,total_quantity_sold,
 ROW_NUMBER() OVER (PARTITION BY category ORDER BY total_quantity_sold DESC) AS product_rank
FROM product_sales)
SELECT category,product_id,total_quantity_sold,product_rank
FROM ranked_products
WHERE product_rank <= 3
ORDER BY category, product_rank;
    
 #-----------------------------<--<<--<<<-- HIGHEST-SPENDING CUSTOMER IN EACH REGION-->>>-->>-->------------------------------------------
#-----------------------------<--<<--<<<-- Identify the customer with the highest total spending within each region.-->>>-->>-->------------------------------------------

WITH customer_region_sales AS (SELECT
        region,
        customer_id,
        SUM(total_amount) AS total_spent
    FROM ecommerce_sales
    GROUP BY region,customer_id
    ),
ranked_customers AS (
    SELECT
        region,
        customer_id,
        total_spent,
        ROW_NUMBER() OVER (
		PARTITION BY region
		ORDER BY total_spent DESC
        ) AS customer_rank
    FROM customer_region_sales
)
SELECT
    region,
    customer_id,
    total_spent
FROM ranked_customers
WHERE customer_rank = 1
ORDER BY region;


#-----------------------------<--<<--<<<-- REPEAT CUSTOMERS -->>>-->>-->------------------------------------------
#-----------------------------<--<<--<<<--Identify customers who placed more than one order.-->>>-->>-->------------------------------------------

SELECT
    customer_id,
    COUNT(*) AS total_orders
FROM ecommerce_sales
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY total_orders DESC;

#-----------------------------<--<<--<<<-- ONE-TIME VS REPEAT CUSTOMERS -->>>-->>-->------------------------------------------
#-----------------------------<--<<--<<<-- Classify customers based on their number of orders. -->>>-->>-->------------------------------------------

WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(*) AS total_orders
    FROM ecommerce_sales
    GROUP BY customer_id
)
SELECT
    CASE WHEN total_orders = 1 THEN 'One-time Customer'
	ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS customer_count
FROM customer_orders
GROUP BY
    CASE WHEN total_orders = 1 THEN 'One-time Customer'
        ELSE 'Repeat Customer'
    END;
    
#-----------------------------<--<<--<<<-- RUNNING TOTAL OF SALES -->>>-->>-->------------------------------------------
#-----------------------------<--<<--<<<-- Calculate cumulative sales over time. -->>>-->>-->------------------------------------------

WITH monthly_sales AS (
    SELECT DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
    SUM(total_amount) AS monthly_sales
    FROM ecommerce_sales
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)
SELECT
    sales_month,
    monthly_sales, 
    SUM(monthly_sales) OVER (
	ORDER BY sales_month
	ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_sales
FROM monthly_sales
ORDER BY sales_month;

#-----------------------------<--<<--<<<-- SALES RANKING -->>>-->>-->------------------------------------------
#-----------------------------<--<<--<<<-- Rank customers based on their total spending. -->>>-->>-->------------------------------------------


WITH customer_sales AS (
    SELECT customer_id,SUM(total_amount) AS total_sales
    FROM ecommerce_sales
    GROUP BY customer_id
)
SELECT
    customer_id,
    total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
    FROM customer_sales
    ORDER BY sales_rank;
    
#-----------------------------<--<<--<<<--<<<0000000000000000000000000>>>-->>>-->>-->------------------------------------------
/* ============================================================
   KEY HIGHLIGHTS
   ============================================================

   1. Total Unique Customers       : 7,903
   2. Total Unique Products        : 24,912
   3. Product Categories           : 7
   4. Regions                      : 5
   5. Total Sales                  : 5,865,293
   6. Total Profit                 : 970,019
   7. Total Units Sold             : 51,430
   8. Average Order Value          : 170
   9. Overall Return Rate          : 5.52%
  10. Average Delivery Time        : 4.81 Days
  11. Highest Spending Customer    : C16655
  12. Highest Customer Spending    : 13,885.1
  13. Top Product by Quantity      : P222065
  14. Top Product Quantity Sold    : 14 Units
  15. Highest Sales Age Group      : 56+
  16. 56+ Age Group Sales          : 1,514,907.34
  17. Highest Payment Method Sales : Credit Card
  18. Electronics Average Order Value : 537.09
  19. East Region Return Rate      : 5.91%
  20. Repeat Customers             : 7,428
  21. One-Time Customers           : 475

   DATA QUALITY
   - NULL Values                  : 0
   - Duplicate Order IDs          : 0
   - Invalid Values               : 0
   - Data Types                   : Correct

   ============================================================
   OVERALL TAKEAWAY
   ============================================================

   The analysis covers sales, profit, customers, products,
   categories, regions, returns, delivery and payment methods
   using SQL and advanced SQL techniques.
   ============================================================ */
   
   
   ## Key Highlights & Findings

-- * The dataset contains **7,903 unique customers** and **24,912 unique products** across **7 product categories and 5 regions**
-- * The dataset was successfully validated with **0 NULL values, 0 duplicate Order IDs and 0 invalid values**.
-- * The business generated total sales of approximately **5.86 million** with total profit of approximately **970K** during the period **September 2023 to September 2025**.
-- * A total of **51,430 units** were sold, with an overall **average order value of 170**.
-- * The overall **return rate was 5.52%**, while the average delivery time was **4.81 days**.
-- * **7,428 customers were repeat customers**, compared with **475 one-time customers**, highlighting the importance of understanding customer purchasing behavior.
-- * Customer **C16655** was the highest-spending customer, with total spending of **13,885.1** and ranked **1st** based on total spending.
-- * The **56+ age group generated approximately 1.51 million in sales**, making it an important customer segment for further analysis.
-- * **Credit Card** generated the highest sales among the analyzed payment methods.
-- * **Electronics** recorded an average order value of **537.09**.
-- * The **East region recorded a 5.91% return rate**, which can be further investigated alongside product, discount and delivery patterns.
-- * Advanced SQL techniques including **CASE WHEN, CTEs, subqueries, ROW_NUMBER, RANK, LAG and window functions** were used to identify customer, product and sales patterns.
-- ### Overall Business Takeaway
-- The analysis provides a clear view of **sales performance, profitability, customer behavior, product performance, regional performance, returns and delivery efficiency**, helping identify areas that can be further investigated for business improvement.