"use client";
import { useGetAllPanelsQuery } from "@/lib/slices/panelsApiSlice";
import React from "react";
import CustomTable from "./CustomTable";
import Loader from "./Loader";

const PanelTable = () => {
  const { data, isLoading, refetch } = useGetAllPanelsQuery({});
  // console.log("data", data.slice(0, 2));
  const panelHead = data && Object?.keys(data?.[0]);
  return (
    <React.Fragment>
      {isLoading ? (
        <>
          <Loader />
        </>
      ) : (
        <CustomTable
          tableHead={panelHead}
          tableData={data}
          type={"panel"}
          fetch={refetch}
        />
      )}
    </React.Fragment>
  );
};

export default PanelTable;
