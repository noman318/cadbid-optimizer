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
import { useCreatePanelMutation } from "@/lib/slices/panelsApiSlice";
import {
  useCreateStockMutation,
  useUploadStocksCsvMutation,
} from "@/lib/slices/stocksApiSlice";
import { TfiLayoutSliderAlt } from "react-icons/tfi";
import { BsStack } from "react-icons/bs";

const formSchema = z.object({
  length: z.string().min(2).max(50),
  width: z.string().min(2).max(50),
  qty: z.string().min(1).max(50),
  panelLength: z.string().min(1).max(50),
  panelWidth: z.string().min(1).max(50),
  panelQty: z.string().min(1).max(50),
  file_input: z.string(),
});

type Props = {
  title: string;
  icon: React.ReactNode;
  type: string;
};
const AddForm = () => {
  const [createPanel, { data: createPanelData, isError, isLoading }] =
    useCreatePanelMutation();
  const [createStock, { data: creatStockeData }] = useCreateStockMutation();
  const [files, setFiles] = useState<File | null>(null);
  const [uploadStockCSV, { isLoading: uploadLoading }] =
    useUploadStocksCsvMutation();
  // console.log("createData", createData);
  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      length: "",
      width: "",
      qty: "",
      panelLength: "",
      panelWidth: "",
      panelQty: "",
      file_input: "",
    },
  });

  async function onSubmit(values: { [key: string]: string }) {
    // console.log("values", values);
    const newData: { [key: string]: string | number } = {};

    Object.keys(values).forEach((key) => {
      newData[key] = Number(values[key]);
    });

    // calling different apiSlice according to the type passed from the props

    try {
      await createPanel(newData).unwrap();

      // form.reset({
      //   length: "",
      //   width: "",
      //   qty: "",
      // }),
      console.log("newData", newData);
    } catch (error) {
      console.log("error", error);
    }
  }
  console.log("files", files);

  const handleUploadStockCSV = async (file: any) => {
    file.preventDefault();
    try {
      const formData = new FormData();
      files && formData.append("file", files);
      const res = await uploadStockCSV(formData).unwrap();
      console.log("res", res);
      alert("Uploaded");

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
    } catch (error) {
      console.error("Error uploading CSV:", error);
      alert("Failed to upload CSV");
    }
  };

  return (
    <section>
      <h1 className="text-xl font-bold flex items-center gap-2 mb-4">
        <TfiLayoutSliderAlt />
        {"Panels"}
      </h1>
      {isError ? <h1 className="text-red-600">Something Went wrong</h1> : <></>}
      <Form {...form}>
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
      </Form>
      <div style={{ marginTop: "25%" }}>
        <h1 className="text-xl font-bold flex items-center gap-2 mb-4">
          <BsStack />
          {"Stock Sheets"}
        </h1>
        <Form {...form}>
          <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-8">
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
              className="mr-2"
              disabled={isLoading}
            >
              Save
            </Button>
          </form>
        </Form>
      </div>

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
    </section>
  );
};

export default AddForm;
