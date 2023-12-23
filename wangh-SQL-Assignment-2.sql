--------------------------------------------------------------------------------------------------------------------
--
-- BUSIT 103           Assignment   #2              DUE DATE :  Consult course calendar
--
--------------------------------------------------------------------------------------------------------------------
--
-- You are to develop SQL statements for each task listed.  You should type your SQL statements under each task.  
-- Please record your answers in the YOUR ANSWER.
-- Submit your .sql file named with your last name, first name and assignment # (e.g., duncanp-SQL-Assignment-2.sql). 
-- Upload your solution file to the correct assignment page in Canvas.  
--
-- NOTE: There may be some discrepancies in datbases which may cause you to have a different answer than mine. 
--       Check the code for differences.
--
--  Enter your answer by the corresponding number below
--
--  1: 847 records
--	
--  2: A Cycle Shop
--
--  3: Professional Sales and Service
--
--  4: adventure-works\jae0
--
--  5: Cable Lock
--
--  6: 772
--
--  7: Road-150 Red, 56
--
--  8: 7.95
--
--  9: Blue
--
-- 10: T2P 2G8
--
-- 11: Brunswick
--
-- 12: Burnaby
--
-- 13: 16261.264656
--
-- 14: 29546
--
----------------------------------------------------------------------------------------------------------------------

USE AdventureWorksLT2017;

--1.	List all customers.  Include all the attributes in the table. Use * in this statement. 
--		NOTE: When exploring data in a table, we will often write a statement using *. In this statement 
--		your primary purpose is to see how * works. After executing the statement, explore the data.
--		QUESTION:	How many records did the query return?	
--		YOUR ANSWER: 847

SELECT *
FROM SalesLT.Customer;


--2.	List the company name, first name, last name, and email address of each customer in alphabetical order 
--		by company name. 
--		NOTE: In this statement you are limiting the fields that you are including in the results set. Additionally, 
--		you are sorting your results in a specific order. Recall that order is not guaranteed unless a sort order is 
--		specified in the statement. 
--		QUESTION:	What is the CompanyName in the record 3?	
--		YOUR ANSWER: A Cycle Shop

SELECT CompanyName, FirstName, LastName, EmailAddress
FROM SalesLT.Customer
ORDER BY CompanyName;


--3.	List the company name, first name, last name, and phone number for each customer in alphabetical 
--		order by last name, then by first name, and then by company.  Hint: There will be one SELECT statement 
--		with three fields in the ORDER BY clause. Do not change the order of the fields in the SELECT clause.
--		NOTE: In this statement, you are experimenting with ORDER BY. Scan the results and look for customers with 
--		the same last name. Notice how they are sorted by first name within the sort by last name. If there are 
--		customers with the same last and first name, they will also be sorted on company name. 
--		QUESTION:	What is the CompanyName in record 2?	
--		YOUR ANSWER: Professional Sales and Service

SELECT CompanyName, FirstName, LastName, Phone
FROM SalesLT.Customer
ORDER BY LastName, FirstName, CompanyName;


--4.	List only the sales person and show each sales person only one time. Sort in alphabetical order. 
--		NOTE: When you are asked to show a field "one time" or "only once" or "unique", the DISTINCT keyword 
--		is used.
--		QUESTION:	What is the SalesPerson in the record 3?	
--		YOUR ANSWER: adventure-works\jae0

SELECT DISTINCT SalesPerson
FROM SalesLT.Customer
ORDER BY SalesPerson;


--5.	List all product models by name.  Include all data about each product model. 
--		"All data" means to include all the fields. 
--		NOTE: When you see the phrase "by [field name]", such as "by name" above, a sort order 
--		is requested. In this case, sort by the model name. Since the order is not designated, 
--		ascending would be used. 
--		QUESTION:	What is the Name in record 3?	
--		YOUR ANSWER: Cable Lock

SELECT *
FROM SalesLT.ProductModel
ORDER BY Name;


--6.	List all products showing product ID, product name, product number, product model id, 
--		product category id. Sort by product category id ascending and then by product number descending. 
--		Do not change the order of the fields in the SELECT clause. 
--		QUESTION:	What is the ProductID in record 3?	
--		YOUR ANSWER: 772
  
  SELECT ProductID, Name, ProductNumber, ProductModelID, ProductCategoryID
  FROM SalesLT.Product
  ORDER BY ProductCategoryID ASC, ProductNumber DESC;


--7.	List all products showing product ID, product name, standard cost, list price, and color ordered by 
--		highest to lowest list price, and then alphabetically by product name.
--		QUESTION:	What is the name in row 4?	
--		YOUR ANSWER: Road-150 Red, 56

SELECT  ProductID, Name, StandardCost, ListPrice, Color
FROM SalesLT.Product
ORDER BY ListPrice DESC, Name ASC;


--8.	List the list price of AdventureWorks products. List each list price only once and sort with lowest list 
--		price at the top. 
--		QUESTION:	What is the ListPrice in the record 4?	
--		YOUR ANSWER: 7.95
 
 SELECT DISTINCT ListPrice
 FROM SalesLT.Product
 ORDER BY ListPrice ASC;


--9.	List the colors of AdventureWorks products.  List each color only once and in alphabetical order. 
--		QUESTION:	What is the Color in record 3?	
--		YOUR ANSWER: Blue

SELECT DISTINCT Color
FROM SalesLT.Product
ORDER BY Color ASC;


--10.	List all addresses.  Include all data about each address. "All data" means to include all 
--		the fields. Order by country, state, and city in ascending order. 
--		NOTE: Wonder why this table does not contain the customer names? Because a customer can have many
--		different addresses and there can be more than one customer at the same address. To see this for 
--		yourself, create a database diagram with Customer, CustomerAddress, and Address. You will see that 
--		CustomerAddress is an intersection table that allows one customer to have many addresses and one 
--		address to belong to many customers. You will not create any joins in this statement and you do  
--		not need to submit the database diagram, but you should create it.
--		QUESTION:	What is the PostalCode in the record 3?	
--		YOUR ANSWER: T2P 2G8

SELECT *
FROM SalesLT.Address
ORDER BY CountryRegion, StateProvince, City;


--11.	List the unique state/province, and country/region and order alphabetically by 
--		country/region and state/province. 
--		NOTE: Even though ascending is the default sort, to make your code self-documenting you should specify 
--		the sort order for each field in the ORDER BY statement. 
--		QUESTION:	What is the StateProvince in the record 3?	
--		YOUR ANSWER: Brunswick

SELECT DISTINCT StateProvince, CountryRegion
FROM SalesLT.Address
ORDER BY CountryRegion ASC, StateProvince ASC;


--12.	List the unique city, state/province and country/region and order alphabetically by country/region and 
--		state/province.
--		NOTE: The statement is asking for the unique combination of city, state/province, and country/region. That means 
--		that state/province will not be unique and country/region will not be unique. However, the combination of city, 
--		state/province, and country/region will be unique. 
--		QUESTION:	What is the City in the record 3?	
--		YOUR ANSWER: Burnaby

SELECT DISTINCT City, StateProvince, CountryRegion
FROM SalesLT.Address
ORDER BY CountryRegion ASC, StateProvince ASC;


--13.	List all orders from the SalesLT.SalesOrderDetail table from highest to lowest on LineTotal.  
--		Include all data related to each order. 
--		QUESTION:	What is the LineTotal in the record 2?	
--		YOUR ANSWER: 16261.264656

SELECT LineTotal
FROM SalesLT.SalesOrderDetail
ORDER BY LineTotal DESC;


--14.	List customer IDs in ascending order for all customers that have placed orders with AdventureWorks. 
--		Use the SalesLT.SalesOrderHeader table and show each customer ID only once even if the customer 
--		has placed multiple orders. Sort by CustomerID in ascending order.
--		NOTE: If a customer has placed an order, that customer's CustomerID will appear in the SalesOrderHeader 
--		table. If the customer has not placed an order, the CustomerID will not be in the table. You will use 
--		only one table. We are only requesting the CustomerID and no other information about the customer.
--		QUESTION:	What is the CustomerID in the record 3?	
--		YOUR ANSWER: 29546

SELECT DISTINCT CustomerID
FROM SalesLT.SalesOrderHeader
ORDER BY CustomerID ASC;
