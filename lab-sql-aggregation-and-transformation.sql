USE Sakila;


/*
Welcome to the SQL Data Aggregation and Transformation lab!

In this lab, you will practice how to use SQL queries to extract insights from the Sakila database which contains information about movie rentals.

You will build on your SQL skills by practicing how to use the GROUP BY and HAVING clauses to group data and filter results based on aggregate values. 
You will also practice how to handle null values, rename columns, and use built-in functions like 
MAX, MIN, ROUND, DATE_DIFF, CONCAT, and SUBSTRING to manipulate and transform data for generating insights.*/


/*
1.You need to use SQL built-in functions to gain insights relating to the duration of movies:
1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
1.2. Express the average movie duration in hours and minutes. Don't use decimals.
Hint: Look for floor and round functions.*/

SELECT min(length) min_duration, max(length) max_duration FROM film;

SELECT floor(avg(length)/60) hours, round((avg(length)/60-floor(avg(length)/60))*60,2) minutes FROM film;


/*
2. You need to gain insights related to rental dates:
2.1 Calculate the number of days that the company has been operating.
	Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
	Hint: use a conditional expression.*/

SELECT * FROM rental ;
SELECT DATEDIFF(max(rental_date),min(rental_date)) dias FROM rental ;

SELECT rental_id, inventory_id, month(rental_date) mes, weekday(rental_date) diasemana from rental
limit 20;


/*
3.You need to ensure that customers can easily access information about the movie collection. 
To achieve this, retrieve the film titles and their rental duration. 
If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
	Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
	Hint: Look for the IFNULL() function.*/

SELECT f.title, r.rental_date, ifnull(r.return_date,'Not Available') return_date, ifnull(datediff(r.return_date,r.rental_date),'Not Available') dias  FROM rental r
LEFT JOIN inventory i on r.inventory_id = i.inventory_id
LEFT JOIN film f on i.film_id = f.film_id;

