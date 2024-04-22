"use client";

import { FaDownload, FaPlay } from "react-icons/fa";
import { MdDashboard } from "react-icons/md";
import SettingDailogForm from "./SettingDailogForm";
import { Button } from "./ui/button";

const Header = () => {
  return (
    <header className="flex items-center justify-between w-full p-2 bg-slate-900 sticky top-0 z-20">
      <div className=" flex items-center gap-2">
        <MdDashboard color="white" size={"30px"} />
        <h1 className=" text-xl font-semibold text-white">Cadbid Optimizer</h1>
      </div>
      <div className="mx-2">
        <Button className="mr-2 bg-green-600 hover:bg-green-500 transition-colors duration-300">
          <FaPlay /> Calculate
        </Button>
        <Button className="mr-2">
          <FaDownload />
          Save
        </Button>
        <SettingDailogForm />
        <Button className="mr-2">Sign In</Button>
      </div>
    </header>
  );
};

export default Header;
