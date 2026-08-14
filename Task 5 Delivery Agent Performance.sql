-- Task 5: Delivery Agent Performance

-- 1.Rank agents (per route) by on-time delivery percentage 

SELECT 
    Agent_ID,
    Agent_Name,
    Route_ID,
    On_Time_Delivery_Percentage,                                                     
    RANK() OVER (
        PARTITION BY Route_ID 
        ORDER BY On_Time_Delivery_Percentage DESC
    ) AS Agent_Rank
FROM flipkart_deliveryagents;

-- 2.Find agents with on-time % < 80%. 

SELECT 
    Agent_ID,
    Agent_Name,
    Route_ID,
    On_Time_Delivery_Percentage
FROM flipkart_deliveryagents
WHERE On_Time_Delivery_Percentage < 80; 

-- 3. Compare average speed of top 5 vs bottom 5 agents using subqueries.

SELECT 
    'Top 5 Agents' AS Group_Type,
    ROUND(AVG(Avg_Speed_KMPH), 2) AS "Avg_Speed (KM/h)"
FROM (
    SELECT Avg_Speed_KMPH
    FROM flipkart_deliveryagents
    ORDER BY Avg_Speed_KMPH DESC
    LIMIT 5
) Top5
UNION ALL
SELECT 
    'Bottom 5 Agents' AS Group_Type,
    ROUND(AVG(Avg_Speed_KMPH), 2) AS "Avg_Speed (KM/h)"
FROM (
    SELECT Avg_Speed_KMPH
    FROM flipkart_deliveryagents
    ORDER BY Avg_Speed_KMPH ASC
    LIMIT 5
) Bottom5;

