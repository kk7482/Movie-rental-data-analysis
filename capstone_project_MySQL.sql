show databases;
use sakila;

/*TASK 1*/
select concat(first_name,'  ',last_name) as full_name from actor ;

/*TASK 2 (i)*/
select count(*) as count_first_name , first_name 
from actor group by first_name 
order by count_first_name desc ;

/*TASK 2 (ii)*/
select count(*) as count_actors,first_name
from actor group by first_name having count_actors = 1 ;

/*TASK 3 (i) */
select count(*) as count_last_name , last_name from actor
group by last_name order by count_last_name desc ;

/*TASK 3 (ii) */
select count(*) as count_actors,last_name
from actor group by last_name having count_actors = 1 ;

/*TASK 4 (i)*/
select * from film where rating = 'R';

/*TASK 4 (ii)*/
select * from film where not rating = 'R';

/*TASK 4 (iii)*/
select * from film where rating = 'PG-13' or 'PG' or 'G';

/*TASK 5 (i)*/
select * from film where replacement_cost <= 11
order by replacement_cost desc ;
select * from film where replacement_cost between 11 and 20
order by replacement_cost desc ;
select * from film order by replacement_cost desc ;

/*TASK 6 */
select film.film_id, film.title, count(*) as actor_count
from film_actor join film on film.film_id = film_actor.film_id
group by film.film_id, film.title order by actor_count desc limit 3;

/*TASK 7 */
select title from film 
where title like 'k%' or 'q%' ;

/*TASK 8 */
select concat(first_name,'  ',last_name) as actor_names from actor
join film_actor on actor.actor_id = film_actor.actor_id
join film on film.film_id = film_actor.film_id
where film.title = 'agent truman';

/*TASK 9 */
select title from film
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
where category.name = 'family';

/* TASK 10 (i)*/
select rating, max(rental_rate) as max_rental_rate, 
min(rental_rate) as min_rental_rate, 
avg(rental_rate) as avg_rental_rate
from film group by rating order by avg_rental_rate desc ;

/* TASK 10(ii) */
select film.film_id, film.title, count(rental.rental_id) as rented_count
from film join inventory on film.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
group by film.film_id, film.title order by rented_count desc;

/* TASK 11 (i)*/
select count(*) as category_count
from (select fc.category_id from film_category fc
join film f on f.film_id = fc.film_id group by fc.category_id
having avg(f.replacement_cost) - avg(f.rental_rate) > 15
) as category_result;
select c.name as category_name, 
avg(f.replacement_cost) as avg_replacement_cost, 
avg(f.rental_rate) as avg_rental_rate from category c
join film_category fc on c.category_id = fc.category_id
join film f on f.film_id = fc.film_id group by c.name
having (avg(f.replacement_cost) - avg(f.rental_rate)) > 15;

/* TASK 12 */
select category.name as category_name, count(*) as movie_count
from film_category join category 
on film_category.category_id = category.category_id
group by category.category_id having movie_count > 70;
