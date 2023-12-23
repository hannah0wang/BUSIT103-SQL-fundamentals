--------------------------------------------------------------------------------------------------------------------
--
-- BUSIT 103           Assignment   #6              DUE DATE :  Consult course calendar
--
--------------------------------------------------------------------------------------------------------------------
--
-- You are to develop SQL statements for each task listed.  You should type your SQL statements under each task.  
-- Please record your answers in the YOUR ANSWER field AND in the Answer Summary section below.
--You are required to use INNER JOINs to solve each problem. Even if you know another method that will produce 
--the result, this module is practice in INNER JOINs.

-- Submit your .sql file named with your last name, first name and assignment # (e.g., FreebergAssignment6.sql). 
-- Submit your file to the instructor using through the course site. 
--
-- If no sort order is specified, assume it is in ascending order. 
--
-- Answer Summary:
-- Question		YOUR ANSWER
--	1a.		john@fourthcoffee.com					
--	1b.		798				
--	2a.		6				
--	2b.		343.65				
--	2c.		802				
--	3a.		Bike Stands				
--	3b.		Gloves			
--	3c.		No, the word 'bike' is not ever in the ProductName field. The names follow a 
--			different format for example: Mountain-400-W Silver, 42 AND Road-450 Red, 58
--			'Bike' would have to be found in either CategoryName or SubcategoryName.				
--	4a.		Cable Lock				
--	4b.		ML Road Frame - Red, 52			
--	5a.		Road Tire Tube			
--	5b.		Question missing
--  6.		Question missing
--  7.		List all the bikes, the types of bikes there are, and their prices.
--
--			SELECT PC.Name, PS.Name, P.ListPrice
--			FROM Production.ProductCategory AS PC
--				INNER JOIN Production.ProductSubcategory AS PS
--				ON PC.ProductCategoryID = PS.ProductCategoryID
--				INNER JOIN Production.Product AS P
--				ON PS.ProductSubcategoryID = P.ProductSubcategoryID
--			WHERE PC.Name LIKE '%BIKE%';				
	

--NOTE: We are now using a different database. 

USE AdventureWorks2017;


--1.a.	List any products that have product reviews.  Show product name, product ID, comments, 
--		email address. Sort alphabetically on the product name. Don’t over complicate this. 
--		A correctly written INNER JOIN will return only those products that have product 
--		reviews; i.e., matching values in the linking field. Hint:  Use the Production.Product 
--		and Production.ProductReview tables.
--      4 points
--      I got 4 rows.
--		QUESTION:		What is the email address in the 3rd row?
--		YOUR ANSWER:	john@fourthcoffee.com

SELECT P.Name AS ProductName, P.ProductID, PR.Comments, PR.EmailAddress
FROM Production.Product AS P
	INNER JOIN Production.ProductReview AS PR
	ON P.ProductID = PR.ProductID
WHERE PR.Comments IS NOT NULL
ORDER BY ProductName ASC;


--1.b.	Copy 1.a. and paste below. Modify the pasted statement to show only records in which 
--		the word 'mountain' is found in the Comments field. Show product ID, product name, and comments. 
--		Sort on ProductID. 
--      2 points
--      I got 2 rows.
--		QUESTION:		What is the product id in the first row?
--		YOUR ANSWER:	798

SELECT P.ProductID, P.Name AS ProductName, PR.Comments
FROM Production.Product AS P
	INNER JOIN Production.ProductReview AS PR
	ON P.ProductID = PR.ProductID
WHERE PR.Comments LIKE '%MOUNTAIN%'
ORDER BY P.ProductID ASC;


--2.a.	List product models with products. Show the product model ID, model name, product ID, 
--		product name, standard cost, and class. Round all money values to exactly two decimal places. 
--		Be sure to give any derived fields an alias. Sort by ProductID from lowest to highest.
--		Hint: You know you need to use the Product table. Now look for a related table that contains 
--		the information about the product model and inner join it to Product on the linking field.  
--      5 points
--      I got 295 rows.
--		QUESTION:		What is the product model id in the first row?
--		YOUR ANSWER:	6

SELECT M.ProductModelID, M.Name AS ProductModel, P.ProductID, P.Name AS ProductName, ROUND(P.StandardCost, 2) AS StandardCost, P.Class
FROM Production.ProductModel AS M
	INNER JOIN Production.Product AS P
	ON M.ProductModelID = P.ProductModelID
ORDER BY ProductID ASC;


--2.b.	Copy/paste 2.a. to 2.b. then modify 2.b. to list only products with a value in the  
--		class field. Do this using NULL appropriately in the WHERE clause. Hint: Remember 
--		that nothing is ever equal (on not equal) to NULL; it either is or it isn't NULL.
--      2 points
--      I got 229 rows.
--		QUESTION:		What is the standard cost in the last row?
--		YOUR ANSWER:	343.65

SELECT M.ProductModelID, M.Name AS ProductModel, P.ProductID, P.Name AS ProductName, ROUND(P.StandardCost, 2) AS StandardCost, P.Class
FROM Production.ProductModel AS M
	INNER JOIN Production.Product AS P
	ON M.ProductModelID = P.ProductModelID
WHERE P.Class IS NOT NULL
ORDER BY ProductID ASC;


--2.c.	Copy/paste 2.b. to 2.c. then modify 2.c. to list only products that contain a value in 
--		the class field AND contain 'fork' or 'front' in the product model name. Be sure that NULL 
--		does not appear in the Class field by using parentheses appropriately.
--      2 points
--      I got 9 rows.
--		QUESTION:		What is the ProductID in the first row?
--		YOUR ANSWER:	802

SELECT M.ProductModelID, M.Name AS ProductModel, P.ProductID, P.Name AS ProductName, ROUND(P.StandardCost, 2) AS StandardCost, P.Class
FROM Production.ProductModel AS M
	INNER JOIN Production.Product AS P
	ON M.ProductModelID = P.ProductModelID
WHERE P.Class IS NOT NULL AND (M.Name LIKE '%FORK%' OR P.Name LIKE '%FRONT%')
ORDER BY ProductID ASC;

--3.a.	List Product categories, their subcategories and their products.  Show the category name, 
--		subcategory name, product ID, and product name, in this order. Sort in alphabetical order on 
---		category name, then subcategory name, and then product name. Give each Name field a descriptive 
--		alias. For example, the Name field in the Product table will have the alias ProductName. 
--		Hint:  To understand the relationships, create a database diagram with the following tables: 
--		Production.ProductCategory
--		Production.ProductSubCategory
--		Production.Product
--      6 points
--      I got 295 rows.
--		QUESTION:		What is the product subcategory name ID in the second row?
--		YOUR ANSWER:	Bike Stands

SELECT PC.Name AS CategoryName, PS.Name AS SubcategoryName, P.ProductID, P.Name AS ProductName
FROM Production.ProductCategory AS PC
	INNER JOIN Production.ProductSubcategory AS PS
	ON PC.ProductCategoryID = PS.ProductCategoryID
	INNER JOIN Production.Product AS P
	ON P.ProductSubcategoryID = PS.ProductSubcategoryID
ORDER BY PC.Name ASC, PS.Name ASC, P.Name ASC;

--3.b.	Copy 3.a. and paste below. Modify to list only Products in product category 3.  
--		Show the category name, subcategory name, product ID, and product name, in this order. 
--		Sort in alphabetical order on product name, then subcategory name, and then by category name. 
--		Hint: Add product category id field to SELECT clause, make sure your results are correct, then 
--		remove or comment out the field.  		
--      3 points
--      I got 35 rows.
--		QUESTION:		What is the product subcategory name in the fifth row?
--		YOUR ANSWER:	Gloves

SELECT PC.Name AS CategoryName, PS.Name AS SubcategoryName, P.ProductID, P.Name AS ProductName
FROM Production.ProductCategory AS PC
	INNER JOIN Production.ProductSubcategory AS PS
	ON PC.ProductCategoryID = PS.ProductCategoryID
	INNER JOIN Production.Product AS P
	ON P.ProductSubcategoryID = PS.ProductSubcategoryID
WHERE PC.ProductCategoryID = 3
ORDER BY P.Name ASC, PS.Name ASC, PC.Name ASC;


--3.c.	Copy 3.b. and paste below. Modify the pasted statement to list Products in product category 1. 
--		Make no other changes to the statement. 
--		Hint: Add product category id field to SELECT clause, make sure your results are correct, then 
--		remove or comment out the field.  Something to consider: Look at the data in the ProductName field. 
--      2 points
--      I got 97 rows.
--		QUESTION:		Could we find bikes by searching for 'bike' in the ProductName field?
--		YOUR ANSWER:	No, the word 'bike' is not ever in the ProductName field. The names follow a 
--						different format for example: Mountain-400-W Silver, 42 AND Road-450 Red, 58
--						'Bike' would have to be found in either CategoryName or SubcategoryName.

SELECT PC.Name AS CategoryName, PS.Name AS SubcategoryName, P.ProductID, P.Name AS ProductName
FROM Production.ProductCategory AS PC
	INNER JOIN Production.ProductSubcategory AS PS
	ON PC.ProductCategoryID = PS.ProductCategoryID
	INNER JOIN Production.Product AS P
	ON P.ProductSubcategoryID = PS.ProductSubcategoryID
WHERE PC.ProductCategoryID = 1
ORDER BY P.Name ASC, PS.Name ASC, PC.Name ASC;


--4.a.	List Product models, the categories, the subcategories, and the products.  Show the model name, 
--		category name, subcategory name, product ID, and product name in this order. Give each Name field a  
--		descriptive alias. For example, the Name field in the ProductModel table will have the alias ModelName. 
--		Sort in alphabetical order by model name. 
--		Hint:  To understand the relationships, refer to a database diagram and the following tables:
--		Production.ProductCategory
--		Production.ProductSubCategory
--		Production.Product
--		Production.ProductModel
--		Choose a path from one table to the next and follow it in a logical order to create the inner joins.
--      5 points
--      I got 295 rows.
--		QUESTION:		What is the model name in the third record?
--		YOUR ANSWER:	Cable Lock

SELECT PM.Name AS ModelName, PC.Name AS CategoryName, PS.Name AS SubcategoryName, P.ProductID, P.Name AS ProductName
FROM Production.ProductSubcategory AS PS
	INNER JOIN Production.ProductCategory AS PC
	ON PS.ProductCategoryID = PC.ProductCategoryID
	INNER JOIN Production.Product AS P
	ON P.ProductSubcategoryID = PS.ProductSubcategoryID
	INNER JOIN Production.ProductModel AS PM
	ON P.ProductModelID = PM.ProductModelID
ORDER BY ModelName ASC;


--4.b.	Copy 4.a. and paste below. Modify the pasted statement to list those products in model ID 16 that 
--		contain red in the product name. Modify the sort to order only on Product ID. Hint: Add the 
--		product model id field to the select clause to check your results and then remove or comment it out.
--      3 points
--      I got 5 rows.
--		QUESTION:		What is the product name in the third record?
--		YOUR ANSWER:	ML Road Frame - Red, 52

SELECT PM.Name AS ModelName, PC.Name AS CategoryName, PS.Name AS SubcategoryName, P.ProductID, P.Name AS ProductName
FROM Production.ProductSubcategory AS PS
	INNER JOIN Production.ProductCategory AS PC
	ON PS.ProductCategoryID = PC.ProductCategoryID
	INNER JOIN Production.Product AS P
	ON P.ProductSubcategoryID = PS.ProductSubcategoryID
	INNER JOIN Production.ProductModel AS PM
	ON P.ProductModelID = PM.ProductModelID
WHERE PM.ProductModelID = 16 AND P.Name LIKE '%RED%'
ORDER BY P.ProductID ASC;


--5.a.	List products ordered by customer id 23104.  Show product name, product number, order quantity, 
--		and sales order id.  Sort on product name and sales order id.  If you add customer id to check your results, 
--		be sure to remove or comment it out. Hint:  First create a database diagram with the following tables: 
--		Production.Product
--		Sales.SalesOrderHeader
--		Sales.SalesOrderDetail
--      4 points
--      I got 5 rows.
--		QUESTION:		What is the product name in the third record?
--		YOUR ANSWER:	Road Tire Tube

SELECT P.Name AS ProductName, P.ProductNumber, SOD.OrderQty, SOH.SalesOrderID
FROM Production.Product AS P
	INNER JOIN Sales.SalesOrderDetail AS SOD
	ON P.ProductID = SOD.ProductID
	INNER JOIN Sales.SalesOrderHeader AS SOH
	ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE SOH.CustomerID = 23104
ORDER BY P.Name, SOH.SalesOrderID;


--5.b.  List the orders and the shipping method for customer id 23104. Show product name, product number, 
--		order quantity, sales order id, and the name of the shipping method. Sort on product name and sales 
--		order id. Hint:  You will need to join an additional table. Add it to your database diagram first. 
--      4 points
--      I got 5 rows.
--		QUESTION:		
--		YOUR ANSWER:	

SELECT P.Name AS ProductName, P.ProductNumber, SOD.OrderQty, SOH.SalesOrderID, SM.Name AS ShippingMethod
FROM Sales.SalesOrderHeader AS SOH
	INNER JOIN Sales.SalesOrderDetail AS SOD
	ON SOH.SalesOrderID = SOD.SalesOrderID
	INNER JOIN Production.Product AS P
	ON SOD.ProductID = P.ProductID
	INNER JOIN Purchasing.ShipMethod AS SM
	ON SOH.ShipMethodID = SM.ShipMethodID
WHERE SOH.CustomerID = 23104
ORDER BY ProductName ASC, SOH.SalesOrderID ASC;

--6.	List all sales for clothing that was ordered during 2013.  Show sales order id, product ID, 
--		product name, order quantity, and line total for each line item sale. Make certain you are retrieving 
--		only clothing. There are multiple ways to find clothing items. Sort the list by sales order id in ascending order. 
--      Hints: Create a database diagram before beginning the statement. Consider using the YEAR(date) function.
--      6 points
--      I got 10266 rows.
--		QUESTION:		
--		YOUR ANSWER:	

SELECT SOH.SalesOrderID, P.ProductID, P.Name AS ProductName, SOD.OrderQty, SOD.LineTotal, PS.ProductSubcategoryID, PC.ProductCategoryID
FROM Sales.SalesOrderHeader AS SOH
	INNER JOIN Sales.SalesOrderDetail AS SOD
	ON SOD.SalesOrderID = SOH.SalesOrderID
	INNER JOIN Production.Product AS P
	ON SOD.ProductID = P.ProductID
	INNER JOIN  Production.ProductSubcategory AS PS
	ON P.ProductSubcategoryID = PS.ProductSubCategoryID
	INNER JOIN Production.ProductCategory AS PC
	ON PC.ProductCategoryID = PS.ProductCategoryID
WHERE (PC.Name = 'CLOTHING') AND YEAR(SOH.OrderDate) = 2013
ORDER BY SOH.SalesOrderID ASC;


/* You will see this last question appear in different forms in many assignments. You have had the opportunity to 
explore the data. Now, what would you like to know about it? You are required to use a concept that was introduced 
in the module. In this case, you are to create a statement that requires at least one inner join. */

--7.	In your own words, write a business question for AdventureWorks that you will try to answer with a SQL query. 
--		Then try to develop the SQL to answer the question using at least one INNER JOIN. 
--		Just show your question and as much SQL as you were able to figure out. 
--      2 points
--		List all the bikes, the types of bikes there are, and their prices.

SELECT PC.Name, PS.Name, P.ListPrice
FROM Production.ProductCategory AS PC
	INNER JOIN Production.ProductSubcategory AS PS
	ON PC.ProductCategoryID = PS.ProductCategoryID
	INNER JOIN Production.Product AS P
	ON PS.ProductSubcategoryID = P.ProductSubcategoryID
WHERE PC.Name LIKE '%BIKE%';


