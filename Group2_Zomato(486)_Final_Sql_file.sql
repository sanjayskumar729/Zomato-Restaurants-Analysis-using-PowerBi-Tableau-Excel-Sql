create database zomato_data_analysis_1;
use zomato_data_analysis_1;

select* from Zomato1 ;


select count('restaurant') from zomato1;


#######################################################################################

# KPI-1 
CREATE TABLE Countries(
CountryCode int, CountryName varchar(30) ) ;

insert into Countries 
values (1, 'India'),
(14, 'Australia'),
(30, 'Brazil'),
(37, 'Canada'),
(94, 'Indonesia'),
(148, 'New Zealand'),
(162, 'Philippines'),
(166, 'Qatar'),
(184, 'South-east Asia'),
(189, 'South Africa'),
(191, 'Srilanka'),
(208, 'Turkey'),
(214, 'UAE'),
(215, 'United Kingdom'),
(216, 'United States');

select * from Countries;
######################################################################################

# KPI-2 Calendar Table
select date(Datekey_Opening) AS DATES, 
year(Datekey_Opening) AS YEARS, 
month(Datekey_Opening) AS MONTHNO, 
monthname(Datekey_Opening) AS MONTHNAME, 
CONCAT("Q",quarter(Datekey_Opening)) AS QUARTERS, 
DATE_FORMAT(Datekey_Opening, '%Y-%b') as "YYYY-MMM",
dayofweek(Datekey_Opening) AS WEEKDAYNO, 
date_format(Datekey_Opening, "%W" ) AS WEEKDAY,

CASE 
when month(Datekey_Opening) = 4 then "FM1"
when month(Datekey_Opening) = 5 then "FM2"
when month(Datekey_Opening) = 6 then "FM3"
when month(Datekey_Opening) = 7 then "FM4"
when month(Datekey_Opening) = 8 then "FM5"
when month(Datekey_Opening) = 9 then "FM6"
when month(Datekey_Opening) = 10 then "FM7"
when month(Datekey_Opening) = 11 then "FM8"
when month(Datekey_Opening) = 12 then "FM9"
when month(Datekey_Opening) = 1 then "FM10"
when month(Datekey_Opening) = 2 then "FM11"
else "FM12"
END as Financial_Month, 

CASE 
when month(Datekey_Opening) between 1 and 3 then "FQ4"
when month(Datekey_Opening) between 4 and 6 then "FQ1"
when month(Datekey_Opening) between 7 and 9 then "FQ2"
else "FQ3"
END AS Financial_Quarter
from zomato1;
 
############################################################################################

# KPI- 3 Find the Numbers of Resturants based on City and Country.

SELECT city , count(RestaurantID) AS Restaurant_No FROM zomato1
GROUP BY  city;

SELECT countryname , COUNT(RestaurantID)  AS Restaurant_No FROM zomato1 z
LEFT JOIN countries c ON z.CountryCode = c. CountryCode
GROUP BY countryname;

SELECT COUNT(RestaurantID) AS Restaurants, City, CountryName 
FROM zomato1 
 LEFT JOIN countries ON zomato1.CountryCode = countries.CountryCode  
GROUP BY City, CountryName;
############################################################################################

# KPI-4 Numbers of Resturants opening based on Year , Quarter , Month

SELECT YEAR(Datekey_Opening) AS Year, COUNT(*) AS Yearwise_Restaurants_Opening
FROM zomato1
GROUP BY YEAR(Datekey_Opening);

SELECT YEAR(Datekey_Opening) AS Year, QUARTER(Datekey_Opening) AS Quarter, COUNT(*) AS Quaterwise_Restaurants_Opening
FROM zomato1
GROUP BY YEAR(Datekey_Opening), QUARTER(Datekey_Opening);

SELECT YEAR(Datekey_Opening) AS Year, MONTHNAME(Datekey_Opening) AS Month, COUNT(*) AS Monthwise_Restaurants_Opening
FROM zomato1
GROUP BY YEAR(Datekey_Opening), MONTHNAME(Datekey_Opening);

SELECT YEAR(Datekey_Opening) AS Year, QUARTER(Datekey_Opening) AS Quarter, MONTHNAME(Datekey_Opening) AS Month, COUNT(*) AS Restaurants_Opening
FROM zomato1
GROUP BY YEAR(Datekey_Opening), QUARTER(Datekey_Opening), MONTHNAME(Datekey_Opening);
######################################################################################################

# KPI-5 Count of Restaurants based on Average Ratings

SELECT AVG(Rating), COUNT(*) AS Num_Restaurants
FROM zomato1
GROUP BY Rating
ORDER BY Rating ASC;

Select count(RestaurantID),avg(Rating) from zomato1;
##############################################################################################

###################################################################################################################### 

# KPI- 6 Create buckets based on Average Price of reasonable size and find out how many resturants falls in each buckets

SELECT 
    Cost_Range,  
    COUNT(*) AS TotalRestaurants 
FROM 
    (
        SELECT 
            CASE
                WHEN Average_Cost_for_two BETWEEN 0 AND 300 THEN '0-300'
                WHEN Average_Cost_for_two BETWEEN 301 AND 600 THEN '301-600'
                WHEN Average_Cost_for_two BETWEEN 601 AND 1000 THEN '601-1000'
                WHEN Average_Cost_for_two BETWEEN 1001 AND 43000 THEN '1001-43000'
                ELSE 'Other' 
            END AS Cost_Range         
        FROM 
            zomato1
    ) AS subquery    
    GROUP BY 
    Cost_Range;

          
###############################################################################################

# KPI-7 Percentage of Resturants based on "Has_Table_booking"
SELECT Has_Table_booking,
       COUNT(*) AS TotalRestaurants,
       ROUND((COUNT(*) / (SELECT COUNT(*) FROM zomato1)) * 100, 2) AS Percentage
FROM zomato1
GROUP BY Has_Table_booking;

#################################################################################################

# KPI-8 Percentage of Resturants based on "Has_Online_delivery"
SELECT Has_Online_delivery,
       COUNT(*) AS TotalRestaurants,
       ROUND((COUNT(*) / (SELECT COUNT(*) FROM zomato1)) * 100, 2) AS Percentage
FROM zomato1
GROUP BY Has_Online_delivery;

#############################################################################################


# KPI-9 Develop Charts based on Cusines, City, Ratings


SELECT 
    cuisines , city,
    COUNT(*) AS TotalRestaurants 
FROM 
    zomato1 
GROUP BY 
    cuisines, city;

select * from zomato1;

##########################################################################

















