-- Clean and Create a VIEW for data visualization

DROP VIEW IF EXISTS cleaned_logistics_data;

CREATE OR REPLACE VIEW cleaned_logistics_data AS

SELECT 
	OrderID,
	Region,
	VehicleType,
	
	-- Created a fix to prevent 'Snow' from taking place in warmer months to instead named 'Heavy Rain'
	CASE
		WHEN WeatherCondition = 'Snow' AND EXTRACT(MONTH FROM CAST(OrderDate AS DATE)) IN (5,6,7,8) THEN 'Heavy Rain'
		ELSE WeatherCondition
	END AS WeatherCondition,
	
	Distance_Miles,
	-- Cast from TIMESTAMP to DATE stripping the time values 
	CAST(OrderDate AS DATE) AS Order_Date,
	CAST(ExpectedDeliveryDate AS DATE) AS Expected_Delivery_Date,
	CAST(ActualDeliveryDate AS DATE) AS Actual_Delivery_Date,
	-- Change any empty rows in Damaged_Flag to 'Unknown', must change empty stings to NULL first
	COALESCE(NULLIF(Damaged_Flag, ''), 'Unknown') AS Damaged_Status,
	-- Compute the days taken to deliver a package
	EXTRACT(DAY FROM(ActualDeliveryDate - OrderDate)) AS Days_To_Deliver,
	-- Flag if ActualDeliveryDate exceeds ExpectedDeliveryDate
	CASE
		WHEN ActualDeliveryDate > ExpectedDeliveryDate THEN 1
		ELSE 0
	END AS Is_Late,
	-- Calculate how late the delivery is
	CASE 
		WHEN ActualDeliveryDate > ExpectedDeliveryDate THEN EXTRACT(DAY FROM(ActualDeliveryDate - ExpectedDeliveryDate))
		ELSE 0
	END AS Days_Delayed,
	-- Flag if package was lost or delivered
	CASE
		WHEN ActualDeliveryDate IS NULL THEN 'Lost/In-Transit'
		ELSE 'Delivered'
	END AS Delivery_Status
FROM apex_logistics_raw;