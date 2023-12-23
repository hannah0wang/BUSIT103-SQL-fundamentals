/*--------------------------------------------------------------------------------------------------------------------
--
-- BUSIT 103           Assignment   #11              DUE DATE :  Consult course calendar
--
--------------------------------------------------------------------------------------------------------------------

1a.	0
1b.	40
1c.	Surprise
2a.	0
2b.	101
2c.	12
2d.	Warehouse	76
2e.	133073.59
3a.	Bikes Anyone?
3b.	Vigorous Exercise Company
3c.	973.67
3d.	Sturdy Toys
4a.	Bachelors	5356
4b.	64395.07
5.	12/13/2013
6.	Which bikes with a list price under $2000 were bought by customers over the internet?
	List product name, list price, and total number of sales for each product.

SELECT P.EnglishProductName, ROUND(P.ListPrice, 2) AS ListPrice, COUNT (*) AS NumberSold
FROM dbo.FactInternetSales AS FIS
	INNER JOIN dbo.DimProduct AS P
	ON FIS.ProductKey = P.ProductKey
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
	INNER JOIN dbo.DimProductCategory AS PC
	ON PS.ProductCategoryKey = PC.ProductCategoryKey
WHERE PC.EnglishProductCategoryName = 'Bikes'
GROUP BY P.EnglishProductName, P.ListPrice
HAVING P.ListPrice < 2000;

Grouping and Summarizing Data

PURPOSE:

Knowledge:
 
    o Explain the purpose of the GROUP BY clause
    o Explain the purpose of the HAVING clause
    o Explain the difference between WHERE and HAVING
      
Skills:

    o  Use the GROUP BY clause to return columns that are not a result of an aggregate calculation
	o  Use the HAVING clause filter the result of an aggregate calculation

TASK:

    1. Download the following SQL file and rename it Xxxxx-SQL-Assignment-11, where Xxxxx is your last and first name. 
	For example, I would rename this file ChengCharlene-SQL-Assignment-11.sql.

		Xxxxx-SQL-Assignment-11.sql

    2. Open the file in SQL Server Management Studio (SSMS).

    3. Add your SQL code in the space provided below each question. The questions are written as comments so they will not execute in SQL Server. 

    4. Proofread your document to make sure all questions are answered completely and that it is easy to distinguish your responses from the questions on the page.

    5. Return to this assignment page, attach your completed file, and submit.

 

CRITERIA:

    o Answer all the questions
    o If you do not understand a question, did you ask for help from the teacher, a classmate, the Discussion board, or a tutor?
    o Your answer/query is in the right place underneath the question
    o Your answer/query is not commented out
    o Your answer/query executes without an error
    o You have renamed the file as specified above and submitted it via Canvas
    o If you cannot complete the assignment, did you communicate with the teacher (before the due date) so that he/she/they understands your situation?



--------------------------------------------------------------------------------------------------------------------
-- AdventureWorks wants to improve its marketing strategies. Management is interested in learning more about the 
-- company's reseller base. Management wants to know such things as where resellers are located, which banks 
-- resellers use, how often resellers order, and about the ordering patterns. */
--------------------------------------------------------------------------------------------------------------------

USE AdventureWorksDW2017;

-- 1.	AdventureWorks management wants geographic information about their resellers. 
--		Be sure to add a meaningful sort as appropriate and give each derived column an alias.

-- 1.a.	First check to determine if there are resellers without geography info.
--		QUESTION:	How many resellers are there with no geography info?	
--		YOUR ANSWER: 0

SELECT COUNT (*) AS ResellersWOGeo
FROM dbo.DimReseller AS R
	LEFT OUTER JOIN dbo.DimGeography AS G
	ON R.GeographyKey = G.GeographyKey
WHERE R.GeographyKey IS NULL;


-- 1b.	Display a count of resellers in each country.
--		Show country name and the count of resellers. Sort by country name in ascending order.
--		I got 6 rows
--		QUESTION:	How many resellers are there in record 5?	
--		YOUR ANSWER==>	40

SELECT G.EnglishCountryRegionName, COUNT (*) AS ResellersInCountry
FROM dbo.DimReseller AS R
	INNER JOIN dbo.DimGeography AS G
	ON R.GeographyKey = G.GeographyKey
GROUP BY G.EnglishCountryRegionName
ORDER BY G.EnglishCountryRegionName ASC;


-- 1c.	Display a count of resellers in each City. 
--		Show count of resellers, City name, State name, and Country name. Sort by EnglishCountryRegionaName DESC, StateProvince ASC, and City ASC.
--		I got 468 rows
--		QUESTION:	What is the city name in record 11?	
--		YOUR ANSWER==>	Surprise

SELECT COUNT (*) AS ResellersInCity, G.City, G.StateProvinceName, G.EnglishCountryRegionName
FROM dbo.DimReseller AS R
	INNER JOIN dbo.DimGeography AS G
	ON R.GeographyKey = G.GeographyKey
GROUP BY G.City,  G.StateProvinceName, G.EnglishCountryRegionName
ORDER BY G.EnglishCountryRegionName DESC, G.StateProvinceName ASC, G.City ASC;


-- 2a. 	Check to see if there are any resellers without a value in the bank name field. 
--		QUESTION:	How many resellers are without a value in the bank name field?
--		YOUR ANSWER==> 0

SELECT COUNT (*) AS ResellersWOBank
FROM dbo.DimReseller
WHERE BankName IS NULL;


-- 2b.	List the name of each bank and the number of resellers using that bank.
--		Sort by bank name in ascending order. 
--      I got 7 rows
--		QUESTION:	How many resellers use the bank identified in record 1?	
--		YOUR ANSWER==> 101

SELECT BankName, COUNT (*) AS ResellersUsingBank
FROM dbo.DimReseller
GROUP BY BankName
ORDER BY BankName ASC;


--2c.	List the year opened and the number of resellers opening in that year. 
--      I got 32 rows
--		QUESTION:	How many resellers opened in 1985?
--		YOUR ANSWER==> 12

SELECT YearOpened, COUNT (*) AS NumResellersOpened
FROM dbo.DimReseller
GROUP BY YearOpened;


-- 2d.	List the average number of employees in each of the three business types. Sort by business type in ascending order.
--      I got 3 rows
--		QUESTION:	What is the Business Type and average number of employees in record 3?
--		YOUR ANSWER==> Warehouse	76

SELECT BusinessType, AVG(NumberEmployees) AS AvgNumEmployees
FROM dbo.DimReseller
GROUP BY BusinessType
ORDER BY BusinessType ASC;


-- 2e.	List business type, the count of resellers in that type, and average of Annual Revenue 
--		in that business type. Sort by business type in ascending order.
--      I got 3 rows
--		QUESTION:	What is the average average annual revenue in record 1?
--		YOUR ANSWER==> 133073.59

SELECT BusinessType, COUNT (*) AS CountResellers, ROUND(AVG(AnnualRevenue), 2) AS AvgAnnualRevenue
FROM dbo.DimReseller
GROUP BY BusinessType
ORDER BY BusinessType ASC;


-- 3.	AdventureWorks wants information about sales to its resellers. Remember that Annual Revenue 
--		is a measure of the size of the business and is NOT the total of the AdventureWorks 
--		products sold to the reseller. Be sure to use SalesAmount when total sales are 
--		requested.

-- 3a. 	List the name of ANY reseller to which AdventureWorks has not sold a product. Sort by reseller name in ascending order.
--		Hint: Use a join.
--      I got 66 rows
--		QUESTION:	What is the name of the reseller in record 5?	
--		YOUR ANSWER==> Bikes Anyone?

SELECT R.ResellerName
FROM dbo.FactResellerSales AS FRS
	RIGHT OUTER JOIN dbo.DimReseller AS R
	ON FRS.ResellerKey = R.ResellerKey
WHERE FRS.ResellerKey IS NULL
ORDER BY R.ResellerName ASC;


-- 3b.	List ALL resellers and total of sales amount to each reseller. Show Reseller 
--		name, business type, and total sales with the sales showing two decimal places. 
--		Be sure to include resellers for which there were no sales. Sort by the total 
--		of sales amount in descending order. NULL will appear. 
--      I got 701 rows
--		QUESTION:	What is the ResellerName in record 3?		
--		YOUR ANSWER==> Vigorous Exercise Company

SELECT R.ResellerName, R.BusinessType, ROUND(SUM(FRS.SalesAmount), 2) AS TotalSales
FROM dbo.FactResellerSales AS FRS
	RIGHT OUTER JOIN dbo.DimReseller AS R
	ON FRS.ResellerKey = R.ResellerKey
GROUP BY R.ResellerName, R.BusinessType
ORDER BY TotalSales DESC;


-- 3c.	List resellers and total sales to each.  Show reseller name, business type, and total sales 
--		with the sales showing two decimal places. Limit the list to only those resellers to which 
--		total sales are less than $1,000 or more than $500,000. Sort by total sales in descending order.
--      I got 67 rows
--		QUESTION:	What is the dollar amount in the record 32?	
--		YOUR ANSWER==> 973.67

SELECT R.ResellerName, R.BusinessType, ROUND(SUM(FRS.SalesAmount), 2) AS TotalSales
FROM dbo.FactResellerSales AS FRS
	INNER JOIN dbo.DimReseller AS R
	ON FRS.ResellerKey = R.ResellerKey
GROUP BY R.ResellerName, R.BusinessType
HAVING ROUND(SUM(FRS.SalesAmount), 2) < 1000 OR ROUND(SUM(FRS.SalesAmount), 2) > 500000
ORDER BY TotalSales DESC;


-- 3d.	List resellers and total sales to each for 2013. Show Reseller name, business type, 
--		and total sales with the sales showing two decimal places. Limit the results to resellers to 
--		which the total sales are between $3,500 and $8,000 or between $60,000 and $90,000.
--		Sort by total sales in descending order.
--      I got 79 rows
--		QUESTION:	What is the name of the reseller in record 5?
--		YOUR ANSWER==> Sturdy Toys

SELECT ResellerName, BusinessType, ROUND(SUM(SalesAmount), 2) AS TotalSales
FROM dbo.FactResellerSales AS FRS
	INNER  JOIN dbo.DimReseller AS R
	ON FRS.ResellerKey = R.ResellerKey
WHERE OrderDate LIKE '%2013%'
GROUP BY ResellerName, BusinessType
HAVING (ROUND(SUM(SalesAmount), 2) BETWEEN 3500 AND 8000) OR (ROUND(SUM(SalesAmount), 2) BETWEEN 60000 AND 90000) 
ORDER BY TotalSales DESC;


--4a.	List customer education level (use EnglishEducation) and the number of customers reporting 
--		each level of education. Sort by EnglishEducation in ascending order.
--      I got 5 rows
--		QUESTION:	What is the EnglishEducation and customer count in record 1?
--		YOUR ANSWER==> Bachelors	5356

SELECT EnglishEducation, COUNT (*) AS CustomerCount
FROM dbo.DimCustomer
GROUP BY EnglishEducation
ORDER BY EnglishEducation ASC;


-- 4b.	List customer education level (use EnglishEducation), the number of customers reporting 
--		each level of education, and the average yearly income for each level of education. 
--		Show the average income rounded to two (2) decimal places. Sort by EnglishEducation in ascending order.
--      I got 5 rows
--		QUESTION:	What is the average yearly income of the customers who have completed a Bachelors degree?	
--		YOUR ANSWER==> 64395.07

SELECT EnglishEducation, COUNT (*) AS CustomerCount, ROUND(AVG(YearlyIncome), 2) AS AvgYearlyIncome
FROM dbo.DimCustomer
GROUP BY EnglishEducation
ORDER BY EnglishEducation ASC;


-- 5.	List all customers and the most recent date on which they placed an order (2 fields). Show the 
--		customer's first name and middle name and last name in one column with a space between each part of the 
--		name. NULL should not appear in the FullName field. That does not mean that you should filter it 
--		out; that means that your concatenation should not result in NULL. Show the date of the most recent 
--		order as mm/dd/yyyy. It is your responsibility to make sure you do not miss any customers. Sort by 
--		last name and first name in ascending order.
--      I got 18,470 rows
--		QUESTION:	What is the date in record 2?
--		YOUR ANSWER==> 12/13/2013

SELECT CONCAT(C.FirstName, ' ', C.MiddleName, ' ', C.LastName) AS FullName, CONVERT(varchar, MAX(FIS.OrderDate), 101) AS LatestOrder
FROM dbo.FactInternetSales AS FIS
	INNER JOIN dbo.DimCustomer AS C
	ON FIS.CustomerKey = C.CustomerKey
GROUP BY C.FirstName, C.MiddleName, C.LastName
ORDER BY C.LastName, C.FirstName;


--6.	In your own words, write a business question that you can answer by querying the data warehouse 
--		and using an aggregate function with the having clause. 
--		Then write the complete SQL query that will provide the information that you are seeking.
--		Which bikes with a list price under $2000 were bought by customers over the internet?
--		List product name, list price, and total number of sales for each product.

SELECT P.EnglishProductName, ROUND(P.ListPrice, 2) AS ListPrice, COUNT (*) AS NumberSold
FROM dbo.FactInternetSales AS FIS
	INNER JOIN dbo.DimProduct AS P
	ON FIS.ProductKey = P.ProductKey
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
	INNER JOIN dbo.DimProductCategory AS PC
	ON PS.ProductCategoryKey = PC.ProductCategoryKey
WHERE PC.EnglishProductCategoryName = 'Bikes'
GROUP BY P.EnglishProductName, P.ListPrice
HAVING P.ListPrice < 2000;