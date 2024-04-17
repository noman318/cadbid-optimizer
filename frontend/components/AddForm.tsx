"use client";

import { z } from "zod";
import { zodResolver } from "@hookform/resolvers/zod";
import React, { useState } from "react";
import { useForm } from "react-hook-form";
import { Button } from "@/components/ui/button";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import {
  useCreatePanelMutation,
  useUploadPanelCsvMutation,
} from "@/lib/slices/panelsApiSlice";
import {
  useCreateStockMutation,
  useUploadStocksCsvMutation,
} from "@/lib/slices/stocksApiSlice";
import { TfiLayoutSliderAlt } from "react-icons/tfi";
import { BsStack } from "react-icons/bs";
import CustomTable from "./CustomTable";

const formSchema = z.object({
  length: z.string().min(2).max(50),
  width: z.string().min(2).max(50),
  qty: z.string().min(1).max(50),
  name: z.string(),
  // panelLength: z.string().min(1).max(50),
  // panelWidth: z.string().min(1).max(50),
  // panelQty: z.string().min(1).max(50),
  file_input: z.string(),
});

type Props = {
  title: string;
  icon: React.ReactElement<React.SVGProps<SVGSVGElement>>;
  type: string;
};

const AddForm = ({ title, icon, type }: Props) => {
  const [createPanel, { data: createPanelData, isError, isLoading }] =
    useCreatePanelMutation();
  const [createStock, { data: creatStockeData }] = useCreateStockMutation();
  const [files, setFiles] = useState<File | null>(null);
  const [uploadStockCSV, { isLoading: uploadLoading }] =
    useUploadStocksCsvMutation();

  const [uploadPanelCSV, { isLoading: panelCsvLoading }] =
    useUploadPanelCsvMutation();
  // console.log("createData", createData);
  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      length: "",
      width: "",
      qty: "",
      name: "",
      file_input: "",
    },
  });
  // console.log("type", type);

  async function onSubmit(values: { [key: string]: string }) {
    // console.log("values", values);
    // values.preventDefault();
    const newData: { [key: string]: string | number } = {};

    Object.keys(values).forEach((key) => {
      if (key !== "name") {
        newData[key] = Number(values[key]);
      } else {
        newData[key] = values[key];
      }
    });

    // console.log("newData", newData);
    const { length, width, qty, name } = newData;
    const updatedData = { length, width, qty, name };
    console.log("updatedData", updatedData);
    // console.log("type", type);

    try {
      if (type === "panel") {
        await createPanel(updatedData).unwrap();
        alert("created panel");
        return;
      } else if (type === "stock") {
        await createStock(updatedData).unwrap();
        alert("created stocks");
        return;
      } else {
        alert("Provide Proper Type");
      }
      form.reset({
        length: "",
        width: "",
        qty: "",
        name: "",
      });
    } catch (error) {
      console.log("error", error);
    }
  }
  // console.log("files", files);

  const handleUploadStockCSV = async (file: any) => {
    file.preventDefault();
    try {
      const formData = new FormData();
      files && formData.append("file", files);
      if (type === "panel") {
        await uploadPanelCSV(formData).unwrap();
        alert("Uploaded Panel CSV");
        return;
      } else if (type === "stock") {
        await uploadStockCSV(formData).unwrap();
        alert("Uploaded Stock CSV");
        return;
      } else {
        alert("Provide Proper Type");
      }

      // const response = await fetch(
      //   "http://localhost:5000/stock-sheets/upload",
      //   {
      //     method: "POST",
      //     body: formData,
      //   }
      // );

      // const responseData = await response.text(); // Parse response as plain text
      // console.log("Response:", responseData);

      // if (response.ok) {
      //   alert("Uploaded");
      // } else {
      //   console.error("Error uploading CSV:", responseData);
      //   alert("Failed to upload CSV");
      // }
      form.reset({
        file_input: "",
      });
    } catch (error) {
      console.error("Error uploading CSV:", error);
      alert("Failed to upload CSV");
    }
  };

  return (
    <section>
      {isError ? <h1 className="text-red-600">Something Went wrong</h1> : <></>}
      {/* <Form {...form}>
        <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-8">
          <FormField
            control={form.control}
            name="panelLength"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Length</FormLabel>
                <FormControl>
                  <Input placeholder="Length" {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="panelWidth"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Width</FormLabel>
                <FormControl>
                  <Input placeholder="Width" {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="panelQty"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Quantity</FormLabel>
                <FormControl>
                  <Input placeholder="Quantity" {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
          <Button
            type="submit"
            size={"sm"}
            className="mr-2"
            disabled={isLoading}
          >
            Save
          </Button>
        </form>
      </Form>
      <Form {...form}>
        <form>
          <FormField
            control={form.control}
            name="file_input"
            render={({ field }) => (
              <FormItem className=" mt-4">
                <FormLabel>Upload File</FormLabel>
                <FormControl>
                  <Input
                    placeholder="Upload File"
                    type="file"
                    accept="csv"
                    onChange={(e) => {
                      setFiles(e?.target?.files ? e?.target?.files[0] : null);
                    }}
                  />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
          <Button
            size={"sm"}
            type="submit"
            onClick={handleUploadStockCSV}
            disabled={!files || uploadLoading}
            className="my-4"
          >
            Upload
          </Button>
        </form>
      </Form> */}
      <h1 className="text-xl font-bold flex items-center gap-2 mb-1">
        {icon}
        {title}
      </h1>
      <Form {...form}>
        <div>
          <form
            onSubmit={form.handleSubmit(onSubmit)}
            className="grid gap-1 py-2 grid-cols-2"
          >
            <FormField
              control={form.control}
              name="name"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Name</FormLabel>
                  <FormControl>
                    <Input placeholder="Name" {...field} />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />
            <FormField
              control={form.control}
              name="length"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Length</FormLabel>
                  <FormControl>
                    <Input placeholder="Length" {...field} />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />
            <FormField
              control={form.control}
              name="width"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Width</FormLabel>
                  <FormControl>
                    <Input placeholder="Width" {...field} />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />
            <FormField
              control={form.control}
              name="qty"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Quantity</FormLabel>
                  <FormControl>
                    <Input placeholder="Quantity" {...field} />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />
            <Button
              type="submit"
              size={"sm"}
              className="mr-2 mt-2"
              disabled={isLoading}
            >
              Save
            </Button>
          </form>
        </div>
      </Form>

      <Form {...form}>
        <form>
          <FormField
            control={form.control}
            name="file_input"
            render={({ field }) => (
              <FormItem className=" mt-4">
                <FormLabel>Upload File</FormLabel>
                <FormControl>
                  <Input
                    placeholder="Upload File"
                    type="file"
                    accept="csv"
                    onChange={(e) => {
                      setFiles(e?.target?.files ? e?.target?.files[0] : null);
                    }}
                  />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
          <Button
            size={"sm"}
            type="submit"
            onClick={handleUploadStockCSV}
            disabled={!files || uploadLoading}
            className="my-4"
          >
            Upload
          </Button>
        </form>
      </Form>
      <CustomTable />
    </section>
  );
};

export default AddForm;
