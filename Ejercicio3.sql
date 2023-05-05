/* PostgreSQL - Sentencias a ejecutar manualmente, para eliminar una base de datos debes situarte en otra */
 DROP DATABASE IF EXISTS tienda_libros;
    CREATE DATABASE tienda_libros;
    \c tienda_libros;

CREATE SEQUENCE seq_id_coleccion;

CREATE TABLE COLECCIONES(
    id_coleccion INTEGER PRIMARY KEY DEFAULT nextval('seq_id_coleccion'),
    ISBN VARCHAR(13) UNIQUE NOT NULL,
    titulo VARCHAR(50) NOT NULL,
    editorial VARCHAR(50) NOT NULL,
    volumenes INTEGER NOT NULL
);

CREATE TABLE LIBROS(
    id_libro SERIAL PRIMARY KEY,
    ISBN VARCHAR(100) UNIQUE NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    editorial VARCHAR(100) NOT NULL,
    id_coleccion INTEGER NOT NULL,
    FOREIGN KEY (id_coleccion) REFERENCES COLECCIONES(id_coleccion)
);

CREATE TABLE SOCIOS(
    id_socio SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    dni VARCHAR(9) NOT NULL,
    id_socio_aval INTEGER,
    id_poblacion INTEGER NOT NULL,
    FOREIGN KEY (id_socio_aval) REFERENCES SOCIOS(id_socio)
);

CREATE TABLE POBLACIONES(
    id_poblacion SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_provincia INTEGER NOT NULL
);

CREATE TABLE PROVINCIAS(
    id_provincia SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_almacen_surte INTEGER NOT NULL
);

CREATE TABLE ALMACENES(
    id_almacen SERIAL PRIMARY KEY,
    fecha_fundacion DATE NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    id_poblacion INTEGER NOT NULL,
    FOREIGN KEY (id_poblacion) REFERENCES POBLACIONES(id_poblacion)
);

ALTER TABLE SOCIOS ADD FOREIGN KEY (id_poblacion) REFERENCES POBLACIONES(id_poblacion);
ALTER TABLE POBLACIONES ADD FOREIGN KEY (id_provincia) REFERENCES PROVINCIAS(id_provincia);
ALTER TABLE PROVINCIAS ADD FOREIGN KEY (id_almacen_surte) REFERENCES ALMACENES(id_almacen);

CREATE TABLE LIBROS_ALMACENES(
    id_libro INTEGER NOT NULL,
    id_almacen INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    FOREIGN KEY (id_libro) REFERENCES LIBROS(id_libro),
    FOREIGN KEY (id_almacen) REFERENCES ALMACENES(id_almacen),
    PRIMARY KEY (id_libro, id_almacen)
);

CREATE TABLE PEDIDOS(
    id_pedido SERIAL,
    forma_envío VARCHAR(100) NOT NULL,
    forma_pago VARCHAR(100) NOT NULL,
    id_socio INTEGER NOT NULL,
    FOREIGN KEY (id_socio) REFERENCES SOCIOS(id_socio),
    PRIMARY KEY (id_pedido, id_socio)
);

CREATE TABLE DETALLE_PEDIDOS(
    id_pedido INTEGER NOT NULL,
    id_socio INTEGER NOT NULL,
    id_libro INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    FOREIGN KEY (id_pedido,id_socio) REFERENCES PEDIDOS(id_pedido,id_socio),
    FOREIGN KEY (id_libro) REFERENCES LIBROS(id_libro),
    PRIMARY KEY (id_pedido,id_socio,id_libro)
);





