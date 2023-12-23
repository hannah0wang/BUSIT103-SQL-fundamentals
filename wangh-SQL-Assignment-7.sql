/*--------------------------------------------------------------------------------------------------------------------
--
-- BUSIT 103           Assignment   #7              DUE DATE :  Consult course calendar
--
--------------------------------------------------------------------------------------------------------------------

Querying Data from a Data Warehouse

1a.		Krista

1b.		Baker

1c.		Lucas

2a.		225

2b.		606

2c.		504

2d.		Fender Set - Mountain

3a.		473		Classic Vest, L		Partial College

3b.		484

4.		472		Classic Vest, M		Professional

5a.		Ben

5b.		9132

5c.		Some customers have multiple customer keys, so there more unique customer keys than probably customers

6.		Road-250 Black, 52

7.		538		LL Road Tire

8.		Which customers with the last name Williams bought bikes in the state of Oregon?

SELECT C.FirstName, C.LastName, C.CustomerKey, P.EnglishProductName, G.City, G.StateProvinceName
FROM dbo.FactInternetSales AS FIS
	INNER JOIN dbo.DimCustomer AS C
	ON FIS.CustomerKey = C.CustomerKey
	INNER JOIN dbo.DimGeography AS G
	ON C.GeographyKey = G.GeographyKey
	INNER JOIN dbo.DimProduct AS P
	ON FIS.ProductKey = P.ProductKey
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
	INNER JOIN dbo.DimProductCategory AS PC
	ON PS.ProductCategoryKey = PC.ProductCategoryKey
WHERE C.LastName = 'Williams' AND PC.EnglishProductCategoryName = 'Bikes' AND G.StateProvinceName = 'Oregon'
ORDER BY C.LastName, C.FirstName;


PURPOSE:

Knowledge:
 
    o Describe the purpose of a data warehouse
    o Describe the Star schema
    o Explain the difference between a Fact table and a Dimension table
    o Explain how a data warehouse holds data that changes slowly over time
    
Skills:

    o Write SQL to extract information from a data warehouse

TASK:

    1. Download the following SQL file and rename it Xxxxx-SQL-Assignment-07, where Xxxxx is your last and first name. 
	For example, I would rename this file ChengCharlene-SQL-Assignment-07.sql.

		Xxxxx-SQL-Assignment-07.sql

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

 You are required to use INNER JOINs to solve each problem. Even if you know another method that will produce 
 the result, this module is practice in INNER JOINs.


 REMINDERS: Run the statement in stages-- Write the SELECT and FROM clauses first and run 
 the statement. Add the ORDER BY clause. Then add the WHERE clause; if it is a compound WHERE clause, 
 add a piece at a time. Lastly perform the CAST or CONVERT. When the statement is created in steps, it 
 is easier to isolate any errors. 

 When there are multiple versions of a field, such as EnglishCountryRegionName, SpanishCountryRegionName, 
 FrenchCountryRegionName, use the English version of the field. When asked to show 'only once', 'unique', 
 or 'one time only', use the DISTINCT keyword. Recall that it is the row that is unique in the result set.  

 'Customers' generally refers only to individuals that purchase over the Internet and are stored in the 
 DimCustomers table. For example, if the request is for customers in the UK city of York, be sure to include 
 the UK portion of the filter. The city of York exists in other countries.

 If no sort order is specified, assume it is in ascending order. 

--------------------------------------------------------------------------------------------------------------------

--/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
--NOTE: We are now using a different database. 
*/

USE AdventureWorksDW2017; 



--1.a.	List the names and locations of AdventureWorks customers who identify as female (Gender field). 
--		Show customer key, first name, last name, state name, and country name. Order the list 
--		by country name, state name, last name, and first name in alphabetical order. 
--      I got 9133 rows
--		QUESTION:		What is the first name in record 7?
--		YOUR ANSWER==>	Krista
--

SELECT C.CustomerKey, C.FirstName, C.LastName, G.StateProvinceName, G.EnglishCountryRegionName
FROM dbo.DimCustomer AS C
	INNER JOIN dbo.DimGeography AS G
	ON C.GeographyKey = G.GeographyKey
WHERE C.Gender = 'F'
ORDER BY G.EnglishCountryRegionName, G.StateProvinceName, C.LastName, C.FirstName;


--1.b.	Copy/paste the statement from 1.a to 1.b. Modify the WHERE clause in 1.b to show only 
--		those AdventureWorks customers who identify as  male and from the US City of Seattle. 
--		Show customer key, first name, last name, and city name. 
--		Change the sort order to list by last name, then first name in alphabetical order. 
--      I got 43 rows
--		QUESTION:		What is the last name in record 7?
--		YOUR ANSWER==>	Baker

SELECT C.CustomerKey, C.FirstName, C.LastName, G.City
FROM dbo.DimCustomer AS C
	INNER JOIN dbo.DimGeography AS G
	ON C.GeographyKey = G.GeographyKey
WHERE C.Gender = 'M' AND G.EnglishCountryRegionName = 'United States' AND G.City = 'Seattle'
ORDER BY C.LastName, C.FirstName;


--1.c.	Copy/paste statement from 1.b to 1.c. Modify the WHERE clause in 1.c to list only 
--		AdventureWorks customers from the US city of Portland who identify as male and have 1 or more cars. 
--		Show customer key, first name, last name, and total number of cars. 
--		Order the list by number of cars in descending order, then by last name and first name 
--		in alphabetical order.
--      I got 32 rows
--		QUESTION:		What is the first name in record 7?
--		YOUR ANSWER==>	Lucas

SELECT C.CustomerKey, C.FirstName, C.LastName, C.NumberCarsOwned
FROM dbo.DimCustomer AS C
	INNER JOIN dbo.DimGeography AS G
	ON C.GeographyKey = G.GeographyKey
WHERE C.Gender = 'M' AND G.EnglishCountryRegionName = 'United States' AND G.City = 'Portland' AND C.NumberCarsOwned >= 1
ORDER BY C.NumberCarsOwned DESC, C.LastName ASC, C.FirstName ASC;


--2.a.	Explore the data warehouse using only the DimProduct table. No joins are required. 
--		Show the English product name, product key, product alternate key, standard cost, list price, 
--		and status. Sort on English product name. Notice that some of the products appear to be duplicates. 
--		The name and the alternate key remain the same but the product is added again with a new product 
--		key to track the history of changes to the product attributes. For example, look at AWC Logo Cap. 
--		Notice the history of changes to StandardCost and ListPrice and to the value in the Status field. 
--      I got 606 rows
--		QUESTION:		What is the ProductKey for the AWC Logo Cap that is currently being sold?
--		YOUR ANSWER==>	225

SELECT EnglishProductName, ProductKey, ProductAlternateKey, StandardCost, ListPrice, Status
FROM dbo.DimProduct
ORDER BY EnglishProductName;



--2.b.  Using the DimProduct table, list the product key, English product name, and product alternate key 
--      for each product only once. Sort on English product name.  
--		QUESTION:		How many rows did your query return?
--		YOUR ANSWER==>	606

SELECT DISTINCT ProductKey, EnglishProductName, ProductAlternateKey
FROM dbo.DimProduct
ORDER BY EnglishProductName;

--2.c.  Using the DimProduct table, list the English product name and product alternate key for each product only once. 
--      Sort on English product name. Recall terms like “only once”, “one time”, and "unique" all indicate the need for the DISTINCT keyword. 
--		QUESTION:		How many rows did your query return?
--		YOUR ANSWER==>	504

SELECT DISTINCT EnglishProductName, ProductAlternateKey
FROM dbo.DimProduct
ORDER BY EnglishProductName;


--2.d.	Join tables to the product table to also show the category and subcategory name for each product. 
--		Show the English category name, English subcategory name, English product name, and product alternate key 
--		only once. Sort the results by the English category name, English subcategory name, and English product 
--		name. 
--      I got 295 rows
--		QUESTION:		English product name in record 7?
--		YOUR ANSWER==>	Fender Set - Mountain

SELECT DISTINCT PC.EnglishProductCategoryName, PS.EnglishProductSubcategoryName, P.EnglishProductName, P.ProductAlternateKey
FROM dbo.DimProductCategory AS PC
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON PC.ProductCategoryKey = PS.ProductCategoryKey
	INNER JOIN dbo.DimProduct AS P
	ON PS.ProductSubcategoryKey = P.ProductSubcategoryKey
ORDER BY PC.EnglishProductCategoryName, PS.EnglishProductSubcategoryName, P.EnglishProductName;


--3.a.	List the English name for products purchased over the Internet by customers who indicate education  
--		as high school or partial college. Show Product key and English Product Name and English Education. 
--		Order the list by English Product name. Show a product only once for each education level 
--      even if it has been purchased several times. Hint 1: SELECT DISTINCT
--      Hint 2: Use FactInternetSales, DimCustomer, DimProduct tables.
--      I got 315 rows
--		QUESTION:		What is the ProductKey, EnglishProductName and EnglishEducation in row 7
--		YOUR ANSWER==>	473		Classic Vest, L		Partial College

SELECT DISTINCT FIS.ProductKey, P.EnglishProductName, C.EnglishEducation
FROM dbo.FactInternetSales AS FIS
	INNER JOIN dbo.DimProduct AS P
	ON FIS.ProductKey = P.ProductKey
	INNER JOIN dbo.DimCustomer AS C	
	ON FIS.CustomerKey = C.CustomerKey
WHERE C.EnglishEducation IN('High School', 'Partial College')
ORDER BY P.EnglishProductName;


--3.b.	List the English name for products purchased over the Internet by customers who indicate 
--		partial high school or partial college. Show Product key and English Product Name 
--		and English Education. Order the list by English Product name and then by English Education. 
--		Show a product only once for each education level even if it has been purchased several times. 
--      I got 311 rows
--		QUESTION:		What is the product key in row 5?
--		YOUR ANSWER==>	484

SELECT DISTINCT FIS.ProductKey, P.EnglishProductName, C.EnglishEducation
FROM dbo.FactInternetSales AS FIS
	INNER JOIN dbo.DimProduct AS P
	ON FIS.ProductKey = P.ProductKey
	INNER JOIN dbo.DimCustomer AS C
	ON FIS.CustomerKey = C.CustomerKey
WHERE C.EnglishEducation IN('Partial High School', 'Partial College')
ORDER BY P.EnglishProductName, C.EnglishEducation;


--4.	List the English name for products purchased over the Internet by customers who list their occupation as 
--      Management or Professional. Show Product key and English Product Name and English Occupation. 
--		Sort by English product name and occupation in alphabetical order. 
--      Show a product only once for each occupation even if it has been purchased several times.
--      I got 314 rows
--		QUESTION:		What is the ProductKey, EnglishProductName and EnglishOccupation in row 10?
--		YOUR ANSWER==>	472		Classic Vest, M		Professional

SELECT DISTINCT FIS.ProductKey, P.EnglishProductName, C.EnglishOccupation
FROM dbo.FactInternetSales AS FIS
	INNER JOIN dbo.DimProduct AS P
	ON FIS.ProductKey = P.ProductKey
	INNER JOIN dbo.DimCustomer AS C
	ON FIS.CustomerKey = C.CustomerKey
WHERE C.EnglishOccupation IN('Management', 'Professional')
ORDER BY P.EnglishProductName, C.EnglishOccupation;


/******************************************************************************************************************
Question 5 contains exploratory questions. You may wish to read all three questions before beginning. 
Seeing the purpose of the questions may help understand the requests. 
*******************************************************************************************************************/



--5.a.	List customers who have purchased bikes over the Internet.  Show customer first name, 
--		last name, and English product category. If a customer has purchased clothing items more than once, 
--		show only one row for that customer. 
--      Order the list by last name, then first name. 
--      I got 9109 rows
--		QUESTION:		What is first name in row 7?
--		YOUR ANSWER==>	Ben

SELECT DISTINCT C.FirstName, C.LastName, PC.EnglishProductCategoryName
FROM dbo.FactInternetSales AS FIS
	INNER JOIN dbo.DimCustomer AS C
	ON FIS.CustomerKey = C.CustomerKey
	INNER JOIN dbo.DimProduct AS P
	ON FIS.ProductKey = P.ProductKey
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
	INNER JOIN dbo.DimProductCategory AS PC
	ON PS.ProductCategoryKey = PC.ProductCategoryKey
WHERE PC.EnglishProductCategoryName = 'Bikes'
ORDER BY C.LastName, C.FirstName;


--5.b.	Copy/paste 5.a to 5.b and modify 5.b.  Show customer key, first name, last name, and English 
--		product category. If a customer has purchased bikes more than once, show only one row for that customer. 
--		Order the list by last name, then first name. 
--		QUESTION:		How many rows did you get?
--		YOUR ANSWER==>	9132

SELECT DISTINCT C.CustomerKey, C.FirstName, C.LastName, PC.EnglishProductCategoryName
FROM dbo.FactInternetSales AS FIS
	INNER JOIN dbo.DimCustomer AS C
	ON FIS.CustomerKey = C.CustomerKey
	INNER JOIN dbo.DimProduct AS P
	ON FIS.ProductKey = P.ProductKey
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
	INNER JOIN dbo.DimProductCategory AS PC
	ON PS.ProductCategoryKey = PC.ProductCategoryKey
WHERE PC.EnglishProductCategoryName = 'Bikes'
ORDER BY C.LastName, C.FirstName;

--5.c.	Be brief and specific. This is actually a simple answer. 
--		QUESTION==>		Why is there a difference between the number of records received in 5a and 5b?
--                      Be brief and specific. This is actually a simple answer. 
--		YOUR ANSWER:	Some customers have multiple customer keys, so there more unique customer keys than probably customers



--6.	List all Internet sales for bikes that occurred during 2013 (Order Date in 2013). 
--		Show Order date, product key, product name, and sales amount for each line item sale. 
--		Show the date as mm/dd/yyyy as DateOfOrder. Show the list in oldest to newest order by date 
--      and alphabetically by product name.
--      Hint: For the date, use the syntax similar to CONVERT(nvarchar, date, style code). 
--      Look up the appropriate style code.  
--      I got 9706 rows
--		QUESTION:		What is the product name in record 7?
--		YOUR ANSWER==>	Road-250 Black, 52

SELECT CONVERT(nvarchar(10), FIS.OrderDate, 101) AS DateOfOrder, P.ProductKey, P.EnglishProductName, FIS.SalesAmount
FROM dbo.FactInternetSales AS FIS
	INNER JOIN dbo.DimProduct AS P
	ON FIS.ProductKey = P.ProductKey
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
	INNER JOIN dbo.DimProductCategory AS PC
	ON PS.ProductCategoryKey = PC.ProductCategoryKey
WHERE YEAR(FIS.OrderDate) = 2013 AND PC.EnglishProductCategoryName = 'Bikes'
ORDER BY FIS.OrderDate, EnglishProductName;

--7.	List all Internet sales of Accessories to customers in Berlin, Germany during 2013. 
--		Show product key, product name, order date as mm/dd/yyyy, SalesAmount, and City for each line item sale. 
--		Show the list by date in ascending order and product key in ascending order. 
--      I got 337 rows
--		QUESTION:		What is the ProductKey and EnglishProductName in record 7?
--		YOUR ANSWER==>	538		LL Road Tire

SELECT P.ProductKey, P.EnglishProductName, CONVERT(nvarchar(10), FIS.OrderDate, 101) AS DateOfOrder, FIS.SalesAmount, G.City
FROM dbo.FactInternetSales AS FIS
	INNER JOIN dbo.DimCustomer AS C
	ON FIS.CustomerKey = C.CustomerKey
	INNER JOIN dbo.DimGeography AS G
	ON C.GeographyKey = G.GeographyKey
	INNER JOIN dbo.DimProduct AS P
	ON FIS.ProductKey = P.ProductKey
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
	INNER JOIN dbo.DimProductCategory AS PC
	ON PS.ProductCategoryKey = PC.ProductCategoryKey
WHERE G.City = 'Berlin' AND G.EnglishCountryRegionName = 'Germany' AND YEAR(FIS.OrderDate) = 2013 AND PC.EnglishProductCategoryName = 'Accessories'
ORDER BY DateOfOrder, P.ProductKey;


--8.	In your own words, write a business question that you can answer by querying the data warehouse. 
--		Then write the SQL query using at least one INNER JOIN that will provide the information that you are 
--		seeking. Try it. You get credit for writing a question and trying to answer it. 
--		Which customers with the last name Williams bought bikes in the state of Oregon?

SELECT C.FirstName, C.LastName, C.CustomerKey, P.EnglishProductName, G.City, G.StateProvinceName
FROM dbo.FactInternetSales AS FIS
	INNER JOIN dbo.DimCustomer AS C
	ON FIS.CustomerKey = C.CustomerKey
	INNER JOIN dbo.DimGeography AS G
	ON C.GeographyKey = G.GeographyKey
	INNER JOIN dbo.DimProduct AS P
	ON FIS.ProductKey = P.ProductKey
	INNER JOIN dbo.DimProductSubcategory AS PS
	ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
	INNER JOIN dbo.DimProductCategory AS PC
	ON PS.ProductCategoryKey = PC.ProductCategoryKey
WHERE C.LastName = 'Williams' AND PC.EnglishProductCategoryName = 'Bikes' AND G.StateProvinceName = 'Oregon'
ORDER BY C.LastName, C.FirstName;