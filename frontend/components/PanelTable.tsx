"use client";
import { useGetAllPanelsQuery } from "@/lib/slices/panelsApiSlice";
import React from "react";
import CustomTable from "./CustomTable";
import Loader from "./Loader";
type Props = {
  title: string;
  icon: React.ReactElement<React.SVGProps<SVGSVGElement>>;
};
const PanelTable = ({ title, icon }: Props) => {
  const { data, isLoading, refetch } = useGetAllPanelsQuery({});
  // console.log("data", data.slice(0, 2));
  const panelHead = data && data?.[0] && Object?.keys(data?.[0]);
  panelHead?.shift();
  // console.log("data", data);
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
