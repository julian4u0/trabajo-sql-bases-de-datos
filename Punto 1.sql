CREATE TABLE
    vagon(
        numero_serie NUMBER(10) PRIMARY KEY CHECK (
            numero_serie >= 0
        ),
        capacidad NUMBER(2) NOT NULL CHECK (
            capacidad >= 0
        ),
        funcion VARCHAR(10) NOT NULL CHECK(funcion IN ("cocina", "mando", "pasajeros"))
    );

CREATE TABLE
    tren(
        id NUMBER(10) PRIMARY KEY CHECK (
            id >= 0
        ),
        combustible VARCHAR(10) NOT NULL,
        capacidad NUMBER(3) NOT NULL CHECK (
            capacidad >= 0 
        ),
        tipo VARCHAR(1) NOT NULL CHECK (tipo IN ("E", "C", "B"))
    );

CREATE TABLE
    posicionvagon(
        posicion NUMBER(2) NOT NULL CHECK(
            posicion >= 0 
        ),
        vagon NUMBER(10) REFERENCES vagon(numero_serie)
        ON DELETE CASCADE,
        tren NUMBER(10) REFERENCES tren(id)
        ON DELETE CASCADE,
        PRIMARY KEY (vagon, tren)
    );

CREATE TABLE
    ciudad(
        nombre VARCHAR(7) PRIMARY KEY CHECK (nombre IN ("Django", "Kepler", "Orion")),
        distancia NUMBER(4) NOT NULL CHECK(
            distancia >= 0
        ),
        altura NUMBER(4) NOT NULL CHECK(
            altura >= 0 
        ),
        temperatura_promedio NUMBER(2) NOT NULL CHECK(
            temperatura_promedio >= -99 AND
            temperatura_promedio <= 99
        )
    );

CREATE TABLE
    ciudadxtren(
        precio NUMBER(2) NOT NULL CHECK(
            precio >= 0 
        ),
        tren NUMBER(10) REFERENCES tren(id)
        ON DELETE CASCADE,
        ciudad VARCHAR(7) REFERENCES ciudad(nombre)
        ON DELETE CASCADE,
        PRIMARY KEY (tren, ciudad)
    );

CREATE TABLE
    empleado(
        documento  NUMBER(10) PRIMARY KEY CHECK (
            documento >= 0 
        ),
        nombre VARCHAR(100) NOT NULL,
        sueldo NUMBER(4) NOT NULL CHECK(
            sueldo >= 0 
        ),
        telefono VARCHAR(13),
        rol VARCHAR(1) CHECK (rol IN ("M", "C", "D", "A"))
    );
    CREATE TABLE
    conductor (
        documento NUMBER(10) REFERENCES empleado(documento)
        ON DELETE CASCADE,
        licencia NUMBER(10) NOT NULL CHECK (
            licencia >= 0 
        )
    );
CREATE TABLE
    mecanico (
        documento NUMBER(10) REFERENCES empleado(documento)
        ON DELETE CASCADE,
        tarjeta_profesional NUMBER(10) NOT NULL CHECK (
            tarjeta_profesional >= 0 
        )
    );
CREATE TABLE
    cocinero (
        documento NUMBER(10) REFERENCES empleado(documento)
        ON DELETE CASCADE,
        fecha_graduacion DATE NOT NULL
    );

CREATE TABLE
    empleadoexterno(
        identificacion NUMBER(10) PRIMARY KEY CHECK(
            identificacion >= 0
        ),
        nombre VARCHAR(100) NOT NULL
    );

CREATE TABLE
    viaje(
        codigo NUMBER(10) PRIMARY KEY CHECK(
            codigo >= 0
        ),
        fecha DATE NOT NULL,

        hora TIME NOT NULL,

        maletas NUMBER(2) NOT NULL CHECK(
            maletas >= 0 AND
            maletas < 10
        ),
        estado VARCHAR(10) NOT NULL CHECK(
            estado IN ("esperando", "encurso", "saliendo", "terminado")
        ),

        ciudad VARCHAR(7) REFERENCES ciudad(nombre)
        ON DELETE CASCADE,
        tren NUMBER(10) REFERENCES tren(id)
        ON DELETE CASCADE,
        anterior NUMBER(10) REFERENCES viaje(codigo)
        ON DELETE CASCADE,
        conductor NUMBER(10) REFERENCES conductor(documento)
        ON DELETE CASCADE,
        conductor_externo NUMBER(10) REFERENCES empleadoexterno(identificacion)
        ON DELETE CASCADE,
        CHECK( (
                conductor IS NULL AND
                conductor_externo IS NOT NULL
            ) OR (
                conductor IS NOT NULL AND
                conductor_externo IS NULL 
            )
        )
    );

CREATE TABLE
    turno(
        codigo NUMBER(10) PRIMARY KEY CHECK(
            codigo >= 0 
        ),
        viaje NUMBER(10) REFERENCES viaje(codigo)
        ON DELETE CASCADE,
        empleado NUMBER(10) REFERENCES empleado(documento)
        ON DELETE CASCADE,
        empleadoexterno NUMBER(10) REFERENCES empleadoexterno(identificacion)
        ON DELETE CASCADE,
    );

CREATE TABLE
    usuario(
        cedula NUMBER(10) PRIMARY KEY CHECK (
            cedula >= 0 
        ),
        nombre VARCHAR(100) NOT NULL,
        fecha_nacimiento DATE NOT NULL,

        email VARCHAR(50) NOT NULL UNIQUE,
        telefono VARCHAR(13)
    );

CREATE TABLE
    tiquete(
        codigo NUMBER(10) PRIMARY KEY CHECK (
            codigo >= 0 
        ),
        fecha_creacion DATE NOT NULL,
        puntos NUMBER(4) NOT NULL,
        fecha_compra DATE,
        vencimiento_reserva DATE,
        usuario NUMBER(10) REFERENCES usuario(cedula)
        ON DELETE CASCADE,
        viaje NUMBER(10) REFERENCES viaje(codigo)
        ON DELETE CASCADE
    );

