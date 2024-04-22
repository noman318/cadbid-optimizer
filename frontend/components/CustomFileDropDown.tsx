import React, { useRef, useState } from "react";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { IoMenu } from "react-icons/io5";
import { useUploadStocksCsvMutation } from "@/lib/slices/stocksApiSlice";
import { useUploadPanelCsvMutation } from "@/lib/slices/panelsApiSlice";

type Props = {
  type: string;
  fetch: any;
};
const CustomFileDropDown = ({ type, fetch }: Props) => {
  const [files, setFiles] = useState<File | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);
  const [uploadStockCSV, { isLoading: uploadLoading }] =
    useUploadStocksCsvMutation();
  // console.log("type", type);
  const [uploadPanelCSV, { isLoading: panelCsvLoading }] =
    useUploadPanelCsvMutation();

  const handleImportFromCSV = () => {
    fileInputRef.current?.click();
  };

  const handleUploadStockCSV = async (
    e: React.ChangeEvent<HTMLInputElement>
  ) => {
    e.preventDefault();
    const selectedFile = e.target.files?.[0] || null;
    setFiles(selectedFile);
    try {
      const formData = new FormData();
      formData.append("file", selectedFile as Blob);
      if (type === "panel") {
        await uploadPanelCSV(formData).unwrap();
        alert("Uploaded Panel CSV");
        fetch();
        return;
      } else if (type === "stocks") {
        await uploadStockCSV(formData).unwrap();
        alert("Uploaded Stock CSV");
        fetch();
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
    <>
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
    </>
  );
};

export default CustomFileDropDown;
