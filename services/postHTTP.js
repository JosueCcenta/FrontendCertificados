import axios from "axios";

export const methodPost = (url, data) => {
    var response = (null);
    var error = (null);
    var loading = (true);
    axios.post(url+clave)
        .then((result) => {
            response = result.data
            console.log(response)
        })
        .catch((err) => {
            error = err;
        })
        .finally(() => {
            loading = false;
        });

    return { response, loading, error };
}
