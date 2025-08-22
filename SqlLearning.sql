#¿Qué peliculas se están proyectando?
SELECT DISTINCT p.id, p.nombre
FROM pelicula p
left join cartelera c on p.id = c.id_pelicula
where c.id_pelicula is not null;


#Actualizar películas que no tengan clasificación de edad
UPDATE pelicula
SET clasificacion_edad = clasificacion_edad = 0;


#¿Qué películas son para todo el público?
SELECT DISTINCT p.id, p.nombre, p.clasificacion_edad
FROM pelicula p
left join cartelera c on p.id =  c.id_pelicula
where p.clasificacion_edad = 0;

#Películas disponibles en cada cine
SELECT DISTINCT c.nombre, p.nombre
FROM  cine c
INNER JOIN cartelera k
ON c.id = k.id_cine
INNER JOIN pelicula p
ON p.id = k.id_pelicula;


#¿Qué películas están disponibles en los cines cerca de mi ciudad?
SELECT DISTINCT ci.nombre, p.nombre,ci.estado, ci.pais
FROM cine ci
left JOIN cartelera c
ON ci.id = c.id_cine
left JOIN pelicula p
ON c.id_pelicula = p.id
WHERE estado="Dublin" AND pais="Irlanda";


#Actualizar género de las películas
CREATE TABLE genero (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre varchar (100));

SELECT*
FROM genero;

INSERT INTO genero (nombre)
VALUES
('accion'),
('aventura'),
('ciencia ficcion'),
('comedia'),
('drama'),
('fantasia'),
('suspenso'),
('terror');


#Actualizar género de las películas
ALTER TABLE pelicula
ADD id_genero INT;

ALTER TABLE pelicula
ADD CONSTRAINT fk_genero
FOREIGN KEY (id_genero) REFERENCES genero(id);
 
UPDATE pelicula
SET id_genero = CASE
WHEN id BETWEEN 1 AND 10 THEN 8
WHEN id BETWEEN 11 AND 20 THEN 3
WHEN id BETWEEN 20 AND 45 THEN 4
WHEN id BETWEEN 46 AND 55 THEN 7
ELSE 1
END;

ALTER TABLE pelicula
ADD nombre_genero VARCHAR (100);
 
UPDATE pelicula p
JOIN genero g ON p.id_genero = g.id
SET p.nombre_genero = g.nombre;

SELECT *
FROM pelicula;


#Películas de suspenso para mayores de edad que se proyectan en cines cerca de mi ciudad
SELECT DISTINCT p.clasificacion_edad,p.nombre, c.*,ci.nombre, ci.estado
FROM pelicula p 
LEFT JOIN cartelera c
ON p.id = c.id_pelicula 
JOIN cine ci
ON c.id_cine = ci.id
JOIN genero g
ON p.id_genero = g.id
WHERE p.clasificacion_edad = 18
AND ci.estado ="Madrid" AND id_genero = 7 ;


