/*
J. Flynn Billinghurst
Assignment #6
2015-4-2
*/

USE MyGuitarShop;

--Question #1
SELECT CategoryName
FROM Categories
WHERE CategoryID IN
	(SELECT DISTINCT CategoryID
	 FROM Products )
ORDER BY CategoryName;

--Question #2
SELECT ProductName, ListPrice
FROM Products
WHERE ListPrice >
	(SELECT AVG(ListPrice)
	 FROM Products)
ORDER BY ListPrice DESC;

--Question #3
SELECT CategoryName
FROM Categories
WHERE NOT EXISTS
	(SELECT CategoryID
	 FROM Products
	 WHERE Products.CategoryID = Categories.CategoryID);

--Question #4
SELECT c.EmailAddress, MAX(sq.OrderTotal) AS LargestOrder
FROM
	(SELECT EmailAddress, oSub.OrderID, SUM(ItemPrice * Quantity) AS OrderTotal
	 FROM Customers cSub JOIN Orders oSub 
		ON cSub. CustomerID = oSub. CustomerID
		JOIN OrderItems oiSub 
		ON oSub.OrderID = oiSub.OrderID
	 GROUP BY EmailAddress, oSub.OrderID) AS sq JOIN Customers AS c ON c.EmailAddress = sq.EmailAddress
GROUP BY c.EmailAddress;

--Question #5
SELECT ProductName, DiscountPercent
FROM Products AS p
WHERE p.DiscountPercent NOT IN
	(SELECT DiscountPercent 
	FROM Products AS pSub
	GROUP BY pSub.DiscountPercent
	HAVING COUNT(pSub.DiscountPercent) > 1); 


--Question #6
SELECT DISTINCT EmailAddress, 
	(SELECT MIN(OrderDate)
	 FROM Orders AS oSub 
	 WHERE oSub.CustomerID = Customers.CustomerID) AS OrderDate
FROM Customers LEFT JOIN Orders AS o ON o.CustomerID = Customers.CustomerID
ORDER BY EmailAddress;
