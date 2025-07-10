-- EJERCICIO TÉCNICO
USE sakila;
--  1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.
SELECT DISTINCT f.title
FROM film AS f;
-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
SELECT f.title
FROM film AS f
WHERE rating = "PG-13"; -- clasificación es la columna rating
-- 3.Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.
-- query final
SELECT f.title, f.description
FROM film AS f
WHERE f.description LIKE '%amazing%'; -- todas las películas las devuelve conteniendo la palabra, patrón
-- query control
SELECT *
FROM film;
-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
SELECT f.title
FROM film AS f
WHERE f.length > 120;
-- 5. Recupera los nombres de todos los actores.
SELECT CONCAT(a.first_name, ' ', a.last_name) AS nombre
FROM actor AS a;
-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
SELECT CONCAT(a.first_name, ' ', a.last_name) AS nombre
FROM actor AS a
WHERE a.last_name = "Gibson";
-- 7.  . Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
SELECT CONCAT(a.first_name, ' ', a.last_name) AS nombre, a.actor_id
FROM actor AS a
WHERE a.actor_id BETWEEN 10 AND 20; -- ambos inclusive

-- 8 Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.
-- query final:
SELECT f.title
FROM film AS f
WHERE f.rating NOT IN ("R", "PG-13"); -- excluyo todos los registros de esas calificaciones

-- 9 Encuentra la cantidad total de películas en cada clasificación de la tabla film  y muestra la  clasificación junto con el recuento.
SELECT COUNT(f.film_id) AS recuento, f.rating AS clasificacion -- contamos la cantidad de películas y las agrupamos por su clasificación
FROM film AS f
GROUP BY f.rating;

 -- 10Encuentra la cantidad total de películas alquiladas por cada cliente y 
 -- muestra el ID del cliente, su  nombre y apellido junto con la cantidad de películas alquiladas.
 -- query final1:
 -- entendiendo que me una todos los clientes que hayan alquilado y la cantidad de sus peliculas alquiladas
 SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS nombre, COUNT(rental_id) AS cantidad_peliculas_alquiladas
 FROM customer AS c
 INNER JOIN rental AS r -- todas la peliculas tienen que tener un cliente
 ON c.customer_id = r.customer_id -- unimos las tablas de cliente y alquiler
 GROUP BY c.customer_id, c.first_name, c.last_name -- agrupamos por cada cliente
 HAVING COUNT(r.rental_id) > 0; -- contamos por cada cliente las peliculas que ha alquilado, siendo este nº > 0, tiene que alquilar algo
 
 -- final 2: query entendiendo que nos devuelva todos los clientes hayan o no alquilado
 SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS nombre, COUNT(rental_id) AS cantidad_peliculas_alquiladas
 FROM customer AS c
 LEFT JOIN rental AS r -- nos une a todos los clientes, hayan o no alquilado
 ON c.customer_id = r.customer_id 
 GROUP BY c.customer_id, c.first_name, c.last_name; -- agrupamos por cada cliente;
 
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
HAVING COUNT(r.rental_id) > 0; -- contamos el alquiler de peliculas de cada categoria, entendiendo que sólo queremos cantidad de peliculas que se hayan alquilado


-- 12 Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y 
-- muestra la clasificación junto con el promedio de duración.
-- query final
SELECT f.rating, AVG(length) AS promedio
FROM film AS f
GROUP BY f.rating; -- agrupamos por su clasificación, y luego el promedio en el select

-- query comprobacion promedio duracion
SELECT AVG(length) AS promedio
FROM film;
 -- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
 SELECT CONCAT(a.first_name,' ', a.last_name) AS nombre
 FROM actor AS a
 INNER JOIN film_actor AS fa -- unimos actor y pelicula, tabla intermedia
 ON a.actor_id = fa.actor_id
 INNER JOIN film AS f
 ON fa.film_id = f.film_id
 WHERE title = "Indian Love";
 -- 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.
 -- query final 1
 SELECT f.title
 FROM film AS f
 WHERE f.description LIKE '% dog %'  OR f.description LIKE '% cat %'; -- contienen la palabra dog o cat como palabras individuales, patrón
 -- query opcion 2
SELECT f.title
 FROM film AS f
 WHERE f.description LIKE '% dog %'
 UNION -- no hace falta duplicados
 SELECT f.title
 FROM film AS f
 WHERE f.description LIKE '% cat %';
 -- query funciona dog
 SELECT f.title, f.description
 FROM film AS f
 WHERE f.description LIKE '% dog %';
 
 SELECT f.title, f.description
 FROM film AS f
 WHERE f.description LIKE '% CAT %'; 
 
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
 INNER JOIN film_category AS fc-- tabla intermedia
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
 -- query final 1:
 SELECT CONCAT(a.first_name, ' ', a.last_name) AS nombre
 FROM actor AS a
 INNER JOIN film_actor AS fa -- tabla intermedia, solo quiero actores que tengan coincidencias con actores en peliculas
 ON a.actor_id = fa.actor_id
 GROUP BY a.actor_id, a.first_name, a.last_name 
HAVING COUNT(fa.film_id) > 10; -- film_id es único, hace referencia a las peliculas

 -- query final opcion 2:
 SELECT CONCAT(a.first_name, ' ', a.last_name) AS nombre
 FROM actor AS a
 INNER JOIN film_actor AS fa -- tabla intermedia, solo quiero actores que tengan coincidencias con peliculas
 ON a.actor_id = fa.actor_id
 INNER JOIN film AS f
 On fa.film_id = f.film_id
 GROUP BY a.actor_id, a.first_name, a.last_name -- agrupamos por nombre
HAVING COUNT(DISTINCT f.title) > 10; -- diferente titulo =diferente peli
 
 -- query control con num_pelis
 SELECT CONCAT(a.first_name, ' ', a.last_name) AS nombre, COUNT(DISTINCT f.title) AS num_peli
 FROM actor AS a
 INNER JOIN film_actor AS fa -- tabla intermedia, solo quiero actores que tengan coincidencias con peliculas
 ON a.actor_id = fa.actor_id
 INNER JOIN film AS f
 On fa.film_id = f.film_id
 GROUP BY a.actor_id, a.first_name, a.last_name -- agrupamos por nombre
HAVING COUNT(DISTINCT f.title) > 10; -- queremos actores que aparezca en +10 pelis, diferente titulo =diferente peli
 
-- 19 Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film
-- query final
SELECT f.title
FROM film AS f
WHERE f.rating = "R" AND f.length > 120 -- su clasificacion es r y su duracion es de + 2h =120min
ORDER BY f.length ASC;
-- queries control
SELECT f.length 
FROM film AS f
WHERE f.length > 120
ORDER BY f.length ASC;
SELECT f.title, f.rating
FROM film AS f
WHERE rating = "R";
SELECT *
FROM film;
 -- 20 Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y
--  muestra el nombre de la categoría junto con el promedio de duración

SELECT c.name, AVG(f.length) AS promedio
FROM category AS c
INNER JOIN film_category AS fc
ON c.category_id = fc.category_id -- unimos todas las coincidencias de categorias con peliculas/tabla intermedia
INNER JOIN film AS f
ON fc.film_id = f.film_id
GROUP BY c.name -- agrupamos por nombre de categoria
HAVING AVG(f.length) > 120; -- donde el promedio de la duracion de cada pelicula sea mayor a 120,no inclusive

-- query control
SELECT film.title, AVG(film.length) as promedio
FROM film
GROUP BY title
HAVING AVG(length) > 120;
 -- 21  Encuentra los actores que han actuado en al menos 5 películas y 
 -- muestra el nombre del actor junto con la cantidad de películas en las que han actuado.
 -- query final
 SELECT CONCAT(a.first_name, ' ', a.last_name) AS nombre, COUNT(fa.film_id) AS cantidad
 FROM actor AS a
 INNER JOIN film_actor AS fa -- unimos actor con actores en peliculas
 ON a.actor_id = fa.actor_id
 GROUP BY a.actor_id, a.first_name, a.last_name 
 HAVING COUNT(fa.film_id) >= 5; -- filtra al menos 5, inclusive, contamos por id que es unico 
 
 -- 22 Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. 
 -- Utiliza una  subconsulta para encontrar los rental_ids con una duración superior a 5 días y
 -- luego selecciona las películas correspondientes.
 -- query final
SELECT DISTINCT f.title --  nos devuelve el nombre de las peliculas 1 vez, de alquiler superior a 5 días, no inclusive
 FROM film AS f
 INNER JOIN inventory AS i
 ON f.film_id = i.film_id -- unimos el titulo de film con rental, a través de tabla inventory
 INNER JOIN rental AS r
 ON i.inventory_id = r.inventory_id
 WHERE r.rental_id IN (SELECT rental_id -- quiero los rental id que estén dentro (IN) de los rental_id que tuvieron una fecha de devolucion > a 5 días
						FROM rental
                        WHERE DATEDIFF(return_date, rental_date) > 5); -- subconsulta que nos devuelve alquiler > 5 dias
 
 -- queries comprobaciones
 SELECT *
 FROM film;
 SELECT * FROM inventory;
 SELECT * FROM rental;
 SELECT f.title
 FROM film AS f
 INNER JOIN inventory AS i
 ON f.film_id = i.film_id -- unimos el titulo de film con rental, a través de tabla inventory
 INNER JOIN rental AS r
 ON i.inventory_id = r.inventory_id;
 -- subconsulta que nos devuelve alquiler > 5 dias
-- query consulta

SELECT * FROM film;
SELECT f.title, DATEDIFF(return_date, rental_date) AS duracion -- nos devuelve mas de 5 dias
 FROM film AS f
 INNER JOIN inventory AS i
 ON f.film_id = i.film_id -- unimos el titulo de film con rental, a través de tabla inventory
 INNER JOIN rental AS r
 ON i.inventory_id = r.inventory_id
 WHERE r.rental_id IN (SELECT rental_id -- quiero los rental id que estén dentro (IN) de los rental_id que tuvieron una fecha de devolucion > a 5 días
						FROM rental
                        WHERE DATEDIFF(return_date, rental_date) > 5); -- subconsulta que nos devuelve alquiler > 5 dias
SELECT f.title, DATEDIFF(return_date, rental_date) AS duracion -- devuelve titulos repetidos: probar distinct
 FROM film AS f
 INNER JOIN inventory AS i
 ON f.film_id = i.film_id -- unimos el titulo de film con rental, a través de tabla inventory, queremos sólo coincidencias
 INNER JOIN rental AS r
 ON i.inventory_id = r.inventory_id
 WHERE r.rental_id IN (SELECT rental_id -- quiero los rental id que estén dentro (IN) de los rental_id que tuvieron una fecha de devolucion > a 5 días
						FROM rental
                        WHERE DATEDIFF(return_date, rental_date) > 5); -- subconsulta que nos devuelve alquiler > 5 dias
 
 SELECT DATEDIFF(return_date, rental_date) AS duracion, rental_id -- para calcular la diferencia entre dos fechas usamos datediff(col1,col2)
 FROM rental 
 WHERE DATEDIFF(return_date, rental_date) > 5
 ;
 SELECT *
 FROM rental; -- quiero restar returndate a rentaldate y que eso sea mayor a 5

 -- rental une con inventory por inventory_id, que une con film title por film_id
 
 -- 23 Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". 
 -- Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores.
-- query final
SELECT a.first_name, a.last_name 
FROM actor AS a
WHERE a.actor_id NOT IN (SELECT a.actor_id -- NOT IN, actores cuyo ID NO está en la lista generada por mi subsconsulta de categoria horror
 FROM actor AS a
 INNER JOIN film_actor AS fa
 ON a.actor_id = fa.actor_id
 INNER JOIN film AS f
 ON fa.film_id = f.film_id
 INNER JOIN film_category AS fc
 ON f.film_id = fc.film_id
 INNER JOIN category AS c
 ON fc.category_id = c.category_id
 WHERE c.name = "Horror");
 
 -- query control
 

SELECT a.first_name, a.last_name 
FROM actor AS a
WHERE a.actor_id NOT IN (SELECT a.actor_id -- NOT IN, actores cuyo ID NO está en la lista generada por mi subsconsulta de categoria horror
 FROM actor AS a
 INNER JOIN film_actor AS fa
 ON a.actor_id = fa.actor_id
 INNER JOIN film AS f
 ON fa.film_id = f.film_id
 INNER JOIN film_category AS fc
 ON f.film_id = fc.film_id
 INNER JOIN category AS c
 ON fc.category_id = c.category_id
 WHERE c.name = "Horror");
 
 
 -- query consulta
 SELECT a.first_name, a.last_name, c.name -- nos devuelve actores que salen en horror
 FROM actor AS a
 INNER JOIN film_actor AS fa
 ON a.actor_id = fa.actor_id
 INNER JOIN film AS f
 ON fa.film_id = f.film_id
 INNER JOIN film_category AS fc
 On f.film_id = fc.film_id
 INNER JOIN category AS c
 ON fc.category_id = c.category_id
 WHERE c.name = "Horror";

 -- 24 Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film
 -- query final
SELECT f.title
 FROM film AS f
 INNER JOIN film_category AS fc -- me devuelva sólo coincidencias
 ON f.film_id = fc.film_id
 INNER JOIN category AS c
 ON fc.category_id = c.category_id
 WHERE c.name = 'Comedy' AND f.length > 180;
 
  -- query consulta
 SELECT f.title, f.length, c.name
 FROM film AS f
 INNER JOIN film_category AS fc
 ON f.film_id = fc.film_id
 INNER JOIN category AS c
 ON fc.category_id = c.category_id
 WHERE c.name = 'Comedy' AND f.length > 180;
 
 SELECT f.title
 FROM film AS f
 WHERE f.length > 180 AND f.film_id IN ( SELECT fc.film_id -- filtra por where, condicion, aquellas peliculas (film_id) que estén dentro de mi condicion de name= comedy
										FROM film_category AS fc
										 INNER JOIN category AS c
										 ON fc.category_id = c.category_id
										 WHERE c.name = 'Comedy');
 SELECT * FROM category 
 WHERE category.name = "Comedy";
 SELECT *
 FROM film_category
 WHERE category_id = "5";
 
 