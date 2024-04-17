import React from "react";
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
import { FaCheck } from "react-icons/fa";
import { useDeletePanelMutation } from "@/lib/slices/panelsApiSlice";
import { useDeleteStockMutation } from "@/lib/slices/stocksApiSlice";

interface Item {
  id?: string;
  name?: string;
  length?: number;
  width?: number;
  qty?: number;
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
  const [deletePanel] = useDeletePanelMutation();
  const [deleteStock] = useDeleteStockMutation();
  const removeItem = async (id: string | undefined) => {
    console.log("id", id);

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
  return (
    <Table aria-label="table_body">
      {/* <TableCaption>A list of your recent invoices.</TableCaption> */}
      <TableHeader className=" font-bold">
        <TableRow>
          {tableHead?.map((head, index) => (
            <React.Fragment key={index}>
              <TableHead className=" capitalize">{head}</TableHead>
            </React.Fragment>
          ))}
          <TableHead className=" capitalize">{"Actions"}</TableHead>

          {/* <TableHead className="w-[100px]">Invoice</TableHead>
          <TableHead>Method</TableHead>
          
          <TableHead className="text-right">Amount</TableHead> */}
        </TableRow>
      </TableHeader>
      <TableBody>
        {tableData?.map((item, index) => (
          <TableRow key={item.id}>
            <TableCell className="font-medium">{index + 1}</TableCell>
            <TableCell className="font-medium capitalize text-ellipsis">
              {item.name}
            </TableCell>
            <TableCell>{item.length}</TableCell>
            <TableCell>{item.width}</TableCell>
            <TableCell>{item.qty}</TableCell>
            <TableCell className=" flex items-center justify-center gap-3">
              <ImCross
                className="cursor-pointer"
                color="red"
                onClick={() => removeItem(item?.id)}
              />
              <FaCheck className="cursor-pointer" color="green" size={15} />
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
