
-- Task 6: Shipment Tracking Analytics 

 -- 1.For each order, list the last checkpoint and time.
 
SELECT 
    Order_ID,
    Checkpoint,
    Checkpoint_Time
FROM flipkart_shipmenttracking
WHERE (Order_ID, Checkpoint_Time) IN (
    SELECT 
        Order_ID,
        MAX(Checkpoint_Time)
    FROM Flipkart_ShipmentTracking
    GROUP BY Order_ID
);

-- 2. Find the most common delay reasons (excluding None).

SELECT 
    Delay_Reason, 
    COUNT(*) AS Reason_Count
FROM flipkart_shipmenttracking
WHERE Delay_Reason IS NOT NULL
  AND Delay_Reason <> 'None'
GROUP BY Delay_Reason
ORDER BY Reason_Count DESC
LIMIT 1;

-- 3. Identify orders with >2 delayed checkpoints 

SELECT 
    Order_ID,
    COUNT(*) AS Delayed_Checkpoints
FROM flipkart_shipmenttracking
WHERE Delay_Reason IS NOT NULL
  AND Delay_Reason <> 'None'
GROUP BY Order_ID
HAVING COUNT(*) > 2
ORDER BY Order_ID ASC;

