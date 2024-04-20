"use client";

import {
  Dialog,
  DialogContent,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import {
  Form,
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { useCreateSettingMutation } from "@/lib/slices/settingSlice";
import { zodResolver } from "@hookform/resolvers/zod";
import React, { useState } from "react";
import { useForm } from "react-hook-form";
import { IoSettingsSharp } from "react-icons/io5";
import { z } from "zod";
import { Button } from "./ui/button";
import { Checkbox } from "./ui/checkbox";
import { RadioGroup, RadioGroupItem } from "./ui/radio-group";

const formSchema = z.object({
  nLeftTrim: z.string().default(""),
  nRightTrim: z.string().default(""),
  nTopTrim: z.string().default(""),
  nBottomTrim: z.string().default(""),
  nSawKerfValue: z.string().default(""),
  bMinmizePanelRotation: z.boolean().default(true),
  bCuttingLayoutMin: z.boolean().default(false),
  nCuttingComplexity: z.string().default(""),
  nMaxLayoutSize: z.string().default(""),
  nStockPile: z.boolean().default(false),
  bCutDirection: z.string().default(""),
  bRollMode: z.boolean().default(false),
  sUserId: z.string().min(8).max(80),
});
const SettingDailogForm = () => {
  const [createSetting, { data, isLoading, isError }] =
    useCreateSettingMutation();

  let showUserId = false;
  const [layoutNumber, setLayoutNumber] = useState(false);
  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      nLeftTrim: "",
      nRightTrim: "",
      nBottomTrim: "",
      nTopTrim: "",
      nSawKerfValue: "",
      nCuttingComplexity: "",
      nMaxLayoutSize: "",
      bMinmizePanelRotation: true,
      bCuttingLayoutMin: false,
      bCutDirection: "",
      bRollMode: false,
      nStockPile: false,
      sUserId: "37c32313-99ad-4d70-90d3-d8fe0df2f823",
    },
  });
  // console.log("layoutNumber", layoutNumber);
  async function onSubmit(values: z.infer<typeof formSchema>) {
    // ✅ This will be type-safe and validated.
    // console.log("values", values);
    const newData = { ...values, bLayoutNumber: layoutNumber };
    // console.log("newData", newData);
    try {
      await createSetting(newData).unwrap();
      alert("Created setting");
    } catch (error: any) {
      console.log("error", error);
      alert(`${error} error`);
    }
  }
  const handleToggleLayoutNumber = (isChecked: any) => {
    setLayoutNumber(isChecked);
  };

  return (
    <React.Fragment>
      <Dialog>
        <DialogTrigger asChild>
          <Button className="mr-2">
            <IoSettingsSharp /> Settings
          </Button>
        </DialogTrigger>
        <DialogContent className="sm:max-w-[425px]">
          <DialogHeader>
            <DialogTitle>Add Settings</DialogTitle>
          </DialogHeader>
          {isError ? (
            <h1 className="text-red-600">Something Went wrong</h1>
          ) : (
            <></>
          )}
          <Form {...form}>
            <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-8">
              <div className="grid gap-2 py-2 grid-cols-2">
                <FormField
                  control={form.control}
                  name="nLeftTrim"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Trim Left</FormLabel>
                      <FormControl>
                        <Input
                          placeholder="Length"
                          type="number"
                          min={0}
                          {...field}
                        />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />

                <FormField
                  control={form.control}
                  name="nRightTrim"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Trim Right</FormLabel>
                      <FormControl>
                        <Input
                          placeholder="Length"
                          type="number"
                          min={0}
                          {...field}
                        />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />

                <FormField
                  control={form.control}
                  name="nTopTrim"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Trim Top</FormLabel>
                      <FormControl>
                        <Input
                          placeholder="Length"
                          type="number"
                          min={0}
                          {...field}
                        />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />

                <FormField
                  control={form.control}
                  name="nBottomTrim"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Trim Bottom</FormLabel>
                      <FormControl>
                        <Input
                          placeholder="Length"
                          type="number"
                          min={0}
                          {...field}
                        />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />

                <FormField
                  control={form.control}
                  name="nSawKerfValue"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Blade Width</FormLabel>
                      <FormControl>
                        <Input
                          placeholder="Length"
                          type="number"
                          min={0}
                          {...field}
                        />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
                {/* <FormField
                    control={form.control}
                    name="nSawKerfValue"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Blade Width</FormLabel>
                        <FormControl>
                          <Input
                            placeholder="Length"
                            type="number"  min={0}
                            {...field}
                          />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  /> */}
                <FormField
                  control={form.control}
                  name="nCuttingComplexity"
                  render={({ field }) => (
                    <FormItem>
                      <FormLabel>Cutting Complexity</FormLabel>
                      <FormControl>
                        <Input
                          placeholder="Length"
                          type="number"
                          min={0}
                          {...field}
                        />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
                {showUserId && (
                  <FormField
                    control={form.control}
                    name="sUserId"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Id</FormLabel>
                        <FormControl>
                          <Input
                            type="hidden"
                            placeholder="user Id"
                            {...field}
                          />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />
                )}
                <br />

                <div></div>
                <FormField
                  control={form.control}
                  name="bMinmizePanelRotation"
                  render={({ field }) => (
                    <FormItem className="flex flex-row items-start space-x-3 space-y-0 rounded-md border p-4">
                      <FormControl>
                        <Checkbox
                          checked={field.value}
                          onCheckedChange={field.onChange}
                        />
                      </FormControl>
                      <div className="space-y-1 leading-none">
                        <FormLabel>Minimize Sheet Rotation</FormLabel>
                      </div>
                    </FormItem>
                  )}
                />
                <FormField
                  control={form.control}
                  name="bCuttingLayoutMin"
                  render={({ field }) => (
                    <FormItem className="flex flex-row items-start space-x-3 space-y-0 rounded-md border p-4">
                      <FormControl>
                        <Checkbox
                          checked={field.value}
                          onCheckedChange={field.onChange}
                        />
                      </FormControl>
                      <div className="space-y-1 leading-none">
                        <FormLabel>Minimize Sheet Rotation</FormLabel>
                      </div>
                    </FormItem>
                  )}
                />

                <FormField
                  control={form.control}
                  name="bCutDirection"
                  render={({ field }) => (
                    <FormItem className="space-y-3">
                      <FormLabel>Cut Direction</FormLabel>
                      <FormControl>
                        <RadioGroup
                          onValueChange={field.onChange}
                          defaultValue={"0"}
                          className="flex flex-col space-y-1"
                        >
                          <FormItem className="flex items-center space-x-3 space-y-0">
                            <FormControl>
                              <RadioGroupItem value="0" />
                            </FormControl>
                            <FormLabel className="font-normal">Auto</FormLabel>
                          </FormItem>
                          <FormItem className="flex items-center space-x-3 space-y-0">
                            <FormControl>
                              <RadioGroupItem value="1" />
                            </FormControl>
                            <FormLabel className="font-normal">
                              Vertical
                            </FormLabel>
                          </FormItem>
                          <FormItem className="flex items-center space-x-3 space-y-0">
                            <FormControl>
                              <RadioGroupItem value="2" />
                            </FormControl>
                            <FormLabel className="font-normal">
                              Horizontal
                            </FormLabel>
                          </FormItem>
                        </RadioGroup>
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />
                <FormField
                  control={form.control}
                  name="bRollMode"
                  render={({ field }) => (
                    <FormItem className="flex flex-row items-start space-x-3 space-y-0 rounded-md border p-4">
                      <FormControl>
                        <Checkbox
                          checked={field.value}
                          onCheckedChange={field.onChange}
                        />
                      </FormControl>
                      <div className="space-y-1 leading-none">
                        <FormLabel>Roll Mode</FormLabel>
                      </div>
                    </FormItem>
                  )}
                />
              </div>
              <div className=" flex items-center">
                <FormField
                  control={form.control}
                  name="nStockPile"
                  render={({ field }) => (
                    <>
                      <FormItem className="flex flex-row items-start space-x-3 space-y-0 rounded-md border-none p-4">
                        <FormControl>
                          <Checkbox
                            checked={field.value}
                            onCheckedChange={(isChecked) => {
                              handleToggleLayoutNumber(isChecked);
                              field.onChange(isChecked);
                            }}
                          />
                        </FormControl>
                        <div className="space-y-1 leading-none flex flex-col">
                          <FormLabel>No. of same layout</FormLabel>
                          <FormDescription>
                            0 means same for all.
                          </FormDescription>
                        </div>
                      </FormItem>
                      <br />
                    </>
                  )}
                />
                <br />
                {layoutNumber && (
                  <FormField
                    control={form.control}
                    name="nMaxLayoutSize"
                    render={({ field }) => (
                      <FormItem className=" w-[30%]">
                        <FormControl>
                          <Input
                            placeholder="No."
                            type="number"
                            min={0}
                            {...field}
                          />
                        </FormControl>

                        <FormMessage />
                      </FormItem>
                    )}
                  />
                )}
              </div>
              <DialogFooter>
                <Button type="submit" disabled={isLoading}>
                  Save changes
                </Button>
              </DialogFooter>
            </form>
          </Form>
        </DialogContent>
      </Dialog>
    </React.Fragment>
  );
};

export default SettingDailogForm;
