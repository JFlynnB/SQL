/*
J. Flynn Billinghurst
Assignment # 13
2015-4-26
*/

USE MyGuitarShop;
GO

--Question #1
CREATE PROC spInsertCategory
	@CategoryName varchar(40)
AS
INSERT INTO Categories ("CategoryName")
VALUES (@CategoryName);

EXEC spInsertCategory 'Microphones';
EXEC spInsertCategory 'Violins';

--Question #2
CREATE FUNCTION fnDiscountPrice
	(@itemID int)
	RETURNS money
BEGIN
	RETURN(
	SELECT ItemPrice - DiscountAmount
	FROM OrderItems
	WHERE ItemID = @itemID)
END

--Question #3
CREATE FUNCTION fnItemTotal
	(@itemID int)
	RETURNS money
BEGIN
	RETURN(
	SELECT dbo.fnItemTotal(@itemID) * Quantity
	FROM OrderItems
	WHERE ItemID = @itemID)
END

--Question #4
CREATE PROC spInsertProduct
	@CatID int = null,
	@ProductCode varchar(10) = null,
	@ProductName varchar(255) = null,
	@ListPrice money = null,
	@DiscountPercent money = null
AS
IF @ListPrice < 0
	THROW 418, 'ListPrice cannot be a negative value', 1;
IF @DiscountPercent < 0
	THROW 50000, 'DiscountPrice cannot be a negative value', 1;
INSERT INTO Products 
	("CategoryID", "ProductCode", "ProductName", "Description", "ListPrice", "DiscountPercent", "DateAdded")
VALUES (@CatID, @ProductCode, @ProductName, '', @ListPrice, @DiscountPercent, GETDATE());

EXEC spInsertProduct 100, 'sq-pb', 'Squire P-Bass', 249.88, 50.00;
EXEC spInsertProduct 22222, 'ib-2r500', 'Ibanez SR500PB', 699.88, 100.00;

--Question #5
CREATE PROC spUpdateProductDiscount
	@productID int = null,
	@discountPercent money = null
AS
IF @discountPercent < 0
	THROW 50001, 'The value for DiscountPercent cannot be negative', 1;
UPDATE Products
SET DiscountPercent = @discountPercent
WHERE ProductID = @productID;

EXEC spUpdateProductDiscount 599, 5.00;
EXEC spUpdateProductDiscount 999, -15.00;

--Question #6
CREATE TRIGGER Products_UPDATE
	ON Products AFTER UPDATE
AS
	IF EXISTS
	(SELECT *
	FROM Products
	WHERE DiscountPercent < 0 OR DiscountPercent > 100)
		BEGIN
			;
			THROW 60001, 'DiscountPercent must be between 0 and 100', 1;
			ROLLBACK TRAN;
		END;
	UPDATE Products
	SET DiscountPercent = DiscountPercent * 100
	WHERE DiscountPercent BETWEEN 0 AND 1;

UPDATE Products
SET DiscountPercent = 0.35
WHERE ProductID = 299;

UPDATE Products
SET DiscountPercent = 120
WHERE ProductID = 199;

--Question #7
CREATE TRIGGER Products_INSERT
	ON Products AFTER INSERT
AS
	UPDATE Products
	SET DateAdded = GETDATE()
	WHERE DateAdded = NULL;

INSERT INTO Products
VALUES (22222, 'ib-2r400', 'Ibanez SR400PB', '', 699.88, 100.00, NULL);

--Question #8
CREATE TABLE ProductsAudit
(AuditID int PRIMARY KEY IDENTITY NOT NULL,
ProductID int NOT NULL,
CategoryID int NULL,
ProductCode varchar(10) NOT NULL,
ProductName varchar(255) NOT NULL,
ListPrice money NOT NULL,
DiscountPercent money NOT NULL,
DateUpdated datetime NULL);

CREATE TRIGGER Products_UPDATE2
	ON Products AFTER UPDATE
AS
	SELECT ProductID, CategoryID, ProductCode, ProductName, ListPrice, DiscountPercent, GETDATE() AS DateUpdated
	INTO ProductsAudit
	FROM deleted;


UPDATE Products
SET ProductCode = 'SR'
WHERE ProductCode = 'ib-2r400';