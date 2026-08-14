-- Task 2: Delivery Delay Analysis 

-- 1.Calculate delivery delay (in days) for each order  

SELECT Order_ID,
DATEDIFF(Actual_Delivery_Date, Expected_Delivery_Date) AS Delay_Days
FROM flipkart_orders;
 
 -- 2.Find Top 10 delayed routes based on average delay days.
 
 SELECT 
    Route_ID,
    Round(AVG(DATEDIFF(Actual_Delivery_Date, Expected_Delivery_Date)),2) AS avg_delay
FROM flipkart_orders
GROUP BY Route_ID
ORDER BY avg_delay DESC
LIMIT 10;

-- 3.Use window functions to rank all orders by delay within each warehouse.

SELECT 
    order_id,
    warehouse_id,
    Route_id,
    DATEDIFF(Actual_Delivery_Date, Expected_Delivery_Date
    ) AS delay_days,
    Rank () OVER (PARTITION BY warehouse_id 
    ORDER BY DATEDIFF(Actual_Delivery_Date, Expected_Delivery_Date) DESC) AS Delay_Rank
FROM flipkart_orders;



