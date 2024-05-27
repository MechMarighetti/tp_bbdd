# Crear y usar base de datos
CREATE DATABASE achuras;
USE achuras;

# Crear tablas
CREATE TABLE IF NOT EXISTS usuarios(
	id_usuario INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(255),
	apellido VARCHAR(255),
	dni int(8),
	mail VARCHAR(255),
	telefono INT(10)
);

CREATE TABLE IF NOT EXISTS canchas(
	id_cancha INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	capacidad INT(2),
	suelo VARCHAR(255),
	techo BOOLEAN,
	precio INT(6),
	activa BOOLEAN
);

CREATE TABLE IF NOT EXISTS administradores(
	id_administrador INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(255),
	apellido VARCHAR(255),
	dni int(8),
	mail VARCHAR(255),
	telefono INT(10)
);

CREATE TABLE IF NOT EXISTS reservas(
	id_reserva INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	id_usuario INT NOT NULL,
	id_cancha INT NOT NULL,
	id_administrador INT NOT NULL,
	FOREIGN KEY (id_usuario) REFERENCES achuras.usuarios(id_usuario),
	FOREIGN KEY (id_cancha) REFERENCES achuras.canchas(id_cancha),
	FOREIGN KEY (id_administrador) REFERENCES achuras.administradores(id_administrador),
	fecha DATE,
	hora TIME,
	precio INT(6),
	abonada BOOLEAN DEFAULT FALSE
);

# Insertar registros
INSERT INTO usuarios VALUES
(NULL, 'María', 'López', 12345678, 'maria.lopez@mail.com', 1194325678),
(NULL, 'Juan', 'Fernández', 87654321, 'juan.fernandez@mail.com', 1134679153),
(NULL, 'Ana', 'García', 11223344, 'ana.garcia@mail.com', 1152297651),
(NULL, 'Pedro', 'Martínez', 22334455, 'pedro.martinez@mail.com', 1168490142),
(NULL, 'Laura', 'Sánchez', 33445566, 'laura.sanchez@mail.com', 1102453829);

INSERT INTO canchas VALUES
(NULL, 10, 'Sintético', 0, 20000, 1),
(NULL, 10, 'Cemento', 1, 12000, 1),
(NULL, 14, 'Sintético', 1, 28000, 1),
(NULL, 14, 'Cemento', 0, 17000, 0),
(NULL, 22, 'Césped', 0, 44000, 1);

INSERT INTO administradores VALUES
(NULL, 'Agustín', 'Braco', 31586279, 'agustin.braco@mail.com', 1132546985),
(NULL, 'Ayelén', 'Corrillo', 85623417, 'ayelen.corrillo@mail.com', 1164058902),
(NULL, 'Claudio', 'Rodríguez', 52367918, 'claudio.rodriguez@mail.com', 1195090427),
(NULL, 'Daniel', 'Drago', 74531289, 'daniel.drago@mail.com', 1142360789),
(NULL, 'Justo', 'Fleitas', 41285673, 'justo.fleitas@mail.com', 1175069012),
(NULL, 'Mercedes', 'Marighetti', 96718523, 'mercedes.marighetti@mail.com', 1156078902),
(NULL, 'Tobías', 'Arraiza', 63489125, 'tomas.arraiza@mail.com', 1123045678);

INSERT INTO reservas VALUES
(NULL, 1, 3, 4, '2024-06-20', '15:00:00', 28000, FALSE),
(NULL, 2, 3, 2, '2024-06-05', '19:00:00', 28000, TRUE),
(NULL, 3, 1, 5, '2024-06-21', '12:00:00', 20000, FALSE),
(NULL, 4, 3, 1, '2024-06-12', '21:00:00', 28000, FALSE),
(NULL, 2, 2, 2, '2024-06-16', '12:00:00', 12000, TRUE),
(NULL, 5, 1, 3, '2024-06-03', '18:00:00', 20000, TRUE),
(NULL, 4, 2, 7, '2024-06-30', '13:00:00', 12000, TRUE);

# Consultas
# Total de canchas disponibles
SELECT COUNT(*) AS 'Canchas disponibles'
FROM canchas
WHERE activa = 1;

# Canchas disponibles según capacidad
SELECT canchas.capacidad AS 'Capacidad', canchas.suelo AS 'Suelo', canchas.precio AS 'Precio'
FROM canchas
WHERE activa = 1 && capacidad = 14;

# Reservas abonadas ordenadas por fecha y hora con administrador concatenado
SELECT reservas.id_cancha AS 'Cancha', reservas.fecha AS 'Fecha', reservas.hora AS 'Horario', CONCAT(administradores.nombre, ' ', administradores.apellido) AS 'Reservado por'
FROM reservas
INNER JOIN administradores ON reservas.id_administrador = administradores.id_administrador
WHERE reservas.abonada = 1
ORDER BY Fecha, Horario;