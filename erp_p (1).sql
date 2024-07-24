-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-07-2024 a las 00:22:42
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `busquedaInstructor` (IN `sp_palabraClase` VARCHAR(200))   BEGIN
 	SELECT * 
    FROM instructor
    WHERE instructor.nombres LIKE CONCAT('%', sp_palabraClase, '%') 
       OR instructor.apellido_p LIKE CONCAT('%', sp_palabraClase, '%')
       OR instructor.apellido_m LIKE CONCAT('%', sp_palabraClase, '%') 
       OR CONCAT(instructor.nombres, ' ', instructor.apellido_p) LIKE CONCAT('%', sp_palabraClase, '%')
       OR CONCAT(instructor.nombres, ' ', instructor.apellido_m) LIKE CONCAT('%', sp_palabraClase, '%')
       OR CONCAT(instructor.nombres,' ',instructor.apellido_p,' ',instructor.apellido_m) LIKE CONCAT('%',sp_palabraClase,'%');
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `busquedaSeminario` (IN `sp_clave` VARCHAR(500))   BEGIN
    	SELECT * FROM seminario 
        WHERE
        seminario.nombre LIKE CONCAT('%',sp_clave,'%') OR
        seminario.fecha_inicio LIKE CONCAT('%',sp_clave,'%')OR
        seminario.fecha_final LIKE CONCAT('%',sp_clave,'%')OR
        seminario.hora_total LIKE CONCAT('%',sp_clave,'%')OR
        seminario.modalidad LIKE CONCAT('%',sp_clave,'%');
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `busquedaUser` (IN `sp_pClave` VARCHAR(50))   BEGIN
 	SELECT * 
    FROM usuarios
    WHERE usuarios.nombres LIKE CONCAT('%', sp_pClave, '%') 
       OR usuarios.apellidos LIKE CONCAT('%', sp_pClave, '%')
       OR usuarios.correo LIKE CONCAT('%', sp_pClave, '%') 
       OR CONCAT(usuarios.nombres, ' ', usuarios.apellidos) LIKE CONCAT('%', sp_pClave, '%');
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
        SELECT 'Alumno ya existe' AS mensaje;
    ELSE
        INSERT INTO Alumno (nombres, apellido_p, apellido_m, dni, email)
        VALUES (sp_nombres, sp_apellido_p, sp_apellido_m, sp_dni, sp_email);
        
        SELECT 'Alumno insertado correctamente' AS mensaje;
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
	DECLARE sp_contador INT;
   	SELECT COUNT(*) INTO sp_contador FROM alumno WHERE id_alumno = sp_idAlumno;
	IF sp_contador = 0 THEN
    	SELECT "No existe el alumno" AS mensaje;
    ELSE
		SELECT * FROM alumno WHERE id_alumno = sp_idAlumno;
    END IF;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCargoInstructorById` (IN `sp_id_cargo_instructor` INT)   BEGIN
    DECLARE sp_contador INT;
    
    SELECT COUNT(*) INTO sp_contador FROM cargo_instructor WHERE id_cargo_instructor = sp_id_cargo_instructor;
    
    IF sp_contador = 0 THEN
        SELECT "El cargo no existe" AS mensaje;
    ELSE
        SELECT * FROM cargo_instructor WHERE id_cargo_instructor = sp_id_cargo_instructor;
    END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCertificadoById` (IN `sp_id_certificado` INT)   BEGIN 
SELECT * FROM certificado WHERE certificado.id_certificado = sp_id_certificado;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCertificadoByIdAlumno` (IN `sp_id_alumno` INT)   BEGIN
	SELECT * FROM certificado WHERE pk_id_alumno = sp_id_alumno;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getCertificadoDetailsById` (IN `sp_id_certificado` INT)   BEGIN
    SELECT
        contenido_seminario.descripcion,
        seminario.nombre AS nombre_seminario,
        seminario.fecha_inicio,
        seminario.fecha_final,
        seminario.hora_total,
        seminario.modalidad,
        instructor1.nombres AS nombres_instructor1,
        instructor1.apellido_p AS apellido_p_i_1,
        instructor1.apellido_m AS apellido_m_i_1,
        instructor1.firma_instructor AS firma1,
        instructor2.nombres AS nombres_instructor2,
        instructor2.apellido_p AS apellido_p_i_2,
        instructor2.apellido_m AS apellido_m_i_2,
        instructor2.firma_instructor AS firma2,
        cargo_instructor.nombre AS nombre_CargoI,
        certificado.hora_fecha_creacion,
        certificado.codigo_qr,
        alumno.nombres AS nombres_alumno,
        alumno.apellido_p AS apellido_p_alumno,
        alumno.apellido_m AS apellido_m_alumno,
        usuarios.correo,
        usuarios.contrasena,
        usuarios.nombres AS nombres_usuario,
        usuarios.apellidos
    FROM 
        contenido_seminario
    INNER JOIN seminario ON contenido_seminario.pk_id_seminario = seminario.id_seminario
    INNER JOIN instructor AS instructor1 ON seminario.pk_id_instructor = instructor1.id_instructor
    INNER JOIN instructor AS instructor2 ON seminario.pk_id_instructor_2 = instructor2.id_instructor
    INNER JOIN cargo_instructor ON instructor1.pk_id_cargo_instructor = cargo_instructor.id_cargo_instructor
    INNER JOIN certificado ON contenido_seminario.pk_id_certificado = certificado.id_certificado
    INNER JOIN alumno ON certificado.pk_id_alumno = alumno.id_alumno
    INNER JOIN usuarios ON certificado.pk_id_usuario = usuarios.id_usuario
    WHERE 
        contenido_seminario.pk_id_certificado = sp_id_certificado;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `getInstructorById` (IN `sp_id_instructor` INT)   BEGIN
	DECLARE sp_contador INT;
	SELECT COUNT(*) INTO sp_contador FROM instructor WHERE id_instructor = sp_id_instructor;
    IF sp_contador = 0 THEN
    	SELECT "No existe un instructor con el id proporcionado " AS mensaje;
    ELSE 
    	SELECT * FROM instructor WHERE id_instructor = sp_id_instructor;
    END IF;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getInstructores` ()   BEGIN
	SELECT * FROM instructor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getQrCertificadoById` (IN `sp_id_certificado` INT)   BEGIN
    DECLARE sp_contador INT;
    
    SELECT COUNT(*) INTO sp_contador FROM certificado WHERE id_certificado = sp_id_certificado;
    
    IF sp_contador = 0 THEN
        SELECT "El certificado no existe" AS mensaje;
    ELSE
        SELECT codigo_qr FROM certificado WHERE id_certificado = sp_id_certificado;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getSeminarioById` (IN `sp_seminario` INT)   BEGIN 
    DECLARE sp_contador INT;
   	SELECT COUNT(*) INTO sp_contador FROM seminario WHERE id_seminario = sp_seminario;
    IF sp_contador = 0 THEN
    	SELECT "No se encontro un seminario con el id propocionado" AS mensaje;
     ELSE 
     	SELECT * FROM seminario WHERE id_seminario = sp_seminario;
     END IF ;
     END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getSeminarioFilter20` (IN `rango` INT)   BEGIN
    DECLARE limite INT;
    DECLARE minimo INT;

    SET limite = rango * 20;
    SET minimo = limite - 20;

    SELECT 
        seminario.nombre,
        seminario.fecha_inicio,
        seminario.fecha_final,
        seminario.hora_total,
        seminario.modalidad,
        instructor1.nombres AS nombres_instructor1,
        instructor1.apellido_p AS apellido_p_i_1,
        instructor1.apellido_m AS apellido_m_i_1,
        instructor2.nombres AS nombres_instructor2,
        instructor2.apellido_p AS apellido_p_i_2,
        instructor2.apellido_m AS apellido_m_i_2
    FROM seminario 
        INNER JOIN instructor AS instructor1 ON seminario.pk_id_instructor = instructor1.id_instructor
        INNER JOIN instructor AS instructor2 ON seminario.pk_id_instructor_2 = instructor2.id_instructor
    LIMIT minimo, 20;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserById` (IN `sp_id_user` INT)   BEGIN
    DECLARE sp_contador INT;
    
    SELECT COUNT(*) INTO sp_contador FROM usuarios WHERE id_usuario = sp_id_user;
    
    IF sp_contador = 0 THEN
        SELECT "No existe un usuario con tal id" AS mensaje;
    ELSE
        SELECT * FROM usuarios WHERE id_usuario = sp_id_user;
    END IF;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserFilter20` (IN `rango` INT)   BEGIN
    DECLARE limite INT;
    DECLARE minimo INT;
    
    SET limite = rango * 20;
    SET minimo = limite - 20;
    
    SELECT * FROM usuarios LIMIT minimo, 20;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateAlumno` (IN `sp_id_alumno` INT, IN `sp_nombres` VARCHAR(200), IN `sp_apellido_p` VARCHAR(200), IN `sp_apellido_m` VARCHAR(200), IN `sp_dni` INT, IN `sp_email` VARCHAR(200))   BEGIN
    DECLARE sp_Contador INT;

    SELECT COUNT(*) INTO sp_Contador FROM alumno WHERE id_alumno = sp_id_alumno;
    
    IF sp_Contador = 0 THEN
        SELECT "El id del alumno que intentas actualizar no existe" AS mensaje;
    ELSE
        UPDATE alumno
        SET
            nombres = IF(sp_nombres IS NOT NULL AND sp_nombres != '', sp_nombres, nombres),
        	apellido_p = IF(sp_apellido_p IS NOT NULL AND sp_apellido_p != '', sp_apellido_p, apellido_p),
        	apellido_m = IF(sp_apellido_m IS NOT NULL AND sp_apellido_m != '', sp_apellido_m, apellido_m),
       		dni = IF(sp_dni IS NOT NULL AND sp_dni != '', sp_dni, dni),
        	email = IF(sp_email IS NOT NULL AND sp_email != '', sp_email, email)
        WHERE id_alumno = sp_id_alumno;
        
        SELECT "Alumno actualizado correctamente" AS mensaje;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCargoInstructor` (IN `sp_id_cargo_instructor` INT, IN `sp_nombre_cargo` VARCHAR(200))   BEGIN 
    	DECLARE sp_contador INT;
        SELECT COUNT(*) INTO sp_contador FROM cargo_instructor WHERE id_cargo_instructor = sp_id_cargo_instructor;
        IF sp_contador = 0 THEN
        	SELECT "No existe el cargo del instructor" AS mensaje;
		ELSE
        	UPDATE cargo_instructor 
            	SET
                	nombre = IF(sp_nombre_cargo IS NOT null AND sp_nombre_cargo != '',sp_nombre_cargo,nombre)
                WHERE id_cargo_instructor = sp_id_cargo_instructor;
            SELECT "Se actualizo correctamente" AS mensaje;
       	END IF;
    END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateInstructor` (IN `sp_id_instructor` INT, IN `sp_nombres` VARCHAR(400), IN `sp_apellido_p` VARCHAR(200), IN `sp_apellido_m` VARCHAR(200), IN `sp_firma_instructor` VARCHAR(7000), IN `sp_pk_id_cargo_instructor` INT)   BEGIN
    DECLARE sp_contador INT;
    
    SELECT COUNT(*) INTO sp_contador FROM instructor WHERE id_instructor = sp_id_instructor;
    
    IF sp_contador = 0 THEN
        SELECT "El instructor no existe" AS mensaje;
    ELSE
        UPDATE instructor
        SET 
            nombres = IF(sp_nombres != '', sp_nombres, nombres),
            apellido_p = IF(sp_apellido_p != '', sp_apellido_p, apellido_p),
            apellido_m = IF(sp_apellido_m != '', sp_apellido_m, apellido_m),
            firma_instructor = IF(sp_firma_instructor != '', sp_firma_instructor, firma_instructor),
            pk_id_cargo_instructor = IF(sp_pk_id_cargo_instructor != '', sp_pk_id_cargo_instructor, pk_id_cargo_instructor)
        WHERE id_instructor = sp_id_instructor;
        
        SELECT "Se actualizó el instructor correctamente" AS mensaje;
    END IF;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateInstructorFirma` (IN `sp_id_instructor` INT, IN `sp_firmaInstructor` VARCHAR(7000))   BEGIN
    DECLARE sp_contador INT;
    
    SELECT COUNT(*) INTO sp_contador FROM instructor WHERE id_instructor = sp_id_instructor;
    
    IF sp_contador = 0 THEN
        SELECT "El instructor no existe" AS mensaje;
    ELSE
        UPDATE instructor
        SET firma_instructor = IF(sp_firmaInstructor IS NOT NULL AND sp_firmaInstructor!='',sp_firmaInstructor, firma_instructor)
        WHERE id_instructor = sp_id_instructor;
        
        SELECT "Se actualizó la firma correctamente" AS mensaje;
    END IF;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateQRCertificado` (IN `sp_id_certificado` INT, IN `sp_codigo_qr` VARCHAR(7000))   BEGIN
    DECLARE sp_Contador INT;

    SELECT COUNT(*) INTO sp_Contador FROM certificado WHERE id_certificado = sp_id_certificado;
    
    IF sp_Contador = 0 THEN
        SELECT "No existe el certificado" AS mensaje;
    ELSE
        UPDATE certificado
        SET
            codigo_qr = IF(sp_codigo_qr != '', sp_codigo_qr, codigo_qr)
        WHERE id_certificado = sp_id_certificado;
        
        SELECT "Certificado QR actualizado correctamente" AS mensaje;
    END IF;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateSeminario` (IN `sp_id_seminario` INT, IN `sp_nombre` VARCHAR(1000), IN `sp_fecha_inicio` DATE, IN `sp_fecha_final` DATE, IN `sp_horas_totales` INT, IN `sp_modalidad` VARCHAR(50), IN `sp_pk_id_instructor` INT, IN `sp_pk_id_instructor2` INT)   BEGIN
	DECLARE sp_contador INT;
	SELECT COUNT(*) INTO sp_contador FROM seminario WHERE id_seminario = sp_id_seminario;
    IF sp_contador = 0 THEN
    	SELECT "No existe un seminario con el id proporcionado" AS mensaje;
    ELSE
    	UPDATE seminario
        SET
        	nombre = IF(sp_nombre IS NOT NULL AND sp_nombre != '',sp_nombre,nombre),
           	fecha_inicio = IF(sp_fecha_inicio IS NOT NULL AND sp_fecha_inicio != '',sp_fecha_inicio,fecha_inicio),
            fecha_final = IF (sp_fecha_final IS NOT NULL AND sp_fecha_final != '', sp_fecha_final, fecha_final),
            hora_total = IF (sp_horas_totales IS NOT NULL AND sp_horas_totales != '', sp_horas_totales,hora_total),
            modalidad = IF(sp_modalidad IS NOT NULL AND sp_modalidad != '', sp_modalidad,modalidad),
            pk_id_instructor = IF(sp_pk_id_instructor IS NOT NULL AND sp_pk_id_instructor !='', sp_pk_id_instructor,pk_id_instructor),
            pk_id_instructor_2 = IF (sp_pk_id_instructor2 IS NOT NULL AND sp_pk_id_instructor2 != '' , sp_pk_id_instructor2, pk_id_instructor_2)
            	WHERE id_seminario = sp_id_seminario;
             SELECT "Seminario actualizado correctamente" AS mensaje;
         	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateUser` (IN `sp_id_user` INT, IN `sp_nombres` VARCHAR(300), IN `sp_apellidos` VARCHAR(300), IN `sp_correo` VARCHAR(100), IN `sp_contrasena` VARCHAR(100))   BEGIN
	DECLARE sp_contador INT;
	SELECT COUNT(*) INTO sp_contador FROM usuarios WHERE id_usuario = sp_id_user;
    IF sp_contador = 0 THEN
    	SELECT "El usuario no existe" AS mensaje;
    ELSE 
    	UPDATE usuarios
        	SET
        		nombres = IF(sp_nombres IS NOT NULL AND sp_nombres != '', sp_nombres, nombres),
        		apellidos = IF(sp_apellidos IS NOT NULL AND sp_apellidos != '', sp_apellidos, apellidos),
        		correo = IF(sp_correo IS NOT NULL AND sp_correo != '', sp_correo, correo),
        		contrasena = IF(sp_contrasena IS NOT NULL AND sp_contrasena != '', sp_contrasena, contrasena)
             WHERE id_usuario = sp_id_user;
         	SELECT "Usuario actualizado correctamente" AS mensaje;
     END IF;
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
(3, 'Mufito', 'Sullon', 'Velasquez', 48156752, 'mufito@gmail.com'),
(4, 'Angely', 'Huaranga', 'Hurtado', 74382123, 'angely@gmail.com');

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
(2, 'Instructor'),
(3, 'Instructor Expert');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `certificado`
--

CREATE TABLE `certificado` (
  `id_certificado` int(11) NOT NULL,
  `pk_id_alumno` int(11) NOT NULL,
  `pk_id_usuario` int(11) NOT NULL,
  `hora_fecha_creacion` datetime NOT NULL,
  `codigo_qr` varchar(5000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `certificado`
--

INSERT INTO `certificado` (`id_certificado`, `pk_id_alumno`, `pk_id_usuario`, `hora_fecha_creacion`, `codigo_qr`) VALUES
(1, 1, 1, '0000-00-00 00:00:00', ''),
(2, 1, 1, '0000-00-00 00:00:00', '');

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

--
-- Volcado de datos para la tabla `contenido_seminario`
--

INSERT INTO `contenido_seminario` (`id_contenido_seminario`, `descripcion`, `pk_id_seminario`, `pk_id_certificado`) VALUES
(1, 'Principios basicos de la termodinamica aplicado a la refrigeracion  y sistemas basicos de la refrigeracion', 1, 1),
(2, 'Parametros de diseño y dimensionamiento de cuartos frios, arquitectura de cuartos frios', 1, 1),
(3, 'Principales ganancias de calor y estimacion de carga termica', 1, 2),
(4, 'seleccion de equipos de refrigeracion2', 1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `instructor`
--

CREATE TABLE `instructor` (
  `id_instructor` int(11) NOT NULL,
  `nombres` varchar(400) NOT NULL,
  `apellido_p` varchar(200) NOT NULL,
  `apellido_m` varchar(200) NOT NULL,
  `firma_instructor` varchar(7000) DEFAULT NULL,
  `pk_id_cargo_instructor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `instructor`
--

INSERT INTO `instructor` (`id_instructor`, `nombres`, `apellido_p`, `apellido_m`, `firma_instructor`, `pk_id_cargo_instructor`) VALUES
(1, 'Mufito', 'Pérez', 'Peves', NULL, 1),
(2, 'Angely', 'Ccenta', 'FAS', NULL, 2);

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

--
-- Volcado de datos para la tabla `seminario`
--

INSERT INTO `seminario` (`id_seminario`, `nombre`, `fecha_inicio`, `fecha_final`, `hora_total`, `modalidad`, `pk_id_instructor`, `pk_id_instructor_2`) VALUES
(1, 'Aire acondicionado con refrigeracion comercial', '2024-07-01', '2024-07-24', 30, 'Presencial', 1, 2);

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
(1, 'josue.ccenta@refriperu.com.pe', '123456789', 'Renato', 'Ccenta Sullon');

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
  MODIFY `id_alumno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `cargo_instructor`
--
ALTER TABLE `cargo_instructor`
  MODIFY `id_cargo_instructor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `certificado`
--
ALTER TABLE `certificado`
  MODIFY `id_certificado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `contenido_seminario`
--
ALTER TABLE `contenido_seminario`
  MODIFY `id_contenido_seminario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `instructor`
--
ALTER TABLE `instructor`
  MODIFY `id_instructor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `seminario`
--
ALTER TABLE `seminario`
  MODIFY `id_seminario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
