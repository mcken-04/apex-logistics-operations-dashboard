-- Create Table Structure

CREATE TABLE apex_logistics_raw (
	OrderID VARCHAR(50) PRIMARY KEY,
	Region VARCHAR(50),
	VehicleType VARCHAR(50),
	WeatherCondition VARCHAR(50),
	Distance_Miles INT,
	OrderDate TIMESTAMP,
	Damaged_Flag VARCHAR(50),
	ExpectedDeliveryDate TIMESTAMP,
	ActualDeliveryDate TIMESTAMP 
);