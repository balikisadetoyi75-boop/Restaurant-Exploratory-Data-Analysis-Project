--EXPLORATORY DATA ANALYSIS PROJECT 

---1. DATABASE EXPLORATION 

--EXPLORE ALL OBJECTS IN THE DATABASE
SELECT * FROM INFORMATION_SCHEMA.TABLES

--EXPLORE ALL COLUMNS IN THE DATABASE

SELECT 
* FROM INFORMATION_SCHEMA.COLUMNS

WHERE TABLE_NAME= 'Orders';

SELECT 
* FROM INFORMATION_SCHEMA.COLUMNS

WHERE TABLE_NAME= 'Restaurant';

--How many orders are in the dataset?
SELECT 
COUNT(Order_ID)
FROM Orders

--How many restaurants are there?
SELECT
COUNT( restaurantID)
FROM Restaurants
SELECT *FROM Orders
--What time range do the orders cover?

SELECT Order_Date
FROM Orders

SELECT 
	MIN (Order_Date) AS  min_date,
	MAX (Order_Date) AS Max_date
FROM Orders




--2.DIMENSION EXPLORATION 

--CHECK FOR MEASURES AND DIMENSIONS

--MEASURES-	QUantity,order amount,delivery time,
--Restaurant ID, Restaurant Name, Cuisine, Zone, Category

--DIMENSIONS-order_ID, Customername, restaurant ID, 
--payment mode, food rating,delivery rating

--DATE/TIME -order Date

--EXPLORE CATEGORIES PRESENT IN THE DATA 

--WHat cuisines are available and how many restaurants per cuisine?
SELECT   Cuisine, COUNT(*) AS restaurant_count
FROM Restaurants
GROUP BY Cuisine

--What zones exist and how are restaurants distributed across them?

SELECT Zone, COUNT(*) AS restaurant_count
FROM Restaurants
GROUP BY Zone
ORDER BY restaurant_count DESC


--What payment methods are used, and how frequently?

SELECT payment_mode, COUNT(*) AS Orders_count
FROM Orders
GROUP BY Payment_Mode
ORDER BY Orders_count DESC


--3. DATE EXPLORATION

--how many orders occur by hour of the day?
SELECT DATEPART(HOUR, Order_Date) AS order_hour,
COUNT(*) AS order_count
FROM Orders
GROUP BY DATEPART(HOUR, Order_Date)



--Which hours have the highest order volume? lowest?

SELECT DATEPART(HOUR, Order_Date) AS order_hour,
COUNT(*) AS total_count
FROM Orders
GROUP BY DATEPART(HOUR, Order_Date)
ORDER BY total_count DESC

--do orders placed at certain times take longer to deliver?
SELECT DATEPART(HOUR, Order_Date) AS order_hour,
AVG(Delivery_Time_Taken_mins) AS avg_timetaken
FROM Orders
GROUP BY DATEPART(HOUR, order_date)
ORDER BY order_hour;




--4. MEASURES EXPLORATION

--What is the average order amount?
SELECT AVG(Order_amount) as avg_order_amount

FROM orders

--What is the average delivery time?

SELECT AVG(Delivery_Time_Taken_mins) Avg_time
FROM Orders




--5. MAGNITUDE
--Which restaurants generate the highest total order amount?
SELECT R.RestaurantID,
    R.RestaurantName,
    SUM(O.order_amount) AS total_order_amount
FROM Orders AS O
INNER JOIN Restaurants AS R ON R. RestaurantID= O.Restaurant_ID
GROUP BY
    R.  RestaurantID,
    R.RestaurantName
ORDER BY total_order_amount DESC;
---Which cuisines contribute the most orders?
SELECT 
        R.Cuisine, 
        COUNT(O.Order_ID) AS total_orders
    FROM Restaurants AS R
    INNER JOIN Orders AS O 
    ON R. RestaurantID= O.Restaurant_ID
    GROUP BY R.Cuisine
    ORDER BY COUNT(O.Order_ID) DESC


    SELECT * FROM Orders

--6. RANKING
--Top 5 restaurants by total revenue
SELECT TOP 5 

R.RestaurantName,
SUM(O.Order_Amount) AS total_revenue
FROM Restaurants AS R 
 INNER JOIN orders AS O 
 ON R.RestaurantID = O.Restaurant_ID
 GROUP BY R.RestaurantName
 ORDER BY SUM(O.Order_Amount) DESC


--Bottom 5 restaurants by average customer delivery rating

SELECT TOP 5 
R.RestaurantName,
AVG(Customer_Rating_Delivery) AS Avg_cust_rating
FROM Restaurants AS R 
 INNER JOIN orders AS O 
 ON R.RestaurantID = O.Restaurant_ID
 GROUP BY R.RestaurantName
 ORDER BY AVG(Customer_Rating_Delivery) ASC


 