Este ejercicio técnico está creado a partir de la realización de varias consultas SQL a la base de datos Sakila. En ella podemos encontrar información sobre películas, actores, categorías, clientes y alquileres. Dentro de la base de datos encontramos tablas principales y tablas intermedias necesarias para representar relaciones de muchos a muchos, como ocurre entre películas y actores, o películas y categorías.
Lo primero que hacemos es familiarizarnos con la base de datos abriendo el esquema. La idea principal de realizar estas consultas es entender las relaciones entre los datos para poder responder a las preguntas, y cuantas más queries ejecutemos, mayor conocimiento de los datos tendremos y más eficientes serán las consultas que hagamos. 
Por ejemplo, esta consulta cuenta cuántas películas hay en cada tipo de claseificación. Agrupamos las películas por su clasificación mediante el group by y después realizamos el recuento total de películas para cada clasificación.
SELECT COUNT(f.film_id) AS recuento, f.rating AS clasificacion FROM film AS f
GROUP BY f.rating. 
O por ejemplo, en esta otra consulta, se muestran los actores que no han participado en películas de la categoría Horror.
Aquí hacemos uso de SELECT para obtener el nombre y apellidos de los actores desde la tabla actor. En la subconsulta, obtenemos los actor_id de los actores que sí han trabajado en películas de Horror (a través de varias uniones entre las tablas film, film_actor, film_category y category). Luego, en la consulta principal, usamos WHERE actor_id NOT IN (...) para excluir a esos actores, y así poder obtener sólo los que no han participado en ese género. 
SELECT a.first_name, a.last_name 
FROM actor AS a
WHERE a.actor_id NOT IN (SELECT a.actor_id 
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
También hemos utilizado herramientas de funciones de agregación como AVG para calcular el promedio, COUNT para contar o CONCAT para unir valores de texto. En conclusión, este ejercicio ayuda a mejorar los conceptos básicos de SQL, así como el pensamiento analítico en la resolución de problemas y la lógica relacional entre las tablas.