import React, { useEffect, useState } from "react";
import { useParams } from "react-router";
import { useMethodPostClave } from "../../services/postClaveHTTP";
import { Toaster, toast } from "sonner";
import Certificado from "./Certificado";

const Certificados = () => {
    const { data } = useParams();
    const [idAlumno, setIdAlumno] = useState(1);
    const [certificados, setCertificados] = useState([]);

    const APP_STATUS = {
        IDLE: 'idle',
        ERROR: 'error',
        READY_ID: 'ready_id',
        UPLOADING: 'uploading',
        READY_USAGE: 'ready_usage',
    };
    const [appStatus, setAppStatus] = useState(APP_STATUS.IDLE);
    
    useEffect(() => {
        const decodedData = JSON.parse(decodeURIComponent(data));
        setIdAlumno(decodedData);
        setAppStatus(APP_STATUS.READY_ID);
    }, [data]);

    const { response, loading, error } = useMethodPostClave(`http://localhost:3000/certificado/alumno/${idAlumno}`);
    
    useEffect(() => {
        setAppStatus(APP_STATUS.UPLOADING)
        if (response && response.certificado) {
            setCertificados(response.certificado);
        }
        setAppStatus(APP_STATUS.READY_USAGE)
    }, [response])

    useEffect(() => {
        if (error) {
            setAppStatus(APP_STATUS.ERROR)
            toast.error("Error: " + error.response.data.details[0].msg);
        }
    }, [error]);

    if (loading) return <p>Cargando...</p>;



    return (
        <>
            <Toaster />
            
                    {certificados.map(certificado => (
                        <tr key={certificado.id_certificado}>
                            {Certificado(certificado)}
                            <td>{certificado.id_certificado}</td>
                            <td>{certificado.nombre_seminario}</td>
                            <td>{`${certificado.nombre_instructor} ${certificado.apellido_p_instructor} ${certificado.apellido_m_instructor}`}</td>
                            <td>{certificado.descripcion_contenido}</td>
                        </tr>
                    ))}
        </>
    );
};

export default Certificados;
