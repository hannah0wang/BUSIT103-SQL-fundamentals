
/*
1.	Mountain Bike Socks, M
2.	Minipump
3.	64
4.	Lowest: 333.42	Highest: 1003.91	Average: 631.42
5.	Thrilling Bike Tours	54331.84
6.	Road Frames
7.	Essonne		Country Parts Shop		Earliest: 2011.12.29	Latest: 2013.11.29
8.	Kate K Anand

*/



USE AdventureWorksDW2017;


-- 1.   List the product category name, product subcategory, product name, product key, product alternate key, and end date 
--      for products that have are no longer sold.
--		Hint: Products that are no longer sold have an end date.
--      Sort by product key in ascending order.
--      Include the code you used to determine the answer.
--      5 points
--		What is the product name in row 5?
--      Put your answer here ==>	Mountain Bike Socks, M

SELECT PC.EnglishProductCategoryName, PS.EnglishProductSubcategoryName, P.EnglishProductName, P.ProductKey, P.ProductAlternateKey, P.EndDate
FROM DimProduct AS P
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
	INNER JOIN dbo.DimProductCategory AS PC
	ON PS.ProductCategoryKey = PC.ProductCategoryKey
WHERE P.EndDate IS NOT NULL
ORDER BY P.ProductKey ASC;


-----------------------------------------------------------------------------------
-- 2.   What accessories products have we not sold over the internet? Sort by EnglishProductName in alphabetical order.
--      Include the code you used to determine the answer.
--      10 points
--      What is the EnglishProductName in row 4?
--      Put your answer here ==>	Minipump

SELECT P.EnglishProductName
FROM dbo.FactInternetSales AS FIS
	RIGHT OUTER JOIN dbo.DimProduct AS P
	ON FIS.ProductKey = P.ProductKey
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
	INNER JOIN dbo.DimProductCategory AS PC
	ON PS.ProductCategoryKey = PC.ProductCategoryKey
WHERE FIS.ProductKey IS NULL AND PC.EnglishProductCategoryName = 'Accessories'
ORDER BY P.EnglishProductName ASC;


---------------------------------------------------------------------------------------------------
-- 3.   List department name, the number of employees, the total sick leave hours,
--		and the average sick leave hours in each department.
--		Sort by DepartmentName in alphabetical order. 
--      Include the code you used to determine the answer. 
--		Hint: Use the DimEmployee table.
--      4 points
--		Question: What is the average sick leave hours in row 4?
--      Put your answer here ==>	64

SELECT DepartmentName, COUNT (*) AS EmployeeCount, SUM(SickLeaveHours) AS TotalSickLeaveHours, AVG(SickLeaveHours) AS AvgSickLeaveHours
FROM dbo.DimEmployee
GROUP BY DepartmentName
ORDER BY DepartmentName ASC;


---------------------------------------------------------------------------------------------------
-- 4.	What is the the lowest list price, the highest list price, and the average list price for touring frames.
--		Round to 2 decimal places.
--		Hint: Explore the data in DimProductSubcategory.
--      Include the code you used to determine the answer. 
--      5 points
--		Question: What is the the lowest list price, the highest list price, and the average list price for touring frames.
--      Put your answer here ==>	Lowest: 333.42	Highest: 1003.91	Average: 631.42


SELECT MIN(P.ListPrice) AS LowestPrice, MAX(P.ListPrice) AS HighestPrice, ROUND(AVG(P.ListPrice), 2) AS AveragePrice
FROM dbo.DimProduct AS P
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
WHERE PS.EnglishProductSubcategoryName = 'Touring Frames'


---------------------------------------------------------------------------------------------------
-- 5.	Show a list of resellers that are not a value added reseller business type and 
--		that have a total sales amount between $20,000 and $60,000 in 2013?
--		Show reseller name, business type and total sales amount rounded to 2 decimal places.
--      Sort by the total sales amount in descending order.
--      Include the code you used to determine the answer. 
--      10 points
--		Question: What is the name of the reseller and the total sales amount in record 4?
--      Put your answer here ==>	Thrilling Bike Tours	54331.84

SELECT R.ResellerName, R.BusinessType, ROUND(SUM(FRS.SalesAmount), 2) AS TotalSalesAmount
FROM dbo.FactResellerSales AS FRS
	INNER JOIN dbo.DimReseller AS R
	ON FRS.ResellerKey = R.ResellerKey
WHERE FRS.OrderDate LIKE '%2013%'
GROUP BY R.ResellerName, R.BusinessType
HAVING ROUND(SUM(FRS.SalesAmount), 2) BETWEEN 20000 AND 60000
ORDER BY TotalSalesAmount DESC;


---------------------------------------------------------------------------------------------------
-- 6.	For each product subcategory, list category name, subcategory name and the average list price, 
--		the lowest list price, the highest list price, and the number of products.
--		Sort by average price highest to lowest.
--      Include the code you used to determine the answer. 
--      5 points
--		Question: What is name of the subcategory in row 5?
--      Put your answer here ==>	Road Frames

SELECT PC.EnglishProductCategoryName, PS.EnglishProductSubcategoryName, AVG(P.ListPrice) AS AvgListPrice,
MIN(ListPrice) AS LowestListPrice, MAX(ListPrice) AS HighestListPrice, COUNT (*) AS ProductCount
FROM dbo.DimProduct AS P
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
	INNER JOIN dbo.DimProductCategory AS PC
	ON PS.ProductCategoryKey = PC.ProductCategoryKey
GROUP BY PS.EnglishProductSubcategoryName, PC.EnglishProductCategoryName
ORDER BY AvgListPrice DESC;


---------------------------------------------------------------------------------------------------
--  7.	List country name, stateprovince name, reseller name, the earliest order date, and the most recent order for French or German resellers. 
--		Show the date fields in the format of yyyy.mm.dd.
--		Sort by country, stateprovince and reseller name in alphabetical order.
--		Question: What is the state, the reseller name, the earliest order date, and the most recent order date in row 2? 
--      Put your answer here ==>	Essonne		Country Parts Shop		Earliest: 2011.12.29	Latest: 2013.11.29
--      10 points

SELECT G.EnglishCountryRegionName, G.StateProvinceName, R.ResellerName, CONVERT(varchar, MIN(OrderDate), 102) AS EarliestOrderDate, 
CONVERT(varchar, MAX(OrderDate), 102) AS LatestOrderDate
FROM dbo.FactResellerSales AS FRS
	INNER JOIN dbo.DimGeography AS G
	ON FRS.SalesTerritoryKey = G.SalesTerritoryKey
	INNER JOIN dbo.DimReseller AS R
	ON G.GeographyKey = R.GeographyKey
WHERE G.EnglishCountryRegionName IN ('France', 'Germany')
GROUP BY G.EnglishCountryRegionName, G.StateProvinceName, R.ResellerName
ORDER BY G.EnglishCountryRegionName, G.StateProvinceName, R.ResellerName


---------------------------------------------------------------------------------------------------
--	8.	The company wants to make a contact list for customers in France who own more than two cars, 
--      and whose yearly income is equal to or more than the average yearly income of U.S. customers.
--		List their full name (concatenated first, middle and last), country, phone number and email address. 
--      Sort by last name, first name, and country in ascending order.
--      Include the code you used to determine the answer. 
--      11 points
--		Question: What is the full name in record 3?
--      Put your answer here ==>	Kate K Anand

SELECT CONCAT(C.FirstName, ' ', C.MiddleName, ' ', C.LastName) AS FullName, G.EnglishCountryRegionName, C.Phone, C.EmailAddress
FROM dbo.DimCustomer AS C
	INNER JOIN dbo.DimGeography AS G
	ON C.GeographyKey = G.GeographyKey
WHERE C.NumberCarsOwned > 2 AND G.EnglishCountryRegionName = 'France' AND C.YearlyIncome >=
	(SELECT AVG(YearlyIncome)
	FROM dbo.DimCustomer AS C
		INNER JOIN dbo.DimGeography AS G
		ON C.GeographyKey = G.GeographyKey
	WHERE G.EnglishCountryRegionName = 'United States')
ORDER BY C.LastName, C.FirstName, G.EnglishCountryRegionName;
