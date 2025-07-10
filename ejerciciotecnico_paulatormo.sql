-- EJERCICIO TÉCNICO
USE sakila;
--  1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.
SELECT DISTINCT f.title
FROM film AS f;
-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
SELECT f.title
FROM film AS f
WHERE rating = "PG-13";
-- 3.Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.
SELECT *
FROM film;
SELECT f.title, f.description
FROM film AS f
WHERE f.description LIKE '%amazing%'; -- todas las películas las devuelve conteniendo la palabra
-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
SELECT f.title
FROM film AS f
WHERE length > 120;
-- 5. Recupera los nombres de todos los actores.
SELECT CONCAT(a.first_name, ' ', a.last_name) AS nombre
FROM actor AS a;
-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
SELECT CONCAT(a.first_name, ' ', a.last_name) AS nombre
FROM actor AS a
WHERE a.last_name = "Gibson";
-- 7.  . Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
SELECT CONCAT(a.first_name, ' ', a.last_name) AS nombre
FROM actor AS a
WHERE actor_id BETWEEN 10 AND 20; -- ambos inclusive
-- 8 Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.
SELECT f.title, f.rating
FROM film AS f
WHERE rating NOT IN ("R", "PG-13"); -- excluyo todos los registros de esas calificaciones
-- 9 Encuentra la cantidad total de películas en cada clasificación de la tabla film  y muestra la  clasificación junto con el recuento.
SELECT COUNT(f.film_id) AS recuento, f.rating AS clasificacion -- contamos la cantidad de películas y las agrupamos por su clasificación
FROM film AS f
GROUP BY f.rating;

 -- 10Encuentra la cantidad total de películas alquiladas por cada cliente y 
 -- muestra el ID del cliente, su  nombre y apellido junto con la cantidad de películas alquiladas.
 -- query entendiendo que me una todos los clientes que hayan alquilado y la cantidad de sus peliculas alquiladas
 SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS nombre, COUNT(rental_id) AS cantidad_peliculas_alquiladas
 FROM customer AS c
 INNER JOIN rental AS r -- todas la peliculas tienen que tener un cliente
 ON c.customer_id = r.customer_id -- unimos las tablas de cliente y alquiler
 GROUP BY c.customer_id, nombre -- agrupamos por cada cliente
 HAVING COUNT(r.rental_id) > 0; -- contamos por cada cliente las peliculas que ha alquilado, siendo este nº > 0, tiene que alquilar algo
 -- query entendiendo que nos devuelva todos los clientes hayan o no alquilado
 SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS nombre, COUNT(rental_id) AS cantidad_peliculas_alquiladas
 FROM customer AS c
 LEFT JOIN rental AS r -- nos une a todos los clientes, hayan o no alquilado
 ON c.customer_id = r.customer_id -- unimos las tablas de cliente y alquiler
 GROUP BY c.customer_id, nombre; -- agrupamos por cada cliente;
 
 -- comprobación de si hay algún cliente sin alquiler: lo devuelve vacío
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS nombre
FROM customer AS c
LEFT JOIN rental AS r
ON c.customer_id = r.customer_id
WHERE r.rental_id IS NULL;
-- 11 Encuentra la cantidad total de películas alquiladas por categoría 
-- y muestra el nombre de la categoría junto con el recuento de alquileres
SELECT COUNT(r.rental_id) AS recuento, cat.name AS nombre
FROM category AS cat
INNER JOIN film_category AS fa -- tabla intermedia para unir la categoria con la pelicula
ON cat.category_id = fa.category_id
INNER JOIN film AS f
ON fa.film_id = f.film_id
INNER JOIN inventory AS i -- tabla que une pelicula con alquiler
ON f.film_id = i.film_id
INNER JOIN rental AS r
ON i.inventory_id = r.inventory_id
GROUP BY cat.name -- agrupamos por el nombre de la categoria
HAVING COUNT(r.rental_id) > 0; -- contamos el alquiler de peliculas de cada categoria, entendiendo que sólo queremos

-- 12 Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y 
-- muestra la clasificación junto con el promedio de duración.
-- query comprobacion promedio duracion
SELECT AVG(length) AS promedio
FROM film;
-- query final
SELECT DISTINCT f.rating, AVG(length) AS promedio
FROM film AS f
GROUP BY f.rating; -- agrupamos por su clasificación, y luego el promedio en el select

 -- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
 SELECT CONCAT(a.first_name,' ', a.last_name) AS nombre
 FROM actor AS a
 INNER JOIN film_actor AS fa -- unimos actor y pelicula, tabla intermedia
 ON a.actor_id = fa.actor_id
 INNER JOIN film AS f
 ON fa.film_id = f.film_id
 WHERE title = "Indian Love";
 -- 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.
 -- query final
 SELECT f.title, f.description
 FROM film AS f
 WHERE f.description LIKE '% dog %'  OR f.description LIKE '% cat %'; -- contienen la palabra dog o cat como palabras individuales, patrón
 -- query funciona dog
 SELECT f.title, f.description
 FROM film AS f
 WHERE f.description LIKE '% dog %'; 
 
 -- query para ver todo de film
 SELECT *
 FROM film; -- description : dog y cat suelen estar en medio, espacios
 
 -- 15. Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor
 SELECT CONCAT(a.first_name, ' ', a.last_name) AS nombre
 FROM actor AS a
 LEFT JOIN film_actor AS fa -- unimos tablas actores y actores en peliculas, todos los actores
 ON a.actor_id = fa.actor_id
 WHERE fa.actor_id IS NULL; -- donde el actor en la pelicula no aparezca
 
 --  16 Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.
 -- query final
 SELECT f.title
 FROM film AS f
 WHERE release_year BETWEEN 2005 AND 2010;
 -- query conocer
 SELECT *
 FROM film; -- release_year entendendemos que incluye 2005 y 2010/ solo me sale 2006
 -- 17 Encuentra el título de todas las películas que son de la misma categoría que "Family".
 -- query final
 SELECT f.title
 FROM film AS f
 INNER JOIN film_category AS fc-- tabla intermedia, quiero solo las que tienen coincidencia
 ON f.film_id = fc.film_id
 INNER JOIN category AS c
 ON fc.category_id = c.category_id
 WHERE c.name = "Family"; -- filtramos por el nombre de la categoria
 
 -- query control
 SELECT f.title, c.name
 FROM film AS f
 INNER JOIN film_category AS fc-- tabla intermedia
 ON f.film_id = fc.film_id
 INNER JOIN category AS c
 ON fc.category_id = c.category_id
 WHERE c.name = "Family";
 SELECT *
 FROM category; -- tiene name family, unimos con cat.film y film
 -- 18 Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.
 SELECT CONCAT(a.first_name, ' ', a.last_name) AS nombre
 FROM actor AS a
 INNER JOIN film_actor AS fa -- tabla intermedia, solo quiero actores que tengan coincidencias con actores en peliculas
 ON a.actor_id = fa.actor_id
 GROUP BY a.actor_id, a.first_name, a.last_name -- unimos por los nombres de columna, actor_id es pk y único= actores individuales pese a nombres duplicados
HAVING COUNT(fa.film_id) > 10; -- film_id es único
 
 
 -- query control con num_pelis
 SELECT CONCAT(a.first_name, ' ', a.last_name) AS nombre, COUNT(fa.film_id) AS num_peli
 FROM actor AS a
 INNER JOIN film_actor AS fa -- tabla intermedia, solo quiero actores que tengan coincidencias con peliculas
 ON a.actor_id = fa.actor_id
 GROUP BY a.actor_id, a.first_name, a.last_name -- agrupamos por nombre
HAVING COUNT(fa.film_id) > 10; -- queremos actores que aparezca en +10 pelis, diferente titulo =diferente peli
 
-- 19 Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film
-- queries control
SELECT f.length
FROM film AS f
WHERE length > 
SELECT f.title, f.rating
FROM film AS f
WHERE rating = "R";
SELECT *
FROM film;
 -- Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y
--  muestra el nombre de la categoría junto con el promedio de duración
 