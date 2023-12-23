-------------------------------------------------------------------
------------- BUSIT 103 Midterm 01		---------------------------
------------- 60 points					---------------------------
------------- Due as posted in Canvas	---------------------------
-------------------------------------------------------------------
/*

1.	a. 1:M One to Many

2.	TeamID

3.	BowlerID

4.	TeamID

5.	10

6.	20

7.	1

8.	Angel

9.	32

10.	13

11.	The Orcas are team 6

12.	Kryptonite Advanced 2000 U-Lock

13.	Armadillo Brand

14.	937

15.	Shinoman, Incorporated


*/

--Using the Bowling League Example database, create a database diagram showing the Teams and Bowlers tables.
-- 1. What is the type of relationship between Teams and Bowlers?
--    a. 1:M One to Many
--    b. 1:1 One to One
--    c. M:M Many to Many
--    POINTS: 4
--    YOUR ANSWER HERE==>  a. 1:M One to Many

-- 2. What is the primary key of the Teams table?
--    POINTS: 2
--    YOUR ANSWER HERE==> TeamID

-- 3. What is the primary key of the Bowlers table?
--    POINTS: 2
--    YOUR ANSWER HERE==> BowlerID


-- 4. What is the foriegn key in the relationship?
--    POINTS: 3
--    YOUR ANSWER HERE==> TeamID

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
USE BowlingLeagueExample;

-- 5. How many teams are there?
--    POINTS: 3
--    Include the code you used to determine the answer. 
--    YOUR ANSWER HERE==> 10

SELECT *
FROM dbo.Teams;

-- 6. What is the CaptainID for the Dolphins team?
--    POINTS: 3
--    You can use query in question 5 to answer this. 
--    YOUR ANSWER HERE==> 20

SELECT *
FROM dbo.Teams;


-- 7. Write a query that returns MatchID, GameNumber, BowlerID, and RawScore for the bowler with BowlerID of 2.
--     Sort by RawScore in descending order. 
--     What is the MatchID in row 2? 
--     POINTS: 6
--     Include the code you used to determine the answer. 
--     YOUR ANSWER HERE==>   1

SELECT MatchID, GameNumber, BowlerID, RawScore
FROM dbo.Bowler_Scores
WHERE BowlerID = '2'
ORDER BY RawScore DESC;


-- 8.  List all the bowlers whose last name ends with the letter 'y'
--     Sort by last name in alphabetical order.
--     What is the first name in row 2?
--     POINTS: 6
--     Include the code you used to determine the answer. 
--     YOUR ANSWER HERE==> Angel

SELECT *
FROM dbo.Bowlers
WHERE BowlerLastName LIKE '%y'
ORDER BY BowlerLastName ASC;


-- 9. How many bowlers are there? 
--    POINTS: 3
--    Include the code you used to determine the answer. 
--    YOUR ANSWER HERE==> 32

SELECT *
FROM DBO.Bowlers;


--10. How many different (unique) last names are there in the bowlers table?
--    POINTS: 4
--    Include the code you used to determine the answer. 
--    YOUR ANSWER HERE==> 13

SELECT DISTINCT BowlerLastName
FROM dbo.Bowlers;



--11. Using the Teams table, create a query to return the team id and the team name of all the teams.
--    Sort by TeamName in ascending order.
--    The output should be in one column in the format of: 
--    The Marlins are team 1
--    POINTS: 6
--    Include the code you used to determine the answer. 
--    What is the value in row 7?
--    YOUR ANSWER HERE==> The Orcas are team 6

SELECT 'The ' + TeamName + ' are team ' + CAST(TeamID AS nvarchar(3)) AS TeamInfo
FROM dbo.Teams
ORDER BY TeamName ASC



--- DIFFERENT DATABASE!!!
USE SalesOrdersExample;

--12.  List the ProductNumber, ProductName, RetailPrice, and QuantityOnHand of
--     all the products from CategoryID 1 that have a retail price less than $51, and have between 9 and 20 (inclusive) quantity on hand.
--     Sort by retail price in descending order.
--     What is the product name in row 1?
--     POINTS: 6
--     Include the code you used to determine the answer. 
--     YOUR ANSWER HERE==> Kryptonite Advanced 2000 U-Lock

SELECT ProductNumber, ProductName, RetailPrice, QuantityOnHand
FROM dbo.Products
WHERE CategoryID = '1' AND RetailPrice < 51 AND QuantityOnHand BETWEEN 9 AND 20
ORDER BY RetailPrice DESC;


-- 13. List all the vendors that are located in Texas (TX) or who do not have a web page. 
--     Sort by VendCity in descending order.
--     What is the VendName name in row 4?
--     POINTS: 3
--     Include the code you used to determine the answer. 
--     YOUR ANSWER HERE==> Armadillo Brand

SELECT *
FROM dbo.Vendors
WHERE VendState = 'TX' OR VendWebPage IS NULL
ORDER BY VendCity DESC;


-- 14. List all the orders from the year 2013.
--     Sort by order date in descending order.
--     What is the order number in row 2?
--     POINTS: 6
--     Include the code you used to determine the answer. 
--     YOUR ANSWER HERE==> 937

SELECT *
FROM dbo.Orders
WHERE OrderDate LIKE '%2013%'
ORDER BY OrderDate DESC;


-- 15. List all the vendors who have a web page and are located in Redmond or Bellevue.
--     Sort by zip code in ascending order.
--     What is the VendName in row 1?
--     POINTS: 3
--     Include the code you used to determine the answer. 
--     YOUR ANSWER HERE==> Shinoman, Incorporated

SELECT *
FROM dbo.Vendors
WHERE VendWebPage IS NOT NULL AND VendCity IN ('Redmond', 'Bellevue')
ORDER BY VendZipCode ASC;

-------------------------------------------------------------------------
----- End of Test -------------------------------------------------------
-------------------------------------------------------------------------