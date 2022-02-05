
--no he terminado
CREATE TABLE
    vagon(
        numero_serie INT(10) UNSIGNED PRIMARY KEY NOT NULL,
        capacidad INT(2) NOT NULL,
        funcion VARCHAR(10) NOT NULL
    ) ENGINE = InnoDB;

CREATE TABLE
    tren(
        id INT(10) UNSIGNED PRIMARY KEY NOT NULL,
        combustible VARCHAR(10) NOT NULL,
        capacidad INT(3) NOT NULL,
        tipo VARCHAR(1) NOT NULL -- Segun profesor arco generico no lleva CF
    ) ENGINE = InnoDB;

CREATE TABLE
    posicionvagon(
        posicion INT(2) NOT NULL,
        FOREIGN KEY fk_p(numero_serie) REFERENCES vagon(numero_serie)
        ON DELETE CASCADE,
        FOREIGN KEY fk_p(id) REFERENCES tren(id)
        ON DELETE CASCADE
    ) ENGINE = InnoDB;

CREATE TABLE
    ciudad(
        nombre INT(6) UNSIGNED NOT NULL PRIMARY KEY, --{“Django”, “Kepler”, “Orion”}
        distancia INT(4) NOT NULL,
        altura INT(4) NOT NULL,
        temperatura_promedio INT(2) NOT NULL
    ) ENGINE = InnoDB;

CREATE TABLE
    ciudadxtren(
        precio INT(2) NOT NULL,
        FOREIGN KEY fk_p(nombre) REFERENCES ciudad(nombre)
        ON DELETE CASCADE,
        FOREIGN KEY fk_p(id) REFERENCES tren(id)
        ON DELETE CASCADE
    ) ENGINE = InnoDB;

CREATE TABLE
    empleado(
        documento INT(10) UNSIGNED PRIMARY KEY NOT NULL,
        nombre VARCHAR(100) NOT NULL,
        sueldo INT(4) NOT NULL,
        telefono VARCHAR(13),
        rol VARCHAR(1) --{“M”,”C”,”D”,”A”}
    ) ENGINE = InnoDB;

CREATE TABLE
    empleadoexterno(
        precio INT(10) PRIMARY KEY NOT NULL,
        nombre VARCHAR(100) NOT NULL
    ) ENGINE = InnoDB;



CREATE TABLE
    viaje(
        codigo INT(10) NOT NULL PRIMARY KEY,
        fecha DATE NOT NULL, --formato: YYYY-MM-DD
        hora TIME NOT NULL, --formato: hh:mm:ss
        maletas INT(1) NOT NULL,
        estado VARCHAR(10) NOT NULL, -- {“esperando”, “encurso”,”saliendo”,”terminado”}
        FOREIGN KEY fk_p(nombre) REFERENCES ciudad(nombre)
        ON DELETE CASCADE,
        FOREIGN KEY fk_p(id) REFERENCES tren(id)
        ON DELETE CASCADE
    ) ENGINE = InnoDB;


-- Para que exista un 
-- Para que haya un turno debe de haber un viaje y un empleado? 
CREATE TABLE
    turno(
        codigo INT(10) PRIMARY KEY NOT NULL,
        FOREIGN KEY fk_p(d_empleado) REFERENCES empleado(documento)
        ON DELETE CASCADE,
        FOREIGN KEY fk_p(c_viaje) REFERENCES viaje(documento)
        ON DELETE CASCADE,
    ) ENGINE = InnoDB;