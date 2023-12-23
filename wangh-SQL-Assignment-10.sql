--------------------------------------------------------------------------------------------------------------------
--
-- BUSIT 103           Assignment   #10              DUE DATE :  Consult course calendar
--
--------------------------------------------------------------------------------------------------------------------
/*
1a. 217
1b. Front Derailleur
1c. Chain
2a. 47.02
2b. 1431.50
3a. 58326.67
3b. Alvarez, Dana
4a. 1457.99
4b. 769.49
5a. 2727
5b. Abigail T White
5c. Adrienne Martin
6. 
--		Find the average income of customers who have more than the average number of children at home.
--		ANSWER: 78086.80

SELECT ROUND(AVG(YearlyIncome), 2) AS AvgYearlyIncome
FROM dbo.DimCustomer
WHERE NumberChildrenAtHome >
	(SELECT AVG(NumberChildrenAtHome) AS AvgChildrenAtHome
	FROM dbo.DimCustomer)
ORDER BY AvgYearlyIncome;

PURPOSE:

Knowledge:

    Describe situations in which a subquery provides the optimal solution to a question.
    Define the three SQL Standard subqueries: Row, table, and scalar.
    Use a subquery in the SELECT clause, the FROM clause, and the WHERE clause

Skills:

    Use EXISTS and/or NOT EXISTS in a SELECT statement
    Model a problem-solving methodology through breaking complex queries into small pieces

TASK:

    Download the following SQL file and rename it Xxxxx-SQL-Assignment-10, where Xxxxx is your last and first name. For example, I would rename this file ChengCharlene-SQL-Assignment-10.sql.

    Xxxxx-SQL-Assignment-10.sql Preview the document

    Open the file in SQL Server Management Studio (SSMS).

    Add your SQL code in the space provided below each question. The questions are written as comments so they will not execute in SQL Server. 

    Proofread your document to make sure all questions are answered completely and that it is easy to distinguish your responses from the questions on the page.

    Return to this assignment page, attach your completed file, and submit.

 

CRITERIA:

    Answer all the questions
    If you do not understand a question, did you ask for help from the teacher, a classmate, the Discussion board, or a tutor?
    Your answer/query is in the right place underneath the question
    Your answer/query is not commented out
    Your answer/query executes without an error
    You have renamed the file as specified above and submitted it via Canvas
    If you cannot complete the assignment, did you communicate with the teacher (before the due date) so that he/she/they understands your situation?


ADDITIONAL GUIDELINES:
1. Even though a question might not ask for it, add meaningful sorts and column names.
2. Unless specified that it is okay, don't hardcode values - use subqueries instead.
   Here's an example of hardcoding:
   List all product that have a list price less than the average list price of all products.
   You could run this a query to find out that the averate list price is 747.6617

SELECT AVG(ListPrice) AS ListPrice
FROM DimProduct;
*/
--    If you then plug 747.6617 into your next query, you have hardcoded. If you add more products, 
--    you will have to change your query.

/*
SELECT *
FROM DimProduct
WHERE ListPrice < 747.6617;
*/
--    Instead, you should use a subquery:
/*
SELECT *
FROM DimProduct
WHERE ListPrice < 
(SELECT AVG(ListPrice)
FROM DimProduct);
*/
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--
--REFRESHER and WARM-UP
--
--------------------------------------------------------------------------------------------------------------------
USE AdventureWorksDW2017;

---------------------------------------------------------------------------------------------------------------------
-- 1.a.	List the distinct ProductKey for products sold over the internet. Sort by ProductKey ascending.
--      I got 158 rows.
--      1 point
--      QUESTION:			What is the ProductKey in the record 2?
--      YOUR ANSWER HERE==>	217

SELECT DISTINCT ProductKey
FROM dbo.FactInternetSales
ORDER BY ProductKey ASC;


---------------------------------------------------------------------------------------------------------------------
-- 1.b.	Using an Outer Join find Products that have NOT been sold over the internet. Show Product Key and 
--		the English Product Name. Sort by product key in DESCENDING order.
--      I got 448 rows.
--      1 point
--      QUESTION:			What is the EnglishProductName in the record 11?
--      YOUR ANSWER HERE==>	Front Derailleur

SELECT P.ProductKey, P.EnglishProductName
FROM dbo.FactInternetSales AS FIS
	RIGHT OUTER JOIN dbo.DimProduct AS P
	ON FIS.ProductKey = P.ProductKey
WHERE FIS.ProductKey IS NULL
ORDER BY P.ProductKey DESC;


---------------------------------------------------------------------------------------------------------------------
-- 1.c. Rewrite the Outer Join from 1b replacing the join with a subquery.
--      I got 448 rows. Duh!
--      2 points
--      QUESTION:			What is the EnglishProductName in the record 4?
--      YOUR ANSWER HERE==>	Chain

SELECT P.ProductKey, P.EnglishProductName
FROM dbo.DimProduct AS P
WHERE NOT EXISTS
		(SELECT FIS.ProductKey
		FROM dbo.FactInternetSales AS FIS
		WHERE FIS.ProductKey = P.ProductKey)
ORDER BY P.ProductKey DESC;


---------------------------------------------------------------------------------------------------------------------
--
-- The next sets of problems are all very similar. First you will write a simple query to return one value, 
-- usually an average. Then you will use that statement as a subquery in the WHERE clause in the next step. 
-- The two steps are to remind you to create the statement in steps and check your work before going on to the next 
-- step in the query. Also, you will be using the query you write in the first statement as your subquery. 
--
---------------------------------------------------------------------------------------------------------------------
-- 2.a.	List the average listprice of components for sale by AdventureWorks. No sort needed. 
--		Remember to provide a column alias. 
--      Hints: Use the AVG function. To determine if a product is clothing, you have to link Product Subcategory,
--             Product Category, and Product tables.
--      3 points
--      QUESTION:			What is the average list price for clothing items?
--      YOUR ANSWER HERE==>	47.02

SELECT ROUND(AVG(ListPrice), 2) AS AverageListPrice
FROM dbo.DimProduct AS P
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON PS.ProductSubcategoryKey = P.ProductSubcategoryKey
	INNER JOIN dbo.DimProductCategory AS PC
	ON PS.ProductCategoryKey = PC.ProductCategoryKey
WHERE PC.EnglishProductCategoryName = 'Clothing';


---------------------------------------------------------------------------------------------------------------------
-- 2.b.	List all products in the Components category that have a listprice higher than the average 
--		listprice of Components items. Show product product name, and listprice in the 
--		results set. Be sure to use a subquery; do not enter the actual value from 2.a. into the statement.
--      Sort by list price in DESCENDING order.
--      I got 63 rows.
--      3 pointS
--      QUESTION:			What is the list price in record 4?
--      YOUR ANSWER HERE==>	1431.50

SELECT P.EnglishProductName, P.ListPrice
FROM dbo.DimProduct AS P
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON PS.ProductSubcategoryKey = P.ProductSubcategoryKey
	INNER JOIN dbo.DimProductCategory AS PC
	ON PS.ProductCategoryKey = PC.ProductCategoryKey
WHERE PC.EnglishProductCategoryName = 'Components' AND P.ListPrice > 
	(SELECT ROUND(AVG(ListPrice), 2) AS AverageListPrice
	FROM dbo.DimProduct AS P
		INNER JOIN dbo.DimProductSubcategory AS PS
		ON PS.ProductSubcategoryKey = P.ProductSubcategoryKey
		INNER JOIN dbo.DimProductCategory AS PC
		ON PS.ProductCategoryKey = PC.ProductCategoryKey
	WHERE PC.EnglishProductCategoryName = 'Components')
ORDER BY P.ListPrice DESC;

		
---------------------------------------------------------------------------------------------------------------------
-- 3.a.	Find the average yearly income of all houseowners in the customer table. 
--      1 point
--      QUESTION:			What is the average yearly income for all homeowners in the customer table?
--      YOUR ANSWER HERE==>	58326.67

SELECT ROUND(AVG(YearlyIncome), 2) AS AverageYearlyIncome
FROM dbo.DimCustomer
WHERE HouseOwnerFlag = 1;


---------------------------------------------------------------------------------------------------------------------
-- 3.b.	Find houseowners in the customers table with an income less than or the same as the 
--		average income of houseowner customers. Concatenate to show last name, a comma and space, and 
--		first name in one column (alias CustName) and yearly income in another column. There will be two columns in the 
--		Results set. Be sure to use a subquery; do not enter the actual value from 3.a. into the statement.
--      Sort by yearly income ascending and CustName ascending.
--      I got 5513 rows.
--      2 points
--      QUESTION:			What is the CustName in row 10?
--      YOUR ANSWER HERE==>	Alvarez, Dana

SELECT LastName + ', ' + FirstName AS CustName, YearlyIncome
FROM dbo.DimCustomer
WHERE YearlyIncome <= 
	(SELECT ROUND(AVG(YearlyIncome), 2) AS AverageYearlyIncome
	FROM dbo.DimCustomer
	WHERE HouseOwnerFlag = 1)
	AND HouseOwnerFlag = 1
ORDER BY YearlyIncome, CustName;


---------------------------------------------------------------------------------------------------------------------
-- 4.a.	List the product name and list price for the bike named Road-450 Red, 60
--      1 point
--      QUESTION:			What is the list price for the bike named Road-450 Red, 60?
--      YOUR ANSWER HERE==>	1457.99

SELECT P.EnglishProductName, ListPrice
FROM dbo.DimProduct AS P
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
	INNER JOIN dbo.DimProductCategory AS PC
	ON PS.ProductCategoryKey = PC.ProductCategoryKey
WHERE PC.EnglishProductCategoryName = 'Bikes' AND P.EnglishProductName = 'Road-450 Red, 60';


---------------------------------------------------------------------------------------------------------------------
-- 4.b.	List the product name and price for each BIKE that has a price less than or equal to that of the Road-450 Red, 60. Be sure you are using the subquery not an actual value.
--      Sort by EnglishProductName in ascending order.
--      I got 75 rows
--      3 points
--      QUESTION:			What is the list price in record 6?
--      YOUR ANSWER HERE==>	769.49

SELECT P.EnglishProductName, P.ListPrice
FROM dbo.DimProduct AS P
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
	INNER JOIN dbo.DimProductCategory AS PC
	ON PS.ProductCategoryKey = PC.ProductCategoryKey
WHERE PC.EnglishProductCategoryName = 'Bikes' AND P.ListPrice <=
	(SELECT ListPrice
	FROM dbo.DimProduct AS P
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
	INNER JOIN dbo.DimProductCategory AS PC
	ON PS.ProductCategoryKey = PC.ProductCategoryKey
	WHERE PC.EnglishProductCategoryName = 'Bikes' AND P.EnglishProductName = 'Road-450 Red, 60')
ORDER BY P.EnglishProductName ASC;


---------------------------------------------------------------------------------------------------------------------
-- 5.a. Show all data from the Survey Response fact table. Use select all. No special predicate requested.
--      1 point
--      QUESTION:			How many records are in the table?
--      YOUR ANSWER HERE==>	2727

SELECT *
FROM dbo.FactSurveyResponse;


---------------------------------------------------------------------------------------------------------------------
-- 5.b.	Use a subquery and the EXISTS predicate to find customers that respond to surveys. List full 
--		name (first middle last) in one column (alias CustName) and email address in a second column. Use the CONCAT() 
--		function or another option for the name to overcome the NULL issue. You will not see NULL in the full 
--		name field for any customer. Sort by CustName in ascending order.
--      I got 1656 rows
--      3 points
--      QUESTION:			What is the name in the record 5?
--      YOUR ANSWER HERE==>	Abigail T White
	
SELECT CONCAT(FirstName, ' ', MiddleName, ' ', LastName) AS CustName, EmailAddress
FROM dbo.DimCustomer AS C
WHERE EXISTS
	(SELECT CustomerKey
	FROM dbo.FactSurveyResponse AS FSR
	WHERE C.CustomerKey = FSR.CustomerKey)
ORDER BY CustName ASC;


---------------------------------------------------------------------------------------------------------------------
-- 5.c.	Copy/paste 5.b and use an additional subquery to narrow the results of 5.b. to only those customers 
--		with a yearly income that is greater than or the same as the average of all customers. 
--      Sort by name in ascending order.
--      I got 883 rows
--      3 points
--      QUESTION:			What is the CustName in the record 11?
--      YOUR ANSWER HERE==>	Adrienne Martin

SELECT CONCAT(FirstName, ' ', MiddleName, ' ', LastName) AS CustName, EmailAddress
FROM dbo.DimCustomer AS C
WHERE EXISTS
	(SELECT CustomerKey
	FROM dbo.FactSurveyResponse AS FSR
	WHERE C.CustomerKey = FSR.CustomerKey)
	AND YearlyIncome >=
		(SELECT AVG(YearlyIncome)
		FROM dbo.DimCustomer AS C)
ORDER BY CustName ASC;


--6.	In your own words, write a business question that you can answer by querying the data warehouse 
--		and using a subquery.
--		Then write the SQL query that will provide the information that you are seeking.
--      1 point

--		Find the average income of customers who have more than the average number of children at home.
--		78086.80

SELECT ROUND(AVG(YearlyIncome), 2) AS AvgYearlyIncome
FROM dbo.DimCustomer
WHERE NumberChildrenAtHome >
	(SELECT AVG(NumberChildrenAtHome) AS AvgChildrenAtHome
	FROM dbo.DimCustomer)
ORDER BY AvgYearlyIncome;

