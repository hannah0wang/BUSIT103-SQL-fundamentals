/*
Assignment 4 - Filtering Data

	1.	Edmonton	Alberta

	2.	V5G 4S4

	3.	595 Burning Street

	4.	V7L 4J4

	5.	3399.99

	6.	Women's Mountain Shorts, S

	7.	BK-M47B-44

	8.	11689.01

	9.	1 (11) 500 555-0195

	10.	Racing Socks, L

	11.	3

PURPOSE:

Knowledge:

    o Understand how the WHERE clause works to filter data
    o Explain the order of precedence and how parenthesis can override the default order
    o Understand how the NULL condition impacts the results set


Skills:

    o Demonstrate the use of five basic predicates: COMPARISON, BETWEEN, IN, LIKE, and IS NULL
    o Use the NOT operator to exclude rows from a result set
    o Combine the AND and OR operators in a WHERE clause
    

TASK:

    1. Download the following SQL file and rename it Xxxxx-SQL-Assignment-04, where Xxxxx is your last and first name. 
	For example, I would rename this file Duncanp-SQL-Assignment-04.sql.

		Xxxxx-SQL-Assignment-04.sql

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
    You are to develop SQL statements for each task listed. You should type your SQL statements under each task.
	The fields' names are written as if a person is asking you for the report. You will need to look at the data
	and understand that list price is in the ListPrice field, for example.
	Add comments to describe your reasoning when you are in doubt about something. 

	If no sort order is specified, assume it is in ascending order. 

    For this assignment, we will use the AdventureWorksLT2012 database. We tell SQL Server which database 
    to use via the USE statement.


    Do not remove the USE statement. 
*/
--

--
	
USE AdventureWorksLT2017;


--1.	Use the SalesLT.Address table to list addresses in Canada. Select the address1, 
--		city, state/province, country/region and postal code. Sort by state/province in ascending order 
--      and city in ascending order. 
--		I got 115 rows.
--		QUESTION:		What is the City and StateProvince in record 12?
--		YOUR ANSWER:	Edmonton	Alberta

SELECT AddressLine1, City, StateProvince, CountryRegion, PostalCode
FROM SalesLT.Address
WHERE CountryRegion = 'Canada'
ORDER BY StateProvince, City;


--2.	Use the SalesLT.Address table to list addresses in the Canadian cities of Burnaby and Vancouver. 
--      Make sure you filter on country, StateProvince AND state.
--		Select the address1, city, state/province, country/region and postal code. Sort by 
--		state/province and city in ascending order. 
--      I got 10 rows.
--		QUESTION:		What is the PostalCode in record 3?
--		YOUR ANSWER:	V5G 4S4

SELECT AddressLine1, City, StateProvince, CountryRegion, PostalCode
FROM SalesLT.Address
WHERE CountryRegion = 'Canada' AND City = 'Burnaby' OR City = 'Vancouver' AND StateProvince = 'British Columbia'
ORDER BY StateProvince, City;

--3.	Use the SalesLT.Address table to list addresses in the cities of Victoria or Vancouver.
--		Select the address1, city, state/province, country/region and postal code. 
--		Order the list by city.
--      I got 7 rows.
--		QUESTION:		What is the AddressLine1 in record 4?
--		YOUR ANSWER:	595 Burning Street

SELECT AddressLine1, City, StateProvince, CountryRegion, PostalCode
FROM SalesLT.Address
WHERE CountryRegion = 'Canada' AND City = 'Victoria' OR City = 'Vancouver'
ORDER BY City ASC;


--4.	Use the SalesLT.Address table to list addresses in the cities of Victoria or Vancouver 
--		in the StateProvince of British Columbia. Select the address1, city, state/province, country/region 
--		and postal code. Order the list by city in ascending order. Do not make assumptions that it is acceptable to skip 
--		requested filters.
--      I got 6 rows.
--		QUESTION:		What is the PostalCode in record 1?
--		YOUR ANSWER:	V7L 4J4

SELECT AddressLine1, City, StateProvince, CountryRegion, PostalCode
FROM SalesLT.Address
WHERE CountryRegion = 'Canada' AND City = 'Victoria' OR City = 'Vancouver' AND StateProvince = 'British Columbia'
ORDER BY City ASC;


--5.	List the name, product number, size, standard cost, and list price in alphabetical order by name 
--		for Products whose standard cost is $1,200 or more, and ListPrice is more than $2,500. 
--      Show all money values at exactly two decimal places. 
--		Be sure to give each derived column an alias. 
--      I got 13 rows.
--		QUESTION:		What is the ListPrice in record 5?
--		YOUR ANSWER:	3399.99

SELECT Name, ProductNumber, Size, ROUND(StandardCost, 2) AS StandardCost, ListPrice
FROM  SalesLT.Product
WHERE StandardCost >= 1200 AND ListPrice > 2500
ORDER BY Name ASC;

--6.	List the name, product number, list price, and size for products whose size is one of the 
--		following:  S, M. Order list price descending, ProductNumber ascending.
--      I got 20 rows.
--		QUESTION:		What is the Name in record 6?
--		YOUR ANSWER:	Women's Mountain Shorts, S

SELECT Name, ProductNumber, ListPrice, Size
FROM SalesLT.Product
WHERE Size = 'S' OR Size = 'M'
ORDER BY ListPrice DESC, ProductNumber ASC;

--7.	List the name, product number, and sell end date for all products in the Product table 
--		that are not currently sold (products that are not currently sold have a date in the End Date field). 
--		Sort by the sell end date from oldest to most recent date, and product number in ascending order. 
--      Show only the date (no time) in the sell end date field. Be sure to give each derived column an alias.
--      I got 98 rows.
--		QUESTION:		What is the ProductNumber in record 3?
--		YOUR ANSWER:	BK-M47B-44

SELECT Name, ProductNumber, CAST(SellEndDate AS Date) AS SellEndDate
FROM SalesLT.Product
WHERE SellEndDate IS NOT NULL
ORDER BY SellEndDate DESC, ProductNumber ASC;


--8.	List the name, product number, standard cost, list price, and weight for products whose weight is greater than 3,000, 
--      standard cost is less than $700, list price is greater than $800. Round money values 
--		to exactly 2 decimal places and give each derived column a meaningful alias. Sort by weight ascending.
--      I got 4 rows.
--		QUESTION:		What is the weight in record 2?
--		YOUR ANSWER:	11689.01

SELECT Name, ProductNumber, ROUND(StandardCost, 2) AS StandardCost, ListPrice, Weight
FROM SalesLT.Product
WHERE Weight > 3000 AND StandardCost < 700 AND ListPrice > 800
ORDER BY Weight ASC;


--  In the next group of requests well will be looking for data based on partial information. For example, we may 
--  be looking for customers whose last name contains 'john'. By using wildcards appropriately, we could find names 
--  like Godejohn, Johns, Johnsen, Johnson, Johnston, and Johnstone. Wildcards should be used only when you have 
--  partial information, because they are inefficient, slow, and can return incorrect results. If you are looking for 
--  'Johnstone', use = 'Johnstone' not LIKE '%Johnstone%'.

--9.	List the company name and phone for those customers whose phone number contains the following 
--		sequence: 19. Order the list by phone number in ascending order. "Contains" means that the sequence exists 
--		within the phone number.
--      I got 57 rows.
--		QUESTION:		What is the phone number in record 3?
--		YOUR ANSWER:	1 (11) 500 555-0195

SELECT DISTINCT CompanyName, Phone
FROM SalesLT.Customer
WHERE Phone LIKE '%19%'
ORDER BY Phone ASC;

--10.	List the name and product number for all products in the Product table that include 'socks' in the name. 
--		Sort by the name. 
--      I got 4 rows.
--		QUESTION:		What is the Name in record 3?
--		YOUR ANSWER:	Racing Socks, L

SELECT Name, ProductNumber
FROM SalesLT.Product
WHERE Name LIKE '%SOCK%'
ORDER BY Name ASC;

--11.	List the name and product category id, and parent id for all product categories that include 
--		'bike' in the name. Sort by the parent product category id. 
--      I got 6 rows.
--		QUESTION:		How many categories of bikes are there? Do not include the parent category in your count.
--		HINT:			Look at the data before you answer.
--		YOUR ANSWER:	3

SELECT Name, ProductCategoryID, ParentProductCategoryID
FROM SalesLT.ProductCategory
WHERE Name LIKE '%BIKE%'
ORDER BY ProductCategoryID ASC;
