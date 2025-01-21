### Data Analysis using SQL

USE sales;
SELECT*FROM customers;
SELECT*FROM date;
SELECT*FROM markets;
SELECT*FROM transactions;


# 1. All tables and their rows in sales schema
SELECT TABLE_SCHEMA,TABLE_NAME,TABLE_ROWS
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA="SALES";


# 2. Date range in date table
SELECT "first_date",MIN(order_date)
FROM sales.transactions
UNION
SELECT "last_date",MAX(order_date)
FROM sales.transactions;

# 3. Revenue generated in 2020 and 2019.
SELECT d.year,SUM(order_date)
FROM sales.transactions t
JOIN sales.date d
ON t.order_date=d.date
WHERE d.year="2019"
UNION
SELECT d.year,SUM(order_date)
FROM sales.transactions t
JOIN sales.date d
ON t.order_date=d.date
WHERE d.year="2020";

# 4. Currency and their count
SELECT currency,COUNT(currency)
FROM sales.transactions
GROUP BY currency;

# 5. Total sales amount collected by each market
SELECT t.market_code,SUM(t.sales_amount) AS total_sales_amount
FROM sales.markets m
JOIN sales.transactions t
ON m.markets_code=t.market_code
GROUP BY t.market_code;

# 6. Sales quantity ordered from each market on each day
SELECT 
		m.markets_name,
        t.market_code,
        t.product_code,
        t.order_date,
        SUM(t.sales_qty) AS TOTAL_SALES_QUANTITY
        FROM sales.markets m 
        JOIN sales.transactions t 
        ON m.markets_code=t.market_code
        JOIN sales.products p
        ON p.product_code=t.product_code
        GROUP BY m.markets_name,t.market_code,t.product_code,order_date;

# 7. Sales across all markets in each year
SELECT 
		m.markets_name,
        t.market_code,
        t.product_code,
        SUM(t.sales_qty) AS total_sales_quantity
        FROM sales.markets m 
        JOIN sales.transactions t 
        ON m.markets_code=t.market_code
        JOIN sales.products p 
        ON p.product_code=t.product_code
        GROUP BY t.market_code,t.product_code
        ORDER BY t.market_code;
        
# 8. Categorizing Product sales based on sales quantity in each order
SELECT
	YEAR(order_date) AS year,
    SUM(t.sales_amount) AS TOTAL_SALES_AMOUNT,
    SUM(t.cost_price) AS TOTAL_COST_PRICE
    FROM sales.transactions t 
    GROUP BY (t.order_date);
    
# 8. Categorizing Product sales based on sales quantity in each order
SELECT product_code,product_type,
CASE WHEN prod.product_code < 300 AND prod.product_code > 50 THEN "MINIMUM ORDERS"
	WHEN prod.product_code >300 AND prod.product_code < 1500 THEN "AVERAGE ORDERS"
    WHEN prod.product_code >1500 THEN "TOP ORDERS"
    ELSE "LOW ORDERS"
    END AS ORDERS
    FROM
    (SELECT 
		t.product_code,p.product_type,
		YEAR(t.order_date) AS ORDERS_YEAR,
        SUM(t.sales_qty) AS SALES_QUANTITY
        FROM sales.transactions t 
        JOIN sales.products p 
        ON t.product_code=p.product_code
        GROUP BY t.product_code,orders_year) AS prod;
        
# 9. Calculating revenue Contribution percentage for each market across all years
SELECT 
	m.markets_name,revenue_contribution_percentage
    FROM sales.markets m
    JOIN
		(SELECT t.market_code,
        SUM(t.profit_margin) AS profit_margin,
        SUM(t.sales_amount) AS revenue,
        ((SUM(t.profit_margin)/SUM(t.sales_amount))*100 ) AS revenue_contribution_percentage
        FROM sales.transactions t 
        GROUP BY t.market_code) AS temp ON m.markets_code=temp.market_code;
        
        
# 10. Finding market name that made maximum sales
WITH tab1 AS(
SELECT m.markets_name AS market_name,SUM(t.sales_amount) AS sales_made
FROM sales.markets m 
JOIN sales.transactions t 
ON m.markets_code=t.market_code
JOIN sales.products p 
ON p.product_code=t.product_code
GROUP BY m.markets_name
),tab2 AS(
SELECT Max(tab1.sales_made) AS Max_sales FROM tab1)
SELECT tab1.market_name,tab2.Max_sales
FROM tab1
JOIN tab2
ON tab1.sales_made=tab2.Max_sales;
           
