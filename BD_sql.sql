CREATE TABLE
    vagon(
        numero_serie BIGINT PRIMARY KEY CHECK (
            numero_serie <= 9999999999 AND
            numero_serie >= 0
        ),
        capacidad TINYINT NOT NULL CHECK (
            capacidad <= 99 AND
            capacidad >= 0
        ),
        funcion VARCHAR(10) NOT NULL CHECK(funcion IN ("cocina", "mando", "pasajeros"))
    );

CREATE TABLE
    tren(
        id BIGINT PRIMARY KEY CHECK (
            id <= 9999999999 AND
            id >= 0
        ),
        combustible VARCHAR(10) NOT NULL,
        capacidad SMALLINT NOT NULL CHECK (
            capacidad >= 0 AND
            capacidad <= 999
        ),
        tipo VARCHAR(1) NOT NULL CHECK (tipo IN ("E", "C", "B"))
    );

CREATE TABLE
    posicionvagon(
        posicion TINYINT NOT NULL CHECK(
            posicion >= 0 AND
            posicion <= 99
        ),
        vagon BIGINT REFERENCES vagon(numero_serie)
        ON DELETE CASCADE,
        tren BIGINT REFERENCES tren(id)
        ON DELETE CASCADE,
        PRIMARY KEY (vagon, tren)
    );

CREATE TABLE
    ciudad(
        nombre VARCHAR(7) PRIMARY KEY CHECK (nombre IN ("Django", "Kepler", "Orion")),
        distancia SMALLINT NOT NULL CHECK(
            distancia >= 0 AND
            distancia <= 9999
        ),
        altura SMALLINT NOT NULL CHECK(
            altura >= 0 AND
            altura <= 9999
        ),
        temperatura_promedio TINYINT NOT NULL CHECK(
            temperatura_promedio >= -99 AND
            temperatura_promedio <= 99
        )
    );

CREATE TABLE
    ciudadxtren(
        precio TINYINT NOT NULL CHECK(
            precio >= 0 AND
            PRECIO <= 99
        ),
        tren BIGINT REFERENCES tren(id)
        ON DELETE CASCADE,
        ciudad VARCHAR(7) REFERENCES ciudad(nombre)
        ON DELETE CASCADE,
        PRIMARY KEY (tren, ciudad)
    );

CREATE TABLE
    empleado(
        documento BIGINT PRIMARY KEY CHECK (
            documento >= 0 AND
            documento <= 9999999999
        ),
        nombre VARCHAR(100) NOT NULL,
        sueldo SMALLINT NOT NULL CHECK(
            sueldo >= 0 AND
            sueldo <= 9999
        ),
        telefono VARCHAR(13),
        -- El telefono se debe guardar como varchar
        rol VARCHAR(1) CHECK (rol IN ("M", "C", "D", "A"))
    );

CREATE TABLE
    empleadoexterno(
        identifiacion BIGINT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL
    );

CREATE TABLE
    viaje(
        codigo BIGINT PRIMARY KEY (
            codigo >= 0 AND
            codigo <= 9999999999
        ),
        fecha DATE NOT NULL,
        -- formato: YYYY-MM-DD
        hora TIME NOT NULL,
        -- formato: hh:mm:ss
        maletas TINYINT NOT NULL CHECK(
            maletas >= 0 AND
            maletas < 10
        ),
        estado VARCHAR(10) NOT NULL CHECK(
            estado IN ("esperando", "encurso", "saliendo", "terminado")
        ),
        -- {“esperando”, “encurso”,”saliendo”,”terminado”}
        ciudad VARCHAR(7) REFERENCES ciudad(nombre)
        ON DELETE CASCADE,
        tren BIGINT REFERENCES tren(id)
        ON DELETE CASCADE,
        anterior BIGINT REFERENCES viaje(codigo)
        ON DELETE CASCADE
    );

CREATE TABLE
    turno(
        codigo BIGINT PRIMARY KEY CHECK(
            codigo >= 0 AND
            codigo <= 9999999999
        ),
        viaje BIGINT REFERENCES viaje(codigo)
        ON DELETE CASCADE,
        empleado BIGINT REFERENCES empleado(documento)
        ON DELETE CASCADE,
        empleadoexterno BIGINT REFERENCES empleadoexterno(identifiacion)
        ON DELETE CASCADE,
        CHECK( (
                empleado IS NULL AND
                empleadoexterno IS NOT NULL
            ) OR (
                empleadoexterno IS NULL AND
                empleado IS NOT NULL
            )
        ) --ver si funciona en sql
    );

CREATE TABLE
    usuario(
        cedula BIGINT PRIMARY KEY CHECK (
            cedula >= 0 AND
            cedula <= 9999999999
        ),
        nombre VARCHAR(100) NOT NULL,
        fecha_nacimiento DATE NOT NULL,
        -- formato: YYYY-MM-DD
        email VARCHAR(50) NOT NULL UNIQUE,
        telefono VARCHAR(13)
    );

CREATE TABLE
    tiquete(
        codigo BIGINT PRIMARY KEY CHECK (
            codigo >= 0 AND
            codigo <= 9999999999
        ),
        fecha_creacion DATE NOT NULL,
        -- puede ser null
        puntos INT NOT NULL,
        fecha_compra DATE,
        -- puede ser null
        vencimiento_reserva DATE,
        usuario BIGINT REFERENCES usuario(cedula)
        ON DELETE CASCADE,
        viaje BIGINT REFERENCES viaje(codigo)
        ON DELETE CASCADE
    );