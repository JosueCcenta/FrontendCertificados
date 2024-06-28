import axios from "axios";
import { useState, useEffect } from 'react';

export const methodGet = (url) => {
    const [data, setData] = useState(null);
    const [error, setError] = useState(null);
    const [loading, setLoading] = useState(true);
    useEffect(() => {
        axios.get(url)
            .then((response) => {
                setData(response.data.alumnos);
            })
            .catch((err) => {
                setError(err);
            })
            .finally(() => {
                setLoading(false);
            });
    }, [url]);
    console.log(data)
    return { data, loading, error };
};
