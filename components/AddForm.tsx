"use client";

import { z } from "zod";
import { zodResolver } from "@hookform/resolvers/zod";
import React from "react";
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

const formSchema = z.object({
  length: z.string().min(2).max(50),
  width: z.string().min(2).max(50),
  qty: z.string().min(1).max(50),
});

type Props = {
  title: string;
  icon: React.ReactNode;
};
const AddForm = ({ title, icon }: Props) => {
  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      length: "",
      width: "",
      qty: "",
    },
  });

  function onSubmit(values: { [key: string]: string }) {
    
    const newData: { [key: string]: string | number } = {};

    Object.keys(values).forEach((key) => {
      newData[key] = Number(values[key]);
    });

    console.log("newData", newData);
  }

  return (
    <section>
      <h1 className="text-xl font-bold flex items-center gap-2 mb-4">
        {icon}
        {title}
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
          <Button type="submit" size={"sm"}>Save</Button>
        </form>
      </Form>
    </section>
  );
};

export default AddForm;
