"use client";
import React, { useEffect, useRef, useState } from "react";
import CustomTable from "./CustomTable";
import {
  useGetAllStockSheetsQuery,
  useUploadStocksCsvMutation,
} from "@/lib/slices/stocksApiSlice";
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
import { useUploadPanelCsvMutation } from "@/lib/slices/panelsApiSlice";

type Props = {
  title: string;
  icon: React.ReactElement<React.SVGProps<SVGSVGElement>>;
  type: string;
};
const StockTable = ({ title, icon, type }: Props) => {
  const { data: stockData, isLoading, refetch } = useGetAllStockSheetsQuery({});
  const [files, setFiles] = useState<File | null>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  const [uploadStockCSV, { isLoading: uploadLoading }] =
    useUploadStocksCsvMutation();
  // console.log("type", type);
  const [uploadPanelCSV, { isLoading: panelCsvLoading }] =
    useUploadPanelCsvMutation();
  // console.log("stockData", stockData);
  // const stockHead = stockData && Object?.keys(stockData?.[0]);
  const stockHead = stockData && stockData?.[0] && Object.keys(stockData[0]);
  stockHead?.shift();

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
      } else if (type === "stocks") {
        await uploadStockCSV(formData).unwrap();
        alert("Uploaded Stock CSV");
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
        <>
          {stockData && stockData.length >= 1 && (
            <CustomTable
              tableHead={stockHead}
              tableData={stockData}
              type="stocks"
              fetch={refetch}
            />
          )}
        </>
      )}
    </React.Fragment>
  );
};

export default StockTable;
