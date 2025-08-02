/* What are the top 5 products by total sales revenue?*/
SELECT TOP 5 P.ProductName, SUM(OD.UnitPrice*OD.Quantity*(1-Discount)) AS [TOTAL SALES REVENUE]
FROM [Order Details] OD 
join Products P ON OD.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY [TOTAL SALES REVENUE]

/* Which employee has processed the most orders?*/
SELECT TOP 1 E.EmployeeID, E.FirstName, E.LastName, COUNT(O.OrderID) AS TOTALORDERS
FROM Employees E 
JOIN Orders O ON O.EmployeeID = E.EmployeeID
GROUP BY E.EmployeeID, E.FirstName, E.LastName
ORDER BY 
    TotalOrders DESC;


/* What is the average order value per customer?*/
SELECT C.CustomerID, C.CompanyName, AVG(O.ORDERID) AS [AVERAGE ORDER VALUE]
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CompanyName
ORDER BY [AVERAGE ORDER VALUE] DESC;

/* *****Joins & Relationships***** */
/* List all orders that include products from more than one category.*/
    SELECT O.OrderID
    FROM Orders O
    JOIN [Order Details] OD ON O.OrderID = OD.OrderID
    JOIN Products P ON OD.ProductID = P.ProductID
    GROUP BY O.OrderID
    HAVING COUNT(DISTINCT(P.CategoryID)) >1

/* Show customers who have never placed an order.*/
    SELECT C.CustomerID, C.CompanyName FROM Customers C 
    LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
    GROUP BY C.CustomerID, C.CompanyName
    HAVING C.CustomerID NOT IN (SELECT O.CustomerID FROM Orders O)

/* Find suppliers who provide products in more than three categories.*/
    SELECT S.SupplierID, S.CompanyName FROM Suppliers S
    JOIN Products P ON S.SupplierID = P.SupplierID
    GROUP BY S.SupplierID, S.CompanyName
    HAVING COUNT(DISTINCT(P.CategoryID)) >3

/* ***** Subqueries & Filtering***** */
/* Which products have never been ordered?*/
    SELECT  P.ProductID, P.ProductName
    FROM Products P 
    LEFT JOIN [Order Details] O ON P.ProductID = O.ProductID
    WHERE O.ProductID IS NULL
    
/* Find the most expensive product in each category.*/
    WITH RANKEDPRODUCT AS
    (
    SELECT P.ProductID, P.ProductName, C.CategoryID, C.CategoryName, UnitPrice,
    RANK() OVER (PARTITION BY P.CategoryID ORDER BY P.UnitPrice DESC) AS EXPENSIVE
    FROM Products P
    JOIN Categories C ON C.CategoryID = P.CategoryID
    )

    SELECT ProductName, UnitPrice FROM RANKEDPRODUCT WHERE EXPENSIVE = 1;

/* List customers whose total order value exceeds the average across all customers.*/
SELECT C.CustomerID, C.CompanyName, SUM(OD.UNITPRICE * OD.QUANTITY *(1 - OD.DISCOUNT)) AS [TOTAL ORDER VALUE] FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
GROUP BY C.CustomerID, C.CompanyName
HAVING SUM(OD.UNITPRICE * OD.QUANTITY *(1 - OD.DISCOUNT)) > (SELECT AVG(CUSTOMER_VALUE) FROM (SELECT SUM(OD.UNITPRICE * OD.QUANTITY *(1 - OD.DISCOUNT)) AS CUSTOMER_VALUE FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
GROUP BY C.CustomerID) AS AVG
) ORDER BY [TOTAL ORDER VALUE];