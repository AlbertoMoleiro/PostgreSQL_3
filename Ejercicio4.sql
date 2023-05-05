/* PostgreSQL - Sentencias a ejecutar manualmente, para eliminar una base de datos debes situarte en otra */
 DROP DATABASE IF EXISTS zoologico;
    CREATE DATABASE zoologico;
    \c zoologico;;

CREATE SEQUENCE seq_id_zoo;

CREATE TABLE ZOOS(
    id_zoo INTEGER PRIMARY KEY DEFAULT nextval('seq_id_zoo'),
    nombre VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    pais VARCHAR(100) NOT NULL,
    tamanho REAL NOT NULL,
    presupuesto_anual REAL NOT NULL
);

CREATE TABLE ESPECIES(
    id_especie SERIAL PRIMARY KEY,
    nombre_comun VARCHAR(100) NOT NULL,
    nombre_cientifico VARCHAR(100) NOT NULL,
    familia VARCHAR(100) NOT NULL,
    extinto BOOLEAN NOT NULL
);

CREATE TABLE ANIMALES(
    id_animal SERIAL PRIMARY KEY,
    sexo CHAR(1) NOT NULL CHECK (sexo IN ('M', 'H')),
    nacimiento DATE NOT NULL,
    pais_origen VARCHAR(100) NOT NULL,
    continente_origen VARCHAR(100) NOT NULL,
    id_especie INTEGER NOT NULL,
    id_zoo INTEGER NOT NULL,
    FOREIGN KEY (id_especie) REFERENCES ESPECIES(id_especie),
    FOREIGN KEY (id_zoo) REFERENCES ZOOS(id_zoo)
);
