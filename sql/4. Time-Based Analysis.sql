-- Show monthly revenue trends for each year.
SELECT 
    YEAR_ID, MONTH_ID, ROUND(SUM(SALES)) AS revenue
FROM
    order_details
        JOIN
    orders ON order_details.OrderID = orders.OrderID
GROUP BY YEAR_ID , MONTH_ID
ORDER BY YEAR_ID , MONTH_ID;

-- count orders by status (Shipped, Cancelled, etc.)
select STATUS, count(OrderID) from orders group by STATUS;

-- Show cumulative revenue month-wise.
SELECT 
    YEAR_ID, MONTH_ID, round(sum(SALES)) AS monthly_revenue,
    SUM(round(sum(SALES))) OVER (ORDER BY YEAR_ID, MONTH_ID) AS cumulative_revenue
FROM order_details JOIN orders ON order_details.OrderID = orders.OrderID
GROUP BY YEAR_ID, MONTH_ID
ORDER BY YEAR_ID, MONTH_ID;
