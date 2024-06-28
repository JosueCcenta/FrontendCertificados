import React, { useState } from "react";
import { methodGet } from "../../services/getHTTP";
const Alumnos = () => {
    const { data, loading, error } = methodGet('http://localhost:3000/alumnos');
    const [searchTerm, setSearchTerm] = useState('');

    if (loading) return <p>Loading...</p>;
    if (error) return <p>Error: {error.message}</p>;




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
            <ul>
                {data.map((alumnos) => {
                    let { id_alumno, nombres, apellido_p, apellido_m, dni, email, contrasena, id_tipo_usuario } = alumnos;
                    console.log(nombres)
                })}
                
            </ul>
        </>
    );
};

export default Alumnos;
