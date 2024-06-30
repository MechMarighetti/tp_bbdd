# Crear y usar base de datos
CREATE DATABASE achuras;
USE achuras;

# Crear tablas
CREATE TABLE IF NOT EXISTS usuarios(
	id_usuario INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	nombreUsuario VARCHAR(20),
	apellidoUsuario VARCHAR(20),
	dniUsuario int(8),
	mailUsuario VARCHAR(50),
	telefonoUsuario INT(12)
);

CREATE TABLE IF NOT EXISTS canchas(
	id_cancha INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	capacidad INT(2),
	FOREIGN KEY (id_tiposuelo) REFERENCES achuras.tipoDeSuelo(id_tiposuelo), INT(1),
	techo BOOLEAN,
	precio INT(6),
	disponible BOOLEAN 
);

CREATE TABLE IF NOT EXISTS tipoDeSuelo(
	id_tiposuelo INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	tipodesuelo VARCHAR (20),
);

CREATE TABLE IF NOT EXISTS administradores(
	id_administrador INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	nombreAdmin VARCHAR(20),
	apellidoAdmin VARCHAR(20),
	dniAdmin int(8),
	mailAdmin VARCHAR(50),
	telefonoAdmin INT(12)
);

CREATE TABLE IF NOT EXISTS reservas(
	id_reserva INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	id_usuario INT NOT NULL,
	id_cancha INT NOT NULL,
	id_administrador INT NOT NULL,
	id_estadoReserva INT NOT NULL,
	id_metodoPago INT NOT NULL,
	FOREIGN KEY (id_estadoReserva) REFERENCES achuras.estadoReserva(id_estadoReserva),
	FOREIGN KEY (id_metodoPago) REFERENCES achuras.metodoDePago(id_metodoPago),
	FOREIGN KEY (id_usuario) REFERENCES achuras.usuarios(id_usuario),
	FOREIGN KEY (id_cancha) REFERENCES achuras.canchas(id_cancha),
	FOREIGN KEY (id_administrador) REFERENCES achuras.administradores(id_administrador),
	fechaInicio DATETIME(),
	fechaFin DATETIME(),
	monto INT(6),
	seña INT(5),
);

CREATE TABLE IF NOT EXISTS metododePago(
	id_metodoPago INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	metodoPago VARCHAR (25),
);

CREATE TABLE IF NOT EXISTS estadoReserva(
	id_estadoReserva INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	estadoReserva VARCHAR (10),
);

# Insertar registros
INSERT INTO usuarios VALUES
(NULL, 'María', 'López', 12345678, 'maria.lopez@mail.com', 1194325678),
(NULL, 'Juan', 'Fernández', 87654321, 'juan.fernandez@mail.com', 1134679153),
(NULL, 'Ana', 'García', 11223344, 'ana.garcia@mail.com', 1152297651),
(NULL, 'Pedro', 'Martínez', 22334455, 'pedro.martinez@mail.com', 1168490142),
(NULL, 'Laura', 'Sánchez', 33445566, 'laura.sanchez@mail.com', 1102453829);

INSERT INTO canchas VALUES
(NULL, 10, 3, 0, 20000, 1),
(NULL, 10, 0, 1, 12000, 1),
(NULL, 14, 3, 1, 28000, 1),
(NULL, 14, 0, 0, 17000, 0),
(NULL, 22, 1, 0, 44000, 1);
(NULL, 14, 2, 0, 44000, 1);

INSERT INTO tipoDeSuelo VALUES
(NULL, 'Cemento'),
(NULL, 'Césped'),
(NULL, 'Flotante'),
(NULL, 'Sintético'),

INSERT INTO metodoDePago VALUES
(NULL, 'Efectivo'),
(NULL, 'Transferencia Bancaria'),
(NULL, 'Pago Electrónico'),
(NULL, 'Tarjetas de Crédito'),

INSERT INTO estadoReserva VALUES
(NULL, 'Anulada'),
(NULL, 'Cancelada'),
(NULL, 'Abonada'),
(NULL, 'Completada'),

INSERT INTO administradores VALUES
(NULL, 'Agustín', 'Braco', 31586279, 'agustin.braco@mail.com', 1132546985),
(NULL, 'Ayelén', 'Corrillo', 85623417, 'ayelen.corrillo@mail.com', 1164058902),
(NULL, 'Claudio', 'Rodríguez', 52367918, 'claudio.rodriguez@mail.com', 1195090427),
(NULL, 'Daniel', 'Drago', 74531289, 'daniel.drago@mail.com', 1142360789),
(NULL, 'Justo', 'Fleitas', 41285673, 'justo.fleitas@mail.com', 1175069012),
(NULL, 'Mercedes', 'Marighetti', 96718523, 'mercedes.marighetti@mail.com', 1156078902),
(NULL, 'Tobías', 'Arraiza', 63489125, 'tomas.arraiza@mail.com', 1123045678);

INSERT INTO reservas VALUES
(NULL, 1, 1, 1, 1, 1, 1, '2024-06-05-19:00:00', '2024-06-05-21:00:00', 20000, 10000 )
(NULL, 2, 1, 3, 1, 5, 2, '2024-06-07-15:00:00', '2024-06-07-18:00:00', 60000, 20000 )
(NULL, 1, 3, 2, 4, 1, 1, '2024-06-08-09:00:00', '2024-06-08-12:00:00', 66000, 40000 )
(NULL, 2, 1, 3, 3, 1, 0, '2024-06-09-21:00:00', '2024-06-09-23:00:00', 44000, 20000 )
	


# Consultas
# Total de canchas disponibles
SELECT COUNT(*) AS 'Canchas disponibles'
FROM canchas
WHERE disponible = 1;

# Canchas disponibles según capacidad
SELECT canchas.capacidad AS 'Capacidad', tipoDeSuelo.tipodesuelo AS 'Suelo', canchas.precio AS 'Precio'
FROM canchas
	INNER JOIN tipoDeSuelo ON canchas.id_tiposuelo = tipoDeSuelo.id_tiposuelo
WHERE disponible = 1 && capacidad = 14;

# Reservas abonadas ordenadas por fecha y hora con administrador concatenado
SELECT reservas.id_cancha AS 'Cancha', reservas.fecha AS 'Fecha', reservas.hora AS 'Horario', CONCAT(administradores.nombreAdmin, ' ', administradores.apellidoAdmin) AS 'Reservado por'
FROM reservas
INNER JOIN administradores ON reservas.id_administrador = administradores.id_administrador
WHERE reservas.abonada = 1
ORDER BY Fecha, Horario;
