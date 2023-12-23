/*--------------------------------------------------------------------------------------------------------------------
--
-- BUSIT 103           Assignment   #9              DUE DATE :  Consult course calendar
--
--------------------------------------------------------------------------------------------------------------------

1a.	10011
1b.	List MaritalStatus and check to see that the number of rows is the same as 1.a where MaritalStatus is 'M'
1c.	Children: 3817	Cars: 3509
1d.	Children: 3987	Cars: 1435 Average Yearly Income: 65041.54
2a.	80450596.98
2b.	227171064.90
3a.	29358677.22
3b.	31483346.85
4.	1742.87
5.	Touring-2000 Blue, 46
6.	Lowest: 539.99	Average: 1742.87	Highest: 3399.99	Count: 38
7.	Road-150 Red, 44
8a.	1487.84
8b.	902.13
8c.	Mountain-200 Silver, 38
9.			QUESTION:	What is the largest tax amount and the smallest tax amount? Round to 2 decimal places.
			YOUR ANSWER==>	Largest: 286.26	Smallest: 0.18

SELECT ROUND(MAX(TaxAmt), 2) AS LargestTaxAmount, ROUND(MIN(TaxAmt), 2) AS SmallestTaxAmount
FROM dbo.FactInternetSales AS FIS

Aggregate Functions

PURPOSE:

Knowledge:
 
    o Explain the purpose of an aggregate function
    o Distinguish when to use a calculated field and when to use an aggregate function
    o Explain how aggregate functions handle NULL values
      
Skills:

    o Use an aggregate function in SELECT and WHERE clauses

TASK:

    1. Download the following SQL file and rename it Xxxxx-SQL-Assignment-9, where Xxxxx is your last and first name. 
	For example, I would rename this file ChengCharlene-SQL-Assignment-9.sql.

		Xxxxx-SQL-Assignment-9.sql

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

ADDITIONAL GUIDANCE:
--------------------------------------------------------------------------------------------------------------------
--
-- GUIDELINES:
-- Unless specified that it is okay, don't hardcode values - use subqueries instead. Hardcode means using an actual number.
-- 
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--
-- Recall that sales to resellers are stored in the FactResellerSales table and sales to individual customers 
-- are stored in the FactInternetSales table. When asked to find Internet sales or sales to 'customers', you 
-- will be using the FactInternetSales table. 
--
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
*/

USE AdventureWorksDW2017;

--------------------------------------------------------------------------------------------------------------------
-- 1.a.	Find the count of customers who are married. Be sure give each derived field an 
--		appropriate alias.
--		QUESTION:		How many customers are there who are married?	
--		YOUR ANSWER==>	10011

SELECT COUNT (*) AS MarriedCustomersCount
FROM dbo.DimCustomer
WHERE MaritalStatus = 'M';


--1.b.	Check your result. Write queries to determine if the answer to 1.a. is correct. 
--		You should be doing proofs for all of your statements. This is a reminder to check our work.
--		QUESTION:		How did you check your answer?	
--		YOUR ANSWER==>	List MaritalStatus and check to see that the number of rows is the same as 1.a where MaritalStatus is 'M'

SELECT MaritalStatus
FROM dbo.DimCustomer
WHERE MaritalStatus = 'M';


--1.c.	Find the total children (sum) and the total cars owned (sum) for customers who are 
--		married and list their education level as High School (use EnglishEducation).
--		QUESTION:		How many children and how many cars owned did you get?	
--		YOUR ANSWER==>	Children: 3817	Cars: 3509

SELECT SUM(TotalChildren) AS SumChildren, SUM(NumberCarsOwned) AS SumCarsOwned
FROM dbo.DimCustomer
WHERE MaritalStatus = 'M' AND EnglishEducation = 'High School';


--1.d.	Find the total children, total cars owned, and average yearly income for:
--		customers who are married AND who list their education level as Graduate Degree.
--		QUESTION:		How many children, how many cars owned, and what average yearly income did you get?		
--		YOUR ANSWER==>	Children: 3987	Cars: 1435 Average Yearly Income: 65041.54

SELECT SUM(TotalChildren) AS SumChildren, SUM(NumberCarsOwned) AS SumCarsOwned,ROUND(AVG(YearlyIncome), 2) AS AverageYearlyIncome
FROM dbo.DimCustomer
WHERE MaritalStatus = 'M' AND EnglishEducation = 'Graduate Degree';


--------------------------------------------------------------------------------------------------------------------
--
-- In the next set of questions you are looking for sales to resellers and sales to individual customers. 
---We will look at the information by total sales and then for sales by geographic locations for specific time 
---frames. Recall that sales to business customers (Resellers) is stored in the FactResellerSales table and sales 
---to individuals (Customers) is stored in the FactInternetSales table.*/
--
--------------------------------------------------------------------------------------------------------------------
--2.a.	List the total dollar amount (SalesAmount) for sales to Resellers. Round to two decimal places.
--		QUESTION:		What is the total dollar amount for sales to Resellers?	
--		YOUR ANSWER==>	80450596.98

SELECT ROUND(SUM(SalesAmount), 2) AS TotalDollarAmount
FROM dbo.FactResellerSales;


--2.b.	List the total dollar amount (SalesAmount) for 2013 sales to resellers who have an address in 
--		the state of Washington in the United States. Show only the total sales--one row, one column--rounded 
--		to two decimal places. Hint: Use the FactResellerSales and DimGeography tables 
--		QUESTION:		What is the total dollar amount for 2013 sales to resellers who have an address in 
--						the state of Washington in the United States?	
--		YOUR ANSWER==>	227171064.90

SELECT ROUND(SUM(FRS.SalesAmount), 2) AS TotalDollarAmount
FROM dbo.FactResellerSales AS FRS
	INNER JOIN dbo.DimGeography AS G
	ON FRS.SalesTerritoryKey = G.SalesTerritoryKey
WHERE FRS.OrderDate LIKE '%2013%' AND G.StateProvinceName = 'Washington' AND G.EnglishCountryRegionName = 'United States';


--3.a.	List the total dollar amount (SalesAmount) for sales to customers. Round to two decimal places.
--		Remember that customer sales are stored in FactInternetSales.
--		QUESTION:		What is the total dollar amount for sales to customers?	
--		YOUR ANSWER==>	29358677.22

SELECT ROUND(SUM(SalesAmount), 2) AS TotalSalesAmount
FROM dbo.FactInternetSales;


--3.b.	List the total dollar amount (SalesAmount) for 2013 sales to customers located in 
--		British Columbia, Canada. Show only the total sales--one row, one column--rounded to two decimal places. 
--		QUESTION:		What is the total dollar amount for 2013 sales to customers located in British Columbia, Canada?
--		YOUR ANSWER==>	31483346.85

SELECT ROUND(SUM(FIS.SalesAmount), 2) AS TotalSalesAmount
FROM dbo.FactInternetSales AS FIS
	INNER JOIN dbo.DimGeography AS G
	ON FIS.SalesTerritoryKey = G.SalesTerritoryKey
WHERE FIS.OrderDate LIKE '%2013%' AND G.StateProvinceName = 'British Columbia' AND G.EnglishCountryRegionName = 'Canada';


--------------------------------------------------------------------------------------------------------------------
--
--  In the next group of requests we are answering questions about bikes. We are asked to create
--  information about bikes either by a specific subcategory or in total.  It is important here that 
--  you recall how to find bikes and subcategories of bikes within the tables. 
--
--------------------------------------------------------------------------------------------------------------------


--4.	List the average unit price for a road bike sold to customers. Round to two 
--		decimal places.
--		QUESTION:		What is the average unit price for a moutain bike sold to customers?	
--		YOUR ANSWER==>	1742.87

SELECT ROUND(AVG(P.ListPrice), 2) AS AveragePriceMtBikes
FROM dbo.DimProduct AS P
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
	INNER JOIN dbo.DimProductCategory AS PC
	ON PS.ProductCategoryKey = PC.ProductCategoryKey
WHERE PC.EnglishProductCategoryName = 'Bikes' AND PS.EnglishProductSubcategoryName = 'Mountain Bikes';


--5.	List bikes that have a list price less than or equal than the average list price for all bikes. Show 
--		product alternate key, English product name, and list price. Order by list price descending
--		and English product name ascending.
--      I got 75 rows.
--		QUESTION:		What is the name of the bike in record 6?	
--		YOUR ANSWER==>	Touring-2000 Blue, 46

SELECT P.ProductAlternateKey, P.EnglishProductName, P.ListPrice
FROM dbo.DimProduct AS P
	INNER JOIN dbo.DimProductSubcategory AS subcat
	ON P.ProductSubcategoryKey = subcat.ProductSubcategoryKey
	INNER JOIN dbo.DimProductCategory AS cat
	ON subcat.ProductCategoryKey = cat.ProductCategoryKey
	INNER JOIN (SELECT AVG(ListPrice) AS AveragePrice, PC.ProductCategoryKey
		FROM dbo.DimProduct AS P
		INNER JOIN dbo.DimProductSubcategory AS PS
		ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
		INNER JOIN dbo.DimProductCategory AS PC
		ON PS.ProductCategoryKey = PC.ProductCategoryKey
		WHERE EnglishProductCategoryName = 'Bikes' GROUP BY PC.ProductCategoryKey) AS AverageBikePrice
	ON cat.ProductCategoryKey = AverageBikePrice.ProductCategoryKey
	WHERE P.ListPrice <= AverageBikePrice.AveragePrice
ORDER BY P.ListPrice DESC, P.EnglishProductName ASC;


--6.	List the lowest list price, the average list price, the highest list price, and product count 
--		for mountain bikes. 
--		QUESTION:		What is the lowest list price, the average list price, the highest list price, and product count for mountain bikes?	
--		YOUR ANSWER==>	Lowest: 539.99	Average: 1742.87	Highest: 3399.99	Count: 38

SELECT MIN(ListPrice) AS LowestListPrice, ROUND(AVG(ListPrice), 2) AS AverageListPrice, MAX(ListPrice) AS HighestListPrice, COUNT (*) AS ProductCount
FROM dbo.DimProduct AS P
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
	INNER JOIN dbo.DimProductCategory AS PC
	ON PS.ProductCategoryKey = PC.ProductCategoryKey
WHERE PS.EnglishProductSubcategoryName = 'Mountain Bikes' AND PC.EnglishProductCategoryName= 'Bikes';


--------------------------------------------------------------------------------------------------------------------
--
--  In the next requests we are digging into the products sold by AdventureWorks by finding the highest 
--  priced products, the profit or loss on products sold to dealers, and the products with the largest   
--  profit on dealer price.
--
--------------------------------------------------------------------------------------------------------------------

-- 7.	List the product alternate key, product name, and list price for the product(s) 
--		with the highest List Price. There can be multiple products with the highest list price.
--      Sort by Product Alternate Key ascending. 
--		I got 5 rows.
--		QUESTION:		What is the English Product Name record 1?
--		YOUR ANSWER==>	Road-150 Red, 44

SELECT ProductAlternateKey, EnglishProductName, ListPrice
FROM dbo.DimProduct
WHERE ListPrice = 
	(SELECT MAX(ListPrice) 
	FROM dbo.DimProduct)
ORDER BY ProductAlternateKey ASC;


-- 8.a.	List the product alternate key, product name, list price, standard cost and the 
--		difference (calculated field with an alias of Margin) between the list price and the standard cost for all product(s). 
--		Show all money values to 2 decimal places. Sort on difference from highest to lowest
--		and product alternate key in ascending order.
--      I got 606 rows.
--		QUESTION:		What is the difference between the list price and the standard cost in record 2?
--		YOUR ANSWER==>	1487.84

SELECT ProductAlternateKey, EnglishProductName, ListPrice, ROUND(StandardCost, 2) AS StandardCost, ROUND((ListPrice - StandardCost), 2) AS Margin
FROM dbo.DimProduct
ORDER BY Margin DESC, ProductAlternateKey ASC;


-- 8.b.	As we learned in prior modules, some products are not intended to be sold and some products in the 
--		table have been updated and are no longer sold. Follow the same specifications as 8.a. for this statement. 
--		Also eliminate from your list all products that are not intended for sale (i.e. not a finished good) 
--      and those no longer for sale (check the status).
--      Explore the data -- you have enough information to answer this. If you make assumptions, state them in comments.
--      I got 197 rows.
--		QUESTION:		Still sorting on the difference from highest to lowest, and on product alternate key ascending,
--						what is the difference between the list price and the standard cost in record 8?	
--		YOUR ANSWER==>	902.13

SELECT ProductAlternateKey, EnglishProductName, ListPrice, ROUND(StandardCost, 2) AS StandardCost, ROUND((ListPrice - StandardCost), 2) AS Margin
FROM dbo.DimProduct
WHERE FinishedGoodsFlag = 1 AND Status IS NOT NULL
ORDER BY Margin DESC, ProductAlternateKey ASC;


-- 8.c.	Use the statement from 8.b. and modify to find the currently sold product(s) with the largest 
--		difference between the list price and the standard cost of all currently sold products. Show all 
--		money values to 2 decimal places. Hint: There will be records in the results set.
--		QUESTION:		What is the name of the product in the 1st record of the results set?
--		YOUR ANSWER==>	Mountain-200 Silver, 38

SELECT Status, ProductAlternateKey, EnglishProductName, ListPrice, ROUND(StandardCost, 2) AS StandardCost, ROUND((ListPrice - StandardCost), 2) AS Margin
FROM dbo.DimProduct
WHERE ROUND((ListPrice - StandardCost), 2) = 
	(SELECT MAX(ROUND((ListPrice - StandardCost), 2))
	FROM dbo.DimProduct
	WHERE FinishedGoodsFlag = 1 AND Status = 'Current')
ORDER BY Margin DESC, ProductAlternateKey ASC;


--9.	In your own words, write a business question that you can answer by querying the data warehouse 
--		and using an aggregate function. Be sure to write your question as a comment. 
--		Then write the complete SQL query that will provide the information that you are seeking.
--		QUESTION:	What is the largest tax amount and the smallest tax amount? Round to 2 decimal places.
--		YOUR ANSWER==>	Largest: 286.2616	Smallest: 0.1832

SELECT ROUND(MAX(TaxAmt), 2) AS LargestTaxAmount, ROUND(MIN(TaxAmt), 2) AS SmallestTaxAmount
FROM dbo.FactInternetSales AS FIS


