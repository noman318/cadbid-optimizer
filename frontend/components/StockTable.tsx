"use client";
import React from "react";
import CustomTable from "./CustomTable";
import { useGetAllStockSheetsQuery } from "@/lib/slices/stocksApiSlice";
import Loader from "./Loader";

const StockTable = () => {
  const { data: stockData, isLoading, refetch } = useGetAllStockSheetsQuery({});
  // console.log("stockData", stockData);
  // const stockHead = stockData && Object?.keys(stockData?.[0]);
  const stockHead = stockData?.[0] && Object.keys(stockData[0]);

  stockHead?.shift();
  return (
    <React.Fragment>
      {isLoading ? (
        <>
          <Loader />
        </>
      ) : (
        <>
          {stockData && (
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
