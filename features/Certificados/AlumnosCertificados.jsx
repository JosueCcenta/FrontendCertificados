import React, { useEffect, useState } from "react";
import { useParams } from "react-router";
import { useMethodPostClave } from "../../services/postClaveHTTP";
import { Toaster, toast } from "sonner";
import Certificado from "./Certificado";
const Certificados = () => {
    const { data } = useParams();
    const [idAlumno, setIdAlumno] = useState(1);
    const [certificados, setCertificados] = useState([]);

    useEffect(() => {
        const decodedData = JSON.parse(decodeURIComponent(data));
        setIdAlumno(decodedData);
    }, [data]);

    const { response, loading, error } = useMethodPostClave(`http://localhost:3000/certificado/alumno/${idAlumno}`);

    useEffect(() => {
        if (response && response.certificado) {
            setCertificados(response.certificado);
        }
    }, [response])

    useEffect(() => {
        if (error) {
            toast.error("Error: " + error.response.data.details[0].msg);
        }
    }, [error]);
    
    if (loading) return <p>Cargando...</p>;
    return (
        <>
            <Toaster />
            <table>
                <thead>
                    <tr>
                        <th>ID Certificado</th>
                        <th>Seminario</th>
                        <th>Instructor</th>
                        <th>Contenido</th>
                    </tr>
                </thead>
                <tbody>
                    {certificados.map(certificado => (
                        <tr key={certificado.id_certificado}>
                            <td>{certificado.id_certificado}</td>
                            <td>{certificado.nombre_seminario}</td>
                            <td>{`${certificado.nombre_instructor} ${certificado.apellido_p_instructor} ${certificado.apellido_m_instructor}`}</td>
                            <td>{certificado.descripcion_contenido}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
            {Certificado(response)}
        </>
    );
};

export default Certificados;
