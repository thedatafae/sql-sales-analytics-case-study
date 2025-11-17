-- List the top 5 customers by total revenue-- 
SELECT 
    CUSTOMERNAME, ROUND(SUM(SALES)) AS total_revenue
FROM
    order_details
        JOIN
    orders ON order_details.OrderID = orders.OrderID
        JOIN
    customers ON customers.CustomerID = orders.CustomerID
GROUP BY CUSTOMERNAME
ORDER BY total_revenue DESC
LIMIT 5;

-- Show total revenue per country and territory
SELECT COALESCE(NULLIF(COUNTRY, ''), 'Unknown') AS COUNTRY,
       COALESCE(NULLIF(TERRITORY, ''), 'Unknown') AS TERRITORY,
       ROUND(SUM(SALES)) AS total_revenue
FROM order_details
JOIN orders ON order_details.OrderID = orders.OrderID
JOIN customers ON customers.CustomerID = orders.CustomerID
GROUP BY COUNTRY, TERRITORY
ORDER BY total_revenue DESC;


-- Identify customers with “Large” deal size contributing > 50% of their country revenue.
WITH country_revenue AS (
    SELECT COALESCE(NULLIF(COUNTRY, ''), 'Unknown') AS COUNTRY,
           ROUND(SUM(SALES), 2) AS total_revenue_by_country
    FROM order_details
    JOIN orders ON order_details.OrderID = orders.OrderID
    JOIN customers ON customers.CustomerID = orders.CustomerID
    GROUP BY COUNTRY
), 
customer_revenue AS (
    SELECT CUSTOMERID,
           CUSTOMERNAME,
           COALESCE(NULLIF(COUNTRY, ''), 'Unknown') AS COUNTRY,
           DEALSIZE,
           ROUND(SUM(SALES), 2) AS total_revenue_by_customer
    FROM order_details
    JOIN orders ON order_details.OrderID = orders.OrderID
    JOIN customers ON customers.CustomerID = orders.CustomerID
    GROUP BY CUSTOMERID, CUSTOMERNAME, COUNTRY, DEALSIZE
)
SELECT cr.CUSTOMERNAME,
       cr.DEALSIZE,
       cr.total_revenue_by_customer,
       ctry.total_revenue_by_country,
       ROUND(cr.total_revenue_by_customer*100.0/ctry.total_revenue_by_country,2) AS contribution_percent
FROM customer_revenue cr
JOIN country_revenue ctry ON cr.COUNTRY = ctry.COUNTRY
WHERE cr.DEALSIZE = 'Large'
  AND cr.total_revenue_by_customer > 0.5 * ctry.total_revenue_by_country
ORDER BY contribution_percent DESC;