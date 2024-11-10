-- creacion tablas

create table preguntas(
	id int primary key, 
	pregunta varchar(255),
	respuesta_correcta varchar
);

create table usuarios (
	id int primary key,
	nombre varchar(255),
	edad int
);

create table respuestas (
	id int primary key,
	respuesta varchar (255),
	usuario_id int references usuarios(id) on delete cascade, -- 8. se le agrega el on delete cascade
	pregunta_id int references preguntas(id)

);
drop table respuestas

select * from preguntas; select * from usuarios; select * from respuestas;

-- Agrega 5 registros a la tabla preguntas, de los cuales: (1 punto)
insert into preguntas (id, pregunta, respuesta_correcta) values
(1, 'Escriba el primer numero del 1 al 5', 'Uno'),
(2, 'Escriba el segundo numero del 1 al 5', 'Dos'),
(3, 'Escriba el tercer numero del 1 al 5', 'Tres'),
(4, 'Escriba el cuarto numero del 1 al 5', 'Cuatro'),
(5, 'Escriba el quinto numero del 1 al 5', 'Cinco');

insert into usuarios (id, nombre, edad) values
(1, 'Juan', 25), 
(2, 'Marta', 35), 
(3, 'Enrique', 15), 
(4, 'Pancrasio', 65), 
(5, 'Dominique', 25);

insert into respuestas (id, respuesta, usuario_id, pregunta_id) values
(1, 'Uno', 1, 1), (2, 'Tres',1 , 2), (3, 'Cinco', 1, 3),  (4, 'Dos', 1, 4), (5, 'Cuatro', 1, 5),
(6, 'Uno', 2, 1), (7, 'Cinco', 2, 2), (8, 'Dos', 2, 3),  (9, 'Tres', 2, 4), (10, 'Cuatro', 2, 5),
(11, 'Cinco', 3, 1), (12,'Dos', 3, 2), (13, 'Cuatro', 3, 3), (14, 'Uno', 3, 4), (15, 'Tres', 3, 5),
(16, 'Tres', 4, 1), (17, 'Cinco', 4, 2), (18, 'Cuatro', 4, 3), (19, 'Uno', 4, 4), (20, 'Dos', 4, 5),
(21, 'Cuatro', 5, 1), (22, 'Cinco', 5, 2), (23, 'Uno', 5, 3), (24, 'Dos', 5, 4), (25, 'Tres', 5, 5);

-- a. 1. La primera pregunta debe ser contestada correctamente por dos usuarios distintos

select r.usuario_id, r.pregunta_id, p.pregunta, p.respuesta_correcta, r.respuesta as respuesta_usuario
from respuestas r
join preguntas p on r.pregunta_id = p.id
where p.id = 1 and r.respuesta = p.respuesta_correcta
group by r.usuario_id, r.pregunta_id, p.pregunta, p.respuesta_correcta, r.respuesta


-- b. 2. La pregunta 2 debe ser contestada correctamente por un usuario.
select r.usuario_id, r.pregunta_id, p.pregunta, p.respuesta_correcta, r.respuesta as respuesta_usuario
from respuestas r
join preguntas p on r.pregunta_id = p.id
where p.id = 2 and r.respuesta = p.respuesta_correcta
group by r.usuario_id, r.pregunta_id, p.pregunta, p.respuesta_correcta, r.respuesta

-- c. 3. Los otros dos registros deben ser respuestas incorrectas

select r.usuario_id, r.pregunta_id, p.pregunta, p.respuesta_correcta, r.respuesta as respuesta_usuario
from respuestas r
join preguntas p on r.pregunta_id = p.id
where r.usuario_id in (4, 5) and r.respuesta <> p.respuesta_correcta
group by r.usuario_id, r.pregunta_id, p.pregunta, p.respuesta_correcta, r.respuesta

--

-- 6. Cuenta la cantidad de respuestas correctas totales por usuario (independiente de la pregunta). (1 punto)
-- este codigo muestra solo 3 usuarios de 5, que tienen respuestas correctas
select r.usuario_id, count(*) as contador
from respuestas r
join preguntas p on r.pregunta_id = p.id
where r.respuesta = p.respuesta_correcta
group by r.usuario_id 

-- este codigo muestra todos los usuarios, independiente tengas correctas o no
select r.usuario_id, sum(case when r.respuesta = p.respuesta_correcta then 1 else 0 end) as contador_correctas
from respuestas r
join preguntas p on r.pregunta_id = p.id
group by r.usuario_id
order by r.usuario_id

-- 7. Por cada pregunta, en la tabla preguntas, cuenta cuántos usuarios tuvieron la respuesta correcta. (1 punto)
select p.id, p.pregunta, count(case when r.respuesta = p.respuesta_correcta then 1 end) as contador_usuarios
from preguntas p
join respuestas r on p.id = r.pregunta_id
group by p.id, p.pregunta
order by p.id

-- 8. Implementa borrado en cascada de las respuestas al borrar un usuario y borrar el primer usuario para probar la implementación. (1 punto)
delete from usuarios where id = 1
select * from usuarios
select * from respuestas

-- 9. Crea una restricción que impida insertar usuarios menores de 18 años en la base de datos.(1 punto)
alter table usuarios
add constraint check_edad check(edad >= 18) -- aplicar el alter me daba un error por un registro de edad 15
select * from usuarios
-- update para modificar edad de dicho usuario
update usuarios
set edad = 18
where id = 3

-- insert para comprobar la restriccion
insert into usuarios(id, nombre, edad) values
(6, 'Usuario Mayor', 24) -- debe realizar insert correctamente
insert into usuarios(id, nombre, edad) values
(7 'Usuario Menor', 16) --deberia dar error

-- 10. Altera la tabla existente de usuarios agregando el campo email con la restricción de único. (1 punto)
alter table usuarios
add column email varchar unique
select * from usuarios

update usuarios
set email = 'correo3@mail.com'
where id = 3

