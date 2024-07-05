import React, { useState, useEffect } from "react";
import { methodPost } from "../../services/postHTTP";

const MyComponent = () => {
    const [response, setResponse] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        const fetchData = async () => {
            try {
                const result = await methodPost('http://localhost:3000/alumno/getbyid/', {"id_alumno": 9});
                setResponse(result);
                setLoading(false);
            } catch (error) {
                setError(error);
                setLoading(false);
            }
        };

        fetchData();
    }, []);

    if (loading) {
        return <p>Loading...</p>;
    }

    if (error) {
        return <p>Error: {error.message}</p>;
    }

    return (
        <div>
            <h1>Response Data:</h1>
            <pre>{JSON.stringify(response, null, 2)}</pre>
        </div>
    );
}

export default MyComponent;
