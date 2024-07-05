import React from "react";

export const Table = (json) => {
    return (
        <>
            <table>
                <thead>
                    <tr>
                        <th>Nombres</th>
                        <th>Apellido paterno</th>
                        <th>Apellido Materno</th>
                        <th>DNI</th>
                        <th>Correo</th>
                        <th>Contraseña</th>
                    </tr>
                </thead>
                <tbody>
                    {json.map((respuesta) => (
                        <tr>
                            <td>{respuesta.nombres}</td>
                            <td>{respuesta.apellido_p}</td>
                            <td>{respuesta.apellido_m}</td>
                            <td>{respuesta.dni}</td>
                            <td>{respuesta.email}</td>
                            <td>{respuesta.contrasena}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </>
    )
}