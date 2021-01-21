Use sakila;

-- 1 --
SELECT *
from film;

SELECT title, length, rank() over (order by length) AS rank_length
from film
where length not in ('',0,' '); 

-- 2 --
SELECT title, length, rating, rank() over (partition by length order by rating) AS rank_length
from film
where length not in ('',0,' ');

-- 3 --
SELECT c.name, count(f.film_id) as nr_of_films
from category as c
join film_category as f
on c.category_id = f.category_id
group by c.name;

-- 4 --
SELECT a.first_name, a.last_name, count(f.film_id) as nr_of_films
from actor as a
join film_actor as f
on a.actor_id = f.actor_id
group by a.last_name;

-- 5 --
SELECT c.first_name, c.last_name, count(r.rental_id) as nr_of_rentals
from customer as c
join rental as r
on c.customer_id = r.customer_id
group by c.last_name
order by nr_of_rentals DESC;

-- Bonus --
SELECT f.film_id, f.title, count(rental_id) as most_rented_film
from rental as r
	join inventory as i
		on r.inventory_id = i.inventory_id
	join film as f
		on i.film_id = f.film_id
group by f.title
order by most_rented_film DESC;
        