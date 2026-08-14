-- Task 4: Warehouse Performance 

--  1.Find the top 3 warehouses with the highest average processing time

SELECT 
Warehouse_ID,
Average_Processing_Time_Min AS Highest_average_processing_time
FROM flipkart_warehouses
ORDER BY Average_Processing_Time_Min DESC 
LIMIT 3;

-- 2.Calculate total vs. delayed shipments for each warehouse. 

SELECT 
    Warehouse_ID,
    COUNT(*) AS Total_shipments,
    SUM(
        CASE 
            WHEN Actual_Delivery_Date > Expected_Delivery_Date THEN 1
            ELSE 0
        END
    ) AS Delayed_shipments
FROM FLIPKART_ORDERS
GROUP BY Warehouse_ID;

 -- 3.Use CTEs to find bottleneck warehouses where processing time > global average.

WITH Global_Avg AS (
    SELECT AVG(Average_Processing_Time_Min) AS global_avg
    FROM flipkart_warehouses
)
SELECT 
    Warehouse_ID,
    Average_Processing_Time_Min,
    (SELECT global_avg FROM Global_Avg) AS Global_Avg,
    'Bottleneck' AS Status
FROM flipkart_warehouses
WHERE Average_Processing_Time_Min > 
      (SELECT global_avg FROM Global_Avg)
ORDER  BY Average_Processing_Time_Min DESC;

-- 4.Rank warehouses based on on-time delivery percentage. 

USE flipkart_logistics;

SELECT 
    w.Warehouse_ID,
    ROUND(AVG(d.On_Time_Delivery_Percentage), 2) AS Avg_On_Time_Delivery,
RANK() OVER (
        ORDER BY AVG(d.On_Time_Delivery_Percentage) DESC
    ) AS Rank_Position
FROM flipkart_orders o
JOIN flipkart_deliveryagents d 
    ON o.Agent_ID = d.Agent_ID
JOIN flipkart_warehouses w 
    ON o.Warehouse_ID = w.Warehouse_ID
GROUP BY 
w.Warehouse_ID;
   