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
        <div aria-label="parent_table" className="-z-10">
          <CustomTable
            tableHead={panelHead}
            tableData={data}
            type={"panel"}
            fetch={refetch}
          />
        </div>
      )}
    </React.Fragment>
  );
};

export default PanelTable;
