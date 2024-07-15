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
    READY_SUBMIT_BD: 'listo para subir a la base',
    SUBMIT_BD: 'subiendo a la base'
}

const BUTTON_TEXT = {
    [APP_STATUS.READY_UPLOAD]: 'Subir Archivo',
    [APP_STATUS.UPLOADING]: 'Subiendo...',
    [APP_STATUS.READY_SUBMIT_BD]: 'Crear Certificados',
    [APP_STATUS.SUBMIT_BD]: 'Subiendo a la base'
}

const SubirArchivo = () => {
    const [appStatus, setAppStatus] = useState(APP_STATUS.IDLE);
    const [file, setFile] = useState(null);
    const [Informacion, setInformacion] = useState(null);
    const [Validador, setValidador] = useState(false);
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
            setCount(data.data.length);
            toast.success('Archivo Subido Correctamente');
        } catch (error) {
            console.error('Error in handleSubmit:', error);
            setAppStatus(APP_STATUS.ERROR);
            toast.error('Error al procesar la solicitud');
        }
    };

    const changeState = () => {
        setAppStatus(APP_STATUS.SUBMIT_BD)
        toast.message(BUTTON_TEXT[appStatus])
    }

    useEffect(() => {
        if (appStatus === APP_STATUS.SUBMIT_BD) {
            setValidador(true);
        }
    }, [appStatus]);


    useEffect(() => {
        const { response,loading, error } = methodPost("http://localhost:3000/alumno", Informacion);
        if (error) {
            toast.error('Error haciendo la llamada');
        }
        if (response) {
            toast.success('Subida correcta de datos');
            setAppStatus(APP_STATUS.READY_SUBMIT_BD);
        }
        
    }, [Validador])


    useEffect(() => {
        if (Informacion !== null) {
            setAppStatus(APP_STATUS.READY_SUBMIT_BD);
            console.log(Informacion);
        }
    }, [Informacion]);

    const showButton = appStatus === APP_STATUS.READY_UPLOAD || appStatus === APP_STATUS.UPLOADING;
    const showButtonBd = appStatus === APP_STATUS.READY_SUBMIT_BD;

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
                {showButtonBd && (
                    <button onClick={changeState} disabled={appStatus !== APP_STATUS.READY_SUBMIT_BD}>
                        {BUTTON_TEXT[appStatus]}
                    </button>
                )}
            </form>
        </>
    );
}

export default SubirArchivo;





const handleDatabaseSubmit = async () => {
    setAppStatus(APP_STATUS.SUBMIT_BD);

};


useEffect(() => {
    const fetchData = async () => {
        if (appStatus === APP_STATUS.SUBMIT_BD && informacion) {
            setLoading(true);
            setError(null);
            try {
                const { response, error } = methodPost("http://localhost:3000/alumno", data);
                if (error) {
                    toast.error('Error haciendo la llamada');
                    setError(error.message);
                    setAppStatus(APP_STATUS.ERROR);
                } else {
                    toast.success('Subida correcta de datos');
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
}, [appStatus, informacion]);

