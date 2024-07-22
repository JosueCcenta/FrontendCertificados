import { useEffect, useState } from "react";
import "./cert1Style.css"
const Certificado = (nombreApellidos, modalidad, titulo, ciudad, fecha_inicio, fecha_termino, año, horas_totales, ins1, cargoIns1, ins2, cargoIns2, contenidoCurso) => {

    /**nombreApellidos
     * modalidad
     * titulo
     *    const ciudad = "Lima"; falta 
    const fecha_inicio = "31 mayo";
    const fecha_termino = "05 julio";
    const año = "2024";
    const horas_totales = "30";
    const ins1 = "Ing. Luis Alberto Perez Peves";
    const cargoIns1 = "Coordinador Academico";
    const ins2 = "Ing. Gabriel Alonso Garcia Leon"; falta 
    const cargoIns2 = "Instructor"; falta
    const contenidoCurso = [
        { clave: "1)Principios basicos de la termodinamica aplicado a la refrigeracion  y sistemas basicos de la refrigeracion" },
        { clave: "2)Parametros de diseño y dimensionamiento de cuartos frios, arquitectura de cuartos frios" },
        { clave: "3)Principales ganancias de calor y estimacion de carga termica" },
        { clave: "4)seleccion de equipos de refrigeracion" },
        { clave: "5)Calculo de tuberias de refrigeracion y seleccion de accesorios de refrigeracion" },
        { clave: "6)Calculo de presiones de trabajo, cantidad de refrigerante, aceite para puesto en marcha" },
        { clave: "7)Casos practicos como calculo de carga terminca y seleccion de  camara de conservacion de frescos,congelado y tunel de congelamiento  y tunel de enfriamiento rapido." },
    ];
     * 
     */

    return (
        <>
            <div className="container">

                <div className="cert1 flex flex-col items-center justify-center text-center" >
                    <div className="informacion mt-28">
                        <h1 className="font-serif font-bold text-5xl">CERTIFICADO</h1>
                        <p className="mt-3 text-xl">Otorgado a:</p>
                        <h2 className="font-semibold text-3xl">{nombreApellidos}</h2>
                        <p className="text-xl mt-1">Por haber participado en el seminario Practico {modalidad}</p>
                        <p className="mt-2 font-semibold text-3xl mx-10">{titulo}</p>
                        <p className="text-xl mx-32 mt-2">Desarrollado en la ciudad de {ciudad} del {fecha_inicio} al {fecha_termino} del {año} con una duracion de {horas_totales} horas</p>
                    </div>
                    <div className="instructores flex flex-row">
                        <div className="firmas">

                        </div>
                        <div className="instructores flex gap-52 mt-24" >
                            <div className="inst1">
                                <p>{ins1}</p>
                                <p>{cargoIns1}</p>
                            </div>
                            <div className="inst2">
                                <p>{ins2}</p>
                                <p>{cargoIns2}</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div className="cert2  flex flex-col items-center justify-center text-center">
                    <div className="container h-4/5 w-11/12 mt-32 flex flex-col items-center  text-center">
                        <p className="font-semibold text-3xl mx-10">{titulo}</p>
                        <div className="dateTime p-4 ">
                            <div className="fechaInicio flex flex-row gap-2 items-center justify-center text-center">
                                <p>fecha de inicio:</p>
                                <p>{fecha_inicio + año}</p>
                            </div>
                            <div className="fechaFinal flex flex-row gap-2">
                                <p>fecha de finalizacion:</p>
                                <p>{fecha_termino + año}</p>
                            </div>
                        </div>
                        <div className="flex flex-column gap-0 border-2 border-black w-2/5">
                            <p className=" w-full border-2 border-black font-bold">TOTAL DE HORAS: </p>
                            <p className=" w-full border-2 border-black font-bold">{horas_totales} HORAS</p>
                        </div>
                        <div className="contenido text-left w-10/12">
                            <p className="mt-10 mb-4 font-bold">El contenido tematico del curso comprende:</p>
                         
                        </div>
                    </div>
                </div>
            </div>
        </>
    )
}
export default Certificado