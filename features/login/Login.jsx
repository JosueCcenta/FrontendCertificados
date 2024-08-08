import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";

const Login = () => {
    const [colaborador, setColaborador] = useState(true);
    const toggleEgresado = () => {
        setColaborador(false);
    }
    const toggleColaborador = () => {
        setColaborador(true);
    }
    const handleSubmit = () => {
        document.querySelector('form').addEventListener('submit', e => {
            e.preventDefault()
            const data = Object.fromEntries(new FormData(e.target))
            console.log(data)
        })
    }

    return (
        <>
            <div className="main w-screen flex flex-col justify-items-center items-center bg-gray-100 h-screen">
                <div className="contenedor flex flex-col gap-2 justify-items-center items-center mt-4 border-2 border-gray-300 rounded-md bg-white">
                    <div className=" relative w-full mt-12 lg:w-48">
                        <img src="../../img/logo/ErpSinFondo.png" alt="" />
                    </div>
                    <div className="form mt-2 flex flex-col justify-items-center items-center bg-blue-900 text-white rounded-md w-80">
                        <div className="titulo m-4" id="idTitulo">
                            <h1>Escuela de Refrigeracion del Peru</h1>
                        </div>
                        <div className="selector flex gap-3">
                            <button className={`rounded-md w-32 ${colaborador ? 'bg-sky-400 sky-900' : 'border-sky-700 bg-sky-700 text-zinc-400'}`} onClick={toggleColaborador}>Colaborador</button>
                            <button className={` rounded-md w-32 ${colaborador ? 'border-sky-700 bg-sky-700 text-zinc-400' : 'bg-sky-400 slate-300'}`} onClick={toggleEgresado}>Egresado</button>
                        </div>
                        <h1 className="mt-3">Por favor ingresa tus credenciales:</h1>
                        <form onSubmit={handleSubmit} className="flex flex-col gap-2 mb-4">
                            <label>{ }</label>
                            <input type="text" placeholder={`${colaborador ? '  Correo electronico...' : '  Dni...'}`} className="rounded-md w-64 h-8 text-black mt-2" />
                            <label></label>
                            <input type="text" placeholder="  Contraseña..." className="rounded-md w-64 h-8 text-black" />
                            <button className="rounded-md bg-sky-400 mt-2 h-8">Iniciar Sesion</button>
                        </form>
                    </div>
                </div>

            </div >
        </>
    )
}


export default Login;