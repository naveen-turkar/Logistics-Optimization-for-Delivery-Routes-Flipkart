--  Task 3: Route Optimization Insights 

-- 1.For each route, calculate: Average delivery time (in days).

SELECT 
    Route_ID,
    AVG(DATEDIFF(Actual_Delivery_Date, Order_Date)) AS Avg_Delivery_Time_Days
FROM flipkart_orders
WHERE Actual_Delivery_Date IS NOT NULL
GROUP BY Route_ID;

-- 1. For each route, calculate: Average traffic delay. 

SELECT 
    Route_ID,
    Round(AVG(Traffic_Delay_Min),2)
    AS Avg_Traffic_Delay
FROM flipkart_routes
GROUP BY Route_ID 
ORDER BY Avg_Traffic_Delay DESC ;

-- 1 .Distance-to-time efficiency ratio: Distance_KM / Average_Travel_Time_Min. 

SELECT Route_ID,
Round(Distance_KM / Average_Travel_Time_Min, 2) AS ' Efficiency ratio'
fROM  flipkart_routes ;


-- 2. Identify 3 routes with the worst efficiency ratio.

SELECT Route_ID,
Round(Distance_KM/Average_Travel_Time_Min, 2) AS Worst_efficiency_ratio
fROM  flipkart_routes
ORDER BY Worst_efficiency_ratio ASC 
limit 3;

-- 3.Find routes with >20% delayed shipments. 

SELECT 
    Route_ID,
    COUNT(*) AS Total_shipments,
    SUM(CASE 
            WHEN Actual_Delivery_Date > Expected_Delivery_Date THEN 1 
            ELSE 0 
        END) AS Delayed_Shipment,
    (SUM(CASE 
            WHEN Actual_Delivery_Date > Expected_Delivery_Date THEN 1 
            ELSE 0 
        END) * 100.0 / COUNT(*)) AS Delay_Shipment_Percentage
FROM flipkart_orders
GROUP BY Route_ID
HAVING Delay_Shipment_Percentage>20;

