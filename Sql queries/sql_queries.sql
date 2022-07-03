#1) Fetch all the brand, model and color of car available for vehicle rental

select Brand, Model, Color 
from car;

#2) Fetch the helpdesk ID, phone number and support executive whose name start with s

select Helpdesk_ID, Phone_Number, Support_Executive 
from branch_customer_support
where Support_Executive regexp '^s';

#3) Fetch the reservation ID, pickup location and state of all rentals on 2020-05-20

Select Reservation_Number, Pick_up_location, State   
from rental r
join branch b
ON b.Branch_ID = r.Pick_up_location
where Pick_up_date = '2020-05-20'
group by Pick_up_location; 


#4)Fetch the customers along with thier rental duration from highest to least

Select customer, sum(Rental_duration) as Rental_duration from (Select concat(First_Name," ",Last_Name) as 'customer', datediff(r.Return_date, r.Pick_up_date) as 'Rental_duration' 
from customer cr
join rental r
ON cr.Customer_ID = r.Customer_ID) A group by customer
order by Rental_duration desc;


#5)Top 3 rented brands of cars

Select c.Brand, count(r.Pick_up_location) as number_of_rentals
from car c
join rental r
ON c.VIN = r.VIN
group by Brand
order by count(number_of_rentals) desc
limit 3;

#6) Display the number of rentals that were made on May 2019 in "MA", "NY" and "NJ"

SELECT 
	(SELECT COUNT(*) 
    FROM rental r 
	LEFT JOIN branch b 
    on  b.Branch_ID = r.Pick_up_location
	WHERE b.State = 'MA' AND extract(month from r.Pick_up_date) = 5 AND extract(year from r.Pick_up_date) = 2019) AS MA,
	(SELECT COUNT(*) 
	FROM rental r 
	LEFT JOIN branch b 
    on  b.Branch_ID = r.Pick_up_location
	WHERE b.State = 'NY' AND extract(month from r.Pick_up_date) = 5 AND extract(year from r.Pick_up_date) = 2019) AS NY,
	(SELECT COUNT(*) 
	FROM rental r 
	LEFT JOIN branch b 
    on  b.Branch_ID = r.Pick_up_location
	WHERE b.State = 'NJ' AND extract(month from r.Pick_up_date) = 5 AND extract(year from r.Pick_up_date) = 2019) AS NJ;
	
#7) Fetch the customers who have rented red colour car and car category is SUV

Select First_Name from customer
	inner join rental on rental.Customer_ID = customer.Customer_ID
	inner join car on car.VIN = rental.VIN
	inner join car_category on car.Category_ID = car_category.Category_ID
	where car_category.class = 'suv' 
    and car.Color = 'Red';
    
    
#8) Display the number of times cars with description economical were rented

Select count(r.Pick_up_location) as number_of_rentals, concat(Model," ",Brand) as 'car' 
FROM car c
JOIN rental r
ON c.VIN = r.VIN
where Car_Description like "%economical%"
GROUP BY car
ORDER BY COUNT(number_of_rentals) DESC;


#9) Fetch the branch ID, Support Phone Number and Support executive for each city

select City, Branch_Branch_ID, Phone_Number as Support_Phone_Number, Support_Executive
from branch b
join branch_customer_support s
on b.Branch_ID = s.Branch_Branch_ID
Group by Branch_Branch_ID
order by city;
 
 
 #1)Fetch the rental duration for each cars rented (R)

Select car, sum(Rental_duration) as Rental_duration from (Select concat(c.Brand," ",c.Model) as 'car', datediff(r.Return_date, r.Pick_up_date) as 'Rental_duration' 
from car c
join rental r
ON c.VIN = r.VIN) A group by car;

#2)Top rented cities based on pickup location (R)

Select b.City, count(r.Pick_up_location) as number_of_rentals
from branch b
join rental r
ON b.Branch_ID = r.Pick_up_location
group by City
order by count(number_of_rentals) desc;

#3) Compare percentage change in total amount of rentals between year 2019 and 2020

SELECT a.month_key as 'Month', a.total_amount as 'Total amount of Rentals in 2019', b.total_amount as 'Total amount of Rentals in 2020', ROUND((b.total_amount - a.total_amount) / a.total_amount * 100, 2) as 'Percentage change'
FROM (
	SELECT
	MONTH(Pick_up_date) as month_key, SUM(Rental_Fee) as total_amount
	FROM rental
	WHERE YEAR(Pick_up_date) = 2019
	GROUP BY MONTH(Pick_up_date)
) a
LEFT JOIN (
	SELECT
	MONTH(Pick_up_date) as month_key, SUM(Rental_Fee) as total_amount
	FROM rental
	WHERE YEAR(Pick_up_date) = 2020
	GROUP BY MONTH(Pick_up_date)
) b on b.month_key = a.month_key
;