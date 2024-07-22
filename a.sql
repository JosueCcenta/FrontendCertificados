DELIMITER //

CREATE PROCEDURE getCertificadoDetailsById (IN sp_id_certificado INT)
BEGIN
    SELECT
        contenido_seminario.id_contenido_seminario,
        contenido_seminario.descripcion AS descripcion_contenido,
        seminario.id_seminario,
        seminario.nombre AS nombre_seminario,
        seminario.fecha_inicio,
        seminario.fecha_final,
        seminario.hora_total,
        seminario.modalidad,
        instructor1.id_instructor AS pk_id_instructor1,
        instructor1.nombres AS nombre_instructor1,
        instructor1.apellido_p AS apellido_p_instructor1,
        instructor1.apellido_m AS apellido_m_instructor1,
        instructor2.id_instructor AS pk_id_instructor2,
        instructor2.nombres AS nombre_instructor2,
        instructor2.apellido_p AS apellido_p_instructor2,
        instructor2.apellido_m AS apellido_m_instructor2,
        cargo_instructor.nombre AS nombre_cargo_instructor,
        certificado.id_certificado,
        certificado.hora_fecha_creacion,
        certificado.codigo_qr,
        alumnos.id_alumno,
        alumnos.nombres AS nombres_alumno,
        alumnos.apellido_p AS apellido_p_alumno,
        alumnos.apellido_m AS apellido_m_alumno,
        alumnos.dni,
        usuarios.id_usuario,
        usuarios.correo,
        usuarios.contrasena,
        usuarios.nombres AS nombres_usuario,
        usuarios.apellidos
    FROM 
        certificado
    INNER JOIN contenido_seminario ON certificado.pk_id_contenido_seminario = contenido_seminario.id_contenido_seminario
    INNER JOIN seminario ON contenido_seminario.pk_id_seminario = seminario.id_seminario
    INNER JOIN instructor AS instructor1 ON seminario.pk_id_instructor = instructor1.id_instructor
    INNER JOIN instructor AS instructor2 ON seminario.pk_id_instructor2 = instructor2.id_instructor
    INNER JOIN cargo_instructor ON instructor1.pk_id_cargo_instructor = cargo_instructor.id_cargo_instructor
    INNER JOIN alumnos ON certificado.pk_id_alumno = alumnos.id_alumno
    INNER JOIN usuarios ON certificado.pk_id_usuario = usuarios.id_usuario
    WHERE certificado.id_certificado = sp_id_certificado;
END //

DELIMITER ;