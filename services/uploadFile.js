export const uploadFile = async (file) => {
    const formData = new FormData();
    formData.append('file', file);

    try {
        const res = await fetch('http://localhost:3000/file/convert', {
            method: 'POST',
            body: formData
        });

        if (!res.ok) {
            return { error: `Error uploading file: ${res.statusText}`, data: null };
        }

        const json = await res.json();
        return { error: null, data: json };
    } catch (error) {
        if (error instanceof Error) {
            return { error: error.message, data: null };
        } else {
            return { error: 'Unknown Error', data: null };
        }
    }
};
