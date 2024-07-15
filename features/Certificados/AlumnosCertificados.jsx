import React, { useEffect, useState } from "react";
import { useParams } from "react-router";
import { useMethodPostClave } from "../../services/postClaveHTTP";
import { Toaster, toast } from "sonner";

const Certificados = () => {
    const { data } = useParams();
    const [idAlumno, setIdAlumno] = useState(1);

    useEffect(() => {
        const decodedData = JSON.parse(decodeURIComponent(data));
        setIdAlumno(decodedData);
    }, [data]);

    const { response, loading, error } = useMethodPostClave(`http://localhost:3000/certificado/alumno/${idAlumno}`);


    if (loading) return <p>Cargando...</p>;

    if (error) {
        toast.error("Error : " + error.response.data.details[0].msg);
    }
    return (
        <div>
            <Toaster />
            {response && (
                <div>
                    <pre>{JSON.stringify(response, null, 2)}</pre>
                </div>
            )}
        </div>
    );
};

export default Certificados;
