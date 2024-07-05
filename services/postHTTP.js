import axios from "axios";
import { useState, useEffect } from 'react';

export const methodPost = (url, data) => {
    const [response, setResponse] = useState(null);
    const [error, setError] = useState(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        setLoading(true);
        axios.post(url, data)
            .then((response) => {
                setResponse(response.data);
            })
            .catch((err) => {
                setError(err);
            })
            .finally(() => {
                setLoading(false);
            });
    }, [url, data]);

    return { response, loading, error };
}
