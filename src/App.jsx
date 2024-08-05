import { Route, Routes } from 'react-router-dom';
import Page404 from '../features/Layouts/404';
import Navbar from '../features/layout/navbar';
import SubirArchivo from '../features/Subir-Archivo/Subir-Archivo';
import Alumnos from '../features/Alumnos/Alumno';
import  Instructores  from '../features/Instructores/Instructor';
import  Table  from '../features/Components/table';
import Certificados from '../features/Certificados/AlumnosCertificados';
import  Certificado  from '../features/Certificados/Certificado';
import Login from '../features/login/Login';
const App = () => {

  return (
    <>
      <Routes>
        <Route path='/bar' element={<Navbar />} />
        <Route path='/alumnos' element={<Alumnos />} />
        <Route path='/CSV' element={<SubirArchivo />}></Route>
        <Route path='/instructores' element={<Instructores/>}/>
        <Route path='/tabla' element={<Table/>}></Route>
        <Route path='/certificado/:data' element={<Certificados/>}></Route>
        <Route path='/certificados' element={<Certificado/>}></Route>
        <Route path='/cert/login' element={<Login/>}></Route>
        <Route path='*' element={<Page404 />} />
      </Routes>
    </>
  )
}

export default App
