USE MyGuitarShop;

SELECT CategoryName, ProductName, ListPrice
FROM Categories JOIN Products ON Products.CategoryID = Categories.CategoryID
ORDER BY ProductName ASC;

SELECT FirstName, LastName, Line1, City, Addresses.State, ZipCode
FROM Customers JOIN Addresses ON Customers.CustomerID = Addresses.CustomerID
WHERE EmailAddress = 'allan.sherwood@yahoo.com';

SELECT FirstName, LastName, Line1, City, Addresses.State, ZipCode
FROM Customers JOIN Addresses ON Customers.CustomerID = Addresses.CustomerID
WHERE AddressID = ShippingAddressID;

SELECT LastName, FirstName, OrderDate, ProductName, ItemPrice, DiscountAmount, Quantity
FROM Customers AS c JOIN Orders AS o ON c.CustomerID = o.CustomerID 
     JOIN OrderItems AS oi ON o.OrderID = oi.OrderID
	 JOIN Products AS p ON p.ProductID = oi.ProductID
ORDER BY LastName, OrderDate, ProductName;

SELECT p1.ProductName, p1.ListPrice
FROM Products AS p1 JOIN Products AS p2
	ON p1.ListPrice = p2.ListPrice AND p1.ProductID <> p2.ProductID
ORDER BY ProductName;

SELECT CategoryName, ProductID
FROM Categories LEFT JOIN  Products ON Categories.CategoryID = Products.CategoryID
WHERE ProductID IS NULL;

SELECT 'SHIPPED' AS ShipStatus, OrderID, OrderDate
FROM Orders
WHERE ShipDate IS NOT NULL
UNION
SELECT 'NOT SHIPPED' AS ShipStatus, OrderID, OrderDate
FROM Orders
WHERE ShipDate IS NULL
ORDER BY OrderDate
