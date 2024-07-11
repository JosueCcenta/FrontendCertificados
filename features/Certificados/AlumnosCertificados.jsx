import React, { useEffect, useState } from "react";
import { useParams } from "react-router";

const Certificados = () => {
    const { data } = useParams();
    const [alumnos, setAlumnos] = useState([]);

    useEffect(() => {
        // Decodificar y parsear la cadena JSON recibida
        const decodedData = JSON.parse(decodeURIComponent(data));
        setAlumnos(decodedData);
    }, [data]);

    return (
        <>
            <h1>Certificados</h1>
            <table>
                <thead>
                    <tr>
                        <th>&nbsp;</th>
                        <th>Nombres</th>
                        <th>Apellido paterno</th>
                        <th>Apellido Materno</th>
                        <th>DNI</th>
                        <th>Correo</th>
                        <th>Tipo usuario</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    {alumnos.map((alumno) => (
                        <tr key={alumno.id_alumno}>
                            <td>{alumno.id_alumno}</td>
                            <td>{alumno.nombres}</td>
                            <td>{alumno.apellido_p}</td>
                            <td>{alumno.apellido_m}</td>
                            <td>{alumno.dni}</td>
                            <td>{alumno.email}</td>
                            <td>{alumno.id_tipo_usuario}</td>
                            <td>
                                <button onClick={() => deleteAlumno(alumno.id_alumno)}>Borrar</button>
                                {/* No necesitas el Link aquí */}
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </>
    );
};

export default Certificados;
