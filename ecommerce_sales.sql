DESCRIBE ecommerce_sales;

-- Which months generate the highest and lowest sales?
-- Highest sales month

SELECT 
    DATE_FORMAT(Order_Date, '%b-%y') AS month,
    SUM(Total_Sales) AS total_sales
FROM ecommerce_sales
GROUP BY DATE_FORMAT(Order_Date, '%b-%y') 
ORDER BY total_sales DESC
LIMIT 5;

-- Lowest sales month

SELECT 
    DATE_FORMAT(Order_Date, '%b-%y') AS month,
    SUM(Total_Sales) AS total_sales
FROM ecommerce_sales
GROUP BY DATE_FORMAT(Order_Date, '%b-%y') 
ORDER BY total_sales ASC
LIMIT 5;

--  Which products generate the most sales?

SELECT
    Product_Name,
    SUM(Total_Sales) AS total_sales
FROM ecommerce_sales
GROUP BY Product_Name
ORDER BY total_sales DESC
LIMIT 5;

-- Which categories generate the most sales?

SELECT
    Category,
    SUM(Total_Sales) AS total_sales
FROM ecommerce_sales
GROUP BY Category
ORDER BY  total_sales DESC;

-- Which regions generate the most sales?

SELECT
    Region,
    SUM(Total_Sales)
FROM ecommerce_sales
GROUP BY Region
ORDER BY SUM(Total_sales) DESC;

-- Is there a relationship between product price and quantity purchased?

SELECT
    Product_Name,
    AVG(Quantity) AS avg_quantity,
    AVG(Unit_Price) AS avg_unit_price
FROM ecommerce_sales
GROUP BY Product_Name;

-- Which customer type generates the most orders/sales?

SELECT
    Customer_Type,
    COUNT(Order_ID) AS total_orders,
    SUM(Total_Sales) AS total_sales
FROM ecommerce_sales
GROUP BY Customer_Type;

-- Which products or categories are most popular within each customer type?

WITH product_sales AS (
    SELECT
        Customer_Type,
        Product_Name,
        Category,
        SUM(Total_Sales) AS Total_Sales,
        ROW_NUMBER() OVER (
            PARTITION BY Customer_Type
            ORDER BY SUM(Total_Sales) DESC
        ) AS rn
    FROM ecommerce_sales
    GROUP BY Customer_Type, Product_Name, Category
)
SELECT
    Customer_Type,
    Product_Name,
    Category,
    Total_Sales
FROM product_sales
WHERE rn = 1;

-- Which payment methods are most used, and which generate the most revenue?

SELECT
    Payment_Method,
    COUNT(Order_ID) AS total_orders,
    SUM(Total_Sales) AS total_sales
FROM ecommerce_sales
GROUP BY Payment_Method
ORDER BY total_sales DESC;