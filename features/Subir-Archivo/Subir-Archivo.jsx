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
    READY_SUBMIT_BD: 'listo_para_subir_bd'
}

const BUTTON_TEXT = {
    [APP_STATUS.READY_UPLOAD]: 'Subir Archivo',
    [APP_STATUS.UPLOADING]: 'Subiendo...',
    [APP_STATUS.READY_SUBMIT_BD]: 'Crear Certificados'
}

function SubirArchivo() {
    const [appStatus, setAppStatus] = useState(APP_STATUS.IDLE);
    const [file, setFile] = useState(null);
    const [Informacion, setInformacion] = useState(null);
    const [Count, setCount] = useState(null);

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
                    <button disabled={appStatus !== APP_STATUS.READY_SUBMIT_BD}>
                        {BUTTON_TEXT[appStatus]}
                    </button>
                )}
            </form>
        </>
    );
}

export default SubirArchivo;
