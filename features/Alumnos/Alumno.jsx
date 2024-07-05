import React, { useState, useEffect } from "react";
import { methodGet } from "../../services/getHTTP";

const Alumnos = () => {
    const { data, loading, error } = methodGet('http://localhost:3000/alumnos');
    const [searchTerm, setSearchTerm] = useState('');

    if (loading) return <p>Loading...</p>;
    if (error) return <p>Error: {error.message}</p>;


    const deleteAlumno = (id_alumno) => {
        const { responseData, loading, error } = methodDelete("http://localhost:3000/alumno", id_alumno)
        console.log("Has borrado al alumno = " + idalumno);
        console.log(data)
    };

    return (
        <>
            <div className="search flex flex-row items-center">
                <input
                    className="border-2 border-blue-300 w-11/12"
                    type="text"
                    value={searchTerm}
                    onChange={(e) => setSearchTerm(e.target.value)}
                    placeholder="Search..."
                />
                <button>Buscar</button>
            </div>
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
                    {data.map((alumno) => (
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
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </>
    );
};

export default Alumnos;