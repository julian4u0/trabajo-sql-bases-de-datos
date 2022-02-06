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
        numero_serie BIGINT FOREIGN KEY REFERENCES vagon(numero_serie)
        ON DELETE CASCADE,
        id BIGINT FOREIGN KEY REFERENCES tren(id)
        ON DELETE CASCADE
    );

CREATE TABLE
    ciudad(
        nombre VARCHAR(7) PRIMARY KEY, --{“Django”, “Kepler”, “Orion”}
        distancia SMALLINT NOT NULL,
        altura SMALLINT NOT NULL,
        temperatura_promedio TINYINT NOT NULL
    );

CREATE TABLE
    ciudadxtren(
        precio TINYINT NOT NULL,
        id BIGINT FOREIGN KEY REFERENCES tren(id)
        ON DELETE CASCADE,
        nombre VARCHAR(7) FOREIGN KEY REFERENCES ciudad(nombre)
        ON DELETE CASCADE
    );

CREATE TABLE
    empleado(
        documento BIGINT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        sueldo SMALLINT NOT NULL,
        telefono VARCHAR(13),
        rol VARCHAR(1) --{“M”,”C”,”D”,”A”}
    );

CREATE TABLE
    empleadoexterno(
        precio BIGINT PRIMARY KEY ,
        nombre VARCHAR(100) NOT NULL
    );



CREATE TABLE
    viaje(
        codigo BIGINT PRIMARY KEY,
        fecha DATE NOT NULL, --formato: YYYY-MM-DD
        hora TIME NOT NULL, --formato: hh:mm:ss
        maletas TINYINT NOT NULL,
        estado VARCHAR(10) NOT NULL, -- {“esperando”, “encurso”,”saliendo”,”terminado”}
        nombre VARCHAR(7) FOREIGN KEY REFERENCES ciudad(nombre)
        ON DELETE CASCADE,
        id BIGINT FOREIGN KEY REFERENCES tren(id)
        ON DELETE CASCADE
    );

CREATE TABLE
    turno(
        identificador BIGINT PRIMARY KEY ,
        documento BIGINT FOREIGN KEY REFERENCES empleado(documento)
        ON DELETE CASCADE,
        codigo BIGINT FOREIGN KEY REFERENCES viaje(codigo)
        ON DELETE CASCADE
    );
CREATE TABLE
    usuario(
        documento BIGINT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        fecha_nacimiento DATE NOT NULL,
        email VARCHAR(50) NOT NULL,
        telefono VARCHAR(13),

        
    );

CREATE TABLE
    tiquete(
        identificador BIGINT PRIMARY KEY NOT NULL,
        fecha_creacion DATE NOT NULL, --puede ser null
        puntos INT NOT NULL, 
        fecha_compra DATE, --puede ser null
        vencimiento_reserva DATE,

        documento BIGINT FOREIGN KEY REFERENCES usuario(documento)
        ON DELETE CASCADE,
        codigo BIGINT FOREIGN KEY REFERENCES viaje(codigo)
        ON DELETE CASCADE
    );