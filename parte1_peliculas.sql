-- Desafio Dia 9
-- Crea el modelo (revisa bien cuál es el tipo de relación antes de crearlo), respeta las claves primarias, foráneas y tipos de datos.


create table peliculas (
	id integer primary key,
	nombre varchar(255),
	anno integer
);

create table tag (
	id integer primary key,
	tag varchar(25)
);
-- tabla para vincular pelis y tags
create table peliculas_tag(
	id_pelicula integer,
	id_tag integer,
	primary key (id_pelicula, id_tag),
	foreign key (id_pelicula) references peliculas(id),
	foreign key (id_tag) references tag(id)
);

select * from peliculas; select * from tag; select * from peliculas_tag;

-- Inserta 5 películas y 5 tags, la primera película tiene que tener 3 tags asociados, la segunda película debe tener dos tags asociados.
-- insertar 5 pelis


insert into peliculas (id, nombre, anno) values
(1, 'El Señor de los Anillos: la Comunidad del Anillo', '2001'),
(2, 'American Pie', '1999'),
(3, 'Deadpool & Wolverine', '2024'),
(4, 'El Demoledor', '1993'),
(5, 'Dragon Ball Super: Super Hero', '2022');

-- insersar 5 tag

insert into tag (id, tag) values
(1, 'Fantasia'),
(2, 'Accion'),
(3, 'Aventura'),
(4, 'Comedia romántica'),
(5, 'Cine adolescente ');


-- pelis_tag
insert into peliculas_tag (id_pelicula, id_tag) values
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5);

-- Cuenta la cantidad de tags que tiene cada película. Si una película no tiene tags debe mostrar 0.

select p.nombre, count(pt.id_tag) as cantidad_tag
from peliculas p 
full outer join peliculas_tag pt on p.id = pt.id_pelicula
group by p.nombre
having p.nombre is null = '0'
order by cantidad_tag




