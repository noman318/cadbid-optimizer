"use client";
import React from "react";
import CustomTable from "./CustomTable";
import { useGetAllStockSheetsQuery } from "@/lib/slices/stocksApiSlice";
import Loader from "./Loader";

type Props = {
  title: string;
  icon: React.ReactElement<React.SVGProps<SVGSVGElement>>;
};
const StockTable = ({ title, icon }: Props) => {
  const { data: stockData, isLoading, refetch } = useGetAllStockSheetsQuery({});
  // console.log("stockData", stockData);
  // const stockHead = stockData && Object?.keys(stockData?.[0]);
  const stockHead = stockData && stockData?.[0] && Object.keys(stockData[0]);

  stockHead?.shift();
  return (
    <React.Fragment>
      <h1 className="text-xl font-bold flex items-center gap-2 mb-1">
        {icon}
        {title}
      </h1>
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
