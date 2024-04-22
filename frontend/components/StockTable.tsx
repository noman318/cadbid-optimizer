"use client";
import { TableCell, TableRow } from "@/components/ui/table";
import { useCreatePanelMutation } from "@/lib/slices/panelsApiSlice";
import {
  useCreateStockMutation,
  useGetAllStockSheetsQuery,
} from "@/lib/slices/stocksApiSlice";
import React, { MouseEventHandler } from "react";
import CustomFileDropDown from "./CustomFileDropDown";
import CustomTable from "./CustomTable";
import Loader from "./Loader";

import { Input } from "@/components/ui/input";
import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import { FaSave } from "react-icons/fa";
import { z } from "zod";
import { Button } from "./ui/button";

import { Form, FormControl, FormField } from "@/components/ui/form";
type Props = {
  title: string;
  icon: React.ReactElement<React.SVGProps<SVGSVGElement>>;
  type: string;
};

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

type FieldName =
  | "nLength"
  | "nWidth"
  | "nQty"
  | "sName"
  | "sMaterialName"
  | "file_input";
const StockTable = ({ title, icon, type }: Props) => {
  const { data: stockData, isLoading, refetch } = useGetAllStockSheetsQuery({});
  const [createPanel] = useCreatePanelMutation();
  const [createStock] = useCreateStockMutation();
  // console.log("stockData", stockData);
  // const stockHead = stockData && Object?.keys(stockData?.[0]);
  const stockHead = stockData && stockData?.[0] && Object.keys(stockData[0]);
  stockHead?.shift();
  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      nLength: "",
      nWidth: "",
      nQty: "",
      sName: "",
      sMaterialName: "",
      file_input: "",
    },
  });

  const onSubmit: MouseEventHandler<HTMLButtonElement> = async (event: any) => {
    event.preventDefault();
    console.log(`clicked`);
    console.log("type", type);

    const values: any = form.getValues();

    const newData: { [key: string]: string | number } = {};

    Object.keys(values).forEach((key) => {
      if (key === "sName" || key === "sMaterialName") {
        newData[key] = values[key] as string;
      } else {
        newData[key] = Number(values[key]);
      }
    });

    try {
      if (type === "panel") {
        await createPanel(newData).unwrap();
        alert("created panel");
        form.reset({
          nLength: "",
          nWidth: "",
          nQty: "",
          sName: "",
          sMaterialName: "",
        });
        refetch();
      } else if (type === "stocks") {
        await createStock(newData).unwrap();
        alert("created stocks");
        form.reset({
          nLength: "",
          nWidth: "",
          nQty: "",
          sName: "",
          sMaterialName: "",
        });
        refetch();
      } else {
        alert("Provide Proper Type");
      }
    } catch (error) {
      console.log("error", error);
    }
  };
  return (
    <React.Fragment>
      <div className=" flex flex-wrap justify-between">
        <h1 className="text-xl font-bold flex items-center gap-2 mb-1">
          {icon}
          {title}
        </h1>
        <CustomFileDropDown type={"stocks"} fetch={refetch} />
      </div>
      {isLoading ? (
        <>
          <Loader />
        </>
      ) : (
        <>
          {stockData && stockData.length >= 1 ? (
            <CustomTable
              tableHead={stockHead}
              tableData={stockData}
              type="stocks"
              fetch={refetch}
            />
          ) : (
            <TableRow>
              <Form {...form}>
                <TableCell className="overflowing font-medium capitalize text-ellipsis">
                  <FormField
                    control={form.control}
                    name={`sName` as FieldName}
                    render={({ field }) => (
                      <FormControl>
                        <Input
                          placeholder="Name"
                          {...field}
                          // onChange={handleInputChange(item.id)}
                          // onChange={(event) => handleInputChange(event, item.id)}
                        />
                      </FormControl>
                    )}
                  />
                </TableCell>
                {type === "panel" && (
                  <TableCell className="font-medium capitalize text-ellipsis overflowing">
                    <FormField
                      control={form.control}
                      name={`sMaterialName` as FieldName}
                      render={({ field }) => (
                        <FormControl>
                          <Input
                            placeholder="Name"
                            {...field}
                            // onChange={(event) => handleInputChange(event, item.id)}
                          />
                        </FormControl>
                      )}
                    />
                  </TableCell>
                )}
                <TableCell>
                  <FormField
                    control={form.control}
                    name={`nLength` as FieldName}
                    render={({ field }) => (
                      <FormControl>
                        <Input
                          placeholder="Quantity"
                          {...field}
                          // onChange={(event) => handleInputChange(event, item.id)}
                        />
                      </FormControl>
                    )}
                  />
                </TableCell>
                <TableCell>
                  <FormField
                    control={form.control}
                    name={`nWidth` as FieldName}
                    render={({ field }) => (
                      <FormControl>
                        <Input
                          placeholder="Quantity"
                          {...field}
                          // onChange={(event) => handleInputChange(event, item.id)}
                        />
                      </FormControl>
                    )}
                  />
                </TableCell>
                <TableCell>
                  <FormField
                    control={form.control}
                    name={`nQty` as FieldName}
                    render={({ field }) => (
                      <FormControl>
                        <Input
                          placeholder="Quantity"
                          {...field}
                          // onChange={(event) => handleInputChange(event, item.id)}
                        />
                      </FormControl>
                    )}
                  />
                </TableCell>
                <TableCell>
                  <Button onClick={onSubmit}>
                    <FaSave />
                  </Button>
                </TableCell>
              </Form>
            </TableRow>
          )}
        </>
      )}
    </React.Fragment>
  );
};

export default StockTable;
