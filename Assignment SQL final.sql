/*
1. Create a table called employees with the following structure
 emp_id (integer, should not be NULL and should be a primary key)
 emp_name (text, should not be NULL)
 age (integer, should have a check constraint to ensure the age is at least 18)
 email (text, should be unique for each employee)
 salary (decimal, with a default value of 30,000).
 Write the SQL query to create the above table with all constraints.*/
 create DATABASE Assignment;
 use assignment;
 Create Table employees 
(    
 emp_id INT NOT NULL PRIMARY KEY,
 emp_name VARCHAR(50) NOT NULL,
 age INT check(age>=18),
 email VARCHAR(50) UNIQUE NOT NULL,
 Salary decimal(10,2) Default 30000
 ) ;

-- 2. Explain the purpose of constraints and how they help maintain data integrity in a database. Provide 
--    examples of common types of constraints.
/*Ans2. Constraints are the rule in SQL, which we have to follow when entering the data in column. 
	   Constraints helps to maintain data integrity like:
       1. Prevent invalid or duplicate data entries.
       2. Enforce specific condition on the data, ensuring correctness.
       3. Maintain relationships betwen table. 
		
        Some constraints are: NOT NUll, PRIMARY KEY, UNIQUE, FOREIGN KEY, DEFAULT, CHECK
*/

--  3.Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify your answer.
/*Ans3. NOT NULL constraint ensures that the column does not contain a null value. It is usefull when data
	  in column is compulsary. 
	  NO, Primary key can not contain a null value. Primary key is combination of Not Null and Unique constraints.
      So, each record is distinct and cannot be null.
*/
-- 4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an 
--    example for both adding and removing a constraint.

-- Ans4 Adding contraint

ALTER TABLE employees
MODIFY Column age INT NOT NULL;

-- Removing Constraint
ALTER TABLE employees
Drop Constraint age ;

--  5. Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. 
--     Provide an example of an error message that might occur when violating a constraint.
/* Ans5. Consequences of violating constraints:
         1. Failed Operation:
                    The database prevents the opeartion entirely, preserving the integrity ofdata.
        2. Error Messages:
                    You'll see an error, and the action(insert, update or delete) will fail.
        3. No partial updates:
                    If a batch operation violates constraints for even one record, the entire
                    operation might fail, depending on the database settings.
        4. Data Integrity Enforcement:
                    Connstraints ensure that your data remain clean, correect and reliable.
        Example when Violating a constraint:
        CREATE TABLE employees (
            emp_id INT PRIMARY KEY,
            emp_name VARCHAR(50) NOT NULL,
            age INT CHECK (age >= 18),
            email VARCHAR(100) UNIQUE
);
        1. Insert violation: 
                    Here, when you attempt to insert a record NULL for emp_name. it will violates
                    NOT NULL constarint. You have to record somee value in emp_name.
        2. Update Violateion:
                    You cant change value in age less than 18.
        3. Delete Violation:
                    Removing a parent record tied to a foreign key without handling dependencies.
                    */
                    
                    
/* 6. You created a products table without constraints as follows:
 CREATE TABLE products (
 product_id INT,
 product_name VARCHAR(50),
 price DECIMAL(10, 2));  
 Now, you realise that
 The product_id should be a primary key
 The price should have a default value of 50.00 */
 CREATE TABLE products (
             product_id INT,
             product_name VARCHAR(50),
             price DECIMAL(10, 2));
-- add primary key
ALTER TABLE products
Add PRIMARY KEY (product_id);
-- modify deafult value
ALTER TABLE products
MODIFY price DECIMAL(10,2) DEFAULT 50.0;

-- Q7. You have two tables: Students, Classes. Write a query to fetch the student_name and class_name for each student using an INNER JOIN.
select student_name, class_name
from student s 
JOIN Classes c 
ON 
s.class_id = c.class_id;

-- Q8. Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are listed 
--     even if they are not associated with an order. 
--    Hint: (use INNER JOIN and LEFT JOIN)
Select order_id, customer_name, product_name
from Products p
LEFT JOIN Orders o
ON p.order_id = o.order_id
LEFT JOIN Customers c
on c.customer_id = o.customer_id;

-- Q9. Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.
Select p.product_name, sum(s.amount) as total_sales
from sales s
Inner join
products p 
On s.product_id = p.product_id 
group by p.product_name;

-- #Q10   Write a query to display the order_id, customer_name, and the quantity of products ordered by each 
--         customer using an INNER JOIN between all three tables.
Select o.order_id, c.customer_name, d.quantity 
from order_details d 
INNER JOIN orders o 
on d.order_id = o.order_id 
Inner JOIN Customers c 
on o.customer_id = c.customer_id;

-- SQL COMMANDS

-- Q1.Identify the primary keys and foreign keys in maven movies db. Discuss the difference
/*	PRIMARY KEY:
	In sakilla database, in rental table rental_id is primary key.
. 	The primary key contains non-null value and each value is unique can't be duplicated 
	
    FOREIGN KEY:
    In rental table, inventory_id and customer_id is foreign key. Foreign key is used to
    create relationship between tables.
    . inventory_id creates the relationship with inventory table.
    . customer_id creates the relationship with customer table.
    
    DIFFERENCES:
		1. A primary key is unique acrros the table while foreign key can contain duplicate values.
        2. Priamry key must not contain null values while foreign key can contain null values.
        3. Primary usage is to identify records while foreign key usage is link tables.
*/
-- Q2. List all details of actors

select * 
from actor; 
-- Q3. List all customer information from DB.

select *
from customer;

-- Q4. List different countries.

select distinct(country)
from country;

-- Q5 -Display all active customers.

select *
from customer
where active = 1;

-- Q6 -List of all rental IDs for customer with ID 1

select rental_id 
from rental
where customer_id = 1;

-- Q7 - Display all the films whose rental duration is greater than 5 .

select title , rental_duration
from film
where rental_duration > 5;

-- Q8 - List the total number of films whose replacement cost is greater than $15 and less than $20.

select count(title) as Total_films
from film
where  replacement_cost between 15 and 20;

-- Q9 - Display the count of unique first names of actors.

select count(distinct(first_name)) as Total_unique_name
from actor;

-- Q10- Display the first 10 records from the customer table .

select *
from customer
order by customer_id asc
limit 10;

-- Q11 - Display the first 3 records from the customer table whose first name starts with ‘b’.

select *
from customer
where first_name like 'b%'
order by customer_id asc limit 3; 

-- 12 -Display the names of the first 5 movies which are rated as ‘G’.
select *
from film
where rating = 'G'
order by film_id LIMIT 5;

-- Q13-Find all customers whose first name starts with "a".

select *
from customer
where first_name like 'a%';

-- Q14- Find all customers whose first name ends with "a".

select *
from customer
where first_name like '%a';

-- Q15- Display the list of first 4 cities which start and end with ‘a’ .

select *
from city
where city like 'a%a'
limit 4;

-- Q16- Find all customers whose first name have "NI" in any position.

select *
from customer
where first_name regexp 'NI';

-- Q17- Find all customers whose first name have "r" in the second position .

select *
from customer
where first_name like '_r%';

-- Q18 - Find all customers whose first name starts with "a" and are at least 5 characters in length.

select * 
from customer
where first_name like 'a%' AND length(first_name) >=5 ; 

-- Q19- Find all customers whose first name starts with "a" and ends with "o".

select *
from customer
where first_name like 'a%o';

-- Q20 - Get the films with pg and pg-13 rating using IN operator.
select title, rating
from film
where rating IN ('PG', 'PG-13');

-- Q21  Get the films with length between 50 to 100 using between operator.
select title, length
from film
where length between 50 AND 100;

-- Q22 - Get the top 50 actors using limit operator.
select * 
from actor
order by actor_id
LIMIT 50;

--  23 - Get the distinct film ids from inventory table.
select DISTINCT(film_id) 
from inventory;

-- FUNCTIONS

use sakila;
-- Question 1: Retrieve the total number of rentals made in the Sakila database.
select count(rental_id)
from rental;
 
-- Question 2: Find the average rental duration (in days) of movies rented from the Sakila database.
select avg(datediff(return_date, rental_date)) as avgerage_rent_duration
from rental;

-- Question 3: Display the first name and last name of customers in uppercase.
select upper(first_name) as first_name , upper(last_name) as last_name
from customer;

-- Question 4: Extract the month from the rental date and display it alongside the rental ID.
select month(rental_date) as Rental_date_month, Rental_id
from rental;

-- GROUP BY:
-- Question 5: Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
select count(rental_id), customer_id
from rental
group by customer_id;

-- Question 6: Find the total revenue generated by each store.

select s.store_id,  sum(amount) as total_amount
from payment p 
join rental r
On p.rental_id = r.rental_id
join inventory i 
On i.inventory_id = r.inventory_id 
join store s
ON s.store_id = i.store_id
group by store_id;

-- Question 7:Determine the total number of rentals for each category of movies.

select y.name as category_name, count(r.rental_id) as total_rental
from rental r
join inventory i on r.inventory_id = i.inventory_id
Join  film f on i.film_id = f.film_id
Join film_category c on f.film_id = c.film_id
join category y on c.category_id = y.category_id
group by y.name
order by total_rental desc;
 
-- Question 8: Find the average rental rate of movies in each language.

select avg(f.rental_rate) as avg_rental_rate, l.name
from film f
Join  language l
On f.language_id = l.language_id
group by l.name;

-- JOINS

-- Questions 9 -Display the title of the movie, customer s first name, and last name who rented it.

select f.title, c.first_name, c.last_name
from customer c
join rental r ON c.customer_id = r.customer_id
Join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id;

-- Question 10: Retrieve the names of all actors who have appeared in the film "Gone with the Wind."

select a.first_name, a.last_name, f.title
from actor a
Join film_actor fa on a.actor_id = fa.actor_id
Join film f On fa.film_id = f.film_id
where f.title =  'Gone with the Wind';

-- Question 11: Retrieve the customer names along with the total amount they've spent on rentals.

select c.first_name, c.last_name, sum(amount) as Total_amount, c.customer_id
from customer c
join rental r On c.customer_id = r.customer_id
join payment p On r.rental_id = p.rental_id
group by c.customer_id;

-- Question 12:List the titles of movies rented by each customer in a particular city (e.g., 'London').

select * from rental;
select c.first_name, c.last_name, ci.city
from customer c
Join address a On c.address_id = a.address_id
Join city ci On a.city_id = a.city_id
join rental r On c.customer_id = r.customer_id
Join inventory i On r.inventory_id = i.inventory_id
Join film f on i.film_id = f.film_id
where ci.city = 'London';

-- ADVANCE JOIN AND GROUP BY

-- Question 13: Display the top 5 rented movies along with the number of times they've been rented.

select title, count(rental_id) as total_time_rents
from film f
join inventory i On f.film_id = i.film_id
Join rental r On i.inventory_id = r.inventory_id
group by title
order by total_time_rents desc LIMIT 5; 

--  Question 14: Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).

Select * from inventory;
select * from rental;
Select * from customer;
select count(r.rental_id), i.store_id
from customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
where i.store_id IN (1,2)
group by i.store_id
HAVING count(distinct i.store_id) = 2;

-- WINDOW FUNCTION:

-- 1. Rank the customers based on the total amount they've spent on rentals
use sakila;

select r.customer_id, sum(amount) as total_amount, dense_rank() over (order by sum(amount)) as rank_
from rental r
join payment p on r.rental_id = p.rental_id
group by r.customer_id;

-- 2. Calculate the cumulative revenue generated by each film over time.

select f.film_id, f.title, p.payment_date,
		sum(p.amount) over (partition by f.film_id order by p.payment_date) as cumulative_revunue
from film f
join inventory i on f.film_id = i.film_id
Join rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
order by f.film_id, p.payment_date;

-- 3. Determine the average rental duration for each film, considering films with similar lengths.
select avg(rental_duration) over (partition by length), film_id, title, length
from film;

-- 4. Identify the top 3 films in each category based on their rental counts.

with ranked_film as (select  dense_rank() over ( order by count(r.rental_id) desc) as rank_ ,
c.category_id, c.name,
count(r.rental_id) as rental_count
from category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f On fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r On i.inventory_id = r.inventory_id
group by c.category_id
order by rank_
)
Select rank_, category_id,name,rental_count
from ranked_film
where rank_ <=3;

-- 5. Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.
select customer_id, count(rental_id) as total_rent,
avg(count(rental_id)) over () as avg_rent,
count(rental_id) - avg(count(rental_id)) over () as difference
from rental
group by customer_id;

-- 6. Find the monthly revenue trend for the entire rental store over time.

select sum(amount), month(payment_date) as month_
from payment
group by month(payment_date)
order by month_;
use sakila;

-- 7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.
select * from payment;
With customer_spending as (
	select customer_id, sum(amount) as total_spending
	from payment
	group by customer_id
),
Ranked_customer as (
	select customer_id, total_spending,
	NTILE(100) Over (Order by total_spending DESC) as percentile_rank
	from customer_spending
)
select customer_id, total_spending, percentile_rank
from Ranked_customer
where percentile_rank <= 20;

-- 8. Calculate the running total of rentals per category, ordered by rental count.

with running_total as (
select fc.category_id, count(rental_id) as total_rental
from film_category fc 
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
group by fc.category_id
)
select category_id, total_rental, sum(total_rental) over (order by total_rental desc) as running_total
from running_total
order by total_rental desc;

-- 9. Find the films that have been rented less than the average rental count for their respective categories.

with film_rental_count as(
select  f.film_id ,fc.category_id, count(rental_id) as rental
from film f 
JOIN film_category fc ON f.film_id = fc.film_id
JOIN inventory i on fc.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
group by f.film_id, fc.category_id
),
category_avg_rental as
(
select category_id, avg(rental) as rent_category
from film_rental_count
group by category_id
)
select f.title, frc.rental, rent_category
from film f 
JOIN film_rental_count frc ON f.film_id = frc.film_id
JOIN category_avg_rental car on frc.category_id = car.category_id
where frc.rental < rent_category;

-- 10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.

select * from payment;
select Month(payment_date) as MONTH_ , SUM(amount) as total_amount
from payment
group by MONTH_
order by total_amount desc
LIMIT 5;

-- NORMALISATION AND CTE:

-- 1. First Normal Form (1NF): a. Identify a table in the Sakila database that violates 1NF. Explain how you
--                                  would normalize it to achieve 1NF.
/*                  Ans1. In sakila database, actor_award table violates th 1nf. In actor_award table, awards column
						  contains the multiple value in single row.
						  To normalize it we have to create new table where each award value stored in 
						  separate row. */

--  2. Second Normal Form (2NF): a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. 
 --                                If it violates 2NF, explain the steps to normalize it. 		
 /*                         
				   Ans2. In sakilla datbase, in payment table staff_id violates the 2nf. In payment table,
						  amount is fully dependent on payment_id But staff_id does not depend on 
                          payment_id it represent the staff member who process the payment.
                          Sice, staff_id is not fully dependent on payment_id , it voilates 2NF
                                    
						  how to normalize it:
						  We can make two table from payment:
					      1. payment_details
					      2. staff_payment details

--  3. Third Normal Form (3NF): a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies 
                                   present and outline the steps to normalize the table to 3NF.
				 Ans3. In sakilla database, rental taable violates the 3NF. The rental table contains
						rental_id -> staff_id -> staff_name
                        Here, staff_name create a transitive dependency means staff_name is indirectly relatd
                        to rental_id through staff_id column.
                        This violats 3NF, as non-key attributes should depend only on promary key.
                        
                        Steps to narmalize it:
                        1. Remove the redundant attribute:
								. Eliminate the staff_name column from rental table.
						2. Make separate table for staff_name.
                        
-- 4. Normalization Process: a. Take a specific table in Sakila and guide through the process of normalizing it from the initial  
								unnormalized form up to at least 2NF.
                                
						Ans4. In sakilla database, we take the actor_award table:
                        1. 1nf
							To normalize the table we have to achieve 1NF
                            . first, we have to convert the non-atmoic values in atmoic values. In, awards column
							  we have to split the value in sepearated row.alter
						2. 2nf
							To acheive 2nf all non prime attributes must be dependent on primary key only.
                            Ensures No partial dependencies.
                            . So to achieve this we have remove the actor_id column. So that all the non-prime
                              attributes fully dependent on actor_award_id.
							. Create the separate table table for actor details.
 */
use sakila;
-- 5. CTE Basics:a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they 
--                  have acted in from the actor and film_actor tables.

with  total_film as
 (select a.actor_id as actor_id,first_name, count(film_id) as films
from actor a
JOIN film_actor fa on a.actor_id = fa.actor_id
group by actor_id)
select distinct(first_name), films
from total_film;

-- 6. CTE with Joins: a. Create a CTE that combines information from the film and language tables to display the film title, 
                --       language name, and rental rate                
with new_table as (
select f.title, f.rental_rate, l.name
from film f
Join language l on f.language_id = l.language_id
)
select title, rental_rate, name
from new_table;

-- 7. CTE for Aggregation: a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) 
 --                           from the customer and payment tables.    
 with total_amount as (
 select customer_id ,sum(amount) as total_revnue
 from payment
 group by customer_id)
 select ta.customer_id, c.first_name, ta.total_revnue
 from total_amount ta 
 JOIN customer c on ta.customer_id = c.customer_id;
 
-- 8. CTE with Window Functions: a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.
with film_ranking as(
select dense_rank() over (order by rental_duration) as rank_ ,title, rental_duration 
from film)
select rank_ , title, rental_duration
from film_ranking;

-- 9. CTE and Filtering: a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the 
--                          customer table to retrieve additional customer details.
with total_rental as (
select customer_id, count(rental_id) as rental
from rental
group by customer_id)
select c.*, ta.rental 
from total_rental ta
JOIN customer c on c.customer_id = ta.customer_id
where rental > 2;

-- 10. CTE for Date Calculations: a. Write a query using a CTE to find the total number of rentals made each month, considering the 
--                                   rental_date from the rental table.
with month_rental as
(select rental_id, month(rental_date)  as rentalmonth from rental)
select count(rentalmonth) as total_rental, rentalmonth as month 
from month_rental
group by rentalmonth
order by rentalmonth;

-- 11.  CTE and Self-Join a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film 
--                           together, using the film_actor table.
with actor_pair as 
(
select fa1.actor_id as actor1,
fa2.actor_id as actor2,
fa1.film_id
from film_actor fa1
join film_actor fa2 on fa1.film_id = fa2.film_id
and fa1.actor_id < fa2.actor_id
)
 select actor1, actor2, film_id
 from actor_pair;
 
 -- 12. CTE for Recursive Search: a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, 
--                                 considering the reports_to column
select * from staff;
WITH RecursiveEmployeeHierarchy AS (
    SELECT 
        staff_id, 
        first_name, 
        last_name
    FROM 
        staff
    WHERE 
        staff_id = 1 -- Replace <manager_id> with the ID of the manager you are starting with
    UNION ALL
    SELECT 
        s.staff_id, 
        s.first_name, 
        s.last_name
    FROM 
        staff s
    INNER JOIN 
        RecursiveEmployeeHierarchy reh 
    ON 
        s.reports_to = reh.staff_id
)
SELECT 
    staff_id, 
    first_name, 
    last_name 
FROM 
    RecursiveEmployeeHierarchy;