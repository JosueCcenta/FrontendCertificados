import { useState, useEffect } from "react";
import axios from "axios";

export const useMethodPostClave = (url, postData) => {
    const [response, setResponse] = useState([]);
    const [error, setError] = useState(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        try {
            const resultado = axios.post(url, postData);
            setResponse(resultado.data);
        } catch (err) {
            setError(err);
        } finally {
            setLoading(false);
        }

    }, [url]);

    return { response, loading, error };
};
