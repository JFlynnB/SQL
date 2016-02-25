/*
J. Flynn Billinghurst
Assignment # 5
2015-3-30
*/

USE MyGuitarShop;

--Question 1
SELECT COUNT( OrderID) AS 'NumOrders', SUM(TaxAmount) AS 'TotalTax' 
FROM Orders;

--Question 2
SELECT CategoryName, COUNT(*) AS 'NumProducts', MAX(ListPrice) AS 'MostExpensive'
FROM Categories JOIN Products ON Categories.CategoryID = Products.CategoryID
GROUP BY CategoryName
ORDER BY COUNT(*) DESC;

--Question 3
SELECT EmailAddress, SUM(ItemPrice * Quantity) AS 'TotalPrice', SUM(DiscountAmount * Quantity) AS 'TotalDiscount'
FROM Customers JOIN Orders ON Customers.CustomerID = Orders.CustomerID
	JOIN OrderItems ON Orders.OrderID = OrderItems.OrderID
GROUP BY EmailAddress
ORDER BY SUM(ItemPrice) DESC;

--Question 4
SELECT EmailAddress, COUNT(ItemID) AS 'NumOfOrders', SUM((ItemPrice - DiscountAmount) * Quantity) AS 'TotalOrderAmount'
FROM Customers JOIN Orders ON Customers.CustomerID = Orders.CustomerID
	JOIN OrderItems ON Orders.OrderID = OrderItems.OrderID
GROUP BY EmailAddress
HAVING COUNT(Orders.OrderID) > 1
ORDER BY TotalOrderAmount DESC;

--Question 5
SELECT EmailAddress, COUNT(ItemID) AS 'NumOfOrders', SUM((ItemPrice - DiscountAmount) * Quantity) AS 'TotalOrderAmount'
FROM Customers JOIN Orders ON Customers.CustomerID = Orders.CustomerID
	JOIN OrderItems ON Orders.OrderID = OrderItems.OrderID
WHERE ItemPrice > 400
GROUP BY EmailAddress
HAVING COUNT(Orders.OrderID) > 1
ORDER BY TotalOrderAmount DESC;

--Question 6
SELECT ProductName, SUM((ItemPrice - DiscountAmount) * Quantity) AS 'TotalProductAmount'
FROM Products JOIN OrderItems ON Products.ProductID = OrderItems.ProductID
GROUP BY ProductName WITH ROLLUP;

--Question 7
SELECT EmailAddress, COUNT(DISTINCT ProductID) AS 'NumberOfProducts'
FROM Customers JOIN Orders ON Customers.CustomerID = Orders.CustomerID
	JOIN OrderItems ON Orders.OrderID = OrderItems.OrderID
GROUP BY EmailAddress
HAVING COUNT(DISTINCT ProductID) > 1;