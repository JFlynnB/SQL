/*
J. Flynn Billinghurst
Assignment #7
2015-4-6
*/

USE MyGuitarShop;

--Question #1
INSERT INTO Categories
VALUES ('Brass');

--Question #2
UPDATE Categories
SET CategoryName = 'Woodwinds'
WHERE CategoryName = 'Brass';

--Question #3
DELETE Categories
WHERE CategoryID = 44445;

--Question #4
INSERT INTO Products (CategoryID, ProductCode, ProductName, Description, ListPrice, DiscountPercent, DateAdded)
VALUES (44444, 'dgx_640', 'Yamaha DGX 640 88-Key Digital Piano', 'Long description to come.', 799.99, 0, GETDATE());

--Question #5
UPDATE Products
SET DiscountPercent = 35
WHERE ProductCode = 'dgx_640';

--Question #6
DELETE Products
WHERE CategoryID = 44444;
DELETE Categories
WHERE CategoryID = 44444;

--Question #7
INSERT INTO Customers (EmailAddress, Password, FirstName, LastName)
VALUES ('rick@raven.com', '', 'Rick', 'Raven');

--Question #8
UPDATE Customers
SET Password = 'secret'
WHERE EmailAddress = 'rick@raven.com';

--Question #9
UPDATE Customers
SET Password = 'reset';
