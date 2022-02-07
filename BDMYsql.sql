-- Borrado de Tablas
DROP TABLE vagon,tren,posicionvagon,ciudad,ciudadxtren;
DROP TABLE empleado,conductor,mecanico,cocinero,empleadoexterno;
DROP TABLE viaje,turno,usuario,tiquete


-- Creación de Tablas
CREATE TABLE
    vagon(
        numero_serie BIGINT PRIMARY KEY ,
        capacidad TINYINT NOT NULL,
        funcion VARCHAR(10) NOT NULL
    ) ENGINE = InnoDB;

CREATE TABLE
    tren(
        id BIGINT PRIMARY KEY ,
        combustible VARCHAR(10) NOT NULL,
        capacidad SMALLINT NOT NULL,
        tipo VARCHAR(1) NOT NULL
    ) ENGINE = InnoDB;

CREATE TABLE
    posicionvagon(
        posicion TINYINT NOT NULL,
        vagon BIGINT,
        FOREIGN KEY(vagon) REFERENCES vagon(numero_serie)
        ON DELETE CASCADE,
        tren BIGINT,
        FOREIGN KEY(tren) REFERENCES tren(id)
        ON DELETE CASCADE,
        PRIMARY KEY (vagon,tren)
    ) ENGINE = InnoDB;

CREATE TABLE
    ciudad(
        nombre VARCHAR(7) PRIMARY KEY, -- {“Django”, “Kepler”, “Orion”}
        CONSTRAINT nombrec CHECK(nombre='Django' OR nombre='Kepler' OR nombre='Orion'),
        distancia SMALLINT NOT NULL,
        altura SMALLINT NOT NULL,
        temperatura_promedio TINYINT NOT NULL
    ) ENGINE = InnoDB;

CREATE TABLE
    ciudadxtren(
        precio TINYINT NOT NULL,
        tren BIGINT,
        FOREIGN KEY(tren) REFERENCES tren(id)
        ON DELETE CASCADE,
        ciudad VARCHAR(7),
        FOREIGN KEY(ciudad) REFERENCES ciudad(nombre)
        ON DELETE CASCADE,
        PRIMARY KEY (tren,ciudad)
    ) ENGINE = InnoDB;

CREATE TABLE
    empleado(
        documento BIGINT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        sueldo SMALLINT NOT NULL,
        telefono VARCHAR(13),
        rol VARCHAR(1), -- {“M”,”C”,”D”,”A”}
        CONSTRAINT rolc CHECK(rol='M' OR rol='C' OR rol='D' OR rol='A' OR   rol IS NULL)
    ) ENGINE = InnoDB;

CREATE TABLE
    conductor (
        documento BIGINT,
        FOREIGN KEY(documento) REFERENCES empleado(documento)
        ON DELETE CASCADE,
        licencia BIGINT NOT NULL
        
    );
CREATE TABLE
    mecanico (
        documento BIGINT,
        FOREIGN KEY(documento) REFERENCES empleado(documento)
        ON DELETE CASCADE,
        tarjeta_profesional BIGINT NOT NULL 
        
    );
CREATE TABLE
    cocinero (
        documento BIGINT,
        FOREIGN KEY(documento) REFERENCES empleado(documento)
        ON DELETE CASCADE,
        fecha_graduacion DATE NOT NULL
    );

CREATE TABLE
    empleadoexterno(
        identificacion BIGINT PRIMARY KEY ,
        nombre VARCHAR(100) NOT NULL
    ) ENGINE = InnoDB;







CREATE TABLE
    viaje(
        codigo BIGINT PRIMARY KEY,
        fecha DATE NOT NULL, -- formato: YYYY-MM-DD
        hora TIME NOT NULL, -- formato: hh:mm:ss
        maletas TINYINT NOT NULL,
        estado VARCHAR(10) NOT NULL, -- {“esperando”, “encurso”,”saliendo”,”terminado”}
        CONSTRAINT estadoc CHECK(estado='esperando' OR estado='encurso' OR estado='saliendo' OR estado='terminado'),
        ciudad VARCHAR(7),
        FOREIGN KEY(ciudad) REFERENCES ciudad(nombre)
        ON DELETE CASCADE,
        tren BIGINT,
        FOREIGN KEY(tren) REFERENCES tren(id)
        ON DELETE CASCADE,
        anterior BIGINT,
        FOREIGN KEY(anterior) REFERENCES viaje(codigo)
        ON DELETE CASCADE,
        conductor BIGINT,
        FOREIGN KEY(conductor) REFERENCES conductor(documento)
        ON DELETE CASCADE,
        conductor_externo BIGINT,
        FOREIGN KEY(conductor_externo) REFERENCES empleadoexterno(identificacion)
        ON DELETE CASCADE,
        CONSTRAINT viaje CHECK ((conductor IS NULL AND conductor_externo IS NOT NULL) 
            OR ( conductor IS NOT NULL AND conductor_externo IS NULL ))

    ) ENGINE = InnoDB;
CREATE TABLE
    turno(
        codigo BIGINT PRIMARY KEY ,
        viaje BIGINT,
        FOREIGN KEY(viaje) REFERENCES viaje(codigo)
        ON DELETE CASCADE,
        empleado BIGINT,
        FOREIGN KEY(empleado) REFERENCES empleado(documento)
        ON DELETE CASCADE,
        empleadoexterno BIGINT,
        FOREIGN KEY(empleadoexterno) REFERENCES empleadoexterno(identificacion)
        ON DELETE CASCADE
    ) ENGINE = InnoDB;

CREATE TABLE
    usuario(
        cedula BIGINT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        fecha_nacimiento DATE NOT NULL, -- formato: YYYY-MM-DD
        email VARCHAR(50) NOT NULL,
        telefono VARCHAR(13)

    ) ENGINE = InnoDB;

CREATE TABLE
    tiquete(
        codigo BIGINT PRIMARY KEY,
        fecha_creacion DATE NOT NULL, -- puede ser null
        puntos INT NOT NULL, 
        fecha_compra DATE, -- puede ser null
        vencimiento_reserva DATE,

        usuario BIGINT,
        FOREIGN KEY(usuario) REFERENCES usuario(cedula)
        ON DELETE CASCADE,
        viaje BIGINT,
        FOREIGN KEY(viaje) REFERENCES viaje(codigo)
        ON DELETE CASCADE
    ) ENGINE = InnoDB;


-- Registros
-- vagones
INSERT INTO vagon VALUES(99999999, 75, "pasajeros");
INSERT INTO vagon VALUES(88888888, 70, "pasajeros");
INSERT INTO vagon VALUES(11111111, 35, "pasajeros");
INSERT INTO vagon VALUES(22233333, 20, "cocina");
INSERT INTO vagon VALUES(44445555, 10, "cocina");
INSERT INTO vagon VALUES(11111122, 50, "pasajeros");
INSERT INTO vagon VALUES(12121211, 3, "mando");
INSERT INTO vagon VALUES(32323232, 5, "mando");

-- ciudades

INSERT INTO ciudad VALUES("Kepler", 1500, 100, -5);
INSERT INTO ciudad VALUES("Django", 2000, 800, 12);
INSERT INTO ciudad VALUES("Orion", 5000, 2000, 30);

-- trenes
INSERT INTO tren VALUES(9939393, "gas", 600, "E");
INSERT INTO tren VALUES(3334444, "carbon", 100, "C");
INSERT INTO tren VALUES(6666666, "gas", 200, "C");
INSERT INTO tren VALUES(9999993, "litio", 300, "B");
INSERT INTO tren VALUES(4121212, "litio", 350, "B");
INSERT INTO tren VALUES(4444222, "gasolina", 800, "E");

-- ciudad x tren
INSERT INTO ciudadxtren VALUES(90, 9939393, "Kepler");
INSERT INTO ciudadxtren VALUES(30, 9939393, "Orion");
INSERT INTO ciudadxtren VALUES(10, 6666666, "Kepler");
INSERT INTO ciudadxtren VALUES(5, 9939393, "Django");
INSERT INTO ciudadxtren VALUES(95, 4121212, "Kepler");
INSERT INTO ciudadxtren VALUES(20, 4121212, "Django");
INSERT INTO ciudadxtren VALUES(25, 3334444, "Django");
INSERT INTO ciudadxtren VALUES(35, 3334444, "Orion");

-- posicionvagon
INSERT INTO posicionvagon VALUES(1,88888888, 6666666);
INSERT INTO posicionvagon VALUES(2,44445555, 6666666);
INSERT INTO posicionvagon VALUES(3,22233333, 6666666);
INSERT INTO posicionvagon VALUES(1,11111111, 9999993);
INSERT INTO posicionvagon VALUES(2,22233333, 9999993);
INSERT INTO posicionvagon VALUES(3,44445555, 9999993);
INSERT INTO posicionvagon VALUES(1,11111122, 4121212);
INSERT INTO posicionvagon VALUES(2,88888888, 4121212);
INSERT INTO posicionvagon VALUES(3,44445555, 4121212);

-- empleado
INSERT INTO empleado VALUES (33333353, "Juan Rallo Ramon", 9000, "3204892838", "C");
INSERT INTO empleado VALUES (90909090, "Rodolfo Hernandez Lisboa ", 4000, "3126293000", "M");
INSERT INTO empleado VALUES (44444422, "Mario Domingo Rojas", 2000, "321049333", "D");
INSERT INTO empleado VALUES (43783140, "Maria Guadalupe Perez", 4200, "3426299999", "D");
INSERT INTO empleado VALUES (47473248, "Vicente Garcia Lopez", 9400, "302629444", "M");
INSERT INTO empleado VALUES (90309843, "Pablo Gomez Lopera", 1450, "3006233300", "C");
INSERT INTO empleado VALUES (83247092, "Ivan Santiago Perea", 3000, "3116293000", "A");


-- empleadoexterno
INSERT INTO empleadoexterno VALUES(100130304, "Juan Ramon Gonzales");
INSERT INTO empleadoexterno VALUES(323232324, "Juan Daniel Lopera");
INSERT INTO empleadoexterno VALUES(666666666, "Pedro Pablo Lopez");
INSERT INTO empleadoexterno VALUES(111111111, "Daniel Rua Colorado");
INSERT INTO empleadoexterno VALUES(333333333, "Daniela Rossi Rodriguez");

-- conductor 
INSERT INTO conductor VALUES(44444422, 10003334);
INSERT INTO conductor VALUES(43783140, 10003940);
-- mecanico 
INSERT INTO mecanico VALUES(90909090, 33334444);
INSERT INTO mecanico VALUES(47473248, 33338801);
-- cocinero 
INSERT INTO cocinero VALUES(33333353, "1999-03-12");
INSERT INTO cocinero VALUES(90309843, "1998-10-27");

-- viaje 
INSERT INTO viaje VALUES(3000001, "2022-01-01", "11:30:00", 3, "terminado", "Kepler",6666666, NULL, NULL, 666666666);
INSERT INTO viaje VALUES(3000002, "2022-01-02", "12:30:00", 2, "terminado", "Orion",3334444, 3000001, 44444422, NULL);
INSERT INTO viaje VALUES(3000006, "2022-01-03", "13:30:00", 4, "terminado", "Kepler",3334444, 3000002, NULL, 666666666);
INSERT INTO viaje VALUES(3000007, "2022-01-04", "11:30:00", 8, "terminado", "Django",6666666, 3000006, 43783140, NULL);
INSERT INTO viaje VALUES(3000008, "2022-01-05", "10:30:00", 1, "encurso", "Django",9999993, 3000007, 44444422, NULL);
INSERT INTO viaje VALUES(3000009, "2022-01-06", "09:30:00", 0, "saliendo", "Kepler",4121212, 3000008, NULL, 333333333);
INSERT INTO viaje VALUES(3000011, "2022-01-06", "22:30:00", 2, "esperando", "Orion",4444222, 3000009, 44444422, NULL);
INSERT INTO viaje VALUES(3000012, "2022-01-06", "24:30:00", 5, "esperando", "Orion",3334444, 3000011, 43783140, NULL);


-- turnos
INSERT INTO turno VALUES (30303001, 3000001, 44444422, NULL);
INSERT INTO turno VALUES (30303002, 3000001, 83247092, NULL);
INSERT INTO turno VALUES (30303003, 3000001, 33333353, NULL);
INSERT INTO turno VALUES (30303004, 3000002, NULL, 333333333);
INSERT INTO turno VALUES (30303005, 3000002, 83247092, NULL);
INSERT INTO turno VALUES (30303006, 3000006, NULL, 333333333);
INSERT INTO turno VALUES (30303007, 3000006, 83247092, NULL);
INSERT INTO turno VALUES (30303008, 3000007, 43783140, NULL);
INSERT INTO turno VALUES (30303009, 3000007, 83247092, NULL);
INSERT INTO turno VALUES (30303010, 3000008, 43783140, NULL);
INSERT INTO turno VALUES (30303011, 3000008, 83247092, NULL);
INSERT INTO turno VALUES (30303012, 3000009, NULL, 323232324);
INSERT INTO turno VALUES (30303013, 3000009, 83247092, NULL);

-- usuarios
INSERT INTO usuario VALUES (11232134, "Juan Camilo Jaramillo", "2012-01-17", "juancara@gmail.com", "304010300");
INSERT INTO usuario VALUES (56653525, "Daniela Gomez Gomez", "2012-01-17", "danielagom@gmail.com", NULL);
INSERT INTO usuario VALUES (54375432, "Daniel Camilo Jaramillo", "2012-01-17", "daniielc@gmail.com", "312000030");
INSERT INTO usuario VALUES (43253263, "Miguel Polo Polo", "2012-01-17", "miguepolo@gmail.com", "300303349");
INSERT INTO usuario VALUES (65465455, "Gustavo Perez Jimenez", "2012-01-17", "gustavope@gmail.com", "310230130");
INSERT INTO usuario VALUES (98984322, "Alvaro Gomez Hurtado", "2012-01-17", "alvarogh@gmail.com", "333310233");

-- tiquete
INSERT INTO tiquete VALUES (3000010, "2019-02-02", 333, "2020-03-01", "2023-01-19", 98984322, 3000008);
INSERT INTO tiquete VALUES (3000012, "2018-03-22", 332, "2020-02-01", "2023-03-04", 98984322, 3000007);
INSERT INTO tiquete VALUES (3000013, "2019-02-12", 0, "2020-03-04", "2023-04-11", 56653525, 3000006);
INSERT INTO tiquete VALUES (3000015, "2018-02-02", 120, "2021-05-01", "2023-02-21", 56653525, 3000002);
INSERT INTO tiquete VALUES (3000016, "2020-02-02", 1, "2021-03-02", "2023-04-28", 43253263, 3000011);
INSERT INTO tiquete VALUES (3000017, "2020-02-02", 100, "2021-05-03", "2023-01-21", 43253263, 3000012);