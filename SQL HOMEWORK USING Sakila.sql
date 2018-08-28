USE sakila;
#1a
SELECT first_name, last_name

FROM actor;
#1b
SELECT UPPER(CONCAT(first_name,"",last_name))

AS NAME FROM actor;
#2a
SELECT actor_id, first_name, last_name

FROM actor WHERE first_name = "JOE";
#2b
SELECT * FROM actor WHERE last_name

LIKE "%GEN%";
#2c
SELECT * FROM actor

WHERE last_name

like "%LI%"

ORDER BY last_name, first_name;
#2d
SELECT country_id, country FROM country WHERE country IN ("Afghanistan", "Bangladesh", "China");
#3a
ALTER TABLE actor

ADD COLUMN description BLOB(15) AFTER last_name;
#3b
ALTER TABLE actor DROP COLUMN description;
#4a
SELECT DISTINCT last_name,

COUNT(last_name) AS "name_count"

FROM actor GROUP BY last_name;
#4b
SELECT DISTINCT last_name, 

COUNT(last_name) AS "name_count"

FROM actor GROUP BY last_name HAVING name_count >=2;
#4c
UPDATE actor SET first_name = "HARPO" WHERE first_name = "GROUCHO" AND last_name = "WILLIAMS";
#4d
UPDATE actor SET first_name = CASE WHEN first_name = "HARPO" 

THEN "GROUCHO" ELSE "GROUCHO WILLIAMS" END WHERE actor_id = 172;
#5a
CREATE TABLE IF NOT EXISTS address (address_id TINYINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,

address VARCHAR(50) NOT NULL, address2 VARCHAR(50) DEFAULT NULL,

district VARCHAR(20) NOT NULL, city_id TINYINT(5) UNSIGNED NOT NULL, postal_code VARCHAR(10)

DEFAULT NULL, phone VARCHAR(20) NOT NULL, GEOMETRYCOLLECTION BIT(5), location geometry NOT NULL, last_update TIMESTAMP

NOT NULL DEFAULT current_timestamp ON UPDATE current_timestamp, PRIMARY KEY (address_id), 

KEY idx_fk_city_id(city_id),  

CONSTRAINT fk_address_city FOREIGN KEY (city_id) REFERENCES city(city_id) 

ON UPDATE CASCADE) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8MB4; 

SELECT * FROM address
#6a
SELECT first_name, last_name, address, city, country 

FROM staff 

JOIN address 

ON staff.address_id = address.address_id 

JOIN city

ON address.city_id = city.city_id 

JOIN country 

ON city.country_id = country.country_id;
#6b
SELECT staff.first_name, staff.last_name,

SUM(payment.amount) 

AS revenue_received FROM staff

JOIN payment ON staff.staff_id = payment.staff_id

WHERE payment.payment_date LIKE "2005-08%" GROUP BY payment.staff_id;
#6c
SELECT title, COUNT(actor_id) AS number_of_actors FROM film 

INNER JOIN film_actor ON film.film_id=film_actor.film_id GROUP BY title;
#6d
SELECT title, COUNT(inventory_id) AS number_of_actors FROM film 

INNER JOIN inventory ON film.film_id=inventory.film_id where title = "Hunchback Impossible";
#6e
SELECT last_name, first_name, SUM(amount) AS total_paid

FROM payment JOIN customer ON payment.customer_id = customer.customer_id

GROUP BY payment.customer_id ORDER BY last_name ASC;
#7a
SELECT title FROM film WHERE language_id IN(

SELECT language_id FROM language
 
WHERE name = "English" AND TITLE LIKE "K%" OR TITLE LIKE"Q%");
#7b
SELECT last_name, first_name 

FROM actor WHERE actor_id IN (

SELECT actor_id FROM film_actor 

WHERE film_id IN (

SELECT film_id IN (

SELECT film_id FROM film

WHERE title = "ALONE TRIP")));
#7c
SELECT last_name, first_name, email, country 

FROM customer 

INNER JOIN address 

ON (customer.address_id = address.address_id)

INNER JOIN city

ON (address.city_id = city.city_id)

INNER JOIN country

ON (city.country_id = country.country_id)

WHERE country.country = "CANADA";
#7d
SELECT title FROM film WHERE film_id IN(

SELECT film_id FROM film_category WHERE category_id IN(

SELECT category_id FROM category WHERE name = "FAMILY"));
#7e
SELECT title, COUNT(title) as "Rentals" 

FROM film

JOIN inventory

ON(film.film_id = inventory.film_id)

JOIN rental

ON(inventory.inventory_id = rental.inventory_id)

GROUP BY title

ORDER BY Rentals DESC;
#7f
SELECT store_id,

SUM(amount) AS revenue FROM store 

JOIN staff 

ON store.store_id = staff.store_id

GROUP BY store.store_id;
#7g
SELECT store.store_id,

city.city, country.country FROM store INNER JOIN address ON store.address_id = address.address_id

INNER JOIN city ON address.city_id = city.city_id INNER JOIN country 

ON city.country_id = country.country_id;
#7h
SELECT name, SUM(p.amount) AS gross_revenue FROM category c INNER JOIN film_category fc 

ON fc.category_id = c.category_id INNER JOIN inventory i 

ON i.film_id = fc.film_id INNER JOIN rental r

ON r.inventory_id = i.inventory_id RIGHT JOIN payment p 

ON p.rental_id = r.rental_id GROUP BY name ORDER BY

gross_revenue DESC LIMIT 5;
#8a
CREATE VIEW top_five_genres AS

SELECT SUM(amount), c.name

FROM payment p

JOIN rental r

ON (p.rental_id = r.rental_id)

JOIN inventory i

ON (r.inventory_id = i.inventory_id)

JOIN film_category fc

ON (i.film_id = fc.film_id)

JOIN category c

ON (fc.category_id = c.category_id)

GROUP BY c.name

ORDER BY SUM(amount) DESC

LIMIT 5;
#8b
SELECT * FROM top_five_genres;
#8c
DROP VIEW top_five_genres;


