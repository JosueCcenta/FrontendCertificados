import axios from "axios";
import { useState, useEffect } from 'react';

export const methodGet = (url) => {
    const [data, setData] = useState(null);
    const [error, setError] = useState(null);
    const [loading, setLoading] = useState(true);
    useEffect(() => {
        axios.get(url)
            .then((response) => {
                setData(JSON.stringify(response.data.alumnos,null,'\t'));
            })
            .catch((err) => {
                setError(err);
            })
            .finally(() => {
                setLoading(false);
            });
    }, [url]);

    return { data, loading, error };
};
