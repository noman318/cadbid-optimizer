"use client";
import {
  useGetAllPanelsQuery,
  useUploadPanelCsvMutation,
} from "@/lib/slices/panelsApiSlice";
import React, { useRef, useState } from "react";
import CustomTable from "./CustomTable";
import Loader from "./Loader";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { IoMenu } from "react-icons/io5";
type Props = {
  title: string;
  icon: React.ReactElement<React.SVGProps<SVGSVGElement>>;
  type: string;
};
const PanelTable = ({ title, icon, type }: Props) => {
  const { data, isLoading, refetch } = useGetAllPanelsQuery({});
  // console.log("data", data.slice(0, 2));
  const [files, setFiles] = useState<File | null>(null);
  const [uploadPanelCSV, { isLoading: panelCsvLoading }] =
    useUploadPanelCsvMutation();
  const fileInputRef = useRef<HTMLInputElement>(null);

  const panelHead = data && data?.[0] && Object?.keys(data?.[0]);
  panelHead?.shift();
  // console.log("data", data);

  const handleImportFromCSV = () => {
    fileInputRef?.current?.click();
  };

  // console.log("filesOutFunction", files);

  const handleUploadStockCSV = async (e: any) => {
    e?.preventDefault();
    console.log("type", type);
    const selectedFile = e.target.files?.[0] || null;
    setFiles(selectedFile);
    // console.log("selectedFile", selectedFile);
    try {
      const formData = new FormData();
      formData.append("file", selectedFile);
      if (type === "panel") {
        await uploadPanelCSV(formData).unwrap();
        alert("Uploaded Panel CSV");
        refetch();
        return;
      } else {
        alert("Provide Proper Type");
      }
    } catch (error) {
      console.error("Error uploading CSV:", error);
      alert("Failed to upload CSV");
    }
  };
  return (
    <React.Fragment>
      <div className=" flex flex-wrap justify-between">
        <h1 className="text-xl font-bold flex items-center gap-2 mb-1">
          {icon}
          {title}
        </h1>
        <DropdownMenu>
          <DropdownMenuTrigger>
            <IoMenu size={30} />
          </DropdownMenuTrigger>
          <DropdownMenuContent>
            <DropdownMenuItem onClick={handleImportFromCSV}>
              Import From CSV
            </DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
        <form style={{ display: "none" }}>
          <input
            type="file"
            accept=".csv"
            ref={fileInputRef}
            onChange={handleUploadStockCSV}
          />
        </form>
      </div>
      {isLoading ? (
        <>
          <Loader />
        </>
      ) : (
        <div aria-label="parent_table">
          {data && data.length >= 1 && (
            <CustomTable
              tableHead={panelHead}
              tableData={data}
              type={"panel"}
              fetch={refetch}
            />
          )}
        </div>
      )}
    </React.Fragment>
  );
};

export default PanelTable;
