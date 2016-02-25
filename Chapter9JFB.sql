/*
J. Flynn Billinghurst
Assignment 9
2015-4-13
*/

USE MyGuitarShop;

--Question #1
SELECT ListPrice, DiscountPercent, ROUND((ListPrice * (1.0 - DiscountPercent)), 2) AS DiscountAmount
FROM Products;

--Questioin #2
SELECT OrderDate, YEAR(OrderDate), DAY(OrderDate), DATEADD(day, 30, OrderDate)
FROM Orders;

--Question #3
SELECT CardNumber, LEN(CardNumber), RIGHT(CardNumber, 4), CONCAT( 'XXXX-XXXX-XXXX-', RIGHT(CardNumber, 4))
FROM Orders;

--Question #4
SELECT OrderID, OrderDate, DATEADD(day, 2, OrderDate) AS ApproxShipDate, ShipDate, DATEDIFF(day, OrderDate, ShipDate) 
	AS DaysToShip
FROM Orders
WHERE MONTH(OrderDate) = 3;

--Question #5
SELECT OrderDate, YEAR(OrderDate), DAY(OrderDate), DATEADD(day, 30, OrderDate)
FROM Orders
WHERE OrderDate < EOMONTH(OrderDate);

--Question #6
SELECT OrderDate, EmailAddress, SUM((ItemPrice - DiscountAmount) * Quantity) AS OrderTotal,
	RANK() OVER(ORDER BY SUM((ItemPrice - DiscountAmount) * Quantity) DESC) AS OrderTotalRank,
	DENSE_RANK() OVER(ORDER BY SUM((ItemPrice - DiscountAmount) * Quantity) DESC) AS DenseRank
FROM Customers JOIN Orders 
	ON Customers.CustomerID = Orders.CustomerID
		JOIN OrderItems
			ON Orders.OrderID = OrderItems.OrderID
GROUP BY OrderItems.OrderID, Orders.OrderDate, Customers.EmailAddress