CREATE DATABASE proyecto;

use proyecto;
create table usuario(
	idusuario int not null primary key,
    nombre varchar(50),
    email varchar(50),
    genero char
    );

create table curso(
	idcurso int not null primary key,
    nombre varchar(20),
    categoría varchar(20),
    url varchar(70),
    fecha_inicio date,
    fecha_fin date,
    precio int,
    año varchar(4),
    semestre varchar(10)
);    
    
create table profesor(
	idprofesor int not null primary key,
    idcurso int,
    nombre varchar(50),
    email varchar(50),
    telefono int,
    area_principal varchar(50),
    area_alterna varchar(50),
    foreign key (idcurso) references curso(idcurso)
);

create table estudiante(
	idestudiante int not null primary key,
    idusuario int,
    nombre varchar(50),
    email varchar(50),
    foreign key (idusuario) references usuario(idusuario)
);
create table administrador(
	id int not null primary key,
    nombre varchar(50),
    email varchar(50),
    idusuario int not null,
    foreign key (idusuario) references usuario (idusuario)
);

create table plataforma(
	idusuario int,
    idcurso int,
    ref_bancaria int,
    id_nodo int not null primary key,
    foreign key (idusuario) references usuario (idusuario),
    foreign key (idcurso) references curso(idcurso)
);

create table paga(
	idcurso int,
    idusuario int,
    contraseña varchar(50),
    matrícula varchar(50) not null primary key,
    foreign key (idcurso) references curso(idcurso),
    foreign key (idusuario) references usuario(idusuario)
);

create table material(
	idmaterial int not null primary key,
    idprofesor int,
    titulo varchar(30),
    descripcion varchar(100),
    foreign key (idprofesor) references profesor(idprofesor)
);
create table archivo_material(
	idmaterial int,
    idarchivo int,
    foreign key (idmaterial) references material(idmaterial),
    foreign key (idarchivo) references archivo(idarchivo)
);

create table archivo(
	idarchivo int not null primary key
);
create table tarea(
	idtarea int not null primary key,
    idprofesor int,
    archivo varchar(50),
    nombre varchar(50),
    descripcion varchar(100),
    fecha_creacion date,
    fecha_entrega date,
    puntaje int,
    foreign key (idprofesor) references profesor(idprofesor)
);
create table foro(
	idforo int not null primary key,
    idprofesor int,
    nombre varchar(50),
    descripcion varchar(100),
    fecha_comienzo date,
    fecha_final date,
    foreign key (idprofesor) references profesor(idprofesor)
);

create table participa_foro(
	idestudiante int,
    idforo int,
    foreign key (idestudiante) references estudiante(idestudiante),
    foreign key (idforo) references foro(idforo)
);
create table ver_material(
	idestudiante int,
    idmaterial int,
    foreign key (idestudiante) references estudiante(idestudiante),
    foreign key (idmaterial) references material(id)
);
create table ver_tarea(
	idestudiante int,
    idtarea int,
	foreign key (idestudiante) references estudiante(idestudiante),
    foreign key (idtarea) references tarea(idtarea)
    
);
create table mensaje(
	idmensaje int not null primary key,
    idforo int,
    foreign key (idforo) references foro(idforo),
    nombre varchar(50),
    descripcion varchar(100),
    foro varchar(50),
    idmensaje_respuesta int
);

INSERT INTO usuario (idusuario, nombre, email, genero)
VALUES
(1, 'Juan', 'juan@example.com', 'M'),
(2, 'Maria', 'maria@example.com', 'F'),
(3, 'Pedro', 'pedro@example.com', 'M');

INSERT INTO curso (idcurso, nombre, categoría, url, fecha_inicio, fecha_fin, precio, año, semestre)
VALUES
(4, 'Curso de Mat', 'Ma', 'https://www.example.com/matematicas', '2023-08-01', '2023-12-31', 100, '2023', 'Z'),
(5, 'Curso de Pro', 'In', 'https://www.example.com/programacion', '2023-07-01', '2023-11-30', 150, '2023', 'Y'),
(6, 'Curso de Mar', 'Ne', 'https://www.example.com/marketing', '2023-09-01', '2023-11-30', 80, '2023', 'X');

INSERT INTO profesor (idprofesor, idcurso, nombre, email, telefono, area_principal, area_alterna)
VALUES
(7, 4, 'Dr. García', 'garcia@example.com', 123456789, 'Álgebra', 'Cálculo'),
(8, 5, 'Ing. López', 'lopez@example.com', 987654321, 'Programación', 'Bases de Datos');

INSERT INTO estudiante (idestudiante, idusuario, nombre, email)
VALUES
(9, 1, 'Ana', 'ana@example.com'),
(10, 2, 'Luis', 'luis@example.com'),
(11, 3, 'Sofía', 'sofia@example.com');

INSERT INTO administrador (id, nombre, email, idusuario)
VALUES
(12, 'Admin', 'admin@example.com', 1);

INSERT INTO plataforma (idusuario, idcurso, ref_bancaria, id_nodo)
VALUES
(1, 4, 123456, 13),
(2, 5, 987654, 14);

INSERT INTO paga (idcurso, idusuario, contraseña, matrícula)
VALUES
(4, 1, 'contraseña1', 'MAT001'),
(5, 2, 'contraseña2', 'MAT002');




#Elaborar las siguientes consultas tanto en álgebra relacional como en SQL (documento PDF, archivo .sql e implementado en nube)

#1
SELECT CONCAT(usuario.nombre, ' ', usuario.apellido) AS nombre_completo, estudiante.idestudiante
FROM estudiante
JOIN usuario ON usuario.idusuario = estudiante.idusuario
JOIN plataforma ON plataforma.idusuario = estudiante.idusuario
JOIN curso ON curso.idcurso = plataforma.idcurso
WHERE curso.año = '2023' AND curso.semestre = 'Semestre 1'
ORDER BY usuario.nombre;

#2
SELECT estudiante.nombre 
FROM estudiante 
INNER JOIN usuario ON estudiante.idusuario = usuario.idusuario 
INNER JOIN plataforma ON estudiante.idusuario = plataforma.idusuario 
INNER JOIN curso ON plataforma.idcurso = curso.idcurso 
WHERE curso.año = '2023' AND curso.semestre = 'Semestre 1' AND curso.nombre = 'Nombre del curso';

#3
SELECT curso.nombre, curso.fecha_inicio, curso.fecha_fin
FROM curso
JOIN plataforma ON plataforma.idcurso = curso.idcurso
JOIN paga ON paga.idcurso = curso.idcurso
JOIN estudiante ON estudiante.idusuario = paga.idusuario
WHERE estudiante.idestudiante = [ID del estudiante]
AND curso.fecha_inicio BETWEEN [Fecha de inicio] AND [Fecha de fin]

#4 
SELECT profesor.idprofesor, profesor.nombre, curso.nombre 
FROM profesor 
JOIN curso 
ON profesor.idcurso = curso.idcurso 
WHERE curso.fecha_inicio <= CURDATE() AND curso.fecha_fin >= CURDATE();

#5
SELECT DISTINCT nombre, categoría FROM curso ORDER BY categoría;

#6
SELECT nombre_curso, valor_curso
FROM cursos
WHERE valor_curso BETWEEN 100000 AND 500000;

#7
SELECT u.id, u.nombre_completo
FROM usuarios u
LEFT JOIN matriculas m ON u.id = m.id_usuario
WHERE m.id_curso IS NULL AND m.anno = '2023' AND m.semestre = '1';

#8
SELECT nombre_curso, categoria FROM cursos WHERE categoria = 'Computación';

#9
SELECT nombre_tarea, descripcion, fecha_limite
FROM tareas
WHERE id_curso = 20;

#10
SELECT material_id, titulo, descripcion, fecha_publicacion, profesor_id, curso_id
FROM materiales
WHERE curso_id = 20 AND profesor_id = 'profesor_id'

#11
SELECT mensaje.id, usuario.nombre
FROM mensaje
INNER JOIN usuario ON mensaje.id_usuario = usuario.id
WHERE mensaje.id_foro = 15;

#12
SELECT c.nombre AS nombre_curso, c.id AS id_curso, COUNT(DISTINCT t.id) AS num_tareas_pendientes
FROM cursos c
INNER JOIN matriculas m ON c.id = m.id_curso
LEFT JOIN tareas t ON c.id = t.id_curso AND t.id NOT IN (SELECT id_tarea FROM entregas WHERE id_estudiante = m.id_estudiante)
WHERE m.id_estudiante = {ID_ESTUDIANTE} AND c.anio = {ANIO_ACTUAL} AND c.semestre = {SEMESTRE_ACTUAL}
GROUP BY c.id
HAVING num_tareas_pendientes > 0
ORDER BY nombre_curso ASC
