/*

1.	HL Road Frame - Red, 56
2.	Classic Vest, M
3.	17.7619
4.	Lowest: 742.35	Highest: 2384.07	Average: 1425.25
5.	Chloe
6.	Kyle E Adams

*/

USE AdventureWorksDW2017;

-- 1.   Using AdventureWorksDW2014, list the product category, product subcategory, product name, product key, list price and status 
--      for all current Component products.
--      Sort by ListPrice from highest to lowest, and ProductKey in ascending order.
--      Include the code you used to determine the answer.
--      11 points
--		I got 95 rows
--		What is the product name in row 5?
--      Put your answer here ==>	HL Road Frame - Red, 56

SELECT PC.EnglishProductCategoryName, PS.EnglishProductSubcategoryName, P.EnglishProductName, P.ProductKey, P.ListPrice, P.Status
FROM dbo.DimProduct AS P
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
	INNER JOIN dbo.DimProductCategory AS PC
	ON PS.ProductCategoryKey = PC.ProductCategoryKey
WHERE P.Status = 'Current' AND PC.EnglishProductCategoryName = 'Components'
ORDER BY P.ListPrice DESC, P.ProductKey ASC;


-- 2.   Using AdventureWorksDW2014, list the names of the resellers who placed orders in 2013 for Clothing. 
--	    Show the reseller name, order date as mm/dd/yyyy, product name, product category name and
--	    product subcategory name. Sort the results by reseller name and EnglishProductName in alphabetical order. 
--      Include the code you used to determine the answer.
--      11 points
--		I got 5483 rows
--		What is the EnglishProductName in row 5?
--      Put your answer here ==>	Classic Vest, M

SELECT R.ResellerName, CONVERT(nvarchar, FRS.OrderDate, 101) AS OrderDate, P.EnglishProductName, PC.EnglishProductCategoryName, PS.EnglishProductSubcategoryName
FROM dbo.FactResellerSales AS FRS
	INNER JOIN dbo.DimReseller AS R
	ON FRS.ResellerKey = R.ResellerKey
	INNER JOIN dbo.DimProduct AS P
	ON FRS.ProductKey = P.ProductKey
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
	INNER JOIN dbo.DimProductCategory AS PC
	ON PS.ProductCategoryKey = PC.ProductCategoryKey
WHERE FRS.OrderDate LIKE '%2013%' AND PC.EnglishProductCategoryName = 'Clothing'
ORDER BY R.ResellerName, P.EnglishProductName;


---------------------------------------------------------------------------------------------------
-- 3.   Using AdventureWorksDW2014, list employee marital status, the number of employees reporting each level of marital status, 
--		and the average BaseRate for each marital status. 
--      Include the code you used to determine the answer. 
--      10 points
--		I got 2 rows
--		Question: What's the average Base rate of employees who are married?
--      Put your answer here ==>	17.7619

SELECT MaritalStatus, COUNT(*) NumberOfEmployees, AVG(BaseRate) AS AverageBaseRate
FROM dbo.DimEmployee
GROUP BY MaritalStatus;


---------------------------------------------------------------------------------------------------
-- 4.	Using AdventureWorksDW2014, what is the the lowest list price, the highest list price, and the average list price for Touring Bikes.
--		Round to 2 decimal places.
--      Include the code you used to determine the answer. 
--      12 points
--      Put your answer here ==>	Lowest: 742.35	Highest: 2384.07	Average: 1425.25

SELECT MIN(ListPrice) AS LowestListPrice, MAX(ListPrice) AS HighestListPrice, ROUND(AVG(ListPrice), 2) AS AverageListPrice
FROM dbo.DimProduct AS P
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
	INNER JOIN dbo.DimProductCategory AS PC
	ON PS.ProductCategoryKey = PC.ProductCategoryKey
WHERE PS.EnglishProductSubcategoryName = 'Touring Bikes'



---------------------------------------------------------------------------------------------------
-- 5.	Using AdventureWorksDW2014, list all the Canadian customers who have spent more than $5,000 total.
--		Show CustomerKey, FirstName, LastName, and total sales amount rounded to 2 decimal places.
--      Sort by the total sales amount in descending order.
--      Include the code you used to determine the answer. 
--      16 points
--		I got 42 rows
--		Question: What is the name of the first name in record 2?
--      Put your answer here ==>	Chloe

SELECT C.CustomerKey, C.FirstName, C.LastName, ROUND(SUM(FIS.SalesAmount), 2) AS TotalSalesAmount
FROM dbo.FactInternetSales AS FIS
	INNER JOIN dbo.DimCustomer AS C
	ON FIS.CustomerKey = C.CustomerKey
	INNER JOIN dbo.DimGeography AS G
	ON C.GeographyKey = G.GeographyKey
WHERE G.EnglishCountryRegionName = 'Canada'
GROUP BY C.CustomerKey, C.FirstName, C.LastName
HAVING ROUND(SUM(FIS.SalesAmount), 2) > 5000
ORDER BY TotalSalesAmount DESC;


---------------------------------------------------------------------------------------------------
--	6(Optional).Use AdventureWorksDW2014. The company wants to make a contact list for customers in the United Kingdom and Canada who own at least one car, 
--      and whose yearly income is equal to or more than the average yearly income of U.S. customers.
--		List their full name (concatenated first, middle and last), country, phone number and email address. 
--      Sort by last name, first name, and country in ascending order.
--      Include the code you used to determine the answer. 
--      10 points
--		No hint on rows
--		Question: What is the full name in record 3?
--      Put your answer here ==>	Kyle E Adams

SELECT CONCAT(C.FirstName, ' ', C.MiddleName, ' ', C.LastName) AS FullName, G.EnglishCountryRegionName, C.Phone, C.EmailAddress
FROM dbo.DimCustomer AS C
	INNER JOIN dbo.DimGeography AS G
	ON C.GeographyKey = G.GeographyKey
WHERE G.EnglishCountryRegionName IN ('United Kingdom', 'Canada') AND NumberCarsOwned > 1 AND C.YearlyIncome >=
	(SELECT AVG(C.YearlyIncome)
	FROM dbo.DimCustomer AS C
		INNER JOIN dbo.DimGeography AS G
		ON C.GeographyKey = G.GeographyKey
	WHERE G.EnglishCountryRegionName = 'United States')
ORDER BY C.LastName, C.FirstName, G.EnglishCountryRegionName