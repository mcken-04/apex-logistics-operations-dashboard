-- Exploritory analysis in apex_logistics_raw
SELECT *
FROM apex_logistics_raw alr 
LIMIT 10;

-- Count of total rows snd check for any duplicates
SELECT 
	COUNT(*) AS total_rows,
	COUNT(DISTINCT OrderID) AS unique_orders
FROM apex_logistics_raw alr;


-- Identify missing data wthin ActualDelveryDate and Damaged_Flag
SELECT 
    SUM(CASE WHEN ActualDeliveryDate IS NULL THEN 1 ELSE 0 END) as missing_delivery_dates,
    SUM(CASE WHEN Damaged_Flag IS NULL THEN 1 ELSE 0 END) as missing_damaged_flags
FROM 
    apex_logistics_raw;

-- Previous query states there are no missing flags which is incorrect
-- Likely happened in data generation process. Instead of creating NULL, an empty sting was created
SELECT 
	damaged_flag,
	LENGTH(Damaged_Flag) AS character_count, -- Used to determine if just an empty sting or filled with spaces
	COUNT(*) AS total_count -- Shows the number of 'NULL' values as an empty sting
FROM apex_logistics_raw alr 
GROUP BY Damaged_Flag;

-- Detecting to see if any delivery dates come before order dates
SELECT 
    OrderID, 
    OrderDate, 
    ActualDeliveryDate
FROM 
    apex_logistics_raw
WHERE 
    ActualDeliveryDate < OrderDate;

-- Check for any outliers in Distance_Miles
SELECT 
	MIN(Distance_Miles) AS shortest_trip,
	MAX(Distance_Miles) AS longest_trip,
	ROUND(AVG(Distance_Miles),0) AS avg_miles
FROM apex_logistics_raw alr;

