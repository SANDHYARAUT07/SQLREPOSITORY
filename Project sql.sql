USE sales;

SHOW TABLES;
SELECT*FROM CUSTOMERS;
SELECT*FROM DATE;
SELECT*FROM MARKETS;
SELECT*FROM PRODUCTS;
SELECT*FROM TRANSACTIONS;

-- Q1. CREATE FOREIGN KEY FOR TRANSACTION TABLE.
SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE transactions
ADD CONSTRAINT FOREIGN KEY(product_code)references products(product_code)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE transactions
ADD CONSTRAINT FOREIGN KEY(customer_code)references customer(customer_code)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE transactions
ADD CONSTRAINT FOREIGN KEY(market_code)references markets(markets_code)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE transactions
ADD CONSTRAINT FOREIGN KEY(order_date) references date(date)
ON DELETE CASCADE
ON UPDATE CASCADE;

describe Transactions;

-- Q2. VERIFY ALL THE TABLES AND THEIR RECORDS IN SALES DB.
SHOW TABLES;
SELECT*FROM CUSTOMERS;
SELECT*FROM DATE;
SELECT*FROM MARKETS;
SELECT*FROM PRODUCTS;
SELECT*FROM TRANSACTIONS;

-- 3.CHECK THE DATE RANGE IN THE DATE TABLE.
SELECT 
	MIN(date) AS earliest_date,
    MAX(date) AS latest_date
FROM 
	date; -- The date is falling under this date range.
    
SELECT DISTINCT date_format(date,"%Y-%m-%d") AS format_date
FROM date
ORDER BY format_date;

SELECT date FROM date
WHERE date is NULL;

-- 4.Calculate revenue generated in 2020 and 2019.
SELECT d.year,ROUND(SUM(t.profit_margin),2) AS total_profit
FROM date d
RIGHT JOIN transactions t
ON d.date=t.order_date
WHERE d.year BETWEEN 2019 AND 2020 AND profit_margin > 0
GROUP BY d.year;

-- 5.Apply currency and calculate their count in proper format.
SELECT CURRENCY,
	CASE WHEN CURRENCY="INR" THEN "₹"
		WHEN CURRENCY="USD" THEN "$"
        ELSE "UNKOWN"
        END AS CURRENCY_SYMBOL,
COUNT(*) AS record_count
FROM transactions
GROUP BY currency
ORDER BY record_count DESC;
	

-- 6.TOTAL SALES AMOUNT COLLECTED BY EACH MARKET.
SELECT DISTINCT M.MARKETS_NAME AS MARKET_NAME,
ROUND(
SUM(T.SALES_AMOUNT) OVER(PARTITION BY M.MARKETS_NAME),2) AS TOTAL_SALES_AMOUNT
FROM MARKETS M
LEFT JOIN TRANSACTIONS T 
ON M.MARKETS_CODE=T.MARKET_CODE
WHERE T.SALES_AMOUNT >0;

-- Q7.SALES QUANTITY ORDER FOR EACH MARKET ON EACH DAY.
SELECT d.date, M.markets_name,
sum(t.sales_qty) AS total_sales
FROM date d
JOIN transactions t
ON d.date=t.order_date
JOIN Markets M
ON M.markets_code=T.market_code
GROUP BY d.date,m.markets_name
ORDER BY d.date,m.markets_name;

-- Q8.Sales across all markets in each year.
SELECT d.year,M.markets_name,
sum(t.sales_amount) AS total_sales
FROM markets AS m
JOIN transactions AS t
ON m.Markets_code=t.market_code
JOIN date d
ON d.date=t.order_date
GROUP BY d.year,m.markets_code
ORDER BY d.year,m.markets_code;

-- Q9.Categorize product sales based on sales quantity in each order.
SELECT c.customer_code,p.product_code,
t.sales_qty AS sales_qty,
		CASE WHEN t.sales_qty >=100 THEN "High sales"
			WHEN t.sales_qty BETWEEN 50 AND 99 THEN "Moderate sales"
            WHEN t.sales_qty BETWEEN 1 AND 49 THEN "Low sales"
            END AS Sales_status
            FROM customers AS c
	JOIN transactions AS t
	ON c.customer_code=t.customer_code
	JOIN products AS p
	ON p.product_code=t.product_code
	GROUP BY c.customer_code,sales_qty,sales_status,p.product_code
	ORDER BY Sales_qty,sales_status DESC;

-- Q10.Calculate revenue contriution percentage % for each market across all years.
SELECT m.markets_name,
SUM(t.sales_amount) AS total_sales,
ROUND(
SUM(t.sales_amount)/(SELECT SUM(sales_amount) FROM transactions)*100,2) AS revenue_percentage
FROM markets m
JOIN transactions t
ON m.markets_code=t.market_code
GROUP BY m.markets_name
ORDER BY revenue_percentage DESC;

-- Q11.Find market name that made maximum sales.
SELECT m.markets_name,
MAX(t.sales_amount) AS max_sales
FROM markets m
JOIN transactions t
ON m.markets_code=t.market_code
GROUP BY m.markets_name
ORDER BY max_sales DESC;

        

