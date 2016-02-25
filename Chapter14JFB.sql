/*
J. Flynn Billinghurst
Assignment # 12
2015-4-22
*/

USE MyGuitarShop;
GO

--Question #1
DECLARE @numProducts int;

SELECT @numProducts = COUNT(*)
FROM Products;

IF @numProducts >= 7
	PRINT 'The number of products is greater than or equal to 7';
ELSE
	PRINT 'The number of products is less than 7';
GO

--Question #2
DECLARE @numProducts int, @averagePrice decimal;

SELECT @numProducts = COUNT(*), @averagePrice = AVG(ListPrice)
FROM Products;

IF @numProducts >= 7
	BEGIN
		PRINT 'The number of products is ' + CONVERT(varchar, @numProducts,1);
		PRINT 'The average price of the products is ' + CONVERT(varchar, @averagePrice, 1);
	END
ELSE
	PRINT 'The number of products is less than 7';
GO

--Question #3
DECLARE @iterator tinyint;
SET @iterator = 1;
PRINT 'Common factors of 10 and 20';

WHILE @iterator <= 10
	BEGIN
		IF 10 % @iterator = 0 AND 20 % @iterator = 0
			PRINT CONVERT(varchar, @iterator, 1);
		SET @iterator = @iterator + 1;
	END;
GO

--Question #4
BEGIN TRY
	INSERT INTO Categories VALUES ('Guitars');
	PRINT 'SUCCESS: Record was inserted.';
END TRY
BEGIN CATCH
	PRINT 'FAILURE: Record was not inserted.';
	PRINT 'ERROR ' + CONVERT(varchar, ERROR_NUMBER(),1) + ': ' + ERROR_MESSAGE();
END CATCH
GO

--Question #5
/* Instructions unclear. "return a single column that represents the number of rows in the first table"
  Wouldn't an integer represent the total number of columns? Perhaps a table containing only a 
  single cell should be displayed? Return a 'single column'. With what in it? The IDs? They don't always 
  tell you haw many there are. Just '1, 2, 3, 4...'? How do I do that? With a script, I guess. I'm going 
  with this. 
*/
DECLARE @tableTitle varchar(20);
--DECLARE @instructions varchar(1000);
SET @tableTitle = 
	(SELECT TOP 1 name
	FROM sys.tables
	WHERE name <> 'dtproperties' AND name <> 'sysdiagrams'
	ORDER BY name ASC);
--SET @instructions = ;

EXECUTE('DECLARE @Total' + @tableTitle + ' TABLE; SET @Total' + @tableTitle + ' = (SELECT COUNT(*) FROM ' + @tableTitle + '); SELECT * FROM @Total' + @tableTitle + '');