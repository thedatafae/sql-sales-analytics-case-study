-- Rank customers by total revenue.
select CUSTOMERNAME, round(sum(SALES)) as total_revenue,
RANK() OVER (ORDER BY SUM(SALES) DESC)  as Customer_Ranking
FROM order_details
JOIN orders ON order_details.OrderID = orders.OrderID
JOIN customers ON customers.CustomerID = orders.CustomerID
group by CUSTOMERNAME;

-- Find the top product in each product line by revenue.
WITH product_revenue AS (
    SELECT 
        PRODUCTCODE,
        PRODUCTLINE,
        ROUND(SUM(SALES)) AS total_revenue
    FROM order_details od
    JOIN orders o ON od.OrderID = o.OrderID
    JOIN products p ON od.ProductID = p.ProductID
    GROUP BY PRODUCTCODE, PRODUCTLINE
)
SELECT 
    PRODUCTCODE,
    PRODUCTLINE,
    total_revenue,
    ROW_NUMBER() OVER (
        PARTITION BY PRODUCTLINE 
        ORDER BY total_revenue DESC
    ) AS rn
FROM product_revenue
ORDER BY PRODUCTLINE, rn;


-- Find customers who ordered the same product more than once.
SELECT 
    CUSTOMERNAME,
    ProductID,
    COUNT(DISTINCT orders.OrderID) AS times_ordered
FROM
    order_details
        JOIN
    orders ON order_details.OrderID = orders.OrderID
        JOIN
    customers ON customers.CustomerID = orders.CustomerID
GROUP BY CUSTOMERNAME , ProductID
HAVING COUNT(DISTINCT order_details.OrderID) > 1;