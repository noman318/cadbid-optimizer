import React from 'react'
import { Button } from './ui/button'
import { FaPlay,FaDownload } from "react-icons/fa";
import { IoSettingsSharp } from "react-icons/io5";
import { MdDashboard } from "react-icons/md";

const Header = () => {
  return (
    <header className='flex items-center justify-between w-full p-1 bg-slate-900'>
        <div className=' flex items-center gap-2'>
        <MdDashboard color='white' size={'30px'} /> 
            <h1 className=' text-xl font-semibold text-white'>Cutlist Optimizer</h1>
        </div>
        <div className='mx-2'>
            <Button className='mr-2 bg-green-600'><FaPlay /> {' '}Calculate</Button>
            <Button className='mr-2'><FaDownload />Save</Button>
            <Button className='mr-2'><IoSettingsSharp /> Settings</Button>
            <Button className='mr-2'>Sign IN</Button>
        </div>
    </header>
  )
}

export default Header