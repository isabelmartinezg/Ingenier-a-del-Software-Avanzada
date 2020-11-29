/*
Created: 27/12/2019
Modified: 28/12/2019
Model: Diagrama de tablas 
Database: MySQL 8.0
*/

-- Create tables section -------------------------------------------------

-- Table Liga

CREATE TABLE `Liga`
(
  `temporada` Date NOT NULL,
  `nombre` Varchar(30),
  `idCategoria` Int NOT NULL
)
;

ALTER TABLE `Liga` ADD PRIMARY KEY (`temporada`, `idCategoria`)
;

-- Table Categoria

CREATE TABLE `Categoria`
(
  `idCategoria` Int NOT NULL,
  `comunidadAutonoma` Varchar(30),
  `sexo` Varchar(30),
  `nivel` Varchar(30),
  `division` Varchar(30)
)
;

ALTER TABLE `Categoria` ADD PRIMARY KEY (`idCategoria`)
;

-- Table Estadio

CREATE TABLE `Estadio`
(
  `idEstadio` Int NOT NULL,
  `nombreEstadio` Varchar(30),
  `ciudad` Varchar(30)
)
;

ALTER TABLE `Estadio` ADD PRIMARY KEY (`idEstadio`)
;

-- Table Jornada

CREATE TABLE `Jornada`
(
  `numeroJornada` Int NOT NULL,
  `temporada` Date NOT NULL,
  `idCategoria` Int NOT NULL
)
;

ALTER TABLE `Jornada` ADD PRIMARY KEY (`numeroJornada`, `temporada`, `idCategoria`)
;

-- Table RepresentanteFedFutbol

CREATE TABLE `RepresentanteFedFutbol`
(
  `dni_representanteFF` Char(9) NOT NULL,
  `nombre` Varchar(30),
  `primerApellido` Varchar(30),
  `segundoApellido` Varchar(30),
  `direccion` Varchar(40),
  `email` Varchar(40),
  `numeroTelefono` Varchar(9),
  `usuario` Varchar(30),
  `contraseña` Varchar(20)
)
;

ALTER TABLE `RepresentanteFedFutbol` ADD PRIMARY KEY (`dni_representanteFF`)
;

-- Table Sede

CREATE TABLE `Sede`
(
  `idSede` Int NOT NULL,
  `comunidadAutonoma` Varchar(30),
  `direccion` Varchar(40),
  `codigoPostal` Varchar(30)
)
;

ALTER TABLE `Sede` ADD PRIMARY KEY (`idSede`)
;

-- Table PresidenteFederacionArbitros

CREATE TABLE `PresidenteFederacionArbitros`
(
  `dni_presidenteFA` Varchar(9) NOT NULL,
  `nombre` Varchar(30),
  `primerApellido` Varchar(30),
  `segundoApellido` Varchar(30),
  `direccion` Varchar(40),
  `email` Varchar(40),
  `numeroTelefono` Varchar(9),
  `usuario` Varchar(30),
  `contraseña` Varchar(30)
)
;

ALTER TABLE `PresidenteFederacionArbitros` ADD PRIMARY KEY (`dni_presidenteFA`)
;

-- Table SancionAutomatica

CREATE TABLE `SancionAutomatica`
(
  `idSancion` Int NOT NULL,
  `motivo` Varchar(300),
  `tipo` Varchar(15),
  `castigo` Varchar(150),
  `aprobada` Bool,
  `dni` Varchar(9) NOT NULL
)
;

ALTER TABLE `SancionAutomatica` ADD PRIMARY KEY (`idSancion`, `dni`)
;

-- Table Empleado

CREATE TABLE `Empleado`
(
  `dni_empleado` Varchar(9) NOT NULL,
  `nombre` Varchar(30),
  `primerApellido` Varchar(30),
  `segundoApellido` Varchar(30),
  `direccion` Varchar(40),
  `email` Varchar(40),
  `numeroTelefono` Varchar(9),
  `area` Int,
  `usuario` Varchar(30),
  `contraseña` Varchar(30),
  `idSede` Int NOT NULL
)
;

CREATE INDEX `IX_sede_tiene` ON `Empleado` (`idSede`)
;

ALTER TABLE `Empleado` ADD PRIMARY KEY (`dni_empleado`)
;

-- Table Arbitro

CREATE TABLE `Arbitro`
(
  `dni_arbitro` Varchar(9) NOT NULL,
  `nombre` Varchar(30),
  `primerApellido` Varchar(30),
  `segundoApellido` Varchar(30),
  `direccion` Varchar(40),
  `email` Varchar(40),
  `numeroTelefono` Varchar(9),
  `ficha` Varchar(200),
  `prioridad` Varchar(4),
  `bajaDefinitiva` Bool,
  `usuario` Varchar(30),
  `contraseña` Varchar(30)
)
;

ALTER TABLE `Arbitro` ADD PRIMARY KEY (`dni_arbitro`)
;

-- Table Acta

CREATE TABLE `Acta`
(
  `idActa` Int NOT NULL,
  `estado` Varchar(30),
  `incidencias` Varchar(200),
  `idPartido` Int NOT NULL
)
;

ALTER TABLE `Acta` ADD PRIMARY KEY (`idActa`, `idPartido`)
;

-- Table Jugador

CREATE TABLE `Jugador`
(
  `dni_jugador` Varchar(9) NOT NULL,
  `nombre` Varchar(30),
  `primerApellido` Varchar(30),
  `segundoApellido` Varchar(30),
  `direccion` Varchar(40),
  `email` Varchar(40),
  `numeroTelefono` Varchar(9),
  `numero` Int,
  `idEquipo` Int
)
;

CREATE INDEX `IX_jugador_pertenece` ON `Jugador` (`idEquipo`)
;

ALTER TABLE `Jugador` ADD PRIMARY KEY (`dni_jugador`)
;

-- Table Equipo

CREATE TABLE `Equipo`
(
  `idEquipo` Int NOT NULL,
  `nombre` Varchar(30),
  `email` Varchar(30),
  `telefono` Varchar(9),
  `usuario` Varchar(30),
  `contraseña` Varchar(30),
  `idEstadio` Int NOT NULL
)
;

CREATE INDEX `IX_estadio_tiene` ON `Equipo` (`idEstadio`)
;

ALTER TABLE `Equipo` ADD PRIMARY KEY (`idEquipo`)
;

-- Table Partido

CREATE TABLE `Partido`
(
  `idPartido` Int NOT NULL,
  `fecha` Date,
  `hora` Datetime,
  `resultado` Varchar(30),
  `numeroPenaltis` Int,
  `numeroJornada` Int NOT NULL,
  `temporada` Date NOT NULL,
  `idCategoria` Int NOT NULL,
  `idEquipoLocal` Int NOT NULL,
  `idEquipoVisitante` Int NOT NULL,
  `dni_arbitroPrincipal` Varchar(9),
  `dni_asistente1` Varchar(9),
  `dni_asistente2` Varchar(9),
  `dni_cuartoArbitro` Varchar(9),
  `dni_suplente` Varchar(9)
)
;

CREATE INDEX `IX_asistente2` ON `Partido` (`dni_asistente2`)
;

CREATE INDEX `IX_jornada_tiene` ON `Partido` (`numeroJornada`, `temporada`, `idCategoria`)
;

CREATE INDEX `IX_suplente` ON `Partido` (`dni_suplente`)
;

CREATE INDEX `IX_cuartoArbitro` ON `Partido` (`dni_cuartoArbitro`)
;

CREATE INDEX `IX_asistente1` ON `Partido` (`dni_asistente1`)
;

CREATE INDEX `IX_arbitroPrincipal` ON `Partido` (`dni_arbitroPrincipal`)
;

CREATE INDEX `IX_equipoVisitante` ON `Partido` (`idEquipoVisitante`)
;

CREATE INDEX `IX_equipoLocal` ON `Partido` (`idEquipoLocal`)
;

ALTER TABLE `Partido` ADD PRIMARY KEY (`idPartido`)
;

-- Table Ausencia

CREATE TABLE `Ausencia`
(
  `idAusencia` Int NOT NULL,
  `justificante` Longtext,
  `tiempo` Int,
  `fechaInicio` Date,
  `fechaFin` Date,
  `dni` Varchar(9) NOT NULL
)
;

ALTER TABLE `Ausencia` ADD PRIMARY KEY (`idAusencia`, `dni`)
;

-- Table SancionEquipo

CREATE TABLE `SancionEquipo`
(
  `idSancion` Int NOT NULL,
  `motivo` Varchar(300),
  `tipo` Varchar(15),
  `castigo` Varchar(150),
  `idEquipo` Int NOT NULL
)
;

ALTER TABLE `SancionEquipo` ADD PRIMARY KEY (`idEquipo`, `idSancion`)
;

-- Table SancionArbitro

CREATE TABLE `SancionArbitro`
(
  `idSancion` Int NOT NULL,
  `motivo` Varchar(300),
  `tipo` Varchar(15),
  `castigo` Varchar(150),
  `dni` Varchar(9) NOT NULL
)
;

ALTER TABLE `SancionArbitro` ADD PRIMARY KEY (`dni`, `idSancion`)
;

-- Table SancionPorFedFutbol

CREATE TABLE `SancionPorFedFutbol`
(
  `idSancion` Int NOT NULL,
  `motivo` Varchar(300),
  `tipo` Varchar(15),
  `castigo` Varchar(150),
  `dni` Varchar(9) NOT NULL
)
;

ALTER TABLE `SancionPorFedFutbol` ADD PRIMARY KEY (`dni`, `idSancion`)
;

-- Table Jugador_Acta

CREATE TABLE `Jugador_Acta`
(
  `idActa` Int NOT NULL,
  `idPartido` Int NOT NULL,
  `dni` Varchar(9) NOT NULL,
  `tarjetasAmarillas` Int,
  `tarjetasRojas` Int,
  `minutoEntrada` Int,
  `minutoSalida` Int
)
;

-- Table Arbitro_Liga

CREATE TABLE `Arbitro_Liga`
(
  `temporada` Date NOT NULL,
  `idCategoria` Int NOT NULL,
  `dni` Varchar(9) NOT NULL
)
;

-- Create foreign keys (relationships) section -------------------------------------------------

ALTER TABLE `Liga` ADD CONSTRAINT `categoria_tiene` FOREIGN KEY (`idCategoria`) REFERENCES `Categoria` (`idCategoria`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Jornada` ADD CONSTRAINT `liga_tiene_jornada` FOREIGN KEY (`temporada`, `idCategoria`) REFERENCES `Liga` (`temporada`, `idCategoria`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Acta` ADD CONSTRAINT `partido_genera_acta` FOREIGN KEY (`idPartido`) REFERENCES `Partido` (`idPartido`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Ausencia` ADD CONSTRAINT `arbitro_tiene_ausencia` FOREIGN KEY (`dni`) REFERENCES `Arbitro` (`dni_arbitro`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Partido` ADD CONSTRAINT `asistente2` FOREIGN KEY (`dni_asistente2`) REFERENCES `Arbitro` (`dni_arbitro`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Empleado` ADD CONSTRAINT `sede_tiene` FOREIGN KEY (`idSede`) REFERENCES `Sede` (`idSede`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Partido` ADD CONSTRAINT `jornada_tiene` FOREIGN KEY (`numeroJornada`, `temporada`, `idCategoria`) REFERENCES `Jornada` (`numeroJornada`, `temporada`, `idCategoria`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Equipo` ADD CONSTRAINT `estadio_tiene` FOREIGN KEY (`idEstadio`) REFERENCES `Estadio` (`idEstadio`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Jugador` ADD CONSTRAINT `jugador_pertenece` FOREIGN KEY (`idEquipo`) REFERENCES `Equipo` (`idEquipo`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Partido` ADD CONSTRAINT `suplente` FOREIGN KEY (`dni_suplente`) REFERENCES `Arbitro` (`dni_arbitro`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Partido` ADD CONSTRAINT `cuartoArbitro` FOREIGN KEY (`dni_cuartoArbitro`) REFERENCES `Arbitro` (`dni_arbitro`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Partido` ADD CONSTRAINT `asistente1` FOREIGN KEY (`dni_asistente1`) REFERENCES `Arbitro` (`dni_arbitro`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Partido` ADD CONSTRAINT `arbitroPrincipal` FOREIGN KEY (`dni_arbitroPrincipal`) REFERENCES `Arbitro` (`dni_arbitro`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Partido` ADD CONSTRAINT `equipoVisitante` FOREIGN KEY (`idEquipoVisitante`) REFERENCES `Equipo` (`idEquipo`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `Partido` ADD CONSTRAINT `equipoLocal` FOREIGN KEY (`idEquipoLocal`) REFERENCES `Equipo` (`idEquipo`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `SancionEquipo` ADD CONSTRAINT `equipo_tiene` FOREIGN KEY (`idEquipo`) REFERENCES `Equipo` (`idEquipo`) ON DELETE RESTRICT ON UPDATE RESTRICT
;

ALTER TABLE `SancionArbitro` ADD CONSTRAINT `arbitro_tiene` FOREIGN KEY (`dni`) REFERENCES `Arbitro` (`dni_arbitro`) ON DELETE RESTRICT ON UPDATE RESTRICT
;


