import React, { useState } from "react";
import {  useMethodGet } from "../../services/getHTTP"

const Instructores = () => {
    const [instructores, setInstructores] = useState(null);

    const { result, loading, error } = useMethodGet('http://localhost:3000/instructors');
    
    return (<>
        <form action="" className="flex flex-col">
            <input type="text" name="" id="" placeholder="Nombre..."/>
            <input type="text" name="" id="" placeholder="Apellido Paterno..."/>
            <input type="text" name="" id="" placeholder="Apellido Materno..."/>
            <input type="file" required accept=".png" name="" id="" placeholder="Input"/>
            <button type="submit">Crear Instructor</button>
        </form>
    </>)
}

export default Instructores;