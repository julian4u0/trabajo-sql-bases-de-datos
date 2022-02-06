

CREATE TABLE
    vagon(
        numero_serie BIGINT PRIMARY KEY ,
        capacidad TINYINT NOT NULL,
        funcion VARCHAR(10) NOT NULL
    );

CREATE TABLE
    tren(
        id BIGINT PRIMARY KEY ,
        combustible VARCHAR(10) NOT NULL,
        capacidad SMALLINT NOT NULL,
        tipo VARCHAR(1) NOT NULL
    );

CREATE TABLE
    posicionvagon(
        posicion TINYINT NOT NULL,
        vagon BIGINT REFERENCES vagon(numero_serie)
        ON DELETE CASCADE,
        tren BIGINT REFERENCES tren(id)
        ON DELETE CASCADE,
        PRIMARY KEY (vagon,tren)
    );

CREATE TABLE
    ciudad(
        nombre VARCHAR(7) PRIMARY KEY, -- {“Django”, “Kepler”, “Orion”}
        distancia SMALLINT NOT NULL,
        altura SMALLINT NOT NULL,
        temperatura_promedio TINYINT NOT NULL
    );

CREATE TABLE
    ciudadxtren(
        precio TINYINT NOT NULL,
        tren BIGINT REFERENCES tren(id)
        ON DELETE CASCADE,
        ciudad VARCHAR(7) REFERENCES ciudad(nombre)
        ON DELETE CASCADE,
        PRIMARY KEY (tren,ciudad)
    );

CREATE TABLE
    empleado(
        documento BIGINT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        sueldo SMALLINT NOT NULL,
        telefono VARCHAR(13),
        rol VARCHAR(1) -- {“M”,”C”,”D”,”A”}
    );

CREATE TABLE
    empleadoexterno(
        identifiacion BIGINT PRIMARY KEY ,
        nombre VARCHAR(100) NOT NULL
    );



CREATE TABLE
    viaje(
        codigo BIGINT PRIMARY KEY,
        fecha DATE NOT NULL, -- formato: YYYY-MM-DD
        hora TIME NOT NULL, -- formato: hh:mm:ss
        maletas TINYINT NOT NULL,
        estado VARCHAR(10) NOT NULL, -- {“esperando”, “encurso”,”saliendo”,”terminado”}
        ciudad VARCHAR(7) REFERENCES ciudad(nombre)
        ON DELETE CASCADE,
        tren BIGINT REFERENCES tren(id)
        ON DELETE CASCADE
    );

CREATE TABLE
    turno(
        codigo BIGINT PRIMARY KEY ,
        viaje BIGINT REFERENCES viaje(codigo)
        ON DELETE CASCADE,
        empleado BIGINT REFERENCES empleado(documento)
        ON DELETE CASCADE,
        empleadoexterno BIGINT REFERENCES empleadoexterno(identifiacion)
        ON DELETE CASCADE,

        CHECK((empleado IS NULL AND empleadoexterno IS NOT NULL)
        OR 
        (empleadoexterno IS NULL AND empleado IS NOT NULL))

    );

CREATE TABLE
    usuario(
        cedula BIGINT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        fecha_nacimiento DATE NOT NULL, -- formato: YYYY-MM-DD
        email VARCHAR(50) NOT NULL,
        telefono VARCHAR(13)

    );

CREATE TABLE
    tiquete(
        codigo BIGINT PRIMARY KEY,
        fecha_creacion DATE NOT NULL, -- puede ser null
        puntos INT NOT NULL, 
        fecha_compra DATE, -- puede ser null
        vencimiento_reserva DATE,

        usuario BIGINT REFERENCES usuario(cedula)
        ON DELETE CASCADE,
        viaje BIGINT REFERENCES viaje(codigo)
        ON DELETE CASCADE
    );