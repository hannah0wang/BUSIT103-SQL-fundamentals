/*--------------------------------------------------------------------------------------------------------------------
--
-- BUSIT 103           Assignment   #8              DUE DATE :  Consult course calendar
--
--------------------------------------------------------------------------------------------------------------------
1.		Swedish Krona

2.		Argentine Peso

3.		Sponsorship

4.		SO43701

5.		Alpine

6.		Gold Coast

7.		Volume Discount over 60

8.		Road-650 Overstock

9a.		NULL

9b.		Accessories Network

9c.		Action Bicycle Specialists	11-29-13

10.		Touring-1000 Promotion

11a.	23

11b.	62

12.		How many bikes have not been sold to customers over the internet? ---> 9

SELECT P.EnglishProductName, PC.EnglishProductCategoryName
FROM dbo.FactInternetSales AS FIS
	RIGHT OUTER JOIN dbo.DimCustomer AS C
	ON FIS.CustomerKey = C.CustomerKey
	RIGHT OUTER JOIN dbo.DimProduct AS P
	ON FIS.ProductKey = P.ProductKey
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
	INNER JOIN dbo.DimProductCategory AS PC
	ON PS.ProductCategoryKey = PC.ProductCategoryKey
WHERE PC.EnglishProductCategoryName = 'Bikes' AND C.CustomerKey IS NULL
ORDER BY P.EnglishProductName ASC;


Querying Data from a Data Warehouse

PURPOSE:

Knowledge:
 
    o Describe the purpose of an OUTER JOIN
    o Describe an OUTER JOIN
    o Explain the differences among LEFT, RIGHT, and FULL OUTER JOINs
    o Describe situations in which to use an OUTER JOIN
    

    
Skills:

    o Write the syntax needed to create LEFT, RIGHT, and FULL OUTER JOINs

TASK:

    1. Download the following SQL file and rename it Xxxxx-SQL-Assignment-08, where Xxxxx is your last and first name. 
	For example, I would rename this file ChengCharlene-SQL-Assignment-08.sql.

		Xxxxx-SQL-Assignment-08.sql

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

You are required to use OUTER JOINSs to solve each problem. Even if you know another method that will produce 
the result, this module is practice in OUTER JOINs.

 Ideas for consideration: Run the statement in stages: Write the SELECT and FROM clauses first and run the 
 statement. Add the ORDER BY clause. Then add the WHERE clause; if it is a compound WHERE clause, add piece 
 at a time. Remember that the order in which the joins are processed does make a difference with OUTER JOINs.
 You will NOT use Cross-Joins, Full Outer Joins, or Unions in the required exercises. All are to be 
 accomplished with outer joins or a combination of outer and inner joins using standard ANSI join syntax.

 When there are multiple versions of a field, such as EnglishCountryRegionName, SpanishCountryRegionName, 
 FrenchCountryRegionName, use the English version of the field. When asked to show 'only once', 'unique', 
 or 'one time only', use the DISTINCT keyword. Recall that it is the row that is unique in the result set.  

 If no sort order is specified, assume it is in ascending order. 
*/

USE AdventureWorksDW2017; 

--1.	List the name of all currencies and the name of each organization that uses that currency. 
--		You will use an Outer Join to list the name of each currency in the Currency table regardless if 
--		it has a matching value in the Organization table. You will see NULL in many rows. Sort ascending on currency name. 
--      Hint: Use DimCurrency and DimOrganization. 
--      I got 115 rows
--		QUESTION:		What is the currency name in row 94?
--		YOUR ANSWER==>	Swedish Krona

SELECT C.CurrencyName, O.OrganizationName
FROM dbo.DimCurrency AS C
	LEFT OUTER JOIN dbo.DimOrganization AS O
	ON C.CurrencyKey = O.CurrencyKey
ORDER BY C.CurrencyName ASC;


--2.	List the name of all currencies that are NOT used by any organization. In this situation 
--		we are using the statement from 1.a. and making a few modifications. We want to find the 
--		currencies that do not have a match in the common field in the Organization table. We do 
--		that by filtering for NULL in the matching field. Sort ascending on currency name. 
--      I got 101 rows
--		QUESTION:		What is the currency name in row 3?
--		YOUR ANSWER==>	Argentine Peso

SELECT C.CurrencyName, O.OrganizationName
FROM dbo.DimCurrency AS C
	LEFT OUTER JOIN dbo.DimOrganization AS O
	ON C.CurrencyKey = O.CurrencyKey
WHERE O.CurrencyKey IS NULL
ORDER BY C.CurrencyName ASC;


--3.	List the name of all Sales Reasons that have not been associated with a sale. Sort descending on sales reason name. 
--		Hint:  Use DimSalesReason and FactInternetSalesReason.
--      I got 3 rows.
--		QUESTION:		What is the sales reason name in row 1?
--		YOUR ANSWER==>	Sponsorship

SELECT SR.SalesReasonName
FROM dbo.FactInternetSales AS FIS
	INNER JOIN dbo.FactInternetSalesReason AS FISR
	ON FIS.SalesOrderNumber = FISR.SalesOrderNumber
	RIGHT OUTER JOIN dbo.DimSalesReason AS SR
	ON FISR.SalesReasonKey = SR.SalesReasonKey
WHERE FIS.SalesOrderNumber IS NULL
ORDER BY SR.SalesReasonName DESC;


--4.	List all internet sales that do not have a sales reason associated. List SalesOrderNumber, SalesOrderLineNumber 
--		and the order date. Do not show the time with the order date. Sort by sales order number ascending 
--      and sales order line number ascending. 
--		Now we are looking at which sales do not have a reason associated with the sale. Since we are looking at the sales, 
--		we don't need the reason name and the corresponding link to that table. 
--		Hint: Use FactInternetSales and FactInternetSalesReason. 
--      I got 6429 rows.
--		QUESTION:		What is the sales order number in row 4?
--		YOUR ANSWER==>	SO43701

SELECT FIS.SalesOrderNumber, FISR.SalesOrderLineNumber, CAST(FIS.OrderDate AS DATE) AS OrderDate
FROM dbo.FactInternetSales AS FIS
	LEFT OUTER JOIN dbo.FactInternetSalesReason AS FISR
	ON FIS.SalesOrderNumber = FISR.SalesOrderNumber
WHERE FISR.SalesOrderNumber IS NULL
ORDER BY FISR.SalesOrderNumber, FIS.SalesOrderNumber;


/* AdventureWorks is looking to expand its market share. AdventureWorks has a list of target locations stored 
in the Geography table. In the next set of questions you want to find locations in which there are no Internet 
customers (individuals) and no business customers (resellers).  */

--5.	Find any locations in which AdventureWorks has no internet customers. List the English country/region 
--		name, state/province, city, and postal code. List each location only one time. Sort by city.
--      I got 319 rows.
--		QUESTION:		What is the city in row 5?
--		YOUR ANSWER==>	Alpine

SELECT DISTINCT G.EnglishCountryRegionName, G.StateProvinceName, G.City, G.PostalCode
FROM dbo.FactInternetSales AS FIS
	INNER JOIN dbo.DimCustomer AS C
	ON FIS.CustomerKey = C.CustomerKey
	RIGHT OUTER JOIN dbo.DimGeography AS G
	ON C.GeographyKey = G.GeographyKey
WHERE FIS.SalesTerritoryKey IS NULL
ORDER BY G.City ASC;


--6. 	Find any locations in which AdventureWorks has no resellers. List the English country/region 
--		name, state/province, city, and postal code. List each location only one time. Sort by country, 
--		state, and city.
--      I got 145 rows.
--		QUESTION:		What is the city in row 7?
--		YOUR ANSWER==>	Gold Coast

SELECT DISTINCT G.EnglishCountryRegionName, G.StateProvinceName, G.City, G.PostalCode
FROM dbo.DimGeography AS G
	LEFT OUTER JOIN dbo.DimReseller AS R
	ON G.GeographyKey = R.GeographyKey
WHERE R.GeographyKey IS NULL
ORDER BY G.EnglishCountryRegionName, G.StateProvinceName, G.City;


--7.	List all promotions that have not been associated with a reseller sale. Show only the English 
--		promotion name in alphabetical order. 
--		Hint: Recall that details about sales to resellers are recorded in the FactResellerSales table.
--      I got 4 rows.
--		QUESTION:		What is the promotion in row 4?
--		YOUR ANSWER==>	Volume Discount over 60

SELECT P.EnglishPromotionName
FROM dbo.FactResellerSales AS FRS
	RIGHT OUTER JOIN dbo.DimPromotion AS P
	ON FRS.PromotionKey = P.PromotionKey
	LEFT OUTER JOIN dbo.DimReseller AS R
	ON FRS.ResellerKey = R.ResellerKey
WHERE R.ResellerKey IS NULL
ORDER BY P.EnglishPromotionName ASC;


--8.	List all promotions that have not been associated with an Internet sale. Show only the 
--		English promotion name in alphabetical order. 
--		Hint: Recall that details about sales to customers are recorded in the FactInternetSales table.
--      I got 12 rows.
--		QUESTION:		What is the promotion in row 6?
--		YOUR ANSWER==>	Road-650 Overstock

SELECT P.EnglishPromotionName
FROM dbo.FactInternetSales AS FIS
	RIGHT OUTER JOIN dbo.DimPromotion AS P
	ON FIS.PromotionKey = P.PromotionKey
WHERE FIS.PromotionKey IS NULL
ORDER BY P.EnglishPromotionName ASC;


--		Read 9.a. and 9.b. before beginning the syntax. There are several ways to write this statement. 
--		You will need three tables to create the lists requested. 

--9.a.	Find all promotions and any related sales to resellers. List unique instances of the 
--		ResellerName, English promotion name, and the order date.
--		Sort by reseller name and the promotion name in alphabetical order. 
--      Be sure to list all promotions even if there is no related sale.
--      I got 5174 rows.
--		QUESTION:		What is the reseller name in row 4?
--		YOUR ANSWER==>	NULL

SELECT DISTINCT R.ResellerName, P.EnglishPromotionName, FRS.OrderDate
FROM dbo.FactResellerSales AS FRS
	RIGHT OUTER JOIN dbo.DimPromotion AS P
	ON FRS.PromotionKey = P.PromotionKey
	LEFT OUTER JOIN dbo.DimReseller as R
	ON FRS.ResellerKey = R.ResellerKey
ORDER BY R.ResellerName, P.EnglishPromotionName;


--9.b.	Copy, paste, and modify 9.a. "No Discount" is not a promotion, so eliminate those sales 
--		without a promotion from your results set. Show the OrderDate as mm/dd/yyyy (CONVERT(nvarchar,OrderDate,101)). 
--      I got 1408 rows.
--		QUESTION:		What is the reseller name in row 5?
--		YOUR ANSWER==>	Accessories Network

SELECT DISTINCT R.ResellerName, P.EnglishPromotionName, CONVERT(nvarchar, FRS.OrderDate, 101) AS OrderDate
FROM dbo.FactResellerSales AS FRS
	RIGHT OUTER JOIN dbo.DimPromotion AS P
	ON FRS.PromotionKey = P.PromotionKey
	LEFT OUTER JOIN dbo.DimReseller as R
	ON FRS.ResellerKey = R.ResellerKey
WHERE P.EnglishPromotionName != 'No Discount'
ORDER BY R.ResellerName, P.EnglishPromotionName;


--9.c.	In 9b. You used CONVERT(nvarchar,OrderDate,101) to change a date field to mm/dd/yyyy.
--		Search online to find the CONVERT style code for a date format of mm-dd-yy. 
--		Copy and paste your 9b answer and change the style code.
--      I got 1408 rows.
--		QUESTION:		What is the reseller name and order date in row 12?
--		YOUR ANSWER==>	Action Bicycle Specialists		11-29-13

SELECT DISTINCT R.ResellerName, P.EnglishPromotionName, CONVERT(nvarchar, FRS.OrderDate, 10) AS OrderDate
FROM dbo.FactResellerSales AS FRS
	RIGHT OUTER JOIN dbo.DimPromotion AS P
	ON FRS.PromotionKey = P.PromotionKey
	LEFT OUTER JOIN dbo.DimReseller as R
	ON FRS.ResellerKey = R.ResellerKey
WHERE P.EnglishPromotionName != 'No Discount'
ORDER BY R.ResellerName, P.EnglishPromotionName;


--10.	Find all promotions and any related customer sales over the Internet. List unique instances 
--		of the English promotion name, customer first name, customer last name, and the order date. Eliminate 
--		sales that show No Discount. Sort by the promotion name. Be sure to list all promotions even if there 
--		is no related sale. Show the OrderDate as mm/dd/yyyy. You just did this in 9b. Now you are investigating 
--		Internet customers. Use similar syntax and different tables. 
--      I got 2120 rows.
--		QUESTION:		What is the promotion name in row 9?
--		YOUR ANSWER==>	Touring-1000 Promotion

SELECT DISTINCT P.EnglishPromotionName, C.FirstName, C.LastName,  CONVERT(nvarchar, FIS.OrderDate, 101) AS OrderDate
FROM dbo.FactInternetSales AS FIS
	RIGHT OUTER JOIN dbo.DimPromotion AS P
	ON FIS.PromotionKey = P.PromotionKey
	LEFT OUTER JOIN dbo.DimCustomer AS C
	ON FIS.CustomerKey = C.CustomerKey
WHERE P.EnglishPromotionName != 'No Discount'
ORDER BY P.EnglishPromotionName ASC;


/* AdventureWorks wants to know if there are any particular clothing items that are not selling. It is important that we 
look at both types of buyers (individual and reseller) to see if there are clothing items that should be promoted or 
discontinued. We will look at each type separately. You will need four tables to create the lists requested. */

--11.a.	List the unique product category name, product subcategory name, class, product name, and list price for all clothing items that have NOT been purchased by individual customers over the internet.
--	Sort by category name, subcategory name and product name. 
--		QUESTION:		How many clothing items have not been sold to individual customers over the internet?
--		YOUR ANSWER==>	23

SELECT DISTINCT PC.EnglishProductCategoryName, PS.EnglishProductSubcategoryName, P.Class, P.EnglishProductName, P.ListPrice
FROM dbo.FactInternetSales AS FIS
	RIGHT OUTER JOIN dbo.DimCustomer AS C
	ON FIS.CustomerKey = C.CustomerKey
	RIGHT OUTER JOIN dbo.DimProduct AS P
	ON FIS.ProductKey = P.ProductKey
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
	INNER JOIN dbo.DimProductCategory AS PC
	ON PS.ProductCategoryKey = PC.ProductCategoryKey
WHERE PC.EnglishProductCategoryName = 'Clothing' AND C.CustomerKey IS NULL
ORDER BY PC.EnglishProductCategoryName, PS.EnglishProductSubcategoryName, P.EnglishProductName;


--11.b.	List the unique product category name, product subcategory name, class, product name, and list price for all clothing items that have NOT been purchased by resellers.
--		Sort by category name, subcategory name and product name. 
--		QUESTION:		How many  have not been sold to resellers?
--		YOUR ANSWER==>	62

SELECT DISTINCT PC.EnglishProductCategoryName, PS.EnglishProductSubcategoryName, P.EnglishProductName, P.ListPrice
FROM dbo.FactResellerSales AS FRS
	RIGHT OUTER JOIN dbo.DimProduct AS P
	ON FRS.ProductKey = P.ProductKey
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
	INNER JOIN dbo.DimProductCategory AS PC
	ON PS.ProductCategoryKey = PC.ProductCategoryKey
	LEFT OUTER JOIN dbo.DimReseller AS R
	ON FRS.ResellerKey = R.ResellerKey
WHERE FRS.ResellerKey IS NULL
ORDER BY PC.EnglishProductCategoryName, PS.EnglishProductSubcategoryName, P.EnglishProductName;


--12.	In your own words, write a business question that you can answer by querying the data warehouse 
--		and using an outer join.
--		Then write the SQL query that will provide the information that you are seeking.
--		How many bikes have not been sold to customers over the internet?

SELECT P.EnglishProductName, PC.EnglishProductCategoryName
FROM dbo.FactInternetSales AS FIS
	RIGHT OUTER JOIN dbo.DimCustomer AS C
	ON FIS.CustomerKey = C.CustomerKey
	RIGHT OUTER JOIN dbo.DimProduct AS P
	ON FIS.ProductKey = P.ProductKey
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
	INNER JOIN dbo.DimProductCategory AS PC
	ON PS.ProductCategoryKey = PC.ProductCategoryKey
WHERE PC.EnglishProductCategoryName = 'Bikes' AND C.CustomerKey IS NULL
ORDER BY P.EnglishProductName ASC;