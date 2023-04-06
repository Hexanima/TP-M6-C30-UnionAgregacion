use movies_db;

/* Micro desafio 1 */

/* Conocer los títulos y el nombre del género de todas las series de la base de datos. */
select series.title, genres.name from series inner join genres on series.genre_id = genres.id;

/* Listar los títulos de los episodios junto con el nombre y apellido de los actores que trabajan en cada uno de ellos. */
select episodes.title as "Episodio", concat(actors.first_name, " ", actors.last_name) as "Actor" from actor_episode 
inner join episodes on episodes.id = actor_episode.episode_id 
inner join actors on actors.id = actor_episode.actor_id; 

/* Micro desafio 2 */

/* Obtener a todos los actores o actrices (mostrar
nombre y apellido) que han trabajado en cualquier película de la saga de la Guerra de las
galaxias, pero ¡cuidado!: debemos asegurarnos de que solo se muestre una sola vez cada
actor/actriz. */

select distinct concat(actors.first_name, " ", actors.last_name) 
from actor_movie
inner join actors on actor_movie.actor_id = actors.id
inner join movies on actor_movie.movie_id = movies.id
where movies.title like "%Guerra de las galaxias%";

/* Micro desafio 3 */

/* Listar los títulos de cada película con su género correspondiente. En el caso de
que no tenga género, mostraremos una leyenda que diga "no tiene género". Como ayuda
podemos usar la función COALESCE() que retorna el primer valor no nulo de una lista.
Podemos encontrar más información haciendo click acá. */

select movies.title, coalesce(genres.name, "No tiene género") from movies
left join genres on movies.genre_id = genres.id;

/* Micro desafio 4 */

/* Mostrar, de cada serie, la cantidad de días desde su estreno hasta su fin, con
la particularidad de que a la columna que mostrará dicha cantidad la renombraremos:
“Duración”. */

select title as Titulo, datediff(end_date, release_date) as Duración from series;

/* Micro desafio 5 */

/* Listar los actores ordenados alfabéticamente cuyo nombre sea mayor a 6 caracteres. */
select * from actors where length(first_name) > 6;

/* Mostrar la cantidad total de los episodios guardados en la base de datos. */
select count(*) as "Episodios en la base de datos" from episodes;

/* Obtener el título de todas las series y el total de temporadas que tiene cada una de ellas. */
select series.title, count(*) as "Cantidad de temporadas" from seasons inner join series on seasons.serie_id = series.id group by serie_id;

/* Mostrar, por cada género, la cantidad total de películas que posee, siempre que sea mayor o igual a 3. */
select genres.name as Genero, count(movies.id) as "Total de peliculas" from movies
inner join genres on movies.genre_id = genres.id group by genre_id;