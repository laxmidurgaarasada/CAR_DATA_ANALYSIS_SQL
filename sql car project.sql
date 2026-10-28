-- new project
--- CAR DATA ANALYSIS USING SQL

CREATE DATABASE CarMarket;
USE CarMarket;

CREATE TABLE Cars
(
Make VARCHAR(50),
Model VARCHAR(100),
Year INT,
Engine_Fuel_Type VARCHAR(100),
Engine_HP INT,
Engine_Cylinders INT,
Transmission_Type VARCHAR(50),
Driven_Wheels VARCHAR(50),
Number_of_Doors INT,
Market_Category VARCHAR(200),
Vehicle_Size VARCHAR(50),
Vehicle_Style VARCHAR(50),
Highway_MPG INT,
City_MPG INT,
Popularity INT,
MSRP DECIMAL(12,2)
);

select * from cars;

-- SQL Project Workflow
-- Phase 1: Create the Database
-- Create Database
-- Create Table
-- Import the CSV file
-- Phase 2: Data Cleaning
-- View the data
-- Count total records
-- Check for NULL values
-- Check for blank (empty) values
-- Check for duplicate records
-- Remove duplicate records
-- Replace NULL values
-- Remove extra spaces
-- Check invalid values (optional)
-- Verify the cleaned data
-- Phase 3: Data Analysis (Project Queries)
-- Write business queries (SELECT, WHERE)
-- Use Aggregate Functions (COUNT, AVG, SUM, MAX, MIN)
-- Use GROUP BY
-- Use HAVING
-- Use ORDER BY
-- Use LIKE, BETWEEN, IN
-- Use Subqueries
-- Use Window Functions (RANK, ROW_NUMBER)
-- Create a View
-- Create a Stored Procedure
-- Create a Function
-- Create a Trigger
-- Write the Project Conclusion
-- STEP 1: Create Database

-- Part 1: Data Cleaning

SELECT COUNT(*) AS Total_Records
FROM Cars;

SELECT *
FROM Cars
WHERE Make IS NULL
OR Model IS NULL
OR Year IS NULL
OR Engine_Fuel_Type IS NULL
OR Engine_HP IS NULL
OR Engine_Cylinders IS NULL
OR Transmission_Type IS NULL
OR Driven_Wheels IS NULL
OR Number_of_Doors IS NULL
OR Market_Category IS NULL
OR Vehicle_Size IS NULL
OR Vehicle_Style IS NULL
OR Highway_MPG IS NULL
OR City_MPG IS NULL
OR Popularity IS NULL
OR MSRP IS NULL;

-- check for blank spaces
SELECT *
FROM Cars
WHERE TRIM(Make) = ''
OR TRIM(Model) = ''
OR TRIM(Transmission_Type) = ''
OR TRIM(Market_Category) = '';

-- check for extra spaces

SELECT *
FROM Cars
WHERE Make <> TRIM(Make)
OR Model <> TRIM(Model);

-- check for duplicate records
SELECT
Make,
Model,
Year,
COUNT(*) AS Duplicate_Count
FROM Cars
GROUP BY Make, Model, Year
HAVING COUNT(*) > 1;


ALTER TABLE Cars
ADD Car_ID INT AUTO_INCREMENT PRIMARY KEY;

SHOW COLUMNS FROM Cars;
SELECT * FROM Cars LIMIT 10;

-- remove duplicates no need we dont have duplicates
-- clean data
SELECT *
FROM Cars
WHERE Make IS NULL
OR Model IS NULL
OR Engine_HP IS NULL;

-- Part 2: 35 SQL Analysis Queries
-- display all records
SELECT * FROM Cars;

-- count total no cars
SELECT COUNT(*) AS Total_Cars
FROM Cars;

-- Display Unique Car Manufacturers
SELECT DISTINCT Make
FROM Cars;

-- Count Cars by Manufacturer
SELECT Make,
COUNT(*) AS Total_Cars
FROM Cars
GROUP BY Make
ORDER BY Total_Cars DESC;

-- find the most expensive
SELECT Make,
Model,
MSRP
FROM Cars
ORDER BY MSRP DESC
LIMIT 1;

-- find the least expensive car
SELECT Make,
Model,
MSRP
FROM Cars
ORDER BY MSRP ASC
LIMIT 1;

-- calculate average carprice
SELECT AVG(MSRP) AS Average_Price
FROM Cars;

-- Find Average Price by Manufacturer
SELECT Make,
AVG(MSRP) AS Average_Price
FROM Cars
GROUP BY Make
ORDER BY Average_Price DESC;

-- find the highest horse power
SELECT MAX(Engine_HP) AS Highest_HP
FROM Cars;

-- : Display Top 10 Powerful Cars
SELECT Make,
Model,
Engine_HP
FROM Cars
ORDER BY Engine_HP DESC
LIMIT 10;

-- Find Average Horsepower by Manufacturer
SELECT Make,
AVG(Engine_HP) AS Average_HP
FROM Cars
GROUP BY Make
ORDER BY Average_HP DESC;

--  Count Cars by Fuel Type
SELECT Engine_Fuel_Type,
COUNT(*) AS Total_Cars
FROM Cars
GROUP BY Engine_Fuel_Type;

--  Count Cars by Transmission Type
SELECT Transmission_Type,
COUNT(*) AS Total_Cars
FROM Cars
GROUP BY Transmission_Type;

--  Count Cars by Vehicle Size
SELECT Vehicle_Size,
COUNT(*) AS Total_Cars
FROM Cars
GROUP BY Vehicle_Size;

--- Count Cars by Vehicle Style
SELECT Vehicle_Style,
COUNT(*) AS Total_Cars
FROM Cars
GROUP BY Vehicle_Style;

-- find average city mpg
SELECT AVG(City_MPG) AS Average_City_MPG
FROM Cars;

--  Find Average Highway MPG 
SELECT AVG(Highway_MPG) AS Average_Highway_MPG
FROM Cars;

--  Find Top 10 Fuel-Efficient Cars
SELECT Make,
Model,
Highway_MPG
FROM Cars
ORDER BY Highway_MPG DESC
LIMIT 10;

--  Display Cars Manufactured After 2018
SELECT *
FROM Cars
WHERE Year > 2018;

--  Display Luxury Cars (Price Above 100000)
SELECT Make,
Model,
MSRP
FROM Cars
WHERE MSRP > 100000;

-- Find Cars with More Than 8 Cylinders
SELECT *
FROM Cars
WHERE Engine_Cylinders > 8;

-- : Find Manufacturers Starting with 'B'
SELECT *
FROM Cars
WHERE Make LIKE 'B%';

-- Find Cars Priced Between 30000 and 60000
SELECT *
FROM Cars
WHERE MSRP BETWEEN 30000 AND 60000;

--  : Display BMW, Audi, and Mercedes-Benz Cars
SELECT *
FROM Cars
WHERE Make IN ('BMW','Audi','Mercedes-Benz');

--- Find Manufacturers with Average Price Greater Than 50000
SELECT Make,
AVG(MSRP) AS Average_Price
FROM Cars
GROUP BY Make
HAVING AVG(MSRP) > 50000;

-- Find Cars Priced Above the Average Price (Subquery)
SELECT *
FROM Cars
WHERE MSRP >
(
SELECT AVG(MSRP)
FROM Cars
);

-- Rank Cars by Price
SELECT
Make,
Model,
MSRP,
RANK() OVER(ORDER BY MSRP DESC) AS Price_Rank
FROM Cars;

-- Assign Row Numbers Based on Price
SELECT
Make,
Model,
MSRP,
ROW_NUMBER() OVER(ORDER BY MSRP DESC) AS Rn
FROM Cars;

--- Assign Dense Rank Based on Price
SELECT
Make,
Model,
MSRP,
DENSE_RANK() OVER(ORDER BY MSRP DESC) AS D_Rank
FROM Cars;

-- Find the Top 5 Most Popular Manufacturers
SELECT Make,
SUM(Popularity) AS Total_Popularity
FROM Cars
GROUP BY Make
ORDER BY Total_Popularity DESC
LIMIT 5;

-- Part 3: Advanced SQL Queries
---  Create a View for Luxury Cars
-- Purpose: Create a view to display cars priced above ₹100,000 (MSRP > 100000).

CREATE VIEW LuxuryCars AS
SELECT
    Make,
    Model,
    Year,
    MSRP
FROM Cars
WHERE MSRP > 100000;

select * from luxurycars;

--  Create a Stored Procedure to Display Cars by Manufacturer
DELIMITER //

CREATE PROCEDURE GetCarsByMake
(
    IN CompanyName VARCHAR(50)
)
BEGIN
    SELECT *
    FROM Cars
    WHERE Make = CompanyName;
END //

DELIMITER ;

-- Execute the Stored Procedure

CALL GetCarsByMake('BMW');

CALL GetCarsByMake('Audi');

CALL GetCarsByMake('Toyota');

-- Create a Function to Calculate 18% GST
DELIMITER //

CREATE FUNCTION CalculateGST(price DECIMAL(12,2))
RETURNS DECIMAL(12,2)

DETERMINISTIC

BEGIN
    RETURN price * 0.18;
END //

DELIMITER ;

-- use the function
SELECT
    Make,
    Model,
    MSRP,
    CalculateGST(MSRP) AS GST
FROM Cars;

--  Create a Log Table

--- This table stores details whenever a new car is inserted.

CREATE TABLE Car_Log
(
    Log_ID INT AUTO_INCREMENT PRIMARY KEY,
    Make VARCHAR(50),
    Model VARCHAR(100),
    Created_Date DATETIME
);

-- Create an AFTER INSERT Trigger
DELIMITER //

CREATE TRIGGER Car_Insert_Trigger

AFTER INSERT

ON Cars

FOR EACH ROW

BEGIN

INSERT INTO Car_Log
(
Make,
Model,
Created_Date
)

VALUES
(
NEW.Make,
NEW.Model,
NOW()
);

END //

DELIMITER ;

-- test the trigger,insert new record
INSERT INTO Cars
(
Make,
Model,
Year,
Engine_Fuel_Type,
Engine_HP,
Engine_Cylinders,
Transmission_Type,
Driven_Wheels,
Number_of_Doors,
Market_Category,
Vehicle_Size,
Vehicle_Style,
Highway_MPG,
City_MPG,
Popularity,
MSRP
)

VALUES
(
'Tesla',
'Model X',
2024,
'Electric',
670,
0,
'Automatic',
'All Wheel Drive',
4,
'Luxury',
'Large',
'SUV',
102,
95,
5000,
120000
);

-- verify the trigger
SELECT * FROM Car_Log;

-- Project Modules:
-- Database Creation,
-- Table Creation,
-- Data Import,
-- Data Cleaning
-- SQL Analysis Queries
-- Views
-- Stored Procedure
-- Function
-- Trigger
-- Business Insights
-- Conclusion 
--






