import { Route, Routes } from 'react-router-dom';
import Page404 from '../features/404-Component/404';
const App = () => {

  return (
    <>
      <Routes>
        <Route path='' element></Route>
        <Route path='*' element={<Page404 />} />
      </Routes>
    </>
  )
}

export default App
