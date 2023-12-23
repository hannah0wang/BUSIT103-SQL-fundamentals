-- Week 10 Group Problem

-- List the names of the people in your group:
-- Hannah Wang

USE AdventureWorksDW2017;

-- List all the bikes that have not been sold to customers and have a list price less than the average list price of all bikes.
-- List the EnglishProductName and ListPrice.
-- Sort by ListPrice in descending order and EnglishProductName in ascending order.
-- I got 9 rows.
-- What is the EnglishProductName in row 7?
-- YOUR ANSWER: Mountain-300 Black, 40

SELECT P.EnglishProductName, P.ListPrice
FROM dbo.FactInternetSales AS FIS
	RIGHT OUTER JOIN dbo.DimProduct AS P
	ON FIS.ProductKey = P.ProductKey
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
	INNER JOIN dbo.DimProductCategory AS PC
	ON PS.ProductCategoryKey = PC.ProductCategoryKey
WHERE FIS.ProductKey IS NULL AND PC.EnglishProductCategoryName = 'Bikes' AND P.ListPrice <
	(SELECT AVG(P.ListPrice) AS AvgListPrice
	FROM dbo.DimProduct AS P
		INNER JOIN dbo.DimProductSubcategory AS PS
		ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
		INNER JOIN dbo.DimProductCategory AS PC
		ON PS.ProductCategoryKey = PC.ProductCategoryKey
		WHERE PC.EnglishProductCategoryName = 'Bikes')
ORDER BY P.ListPrice DESC, P.EnglishProductName ASC;

