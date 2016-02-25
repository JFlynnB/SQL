/*
J. Flynn Billinghurst
Assignment #11
2015-4-20
*/

USE MyGuitarShop;
GO

--Question #1
CREATE VIEW CustomerAddresses
AS
SELECT CustID AS CustomerID, EmailAddress, LastName, FirstName,
	BillLine1, BillLine2, BillCity, BillState, BillZip,
	Line1 AS ShipLine1, Line2 AS ShipLine2, City AS ShipCity,
	State AS ShipState, ZipCode AS ShipZip
FROM
(
SELECT Customers.CustomerID AS CustID, EmailAddress, LastName, FirstName,
	 Line1 AS BillLine1, Line2 AS BillLine2, City AS BillCity,
	 State AS BillState, ZipCode AS BillZip, ShippingAddressID
FROM Customers JOIN Addresses ON Customers.BillingAddressID = Addresses.AddressID
) AS CustomerInfo JOIN Addresses ON CustomerInfo.ShippingAddressID = Addresses.AddressID;


--Question #2
SELECT CustomerID, LastName, FirstName, BillLine1
FROM CustomerAddresses;

--Question #3
UPDATE CustomerAddresses
SET ShipLine1 = '1990 Westwood Blvd'
WHERE CustomerID = 8;

--Question #4
CREATE VIEW OrderItemProducts
AS
SELECT Orders.OrderID, OrderDate, TaxAmount, ShipDate,
	ItemPrice, DiscountAmount, ItemPrice - DiscountAmount AS FinalPrice,
	Quantity, (ItemPrice - DiscountAmount) * Quantity AS ItemTotal,
	ProductName
FROM Products JOIN OrderItems ON Products.ProductID = OrderItems.ProductID
	JOIN Orders ON OrderItems.OrderID = Orders.OrderID;


--Question #5
CREATE VIEW ProductSummary
AS
SELECT ProductName, SUM(Quantity) AS OrderCount, SUM(ItemTotal) AS OrderTotal
FROM OrderItemProducts
GROUP BY ProductName;

--Question #6
SELECT TOP 5 ProductName, OrderCount, OrderTotal
FROM ProductSummary
ORDER BY OrderCount DESC, OrderTotal DESC;
