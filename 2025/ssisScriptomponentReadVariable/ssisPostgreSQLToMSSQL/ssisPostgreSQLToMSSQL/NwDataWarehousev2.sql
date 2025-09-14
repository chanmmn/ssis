-- Sales Fact Table
CREATE TABLE SalesFact (
    SalesID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    CustomerID NCHAR(5),
    EmployeeID INT,
    ShipperID INT,
    TimeID INT,
    Quantity SMALLINT,
    UnitPrice MONEY,
    Discount REAL,
    TotalAmount MONEY
);
-- Time Dimension
CREATE TABLE TimeDimension (
    TimeID INT IDENTITY(1,1) PRIMARY KEY,
    Date DATE,
    Day INT,
    Month INT,
    Quarter INT,
    Year INT,
    WeekdayName NVARCHAR(10)
);
-- Product Dimension
CREATE TABLE ProductDimension (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(40),
    CategoryID INT,
    CategoryName NVARCHAR(15),
    SupplierID INT,
    SupplierName NVARCHAR(40)
);
-- Customer Dimension
CREATE TABLE CustomerDimension (
    CustomerID NCHAR(5) PRIMARY KEY,
    CompanyName NVARCHAR(40),
    ContactName NVARCHAR(30),
    Country NVARCHAR(15),
    City NVARCHAR(15)
);
-- Employee Dimension
CREATE TABLE EmployeeDimension (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(10),
    LastName NVARCHAR(20),
    Title NVARCHAR(30),
    Country NVARCHAR(15),
    HireDate DATETIME
);
-- Shipper Dimension
CREATE TABLE ShipperDimension (
    ShipperID INT PRIMARY KEY,
    CompanyName NVARCHAR(40),
    Phone NVARCHAR(24)
);
-- SQL Scripts to Populate Dimension Tables
-- Time Dimension
INSERT INTO TimeDimension (Date, Day, Month, Quarter, Year, WeekdayName)
SELECT DISTINCT
    OrderDate,
    DAY(OrderDate),
    MONTH(OrderDate),
    DATEPART(QUARTER, OrderDate),
    YEAR(OrderDate),
    DATENAME(WEEKDAY, OrderDate)
FROM [northwind].dbo.Orders
WHERE OrderDate IS NOT NULL;
-- Product Dimension
INSERT INTO ProductDimension (ProductID, ProductName, CategoryID, CategoryName, SupplierID, SupplierName)
SELECT 
    p.ProductID,
    p.ProductName,
    p.CategoryID,
    c.CategoryName,
    p.SupplierID,
    s.CompanyName
FROM [northwind].dbo.Products p
LEFT JOIN [northwind].dbo.Categories c ON p.CategoryID = c.CategoryID
LEFT JOIN [northwind].dbo.Suppliers s ON p.SupplierID = s.SupplierID;
-- Customer Dimension
INSERT INTO CustomerDimension (CustomerID, CompanyName, ContactName, Country, City)
SELECT 
    CustomerID,
    CompanyName,
    ContactName,
    Country,
    City
FROM [northwind].dbo.Customers;
-- Employee Dimension
INSERT INTO EmployeeDimension (EmployeeID, FirstName, LastName, Title, Country, HireDate)
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    Title,
    Country,
    HireDate
FROM [northwind].dbo.Employees;
-- Shipper Dimension
INSERT INTO ShipperDimension (ShipperID, CompanyName, Phone)
SELECT 
    ShipperID,
    CompanyName,
    Phone
FROM [northwind].dbo.Shippers;
-- SalesFact Table Population Script
INSERT INTO SalesFact (
    OrderID,
    ProductID,
    CustomerID,
    EmployeeID,
    ShipperID,
    TimeID,
    Quantity,
    UnitPrice,
    Discount,
    TotalAmount
)
SELECT 
    od.OrderID,
    od.ProductID,
    o.CustomerID,
    o.EmployeeID,
    o.ShipVia AS ShipperID,
    td.TimeID,
    od.Quantity,
    od.UnitPrice,
    od.Discount,
    od.Quantity * od.UnitPrice * (1 - od.Discount) AS TotalAmount
FROM [northwind].dbo.[Order Details] od
JOIN [northwind].dbo.Orders o ON od.OrderID = o.OrderID
JOIN TimeDimension td ON td.Date = o.OrderDate;















