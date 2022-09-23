-- LAB SQL Self and cross join

-- Get all pairs of actors that worked together.
use sakila;
select * from actor;
select * from film;
select * from film_actor;

select * from film_actor fa
join film_actor fa1
on fa1.film_id=fa.film_id
and fa1.actor_id<>fa.actor_id;

-- Get all pairs of customers that have rented the same film more than 3 times. 
select * from customer;

select c1.customer_id customer1, c2.customer_id customer2 from (
(select c.customer_id, f.film_id from customer c
	join rental r on c.customer_id = r.customer_id
	join inventory i on r.inventory_id = i.inventory_id
	join film f on i.film_id = f.film_id
	) c1 
join (
select c.customer_id, f.film_id from customer c
	join rental r on c.customer_id = r.customer_id
	join inventory i on r.inventory_id = i.inventory_id
	join film f on i.film_id = f.film_id 
	) c2 on c2.film_id = c1.film_id and c2.customer_id < c1.customer_id
	)
group by c1.customer_id, c2.customer_id
having count(c1.film_id) > 3 
order by 1;


-- Get all possible pairs of actors and films.
select * from (select distinct first_name, last_name from actor
) query1 
cross join (select title from film
) query2;