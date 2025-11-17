-- Total revenue
SELECT 
    ROUND(SUM(SALES)) AS total_revenue
FROM
    order_details;

-- unique orders
select count(distinct(OrderID))as unique_orders from order_details;

-- Average order value
select round(avg(total_sales)) as AvgOrderValue
from ( select OrderID ,sum(SALES) as total_sales from order_details group by OrderID) AS OrderSums;