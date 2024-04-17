import React from "react";

const Loader = () => {
  return (
    <div className="flex justify-center items-center">
      <div className=" h-16 w-16 rounded-full animate-ping text-black">.</div>
    </div>
  );
};

export default Loader;
