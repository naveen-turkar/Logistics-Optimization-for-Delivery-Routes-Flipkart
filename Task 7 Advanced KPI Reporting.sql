-- Task 7: Advanced KPI Reporting -----

--  Calculate KPIs using SQL queries: 
--  1. Delivery Delay per Region (Start_Location).

SELECT 
    r.Start_Location AS Region,
    ROUND(AVG(DATEDIFF(o.Actual_Delivery_Date, o.Expected_Delivery_Date)), 2)
    AS Avg_Delivery_Delay
FROM flipkart_orders o
INNER JOIN flipkart_routes r 
    ON o.Route_ID = r.Route_ID
GROUP BY r.Start_Location
ORDER BY Avg_Delivery_Delay DESC ;

-- 2. On-Time Delivery % = (Total On-Time Deliveries / Total Deliveries) * 100.

SELECT 
    (SUM(CASE 
            WHEN Actual_Delivery_Date <= Expected_Delivery_Date THEN 1 
            ELSE 0 
         END) * 100.0 / COUNT(*)) AS On_Time_Delivery_Percentage
FROM flipkart_orders;

-- 3. Average Traffic Delay per Route. 

SELECT 
    Route_ID,
    Round(AVG(Traffic_Delay_Min),2) AS Avg_Traffic_Delay
FROM flipkart_routes
GROUP BY Route_ID 
ORDER BY Avg_Traffic_Delay DESC ;




