import { Route, Routes } from 'react-router-dom';
import Page404 from '../features/404-Component/404';
import Navbar from '../features/layout/navbar';
import SubirArchivo from '../features/Subir-Archivo/Subir-Archivo';
import Alumnos from '../features/Alumnos/Alumno';
import  Instructores  from '../features/Instructores/Instructor';
const App = () => {

  return (
    <>
      <Routes>
        <Route path='/bar' element={<Navbar />} />
        <Route path='/alumnos' element={<Alumnos />} />
        <Route path='/CSV' element={<SubirArchivo />}></Route>
        <Route path='/instructores' element={<Instructores/>}/>
        <Route path='*' element={<Page404 />} />
      </Routes>
    </>
  )
}

export default App
