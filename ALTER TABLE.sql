USE join_sql;

-- ALTER TABLE
-- 1. Basic Column Modifications
-- Add a new column called Price (of type DECIMAL(10, 2)) to the ProductSales table.
ALTER TABLE productsales
ADD price DECIMAL(10,2);
SELECT*FROM productsales;


-- Rename the column Quantity in the ProductSales table to Units_Sold.
ALTER TABLE productsales
RENAME COLUMN Quantity to Units_sold;


-- Change the data type of the Sale_Date column to DATETIME.
ALTER TABLE productsales
MODIFY COLUMN Sale_Date DATETIME;
SELECT*FROM productsales;

-- 2. Adding Constraints
-- Add a NOT NULL constraint to the Product_ID column in the ProductSales table.
ALTER TABLE productsales
MODIFY Product_ID INT NOT NULL; 
SELECT*FROM productsales;


-- Add a unique constraint to the Product_ID column.
ALTER TABLE productsales
ADD CONSTRAINT Unique_Product UNIQUE(Product_ID);

-- Add a CHECK constraint to ensure that Quantity is always greater than or equal to 0.
ALTER TABLE productsales
ADD CONSTRAINT CHECK_QUANTITY CHECK(UNITS_SOLD>=0);

-- 3. Dropping Constraints
-- Remove the unique constraint from the Product_ID column.
ALTER TABLE productsales 
DROP CONSTRAINT; 

-- Drop the CHECK constraint on the Quantity column.
ALTER TABLE productsales
DROP CONSTRAINT CHECK_QUANTITY;

-- 4. Dropping and Renaming Columns
-- Remove the Price column from the ProductSales table.
ALTER TABLE productsales
DROP COLUMN price;
SELECT*FROM productsales;

-- Rename the table ProductSales to SalesData.
ALTER TABLE productsales
RENAME TO Salesdata;
SELECT*FROM Salesdata;

-- Add a Default Value: Add a column Category with a default value of 'General'.
ALTER TABLE Salesdata
ADD COLUMN Category VARCHAR(20) DEFAULT "General";
DESC Salesdata;

-- Make Column Unique: Ensure that the combination of Product_ID and Sale_Date is unique.
ALTER TABLE Salesdata
ADD CONSTRAINT UNIQUE_PRODUCT_SALES_Date UNIQUE(Product_ID,Sale_Date);
SELECT*FROM Salesdata;
DESC Salesdata;

-- Add a Primary Key: Make the Product_ID column a primary key. (If it already contains duplicates, clean the data first.)
SELECT Product_ID ,COUNT()
-- Modify Column Properties: Change the maximum length of a VARCHAR column (if you create one in the table).
-- Add a Foreign Key: Add a Category_ID column to the ProductSales table and link it to a Categories table.