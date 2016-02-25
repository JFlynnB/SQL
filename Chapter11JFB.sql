/*
J. Flynn Billinghurst
Assignment #11
2015-4-15
*/

--Question #1
USE MyGuitarShop;
CREATE INDEX ZipCodeIndex ON Addresses (ZipCode);

--Question #2
USE master;

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'MyWebDB')
DROP DATABASE MyWebDB;

CREATE DATABASE MyWebDB;
GO

USE MyWebDB;

CREATE TABLE Users
(UserID         INT            NOT NULL PRIMARY KEY IDENTITY,
EmailAddress    VARCHAR(35)    NULL,
FirstName       VARCHAR(15)    NOT NULL,
LastName        VARCHAR(25)    NOT NULL);

CREATE TABLE Products
(ProductID      INT            NOT NULL PRIMARY KEY IDENTITY,
ProductName     VARCHAR(25)    NOT NULL);

CREATE TABLE Downloads
(DownloadID     INT            NOT NULL PRIMARY KEY IDENTITY,
UserID          INT            NOT NULL REFERENCES Users(UserID),
DownloadDate    DATETIME2      NOT NULL,        
FileName        VARCHAR(50)    NOT NULL,
ProductID       INT            NOT NULL REFERENCES Products(ProductID));

CREATE INDEX FileIndex ON Downloads(FileName);

--Question #3
INSERT INTO Users --(EmailAddress, FirstName, LastName)
VALUES 
('guy@somewhere.com', 'Guy', 'Fawkes'),
('dude@someplace.org', 'Dude', 'Simpson');

INSERT INTO Products VALUES
('Minecraft'),
('Halo 4');

INSERT INTO Downloads
VALUES
(1, GETDATE(), 'halo_4.iso', 2),
(2, GETDATE(), 'minecraft.exe', 1),
(2, GETDATE(), 'halo_4.iso', 2);

SELECT EmailAddress, FirstName, LastName, DownloadDate, FileName, ProductName
FROM Users JOIN Downloads 
		ON Users.UserID = Downloads.UserID
	JOIN Products
		ON Downloads.ProductID = Products.ProductID
ORDER BY EmailAddress DESC, ProductName ASC;

--Question #4
ALTER TABLE Products
ADD ProductPrice DECIMAL(5,2) DEFAULT 9.99;

ALTER TABLE Products
ADD ProductAddDate DATETIME2;

--Question #5
ALTER TABLE Users
ALTER COLUMN FirstName VARCHAR(20) NOT NULL;

UPDATE Users
SET FirstName=NULL
WHERE FirstName='Dude';

UPDATE Users
SET FirstName='Supercalifragilisticexpialidocious'
WHERE FirstName='Guy';