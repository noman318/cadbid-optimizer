import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table";
import React, { useEffect, useState } from "react";

import {
  useDeletePanelMutation,
  useUpdatePanelMutation,
} from "@/lib/slices/panelsApiSlice";
import {
  useDeleteStockMutation,
  useUpdateStockMutation,
} from "@/lib/slices/stocksApiSlice";
import { FaCheck, FaRegSquare } from "react-icons/fa";
import { ImCross } from "react-icons/im";
import { Form, FormControl, FormField } from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import {
  useForm,
  FieldName,
  FieldValues,
  UseFormSetValue,
} from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";

interface Item {
  id: string;
  sName?: string;
  sMaterialName?: string;
  nLength?: number | string;
  nWidth?: number | string;
  nQty?: number | string;
  bIsEnabled?: boolean;
}
const formSchema = z.object({
  nLength: z.string().min(2).max(50),
  nWidth: z.string().min(2).max(50),
  nQty: z.string().min(1).max(50),
  sName: z.string(),
  sMaterialName: z.string(),
  // panelLength: z.string().min(1).max(50),
  // panelWidth: z.string().min(1).max(50),
  // panelQty: z.string().min(1).max(50),
  file_input: z.string(),
});

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
  const newTableHead = tableHead && tableHead?.slice(0, -1);
  // console.log("newTableHead", newTableHead);

  const [statusFlag, setStatusFlag] = useState(false);
  const [deletePanel] = useDeletePanelMutation();
  const [deleteStock] = useDeleteStockMutation();
  const [updatePanel] = useUpdatePanelMutation();
  const [updateStock] = useUpdateStockMutation();

  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues:
      tableData &&
      tableData.reduce((acc, item) => {
        return {
          ...acc,
          [`sName_${item?.id}`]: item?.sName || "",
          [`nLength_${item?.id}`]:
            typeof item?.nLength === "number" ? String(item?.nLength) : "",
          [`nWidth_${item?.id}`]:
            typeof item?.nWidth === "number" ? String(item?.nWidth) : "",
          [`nQty_${item?.id}`]:
            typeof item?.nQty === "number" ? String(item?.nQty) : "",
          [`sMaterialName_${item?.id}`]: item?.sMaterialName || "",
        };
      }, {}),
  });
  const defaultFormData =
    tableData?.reduce((acc, item) => {
      return {
        ...acc,
        [`sName_${item?.id}`]: item?.sName || "",
        [`nLength_${item?.id}`]:
          typeof item?.nLength === "number" ? String(item?.nLength) : "",
        [`nWidth_${item?.id}`]:
          typeof item?.nWidth === "number" ? String(item?.nWidth) : "",
        [`nQty_${item?.id}`]:
          typeof item?.nQty === "number" ? String(item?.nQty) : "",
        [`sMaterialName_${item?.id}`]: item?.sMaterialName || "",
      };
    }, {}) || {};
  // console.log("formData", formData);
  const [formData, setFormData] = useState(defaultFormData);
  const handleInputChange = async (
    event: React.ChangeEvent<HTMLInputElement>,
    itemId: string
  ) => {
    console.log("itemId", itemId);
    const { name, value } = event.target;
    form.setValue(name as FieldName, value);
    console.log("name", name);
    const strName = name.split("_");
    const newArray = strName.slice(0, -1);

    // Convert the modified array back to a string
    const resultString = newArray.join(",");

    console.log("resultString", resultString);
    try {
      await updatePanel({
        id: itemId,
        data: { [resultString]: value },
      }).unwrap();
    } catch (error) {
      console.log("Error updating panel:", error);
    }
  };
  type FieldName =
    | "nLength"
    | "nWidth"
    | "nQty"
    | "sName"
    | "sMaterialName"
    | "file_input";

  const removeItem = async (id: string | undefined) => {
    console.log("id", id);
    console.log("statusFlag", statusFlag);
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

  const handleUpdateStatusToEnabled = async (itemId: string) => {
    console.log("itemId", itemId);
    console.log("type", type);
    console.log("statusFlag", statusFlag);

    try {
      setStatusFlag(true);
      if (type === "panel") {
        await updatePanel({
          id: itemId,
          data: { bIsEnabled: true },
        }).unwrap();
        alert("Panel Updated");
        fetch();
        return;
      } else if (type === "stocks") {
        await updateStock({
          id: itemId,
          data: { bIsEnabled: true },
        }).unwrap();
        alert("Stock Sheet Updated");
        fetch();
        return;
      } else {
        alert("Provide proper type");
        return;
      }
    } catch (error) {}
  };
  const handleUpdateStatusToDisabled = async (itemId: string) => {
    console.log("itemId", itemId);
    console.log("type", type);

    try {
      setStatusFlag(false);
      if (type === "panel") {
        await updatePanel({
          id: itemId,
          data: { bIsEnabled: false },
        }).unwrap();
        alert("Panel Updated");
        fetch();
        return;
      } else if (type === "stocks") {
        await updateStock({
          id: itemId,
          data: { bIsEnabled: false },
        }).unwrap();
        alert("Stock Sheet Updated");
        fetch();
        return;
      } else {
        alert("Provide proper type");
        return;
      }
    } catch (error) {}
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
          <TableRow key={item?.id}>
            <Form {...form}>
              <TableCell className="overflowing font-medium capitalize text-ellipsis">
                <FormField
                  control={form.control}
                  name={`sName_${item?.id}` as FieldName}
                  defaultValue={item?.sName}
                  render={({ field }) => (
                    <FormControl>
                      <Input
                        placeholder="Name"
                        {...field}
                        // onChange={handleInputChange(item.id)}
                        onChange={(event) => handleInputChange(event, item.id)} // Pass a function reference here
                      />
                    </FormControl>
                  )}
                />
              </TableCell>
              {type === "panel" && (
                <TableCell className="font-medium capitalize text-ellipsis overflowing">
                  <FormField
                    control={form.control}
                    name={`sMaterialName_${item?.id}` as FieldName}
                    defaultValue={item?.sMaterialName}
                    render={({ field }) => (
                      <FormControl>
                        <Input placeholder="Name" {...field} />
                      </FormControl>
                    )}
                  />
                </TableCell>
              )}
              <TableCell>
                <FormField
                  control={form.control}
                  name={`nLength_${item?.id}` as FieldName}
                  defaultValue={`${item?.nLength}`}
                  render={({ field }) => (
                    <FormControl>
                      <Input placeholder="Quantity" {...field} />
                    </FormControl>
                  )}
                />
              </TableCell>
              <TableCell>
                <FormField
                  control={form.control}
                  name={`nWidth_${item?.id}` as FieldName}
                  defaultValue={`${item?.nWidth}`}
                  render={({ field }) => (
                    <FormControl>
                      <Input placeholder="Quantity" {...field} />
                    </FormControl>
                  )}
                />
              </TableCell>
              <TableCell>
                <FormField
                  control={form.control}
                  name={`nQty_${item?.id}` as FieldName}
                  defaultValue={`${item?.nQty}`}
                  render={({ field }) => (
                    <FormControl>
                      <Input placeholder="Quantity" {...field} />
                    </FormControl>
                  )}
                />
              </TableCell>
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
                      onClick={() => handleUpdateStatusToDisabled(item?.id)}
                    />
                  </>
                ) : (
                  <>
                    <FaRegSquare
                      className="cursor-pointer"
                      color="green"
                      size={15}
                      onClick={() => handleUpdateStatusToEnabled(item?.id)}
                    />
                  </>
                )}
              </TableCell>
            </Form>
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
