import React, { useEffect, useState } from "react";
import { uploadFile } from "../../services/uploadFile";
import { Toaster, toast } from "sonner";
import { methodPost } from "../../services/postHTTP";

const APP_STATUS = {
    IDLE: 'idle',
    ERROR: 'error',
    READY_UPLOAD: 'ready_upload',
    UPLOADING: 'uploading',
    READY_USAGE: 'ready_usage',
    READY_SUBMIT_BD: 'ready_submit_bd',
    SUBMIT_BD: 'submit_bd'
};

const BUTTON_TEXT = {
    [APP_STATUS.READY_UPLOAD]: 'Subir Archivo',
    [APP_STATUS.UPLOADING]: 'Subiendo...',
    [APP_STATUS.READY_SUBMIT_BD]: 'Crear Certificados',
    [APP_STATUS.SUBMIT_BD]: 'Subiendo a la base'
};

const SubirArchivo = () => {
    const [appStatus, setAppStatus] = useState(APP_STATUS.IDLE);
    const [file, setFile] = useState(null);
    const [informacion, setInformacion] = useState(null);
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(null);
    const [validador, setValidador] = useState(false);
    const [respuesta, setRespuesta] = useState(null);
    const handleInputChange = (event) => {
        const file = event.target.files[0];
        if (file) {
            setFile(file);
            setAppStatus(APP_STATUS.READY_UPLOAD);
        }
    };

    const handleSubmit = async (event) => {
        event.preventDefault();
        if (appStatus !== APP_STATUS.READY_UPLOAD || !file) {
            return;
        }
        setAppStatus(APP_STATUS.UPLOADING);

        try {
            const { error, data } = await uploadFile(file);
            if (error) {
                setAppStatus(APP_STATUS.ERROR);
                toast.error(error.message);
                return;
            }
            setAppStatus(APP_STATUS.READY_USAGE);
            setInformacion(JSON.stringify(data.data, null, '\t'));
            toast.success('Archivo Subido Correctamente');
            setAppStatus(APP_STATUS.READY_SUBMIT_BD);
        } catch (error) {
            console.error('Error in handleSubmit:', error);
            setAppStatus(APP_STATUS.ERROR);
            toast.error('Error al procesar la solicitud');
        }
    };

    const handleDatabaseSubmit = async () => {
        setAppStatus(APP_STATUS.SUBMIT_BD);
        setValidador(true);
    };

    useEffect(() => {
        const fetchData = async () => {
            console.log("antes")
            const { response,loading, error } = methodPost("http://localhost:3000/alumno/search/","",clave);
            console.log(appStatus)
            if (appStatus === APP_STATUS.SUBMIT_BD && informacion) {
                setLoading(true);
                setError(null);

                try {
                    if (error) {
                        toast.error('Error haciendo la llamada');
                        setError(error.message);
                        setAppStatus(APP_STATUS.ERROR);
                    } else {
                        toast.success('Subida correcta de datos');
                        setRespuesta(response);
                        setAppStatus(APP_STATUS.SUBMIT_BD);
                    }
                } catch (error) {
                    console.error('Error en la llamada a methodPost:', error);
                    toast.error('Error al procesar la solicitud');
                    setError(error.message);
                    setAppStatus(APP_STATUS.ERROR);
                } finally {
                    setLoading(false);
                }
            }
        };
        fetchData();
    }, [validador]);

    const showButton = appStatus === APP_STATUS.READY_UPLOAD || appStatus === APP_STATUS.UPLOADING;
    const showButtonBd = appStatus === APP_STATUS.READY_SUBMIT_BD;
    console.log(respuesta)
    return (
        <>
            <Toaster />
            <h4>Subir el archivo CSV</h4>
            <form onSubmit={handleSubmit}>
                <label>
                    <input
                        disabled={appStatus === APP_STATUS.UPLOADING}
                        onChange={handleInputChange}
                        name="file"
                        type="file"
                        required
                        accept=".csv"
                    />
                </label>
                {showButton && (
                    <button disabled={appStatus === APP_STATUS.UPLOADING}>
                        {BUTTON_TEXT[appStatus]}
                    </button>
                )}
            </form>
            {showButtonBd && (
                <button onClick={handleDatabaseSubmit} disabled={loading || appStatus !== APP_STATUS.READY_SUBMIT_BD}>
                    {loading ? 'Enviando...' : BUTTON_TEXT[appStatus]}
                </button>
            )}
        </>
    );
};

export default SubirArchivo;
