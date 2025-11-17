-- List top 5 products by total revenue. 
SELECT 
    SUM(SALES) AS total_revenue, PRODUCTLINE
FROM
    order_details
        JOIN
    products ON order_details.ProductID = products.ProductID
GROUP BY PRODUCTLINE
ORDER BY total_revenue DESC
LIMIT 5;

-- Find products where revenue is high but quantity sold is low.
select PRODUCTLINE, ROUND(SUM(SALES)), sum(QUANTITYORDERED)
from order_details join products on order_details.ProductID = products.ProductID
group by PRODUCTLINE 
HAVING ROUND(SUM(SALES)) >= 97000 AND sum(QUANTITYORDERED) <= 10000;

-- calculate average price per unit sold.
SELECT p.PRODUCTLINE,
       ROUND(SUM(od.PRICEEACH * od.QUANTITYORDERED) / SUM(od.QUANTITYORDERED), 2) AS avg_price_per_unit
FROM order_details od
JOIN products p ON od.ProductID = p.ProductID
GROUP BY p.PRODUCTLINE;
