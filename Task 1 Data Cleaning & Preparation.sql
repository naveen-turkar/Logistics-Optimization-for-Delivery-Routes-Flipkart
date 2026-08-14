-- Task 1: Data Cleaning & Preparation 

--  1.Identify and delete duplicate Order_ID records.

SELECT 
    Order_ID, COUNT(*) AS COUNT
FROM
    flipkart_orders
GROUP BY Order_ID
HAVING COUNT(*) > 1;
-- Result: No duplicate records found, so no deletion required
  
--  2.Replace null Traffic_Delay_Min with the average delay for that route. 

UPDATE flipkart_routes
SET Traffic_Delay_Min = (
    SELECT avg_delay FROM (
        SELECT AVG(Traffic_Delay_Min) AS avg_delay
        FROM flipkart_routes 
    ) AS temp 
)
WHERE Traffic_Delay_Min IS NULL;
select * from flipkart_routes;
--   Result  No NULL values found in Traffic_Delay_Min, Hence no replacement required 

--  3.Convert all date columns into YYYY-MM-DD format using SQL functions.

SELECT 
    DATE_FORMAT(Order_Date, '%Y-%m-%d') AS Order_Date,
    DATE_FORMAT(Expected_Delivery_Date, '%Y-%m-%d') AS Expected_Delivery_Date,
    DATE_FORMAT(Actual_Delivery_Date, '%Y-%m-%d')  AS  Actual_Delivery_Date
FROM Flipkart_Orders;
 --  Conclusion  ALL date columns are correctly Formatted YYYY-MM-DD
 
--   4. Ensure that no Actual_Delivery_Date is before Order_Date (flag such records). 

SELECT 
    Order_ID,
    Order_Date,
    Actual_Delivery_Date,
    CASE 
        WHEN Actual_Delivery_Date < Order_Date THEN 'Invalid Date'
        ELSE 'Valid Date'
    END AS Status
FROM flipkart_orders;
-- conclusion  All records have valid dates; no delivery occurs before the order date









