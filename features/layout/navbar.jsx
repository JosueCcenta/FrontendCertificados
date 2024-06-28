import React from "react"
import { Link } from "react-router-dom";

const Navbar = () => {
    return (
        <>
            <nav className="p-0 m-0 ml-0"> 
                <ul className="items-center flex  flex-row gap-3 text-sm">
                    <li>
                        <Link to={'/Home'}>Home</Link>

                    </li>
                    <li>
                        <Link to={'/submit-CSV'}>Subir Archivo</Link>
                    </li>
                    <li>
                        Certificados
                        <ul>
                            <li>
                                <Link>Generar Certificado</Link>
                            </li>

                        </ul>
                    </li>
                    <li>
                        Alumnos
                    </li>
                    <li>
                        Instructor
                        <ul>
                        </ul>
                    </li>
                    <li>
                        Tipo usuario
                    </li>
                    <li>
                        Usuarios
                    </li>
                    <li>
                        Seminario
                        <ul>
                            <li>
                                Crear contenido Seminario
                            </li>
                            <li>
                                Ver Seminarios
                            </li>
                            <li>
                                Ver contenidos Seminarios
                            </li>
                        </ul>
                    </li>
                </ul>
            </nav>

        </>
    )
}

export default Navbar;