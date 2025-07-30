/*List orders with customer company names.*/
SELECT O.OrderID, C.CompanyName
FROM ORDERS O JOIN Customers C on O.CustomerID = C.CustomerID

/* Show total quantity ordered per product.*/
SELECT ProductID, SUM(Quantity) AS TotalOrdered
FROM [Order Details]
GROUP BY ProductID;

/* Find the top 5 most expensive products.*/
SELECT TOP 5*
FROM Products 
ORDER BY UnitPrice DESC;

/* List employees who report to someone.*/
SELECT *
FROM Employees
WHERE ReportsTo IS NOT NULL;

/* Show the number of orders placed by each customer.*/
SELECT C.CustomerID, CompanyName, COUNT(orderid) AS OrderCount
FROM Orders O JOIN 
Customers C ON O.CustomerID = C.CustomerID 
GROUP BY C.CustomerID, CompanyName;

/* Display products with stock less than their reorder level.*/
SELECT ProductID, ProductName, UnitsInStock, ReorderLevel
FROM Products
WHERE UnitsInStock < ReorderLevel;

/* List all orders with the shipper name used.*/
SELECT O.OrderID, CustomerID, S.CompanyName
FROM Orders O JOIN
Shippers S on O.ShipVia = S.ShipperID;

/* Show the number of products in each category.*/
SELECT C.CategoryID, C.CategoryName ,COUNT(ProductID) AS [NUMBER OF PRODUCTS]
FROM Products P JOIN
Categories C ON P.CategoryID = C.CategoryID
GROUP BY C.CategoryID, C.CategoryName 
ORDER BY [NUMBER OF PRODUCTS] DESC;

/* Find the average unit price of products per category.*/
SELECT C.CategoryID, C.CategoryName, AVG(UnitPrice) AS [AVERAGE UNIT PRICE] 
FROM Products P JOIN
Categories C ON P.CategoryID = C.CategoryID 
GROUP BY C.CategoryID, C.CategoryName
ORDER BY  [AVERAGE UNIT PRICE];

/* List customers who have placed at least one order.*/
SELECT * 
FROM Customers C LEFT JOIN
ORDERS O ON O.CustomerID = O.CustomerID 
WHERE O.OrderID IS NOT NULL
