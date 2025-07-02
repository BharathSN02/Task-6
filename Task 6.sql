CREATE TABLE OnlineSales (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    Category VARCHAR(50),
    ProductName VARCHAR(100),
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    TotalPrice DECIMAL(10, 2),
    Region VARCHAR(50),
    PaymentMethod VARCHAR(50)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Online Sales Data.csv'
INTO TABLE OnlineSales
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(OrderID, @OrderDate, Category, ProductName, Quantity, UnitPrice, TotalPrice, Region, PaymentMethod)
SET OrderDate = STR_TO_DATE(@OrderDate, '%d-%m-%Y');

Select * 
from onlinesales;


SELECT OrderID, COUNT(*)
FROM OnlineSales
GROUP BY OrderID
HAVING COUNT(*) > 1;

SELECT 
    YEAR(OrderDate) AS Year,
    MONTH(OrderDate) AS Month,
    SUM(TotalPrice) AS MonthlyRevenue,
    COUNT(DISTINCT OrderID) AS OrderVolume
FROM OnlineSales
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY Year, Month;


SELECT 
    ProductName,
    SUM(Quantity) AS TotalUnitsSold,
    SUM(TotalPrice) AS TotalRevenue
FROM OnlineSales
GROUP BY ProductName
ORDER BY TotalRevenue DESC
LIMIT 10;


SELECT 
    Category,
    YEAR(OrderDate) AS Year,
    SUM(TotalPrice) AS TotalRevenue
FROM OnlineSales
GROUP BY Category, YEAR(OrderDate)
ORDER BY TotalRevenue DESC;


SELECT 
    Region,
    SUM(TotalPrice) AS TotalRevenue,
    COUNT(DISTINCT OrderID) AS OrderVolume
FROM OnlineSales
GROUP BY Region
ORDER BY TotalRevenue DESC;


SELECT 
    PaymentMethod,
    COUNT(DISTINCT OrderID) AS NumberOfOrders,
    SUM(TotalPrice) AS TotalRevenue
FROM OnlineSales
GROUP BY PaymentMethod
ORDER BY TotalRevenue DESC;


SELECT 
    YEAR(OrderDate) AS Year,
    MONTH(OrderDate) AS Month,
    SUM(TotalPrice) AS CategoryRevenue
FROM OnlineSales
WHERE Category = 'Electronics' 
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY Year, Month;


SELECT 
    YEAR(OrderDate) AS Year,
    MONTH(OrderDate) AS Month,
    Region,
    SUM(TotalPrice) AS MonthlyRevenue
FROM OnlineSales
GROUP BY Year, Month, Region
ORDER BY Year, Month, MonthlyRevenue DESC;


SELECT 
    YEAR(OrderDate) AS Year,
    MONTH(OrderDate) AS Month,
    SUM(TotalPrice) AS TotalRevenue
FROM OnlineSales
WHERE OrderDate BETWEEN '2024-01-01' AND '2024-06-30'
GROUP BY Year, Month
ORDER BY Year, Month;

SELECT 
    OrderDate,
    SUM(TotalPrice) AS DailyRevenue,
    COUNT(DISTINCT OrderID) AS DailyOrders
FROM OnlineSales
GROUP BY OrderDate
ORDER BY DailyRevenue DESC
LIMIT 10;


SELECT 
    ProductName,
    SUM(TotalPrice) AS TotalRevenue,
    SUM(Quantity) AS TotalUnitsSold
FROM OnlineSales
GROUP BY ProductName
ORDER BY TotalRevenue ASC
LIMIT 10;


