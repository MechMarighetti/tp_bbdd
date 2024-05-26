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