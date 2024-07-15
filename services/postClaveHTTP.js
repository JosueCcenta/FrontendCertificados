import { useState, useEffect } from "react";
import axios from "axios";

export const useMethodPostClave = (url) => {
    const [response, setResponse] = useState([]); 
    const [error, setError] = useState(null); 
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchData = async () => {
            try {
                const resultado = await axios.post(url);
                setResponse(resultado.data); 
            } catch (err) {
                setError(err); 
            } finally {
                setLoading(false); 
            }
        };

        fetchData();
    }, [url]);

    return { response, loading, error };
};
