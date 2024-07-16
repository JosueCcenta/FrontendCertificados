import React, { useState, useEffect } from "react";
import { useMethodGet } from "../../services/getHTTP";
import { useMethodPostClave } from "../../services/postClaveHTTP";
import { Link } from 'react-router-dom';

const Alumnos = () => {
    const { data, loading, error } = useMethodGet('http://localhost:3000/alumnos');
    const [searchTerm, setSearchTerm] = useState("");
    const [respuesta, setRespuesta] = useState(null);

    const search = async (palabraClave) => {
        setSearchTerm(palabraClave);
        const { response, loading, error } = await useMethodPostClave("http://localhost:3000/alumno/search/", "", palabraClave);
        setRespuesta(response);
    };
    useEffect(() => {
        if (searchTerm !== "") {
            search(searchTerm);
        } else {
            setRespuesta(null);
        }
    }, [searchTerm]);


    const renderTable = () => {
        if (!respuesta) {
            return (
                <tbody className="">
                    {data.map((alumno) => (
                        <tr key={alumno.id_alumno}>
                            <td>{alumno.id_alumno}</td>
                            <td>{alumno.nombres}</td>
                            <td>{alumno.apellido_p} {alumno.apellido_m}</td>
                            <td>{alumno.dni}</td>
                            <td>{alumno.email}</td>
                            <td>{alumno.id_tipo_usuario}</td>
                            <td>
                                <button> <Link to={`/certificado/${encodeURIComponent(alumno.id_alumno)}`}>Ver Certificados</Link></button>
                            </td>
                        </tr>
                    ))}
                </tbody>
            );
        } else {
            return (
                <tbody>
                    {respuesta.map((alumno) => (
                        <tr key={alumno.id_alumno}>
                            <td>{alumno.id_alumno}</td>
                            <td>{alumno.nombres+alumno.apellido_p}</td>
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
            );
        }
    };

    if (loading) return <p>Loading...</p>;
    if (error) return <p>Error: {error.message}</p>;

    return (
        <>
            <div className="container font-sans text-sm">
                <div className="search flex flex-row items-center">
                    <input
                        className="border-2 border-blue-300 w-11/12"
                        type="text"
                        value={searchTerm}
                        onChange={(e) => setSearchTerm(e.target.value)}
                        placeholder="Search..."
                    />
                    <button onClick={() => search(searchTerm)}>Buscar</button>
                </div>
                <table className="w-full">
                    <thead className="border-2 border-black rounded-tl-2xl rounded-tr-5%">
                        <tr>
                            <th>&nbsp;</th>
                            <th>Nombres</th>
                            <th>Apellidos</th>
                            <th>DNI</th>
                            <th>Correo</th>
                            <th>Tipo usuario</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    {renderTable()}
                </table>
            </div>
        </>
    );
};

export default Alumnos;
