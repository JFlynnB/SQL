/*
J. Flynn Billinghurst
Assignment #8
2015-4-9
*/

USE MyGuitarShop;

--Question #1
SELECT CAST(ListPrice AS decimal(10,1)), CONVERT(integer, ListPrice), CAST(ListPrice AS integer)
FROM Products;

--Question #2
SELECT DateAdded, CAST(DateAdded AS date), CAST(DateAdded AS time(3)), CAST(DateAdded AS varchar(6))
FROM Products;

--Question #3
SELECT CONVERT(varchar, OrderDate, 101), CONVERT(varchar, OrderDate, 100), CONVERT(varchar, OrderDate, 108)
FROM Orders;