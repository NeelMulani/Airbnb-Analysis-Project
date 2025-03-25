create database Airbnb;
use Airbnb;
-- 1.Import Data from both the .CSV files to create tables, Listings and Booking Details.
create table booking_details(
listing_id int,
price int,
minimum_nights int,
number_of_reviews int,
reviews_per_month float,
calculated_host_listings_count int,
availability_365 int
);
load data local infile "C:/Users/neelm/Downloads/booking_details.csv"
into table booking_details
fields terminated by ','
ignore 1 rows;
select count(*) from booking_details;

create table listing(
id int,
name varchar(255),
host_id	int,
host_name varchar(255),
neighbourhood_group	varchar(255),
neighbourhood varchar(255),
room_type varchar(255)
);
load data local infile "C:/Users/neelm/Downloads/listing.csv"
into table listing
fields terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;
select count(*) from listing;

-- 2.Write a query to show names from Listings table
select name from listing;

-- 3.Write a query to fetch total listings from the listings table
select count(*) as total_listings from listing;

-- 4 Write a query to fetch total listing_id from the booking_details table
select count(listing_id)as total_listing_id from booking_details;
-- The booking_details table have total of 48895 listings.

-- 5.Write a query to fetch host ids from listings table
select host_id from listing;

-- 6.Write a query to fetch all unique host name from listings table
select distinct host_name from listing;
-- Here we find 11344 distinct host names in the listing table.

-- 7.Write a query to show all unique neighbourhood_group from listings table
select distinct neighbourhood_group from listing;
-- New York City have 5 unique neighborhood groups.

-- 8.Write a query to show all unique neighbourhood from listings table
select distinct neighbourhood from listing;

-- 9.Write a query to fetch unique room_type from listings tables
select distinct room_type from listing;
-- The listing table have 3 room types: Private room, Entire home/apt, and Shared room.

-- 10.Write a query to show all values of Brooklyn & Manhattan from listings tables
select * from listing 
where neighbourhood_group ="Brooklyn"
or neighbourhood_group ="Manhattan";
-- A total of 41765 listings are available in the Brooklyn and Manhattan neighborhood groups.

-- 11.Write a query to show maximum price from booking_details table
select max(price)as max_price from booking_details;
-- The highest price is 1000 for the Upper West Side neighborhood for an Entire home/apt.

-- 12.Write a query to show minimum price fron booking_details table
select min(price)as min_price from booking_details;
-- we can see that there are total 11 listings with munumum 0 price.

-- 13.Write a query to show average price from booking_details table
select avg(price)as average_price from booking_details;
-- Here average price for room is 152.72

-- 14. Write a query to show minimum value of minimum_nights from booking_details table
select min(minimum_nights)as min_value_of_minimum_nights from booking_details;
 -- A booking requires at least 1 night.

-- 15.Write a query to show maximum value of minimum_nights from booking_details table
select max(minimum_nights)as max_value_of_maximum_nights from booking_details;
-- The maximum booking is 1250 nights. 

-- 16.Write a query to show average availability_365
select avg(availability_365) as avg_availability_365 from booking_details;
-- On average, 112.7813 rooms are available throughout the year.

-- 17.Write a query to show id , availability_365 and all availability_365 values greater than 30
select listing_id,availability_365
from booking_details
where availability_365>30;

-- 18.Write a query to show count of id where price is in between 300 to 400
select count(listing_id) as count_of_id from booking_details 
where price between 300 and 400;
-- There are 2155 listings with prices in the range of 300 to 400.

-- 19 Write a query to show count of id where minimum_nights spend is less than 5
select count(listing_id) as count_of_id from booking_details 
where minimum_nights<5;
-- Here There are 35718 bookings with minimum night less than 5

-- 20.Write a query to show count where minimum_nights spend is greater than 100
select count(*) as counts from booking_details 
where minimum_nights>100;
-- There are 174 bookings where the minimum nights greater then 100.

-- 21.Write a query to show all data of listings & booking_details 
select * from listing as l
left join booking_details as b
on l.id=b.listing_id
union
select * from booking_details as b
right join listing as l
on b.listing_id=l.id;

-- 22.Write a query to show host name and price
select host_name,price from listing as l
inner join booking_details as b 
on l.id=b.listing_id;

-- 23.Write a query to show room_type and price
select room_type,price from listing as l
inner join booking_details as b 
on l.id=b.listing_id;

-- 24.Write a query to show neighbourhood_group & minimum_nights spend
select neighbourhood_group,minimum_nights from listing as l
inner join booking_details as b 
on l.id=b.listing_id;

-- 25.Write a query to show neighbourhood & availability_365
select neighbourhood,availability_365 from listing as l
inner join booking_details as b 
on l.id=b.listing_id;

-- 26.Write a query to show total price by neighbourhood_group
select neighbourhood_group,sum(price) as total_price from listing as l
inner join booking_details as b 
on l.id=b.listing_id
group by neighbourhood_group
order by total_price;
-- Neighborhood group with the least total price is 42825.

-- 27. Write a query to show maximum price by neighbourhood_group
select neighbourhood_group,max(price) from listing as l
inner join booking_details as b
on l.id=b.listing_id
group by neighbourhood_group
limit 1;
-- The Brooklyn neighborhood group has a maximum price of 10000.

-- 28 Write a query to show maximum night spend by neighbourhood_group
select neighbourhood_group,max(minimum_nights) as maximum_night from listing as l
inner join booking_details as b
on l.id=b.listing_id
group by l.neighbourhood_group;
-- Manhattan has the highest maximum night spend of 1250 and Staten Island and Bronx have the lowest, at 365 nights.

-- 29.Write a query to show maximum reviews_per_month spend by neighbourhood
select neighbourhood,max(reviews_per_month) as maximum_reviews_per_month from listing as l
inner join booking_details as b 
on l.id=b.listing_id
group by l.neighbourhood
order by maximum_reviews_per_month desc;
-- Here Theater District has the highest reviews_per_month with 58.5 followed by Rosedale with 20.94 and New Drop has 0 reviews.

-- 30.Write a query to show maximum price by room type
select room_type, max(price) as maximum_price from listing as l 
inner join booking_details as b 
on l.id=b.listing_id
group by l.room_type;

-- 31.Write a query to show average number_of_reviews by room_type
select room_type,round(avg(reviews_per_month),2) as average_reviews_per_month from listing as l
inner join booking_details as b 
on l.id=b.listing_id
group by l.room_type
order by average_reviews_per_month desc;

-- 32.Write a query to show average price by room type
select room_type,round(avg(price),2) as average_price from listing as l
inner join booking_details as b 
on l.id=b.listing_id
group by l.room_type
order by average_price desc;
-- Entire home/apt has the highest average price at 211.79 and there is a significant difference between Entire home/apt and private rooms.

-- 33.Write a query to show average night spend by room type
select room_type, round(avg(minimum_nights),2) as average_night 
from listing as l
inner join booking_details as b
on l.id=b.listing_id
group by room_type;

-- 34.  Write a query to show average price by room type but average price is less than 100
select room_type, round(avg(price),2) as average_price from listing as l
inner join booking_details as b
on l.id=b.listing_id
group by l.room_type
having average_price < 100;

-- 35.Write a query to show average night by neighbourhood and average_nights is greater than 5
select neighbourhood, round(avg(minimum_nights),2) as average_night from listing as l
inner join booking_details as b
on l.id=b.listing_id
group by l.neighbourhood
having average_night > 5;
-- -- It Shows neighborhoods where the average minimum nights required exceed 5.

-- 36.Write a query to show all data from listings where price is greater than 200 using sub-query.
select * from listing 
where id in (select listing_id from booking_details where price> 200);

-- 37.Write a query to show all values from booking_details table where host id is 314941 using sub-query.
select * from booking_details 
where listing_id in (select id from listing where host_id=314941 );

-- 38. Find all pairs of id having the same host id, each pair coming once only.
select l1.id as l1_id,l2.id as l2_id from listing as l1
join listing as l2
on l1.id= l2.id
where l1.host_id= l2.host_id;

-- 39. Write an sql query to show fetch all records that have the term cozy in name
select * from listing where name like "%cozy%";

-- 40.Write an sql query to show price, host id, neighbourhood_group of manhattan neighbourhood_group
select price,host_id,neighbourhood_group from listing as l 
inner join booking_details as b 
on l.id=b.listing_id 
where l.neighbourhood_group= "manhattan";

-- 41 Write a query to show id , host name, neighbourhood and price but only for Upper West Side & Williamsburg neighbourhood, also make sure price is greater than 100
select id ,host_name, neighbourhood,price from listing as l
inner join booking_details as b 
on l.id=b.listing_id 
where b.price>100
and neighbourhood in ("Upper West Side","Williamsburg");

-- 42.Write a query to show id , host name, neighbourhood and price for host name Elise and neighbourhood is Bedford-Stuyvesant
select id,host_name,neighbourhood,price from listing as l
inner join booking_details as b 
on l.id=b.listing_id
where l.host_name like "elise" and l.neighbourhood = "Bedford-Stuyvesant";

-- 43.Write a query to show host_name, availability_365,minimum_nights only for 100+ availability_365 and minimum_nights
select host_name,availability_365,minimum_nights from listing as l
inner join booking_details as b 
on l.id=b.listing_id
where availability_365>100 and minimum_nights>100;

-- 44.Write a query to show to fetch id , host_name , number_of_reviews, and reviews_per_month but show only that records where number of reviews are 500+ and review per month is 5+
select id,host_name,number_of_reviews,reviews_per_month from listing as l
inner join booking_details as b 
on l.id=b.listing_id
where number_of_reviews>500 and reviews_per_month>5;

-- 45.Write a query to show neighbourhood_group which have most total number of review
select neighbourhood_group, sum(number_of_reviews) as total_number_of_reviews
from listing as l
inner join booking_details as b 
on l.id=b.listing_id
group by neighbourhood_group
order by total_number_of_reviews desc
limit 1;
-- The brooklyn is at the top with 486574  total number of reviews.

-- 46.  Write a query to show host name which have most cheaper total price
select host_name, sum(price) as total_price from listing as l
inner join booking_details as b 
on l.id=b.listing_id
group by host_name 
order by total_price 
limit 1;
-- Host name is Qiuchi.

-- 47.Write a query to show host name which have most costly total price
select host_name, sum(price) as total_price from listing as l
inner join booking_details as b 
on l.id=b.listing_id
group by host_name 
order by total_price desc
limit 1;
-- Host name is Sonder(NYC).

-- 48.Write a query to show host name which have max price using sub-query
select host_name,price from listing as l
inner join booking_details as b 
on l.id=b.listing_id
where b.price = (select max(price) from booking_details);

-- 49.Write a query to show neighbourhood_group where price is less than 100
select neighbourhood_group from listing as l
inner join booking_details as b 
on l.id=b.listing_id
where  b.price< 100;

-- 50.Write a query to find max price, average availability_365 for each room type and order in ascending by maximum price.
select room_type, max(price) as max_price, avg(availability_365) as average_availability_365 from listing as l
inner join booking_details as b 
on l.id=b.listing_id
group by l.room_type 
order by max_price;
--  Highest average vailability of Shared room has 162 and Entire home/apt and private rooms follow with average availabilities of 111.9203 and 111.2039, both peaking at a maximum price of 10000.
