import axios from "axios";
import { useState, useEffect } from "react";

export const methodDelete = (url) => {
    const [responseData, setResponseData] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        setLoading(true);
        axios.delete(url)
            .then((response) => {
                setResponseData(response.data);
            })
            .catch((err) => {
                setError(err);
            })
            .finally(() => {
                setLoading(false);
            });
    }, [url]);

    return { responseData, loading, error };
}