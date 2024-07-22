-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-07-2024 a las 00:51:41
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `erp_p`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `busquedaAlumno` (IN `sp_pClave` VARCHAR(200))   BEGIN
    SELECT * 
    FROM alumno 
    WHERE alumno.nombres LIKE CONCAT('%', sp_pClave, '%') 
       OR alumno.apellido_p LIKE CONCAT('%', sp_pClave, '%') 
       OR alumno.apellido_m LIKE CONCAT('%', sp_pClave, '%')
       OR alumno.dni LIKE CONCAT('%', sp_pClave, '%') 
       OR alumno.email LIKE CONCAT('%', sp_pClave, '%')
       OR CONCAT(alumno.nombres, ' ', alumno.apellido_p) LIKE CONCAT('%', sp_pClave, '%') 
       OR CONCAT(alumno.nombres, ' ', alumno.apellido_m) LIKE CONCAT('%', sp_pClave, '%') 
       OR CONCAT(alumno.apellido_p, ' ', alumno.apellido_m) LIKE CONCAT('%', sp_pClave, '%');  
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `busquedaCargoInstructor` (IN `sp_pClave` VARCHAR(100))   BEGIN
	SELECT * FROM cargo_instructor WHERE cargo_instructor.nombre LIKE CONCAT('%', sp_pClave, '%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `createAlumno` (IN `sp_nombres` VARCHAR(200), IN `sp_apellido_p` VARCHAR(200), IN `sp_apellido_m` VARCHAR(200), IN `sp_dni` INT, IN `sp_email` VARCHAR(200))   BEGIN
    DECLARE sp_contador INT;
    
    SELECT COUNT(*) INTO sp_contador 
    FROM Alumno 
    WHERE nombres = sp_nombres AND 
          apellido_p = sp_apellido_p AND 
          apellido_m = sp_apellido_m OR
          dni = sp_dni OR 
          email = sp_email;
    
    IF sp_contador > 0 THEN
        SELECT sp_contador AS 'Alumno ya existe';
    ELSE
        INSERT INTO Alumno (nombres, apellido_p, apellido_m, dni, email)
        VALUES (sp_nombres, sp_apellido_p, sp_apellido_m, sp_dni, sp_email);
        
        SELECT 'Alumno insertado correctamente' AS 'Mensaje';
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `createCargoInstructor` (IN `sp_nombre` VARCHAR(200))   BEGIN
    DECLARE sp_contador INT;
    
    SELECT COUNT(*) INTO sp_contador FROM cargo_instructor WHERE nombre = sp_nombre;
    
    IF sp_contador > 0 THEN

	SELECT 'El cargo del instructor ya existe' AS Mensaje;
    ELSE
        INSERT INTO cargo_instructor (nombre)
        VALUES (sp_nombre);
        
        SELECT 'Cargo del instructor insertado correctamente' AS Mensaje;
    END IF;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `createCertificado` (IN `sp_id_alumno` INT, IN `sp_id_usuario` INT, IN `sp_datetime` DATETIME)   BEGIN
    INSERT INTO certificado(pk_id_alumno, pk_id_usuario, hora_fecha_creacion) 
    VALUES (sp_id_alumno, sp_id_usuario, sp_datetime);
    SELECT 'Certificado creado correctamente' AS Mensaje;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `createContenidoSeminario` (IN `sp_descripcion` VARCHAR(400), IN `sp_id_seminario` INT, IN `sp_id_certificado` INT)   BEGIN
    INSERT INTO contenido_seminario (descripcion, pk_id_seminario, pk_id_certificado)
    VALUES (sp_descripcion, sp_id_seminario, sp_id_certificado);
    
    SELECT 'Contenido de seminario insertado correctamente' AS Mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `createInstructor` (IN `sp_nombres` VARCHAR(400), IN `sp_apellido_p` VARCHAR(200), IN `sp_apellido_m` VARCHAR(200), IN `sp_id_cargo_instructor` INT)   BEGIN
    DECLARE sp_contador INT;
    
    SELECT COUNT(*) INTO sp_contador 
    FROM instructor 
    WHERE apellido_p = sp_apellido_p 
      AND apellido_m = sp_apellido_m;
      
    IF sp_contador > 0 THEN
        SELECT 'Instructor ya existe' AS mensaje;
    ELSE
        INSERT INTO instructor (nombres, apellido_p, apellido_m, pk_id_cargo_instructor) 
        VALUES (sp_nombres, sp_apellido_p, sp_apellido_m, sp_id_cargo_instructor);
        
        SELECT 'Instructor insertado correctamente' AS mensaje;
    END IF;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `createSeminario` (IN `sp_nombre` VARCHAR(1000), IN `sp_fecha_inicio` DATE, IN `sp_fecha_final` DATE, IN `sp_hora_total` INT, IN `sp_modalidad` VARCHAR(50), IN `sp_pk_id_instructor` INT, IN `sp_pk_id_instructor_2` INT)   BEGIN
    INSERT INTO seminario (nombre, fecha_inicio, fecha_final, hora_total, modalidad, pk_id_instructor, pk_id_instructor_2)
    VALUES (sp_nombre, sp_fecha_inicio, sp_fecha_final, sp_hora_total, sp_modalidad, sp_pk_id_instructor, sp_pk_id_instructor_2);

    SELECT "Se creo el seminario correctamente" AS mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `createUser` (IN `sp_correo` VARCHAR(200), IN `sp_contrasena` VARCHAR(200), IN `sp_nombres` VARCHAR(200), IN `sp_apellidos` VARCHAR(200))   BEGIN
	INSERT INTO usuarios(correo,contrasena,nombres,apellidos) VALUES (sp_correo,sp_contrasena,sp_nombres,sp_apellidos);
    SELECT "Usuario creado correctamente" AS mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAlumnoById` (IN `sp_idAlumno` INT)   BEGIN
	SELECT * FROM alumno WHERE id_alumno = sp_idAlumno;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getAlumnoFilter20` (IN `page` INT)   BEGIN
	DECLARE limite INT;
    DECLARE minimo INT;
    SET limite = page * 20;
    SET minimo = limite - 20;
    SELECT * FROM alumno LIMIT minimo, limite;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCargoInstructor` ()   BEGIN 
SELECT * FROM cargo_instructor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCargoInstructorById` (IN `sp_id_instructor` INT)   BEGIN
SELECT * FROM cargo_instructor WHERE id_cargo_instructor = sp_id_instructor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCertificadoById` (IN `sp_id_certificado` INT)   BEGIN 
SELECT * FROM certificado WHERE certificado.id_certificado = sp_id_certificado;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCertificadoFilter30` (IN `page` INT)   BEGIN
	DECLARE limite INT;
    DECLARE minimo INT;
    SET limite = page * 30;
    SET minimo = limite - 30;
    SELECT * FROM certificado LIMIT minimo, limite;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getContenidoSemByIdCertificado` (IN `sp_id_certificado` INT)   BEGIN 
SELECT * FROM contenido_seminario WHERE pk_id_certificado = sp_id_certificado;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumno`
--

CREATE TABLE `alumno` (
  `id_alumno` int(11) NOT NULL,
  `nombres` varchar(200) NOT NULL,
  `apellido_p` varchar(200) NOT NULL,
  `apellido_m` varchar(200) NOT NULL,
  `dni` int(11) NOT NULL,
  `email` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `alumno`
--

INSERT INTO `alumno` (`id_alumno`, `nombres`, `apellido_p`, `apellido_m`, `dni`, `email`) VALUES
(1, 'Josue', 'Ccenta', 'Sullon', 71381450, 'sullon.centa@gmail.com'),
(2, 'Renato', 'Ccenta', 'Sullon', 71381450, 'VXCV@gmail.com'),
(3, 'Mufito', 'Sullon', 'Velasquez', 48156752, 'mufito@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargo_instructor`
--

CREATE TABLE `cargo_instructor` (
  `id_cargo_instructor` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cargo_instructor`
--

INSERT INTO `cargo_instructor` (`id_cargo_instructor`, `nombre`) VALUES
(1, 'Coordinador Académico'),
(2, 'Instructor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `certificado`
--

CREATE TABLE `certificado` (
  `id_certificado` int(11) NOT NULL,
  `pk_id_alumno` int(11) NOT NULL,
  `pk_id_usuario` int(11) NOT NULL,
  `hora_fecha_creacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `certificado`
--

INSERT INTO `certificado` (`id_certificado`, `pk_id_alumno`, `pk_id_usuario`, `hora_fecha_creacion`) VALUES
(1, 1, 1, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contenido_seminario`
--

CREATE TABLE `contenido_seminario` (
  `id_contenido_seminario` int(11) NOT NULL,
  `descripcion` varchar(400) NOT NULL,
  `pk_id_seminario` int(11) NOT NULL,
  `pk_id_certificado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `instructor`
--

CREATE TABLE `instructor` (
  `id_instructor` int(11) NOT NULL,
  `nombres` varchar(400) NOT NULL,
  `apellido_p` varchar(200) NOT NULL,
  `apellido_m` varchar(200) NOT NULL,
  `firma_instructor` varchar(2000) DEFAULT NULL,
  `pk_id_cargo_instructor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seminario`
--

CREATE TABLE `seminario` (
  `id_seminario` int(11) NOT NULL,
  `nombre` varchar(1000) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_final` date NOT NULL,
  `hora_total` int(11) NOT NULL,
  `modalidad` varchar(50) NOT NULL,
  `pk_id_instructor` int(11) NOT NULL,
  `pk_id_instructor_2` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `contrasena` varchar(100) NOT NULL,
  `nombres` varchar(300) NOT NULL,
  `apellidos` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `correo`, `contrasena`, `nombres`, `apellidos`) VALUES
(1, 'josue.ccenta@refriperu.com.pe', '123456789', 'Josue Renato', 'Ccenta Sullon');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD PRIMARY KEY (`id_alumno`);

--
-- Indices de la tabla `cargo_instructor`
--
ALTER TABLE `cargo_instructor`
  ADD PRIMARY KEY (`id_cargo_instructor`);

--
-- Indices de la tabla `certificado`
--
ALTER TABLE `certificado`
  ADD PRIMARY KEY (`id_certificado`),
  ADD KEY `pk_id_alumno` (`pk_id_alumno`),
  ADD KEY `pk_id_usuario` (`pk_id_usuario`);

--
-- Indices de la tabla `contenido_seminario`
--
ALTER TABLE `contenido_seminario`
  ADD PRIMARY KEY (`id_contenido_seminario`),
  ADD KEY `pk_id_seminario` (`pk_id_seminario`),
  ADD KEY `pk_id_certificado` (`pk_id_certificado`);

--
-- Indices de la tabla `instructor`
--
ALTER TABLE `instructor`
  ADD PRIMARY KEY (`id_instructor`),
  ADD KEY `pk_id_car_instructor` (`pk_id_cargo_instructor`);

--
-- Indices de la tabla `seminario`
--
ALTER TABLE `seminario`
  ADD PRIMARY KEY (`id_seminario`),
  ADD KEY `pk_id_instructor` (`pk_id_instructor`),
  ADD KEY `pk_id_instructor_2` (`pk_id_instructor_2`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alumno`
--
ALTER TABLE `alumno`
  MODIFY `id_alumno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `cargo_instructor`
--
ALTER TABLE `cargo_instructor`
  MODIFY `id_cargo_instructor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `certificado`
--
ALTER TABLE `certificado`
  MODIFY `id_certificado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `contenido_seminario`
--
ALTER TABLE `contenido_seminario`
  MODIFY `id_contenido_seminario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `instructor`
--
ALTER TABLE `instructor`
  MODIFY `id_instructor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `seminario`
--
ALTER TABLE `seminario`
  MODIFY `id_seminario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `certificado`
--
ALTER TABLE `certificado`
  ADD CONSTRAINT `certificado_ibfk_1` FOREIGN KEY (`pk_id_alumno`) REFERENCES `alumno` (`id_alumno`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `certificado_ibfk_2` FOREIGN KEY (`pk_id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `contenido_seminario`
--
ALTER TABLE `contenido_seminario`
  ADD CONSTRAINT `contenido_seminario_ibfk_1` FOREIGN KEY (`pk_id_seminario`) REFERENCES `seminario` (`id_seminario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `contenido_seminario_ibfk_2` FOREIGN KEY (`pk_id_certificado`) REFERENCES `certificado` (`id_certificado`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `instructor`
--
ALTER TABLE `instructor`
  ADD CONSTRAINT `instructor_ibfk_1` FOREIGN KEY (`pk_id_cargo_instructor`) REFERENCES `cargo_instructor` (`id_cargo_instructor`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `seminario`
--
ALTER TABLE `seminario`
  ADD CONSTRAINT `seminario_ibfk_1` FOREIGN KEY (`pk_id_instructor`) REFERENCES `instructor` (`id_instructor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `seminario_ibfk_2` FOREIGN KEY (`pk_id_instructor_2`) REFERENCES `instructor` (`id_instructor`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
