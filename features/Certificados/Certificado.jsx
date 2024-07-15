import "./cert1Style.css"
const Certificado = () => {
    const nombreApellidos = "Josue Renato Ccenta Sullon";
    const modalidad = "";
    const titulo = '"AIRE ACONDICIONADO "';
    const ciudad = "Lima";
    const fecha_inicio = "23 junio";
    const fecha_termino = "28 agosto";
    const año = "2024";
    const horas_totales = 3;
    const ins1 = "Ing. Luis Alberto Perez Peves";
    const cargoIns1 = "Coordinador Academico";
    const ins2 = "Ing. Rony Montoya Campos";
    const cargoIns2 = "Instructor";
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
                <div className="cert2">

                </div>
            </div>
            </>
            )
}
            export default Certificado