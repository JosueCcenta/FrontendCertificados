import axios from "axios";

export const  useMethodPostClave = (url, data, clave) => {
    let response = null;
    let error = null;
    let loading = true;

    const postData = async () => {
        try {
            const result = await axios.post(url + clave, data);
            response = result.data; 
            console.log(response)
        } catch (err) {
            error = err;
        } finally {
            loading = false;
        }
    };
    postData();
   return () => ({
        response,
        loading,
        error
    });
}

