import axios from "axios";
import { useState, useEffect } from 'react';

export const methodPost = (url, data) => {
    const [result, setResult] = useState(null);
    const [error, setError] = useState(null);
    const [loading, setLoading] = useState(null);
    console.log("inICIAR")
    useEffect(() => {
        axios.post(url, data)
            .then((response) => {
                setResult(JSON.stringify(response, null, '\t'));
            })
            .catch((err) => {
                setError(err);
            })
            .finally(() => {
                setLoading(false);
            });
    }, [url]);
    return { result, loading, error };

}