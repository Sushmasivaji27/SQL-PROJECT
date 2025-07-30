 /*List all columns from the Products table.*/
 SELECT * FROM Products;

/* Show product names and their unit prices.*/
SELECT ProductName,UnitPrice FROM Products;

/* Find products with a unit price greater than $25.*/
SELECT * from Products WHERE UnitPrice > 25;

/* Display all customers located in France.*/
SELECT * FROM Customers WHERE COUNTRY = 'FRANCE' ;

/* Show employee first and last names along with their titles.*/
SELECT FirstName, LastName, Title FROM Employees;

/* List all discontinued products.*/
SELECT * FROM Products where Discontinued = 1;

/* Find suppliers based in the USA.*/
SELECT * FROM Suppliers WHERE Country = 'USA';

/* Show all categories and their descriptions.*/
SELECT CategoryID, CategoryName, Description FROM Categories;

/* Display orders placed in the year 1997.*/
SELECT * FROM Orders WHERE YEAR(OrderDate) = 1997;

/* List all shippers with their phone numbers.*/
SELECT CompanyName, Phone FROM Shippers;
