import React, { useState } from "react";
import {
  Table,
  TableBody,
  TableCaption,
  TableCell,
  TableFooter,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";

import { ImCross } from "react-icons/im";
import { FaCheck, FaRegSquare } from "react-icons/fa";
import { useDeletePanelMutation } from "@/lib/slices/panelsApiSlice";
import { useDeleteStockMutation } from "@/lib/slices/stocksApiSlice";
import { Checkbox } from "./ui/checkbox";
import { CheckedState } from "@radix-ui/react-checkbox";
import { FormControl, FormField, FormItem } from "./ui/form";
interface Item {
  id: string;
  sName?: string;
  sMaterialName?: string;
  nLength?: number;
  nWidth?: number;
  nQty?: number;
  bIsEnabled?: boolean;
}

const CustomTable = ({
  tableHead,
  tableData,
  type,
  fetch,
}: {
  tableHead: string[];
  tableData: Item[];
  type: string;
  fetch: any;
}) => {
  // console.log("tableHead", tableHead);
  const newTableHead = tableHead.slice(0, -1);
  // console.log("newTableHead", newTableHead);
  const [isDisabled, setIsDisabled] = useState(false);
  const [deletePanel] = useDeletePanelMutation();
  const [deleteStock] = useDeleteStockMutation();
  const removeItem = async (id: string | undefined) => {
    console.log("id", id);
    console.log("isDisabled", isDisabled);
    if (type === "panel") {
      await deletePanel(id).unwrap();
      alert("Panel Deleted");
      fetch();
      return;
    } else if (type === "stocks") {
      await deleteStock(id).unwrap();
      alert("Stock Sheet Deleted");
      fetch();
      return;
    } else {
      alert("Provide proper type");
      return;
    }
  };

  function formatTableHeader(sUserType: string) {
    if (sUserType.charAt(0) === sUserType.charAt(0).toLowerCase()) {
      sUserType = sUserType.substring(1);
    }
    return sUserType.split(/(?=[A-Z])/).join(" ");
  }

  const handleElippsis = (char: string) => {
    if (char.length >= 10) {
      const str = char.slice(0, 10);
      const newStr = `${str}...`;
      return newStr;
    }
    return char;
  };

  const handleToggleLayoutNumber = (itemId: string, type: string) => {
    console.log("itemId", itemId);
    console.log("type", type);
    if (type === "enable") {
      setIsDisabled(true);
    } else if (type === "disable") {
      setIsDisabled(false);
    }
  };

  // console.log("tableData", tableData);
  return (
    <Table
      aria-label="table_body"
      className=" overflow-x-hidden overflow-y-hidden hide-scrollbar -z-0"
    >
      {/* <TableCaption>A list of your recent invoices.</TableCaption> */}
      <TableHeader className=" font-bold">
        <TableRow>
          {newTableHead?.map((head, index) => (
            <React.Fragment key={index}>
              <TableHead className=" capitalize overflowing">
                {formatTableHeader(head)}
              </TableHead>
            </React.Fragment>
          ))}
          <TableHead className=" capitalize">{"Actions"}</TableHead>
        </TableRow>
      </TableHeader>
      <TableBody>
        {tableData?.map((item) => (
          <TableRow key={item.id}>
            <TableCell className="overflowing font-medium capitalize text-ellipsis">
              {handleElippsis(`${item.sName}`)}
            </TableCell>
            {type === "panel" && (
              <TableCell className="font-medium capitalize text-ellipsis overflowing">
                {handleElippsis(`${item.sMaterialName}`)}
              </TableCell>
            )}
            <TableCell>{item.nLength}</TableCell>
            <TableCell>{item.nWidth}</TableCell>
            <TableCell>{item.nQty}</TableCell>
            <TableCell className=" flex items-center justify-start gap-3">
              <ImCross
                className="cursor-pointer"
                color="red"
                onClick={() => removeItem(item?.id)}
              />
              {item.bIsEnabled ? (
                <>
                  <FaCheck
                    className="cursor-pointer"
                    color="green"
                    size={15}
                    onClick={() =>
                      handleToggleLayoutNumber(item?.id, "disable")
                    }
                  />
                </>
              ) : (
                <>
                  <FaRegSquare
                    className="cursor-pointer"
                    color="green"
                    size={15}
                    onClick={() => handleToggleLayoutNumber(item?.id, "enable")}
                  />
                </>
              )}
            </TableCell>
          </TableRow>
        ))}
      </TableBody>
      {/* <TableFooter>
        <TableRow>
          <TableCell colSpan={3}>Total</TableCell>
          <TableCell className="text-right">$2,500.00</TableCell>
        </TableRow>
      </TableFooter> */}
    </Table>
  );
};

export default CustomTable;
