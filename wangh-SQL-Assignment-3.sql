--*  BUSIT 103           Assignment   #3              DUE DATE:  Consult course calendar
							
/*
Assignment 3 - Expressions and Data Types

	1.	Ms. Frances Adams

	2.	29489 Ms. Frances Adams

	3.	Customer ID 29485 is: Ms. Catherine Abel

	4.	Product Category 10 -- Brakes

	5a.	14304.42

	5b.	5.39

	6a.	1419.95

	6b.	1955.04

	7a.	PO19372114749	2008-06-08

	7b.	29568	2008-06-01

	7c.	5

	7d.	5

	8.	SELECT CAST(CURRENT_TIMESTAMP AS Date) AS MyPCDate;

PURPOSE:

Knowledge:

    o Identify Data Types
    o Explain a NULL valueUnderstand how data is stored in relational database tables
    
Skills:

    o Create calculated columns
    o Write concatenation expressions
    o Use character, numeric, and date/time data types in expressions
    o Use the CAST and CONVERT functions

TASK:

    1. Download the following SQL file and rename it Xxxxx-SQL-Assignment-03, where Xxxxx is your last and first name. 
	For example, I would rename this file Duncanp-SQL-Assignment-03.sql.

		Xxxxx-SQL-Assignment-03.sql

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

*/

/*	
	The fields' names are written as if a person is asking you for the report. You will need to look at the data
	and understand that list price is in the ListPrice field, for example.
	Add comments to describe your reasoning when you are in doubt about something. 
	
    For this assignment, we will use the AdventureWorksLT2012 database. We tell SQL Server which database 
    to use via the USE statement.

    Do not remove the USE statement. 
*/

USE AdventureWorksLT2017;


--1.	List the customer id and the name for each customer using two columns. The customer id will 
--		be in the first column. Create a concatenation for the second column that combines the title,
--		first name, and last name for each customer. For example, the name for customer ID 29485 will  
--		display in one column as 
--					Ms. Catherine Abel
--		Don't forget to include a space between each part of the name. Assign CustomerName as the alias
--		for the derived column. Order the results in alphabetical order by last name then by first name.
--		QUESTION:		What is the CustomerName with the CustomerID of 29489?
--		YOUR ANSWER: Ms. Frances Adams
--

SELECT CustomerID, CONCAT(Title,' ', FirstName, ' ', LastName) AS CustomerName
FROM SalesLT.Customer
ORDER BY LastName, FirstName;


--2.	Using the CAST function, list the customer ID and the name for each customer in one column. 
--		Create a concatenation of the customer id, title, first name and last name for each customer. For 
--		example, the record for customer id 29485 will display in one column as 
--					29485 Ms. Catherine Abel
--		Assign CustomerInfo as the alias for the derived column. 
--		Order the results in alphabetical order by last name then by first name.
--		HINT: Look at the data type of the fields to which you are concatenating the customer id and cast 
--		customer id to match.
--		QUESTION:		What is the value for CustomerInfo in row 6?
--		YOUR ANSWER:	29489 Ms. Frances Adams

SELECT CAST(CustomerID AS nvarchar(10)) + ' ' + Title + ' ' + FirstName + ' ' + LastName AS CustomerInfo
FROM SalesLT.Customer
ORDER BY LastName, FirstName;


--3.	Using the CAST function, rewrite the SELECT statement created in #2 to add the descriptive text  
--		"Customer ID" and "is". The record for customer id 29485 will display in one column as 
--					Customer ID 29485 is: Ms. Catherine Abel
--		Use the same alias and sort order as #2.
--		QUESTION:		What is the value for CustomerInfo in row 2?
--		YOUR ANSWER: Customer ID 29485 is: Ms. Catherine Abel

SELECT 'Customer ID ' + CAST(CustomerID AS nvarchar(10)) + ' is: ' + Title + ' ' + FirstName + ' ' + LastName AS CustomerInfo
FROM SalesLT.Customer
ORDER BY LastName, FirstName;

--4.	Using the CAST function and the ProductCategory table, create a list of the product category  
--		and the category name in one column. Product category 1 will display in one column as 
--					Product Category 1 -- Bikes 
--		Give the derived column a meaningful alias (column name) and sort by the derived column in ascending order.
--		QUESTION:		What is the value in row 2?
--		YOUR ANSWER:	Product Category 10 -- Brakes

SELECT 'Product Category ' + CAST(ProductCategoryID AS nvarchar(3)) + ' -- ' + Name AS ProductInfo
FROM SalesLT.ProductCategory
ORDER BY ProductInfo ASC;


--5.	For a and b below, use the SalesLT.SalesOrderDetail table to list all product sales. 
--		Show SalesOrderID, TotalCost and LineTotal for each sale. Compute TotalCost as
--		UnitPrice * (1-UnitPriceDiscount)* OrderQty. Change the data type of LineTotal to money.
--      Display money values to exactly 2 decimal places (hint - use the ROUND function).
--		TotalCost and LineTotal should show the same amount. LineTotal is included to double check 
--		your calculation; the two amounts should match. Sort by TotalCost in descending order.   

--a.	CAST is the ANSI standard. Write the statement using CAST.
--		QUESTION:		What is the TotalCost in record 3?
--		YOUR ANSWER:	14304.42

SELECT SalesOrderID, ROUND((UnitPrice * (1 - UnitPriceDiscount) * OrderQty), 2) AS TotalCost, 
CAST(ROUND(LineTotal, 2) AS money) AS LineTotal
FROM SalesLT.SalesOrderDetail
ORDER BY TotalCost DESC;


--b.	Write the statement again using CONVERT instead of CAST. CONVERT is also commonly used. 
--      Change the sort to TotalCost in ascending order.
--		QUESTION:		What is the TotalCost in record 3?
--		YOUR ANSWER:	5.39

SELECT SalesOrderID, ROUND((UnitPrice * (1 - UnitPriceDiscount) * OrderQty), 2) AS TotalCost, 
CONVERT(money, ROUND(LineTotal, 2)) AS LineTotal
FROM SalesLT.SalesOrderDetail
ORDER BY TotalCost ASC;


--6.	For a. and b. below, AdventureWorks predicts a 3% increase in production costs for all their 
--		products. They wish to see how the increase will affect their profit margins. To help them 
--		understand the impact of this increase in production costs (StandardCost), you will create 
--		a list of all products showing ProductID, Name, ListPrice, FutureCost (use StandardCost * 1.03  
--		to compute FutureCost), and Profit (use ListPrice minus the calculation for FutureCost to find Profit). 
--		All money values are to show exactly 2 decimal places. Order the results descending by Profit. 
--      Hint: Use the DECIMAL or NUMERIC data type.

--a.	First write the requested statement using CAST. CAST is the ANSI standard. There will be five 
--		fields (columns). There will be one row for each product in the Product table. 
--		QUESTION:		What is the Profit number in row 8?
--		YOUR ANSWER:	1419.95

SELECT ProductID, Name, ListPrice, CAST(StandardCost * 1.03 AS decimal(8, 2)) AS FutureCost, 
CAST(ListPrice - (StandardCost * 1.03) AS decimal(8, 2)) AS Profit
FROM SalesLT.Product
ORDER BY Profit DESC;

--b.	Next write the statement from 6a again using CONVERT. There will be five 
--		fields (columns). There will be one row for each product in the Product table. 
--		QUESTION:		What is the FutureCost number in row 5?
--		YOUR ANSWER:	1955.04

SELECT ProductID, Name, ListPrice, CONVERT(decimal(8, 2), (StandardCost * 1.03)) AS FutureCost, 
CONVERT(decimal(8, 2), (ListPrice - (StandardCost * 1.03))) AS Profit
FROM SalesLT.Product
ORDER BY Profit DESC;


--7.	For a. and b. below, list all sales orders showing PurchaseOrderNumber, SalesOrderID, CustomerID, OrderDate, 
--		DueDate, and ShipDate. Format the datetime fields so that no time is displayed. Be sure to give each derived 
--		column an alias and order by CustomerID in ascending order. 

--a.	CAST is the ANSI standard. Write the statement using CAST. 
--		QUESTION:		What is the PurchaseOrderNumber and ShipDate in the first record?
--		YOUR ANSWER:	PO19372114749	2008-06-08

SELECT PurchaseOrderNumber, SalesOrderID, CustomerID, CAST(OrderDate AS date) AS OrderDate, 
CAST(DueDate AS date) AS DueDate, CAST(ShipDate AS date) AS ShipDate
FROM SalesLT.SalesOrderHeader
ORDER BY CustomerID ASC;

--b.	Write the statement again using CONVERT.
--		QUESTION:		What is the CustomerID and OrderDate in the record 4?
--		YOUR ANSWER:	29568	2008-06-01

SELECT PurchaseOrderNumber, SalesOrderID, CustomerID, CONVERT(date, OrderDate) AS OrderDate, 
CONVERT(date, DueDate) AS DueDate, CONVERT(date, ShipDate) AS ShipDate
FROM SalesLT.SalesOrderHeader
ORDER BY CustomerID ASC;


--c.	Write a statement using all of either 7a or 7b and add a field that calculates the 
--		difference between the ship date and the due date. Name the field ShipDays and show 
--		the result as a positive number. Be sure Datetime fields still show only the date. 
--		The DateDiff function is not an ANSI standard; don't use it in this statement. 
--		QUESTION:		What is the value for ShipDays in all the records?
--		YOUR ANSWER:	5

SELECT PurchaseOrderNumber, SalesOrderID, CustomerID, CAST(OrderDate AS date) AS OrderDate, 
CAST(DueDate AS date) AS DueDate, CAST(ShipDate AS date) AS ShipDate, CAST((DueDate - ShipDate) AS int) AS ShipDays
FROM SalesLT.SalesOrderHeader
ORDER BY CustomerID ASC;


--d.	Rewrite the statement from 7c to use the DateDiff function to find the 
--		difference between the ShipDate and the DueDate. Again, show only the date in datetime fields.
--		QUESTION:		What is the value for ShipDays in all the records?
--		YOUR ANSWER:	5

SELECT PurchaseOrderNumber, SalesOrderID, CustomerID, CAST(OrderDate AS date) AS OrderDate, 
CAST(DueDate AS date) AS DueDate, CAST(ShipDate AS date) AS ShipDate, DATEDIFF(day, ShipDate, DueDate) AS ShipDays
FROM SalesLT.SalesOrderHeader
ORDER BY CustomerID ASC;

 
--8.	EXPLORE: Research the following on the Web for an answer:
--		Find a date function that will return a datetime value that contains the date and time from the computer
--		on which the instance of SQL Server is running (this means it shows the date and time of the PC on which 
--		the function is executed). The time zone offset is not included. Write the statement so it will execute.
--		Format the result to show only the date portion of the field and give it the alias of MyPCDate.

--		SELECT CURRENT_TIMESTAMP AS MyPCDate;

SELECT CAST(CURRENT_TIMESTAMP AS date) AS MyPCDate;
