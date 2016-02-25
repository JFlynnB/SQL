USE MyGuitarShop;

SELECT ProductCode, ProductName, ListPrice, DiscountPercent
FROM Products
ORDER BY ListPrice DESC;

SELECT LastName + ', ' + FirstName AS FullName
FROM Customers
WHERE LastName > 'N%';

SELECT ProductName, ListPrice, DateAdded
FROM Products
WHERE ListPrice BETWEEN 500 AND 2000
ORDER BY DateAdded DESC;

SELECT ProductName, ListPrice, DiscountPercent, ListPrice * DiscountPercent AS DiscountAmount, ListPrice - (ListPrice * DiscountPercent) AS DiscountPrice
FROM Products
ORDER BY DiscountPrice DESC;

SELECT OrderID, ItemPrice, DiscountAmount, Quantity, ItemPrice * Quantity AS PriceTotal,
	DiscountAmount * Quantity AS DiscountTotal, (ItemPrice - DiscountAmount) * Quantity AS ItemTotal
FROM OrderItems
WHERE (ItemPrice - DiscountAmount) * Quantity > 500
ORDER BY ItemTotal DESC;

SELECT OrderID, OrderDate, ShipDate
FROM Orders
WHERE ShipDate IS NULL;

SELECT Price = 100, TaxRate = 0.07, TaxAmount = (100 * 0.07), Total = 100 + (100 *0.07);

SELECT *
FROM Customers; --Customers are ordered by CustomerID because CustomerID is the primary key

SELECT *
FROM Customers
WHERE EmailAddress IS NULL
ORDER BY LastName, FirstName;