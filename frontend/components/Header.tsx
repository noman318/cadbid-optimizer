"use client";

import React from "react";
import { Button } from "./ui/button";
import { FaPlay, FaDownload } from "react-icons/fa";
import { IoSettingsSharp } from "react-icons/io5";
import { MdDashboard } from "react-icons/md";
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import { Label } from "@/components/ui/label";
import { z } from "zod";
import { zodResolver } from "@hookform/resolvers/zod";
import { useForm, SubmitHandler } from "react-hook-form";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { Checkbox } from "./ui/checkbox";
import {
  useCreateSettingMutation,
  useGetSingleSettingsQuery,
} from "@/lib/slices/settingSlice";

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
  bCutDirection: z.boolean().default(false),
  bRollMode: z.boolean().default(false),
  userId: z.string().min(8).max(80),
});

const Header = () => {
  const [createSetting, { data, isLoading, isError }] =
    useCreateSettingMutation();

  let showUserId = false;

  const [settings, { data: settingData }] = useCreateSettingMutation();
  // console.log("settingData", settingData);
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
      bCutDirection: false,
      bRollMode: false,
      userId: "37c32313-99ad-4d70-90d3-d8fe0df2f823",
    },
  });

  async function onSubmit(values: z.infer<typeof formSchema>) {
    // ✅ This will be type-safe and validated.
    console.log("values", values);
    try {
      await createSetting(values).unwrap();
      alert("Created setting");
    } catch (error: any) {
      console.log("error", error);
      alert(`${error} error`);
    }
  }
  return (
    <header className="flex items-center justify-between w-full p-2 bg-slate-900 sticky top-0 z-20">
      <div className=" flex items-center gap-2">
        <MdDashboard color="white" size={"30px"} />
        <h1 className=" text-xl font-semibold text-white">Cutlist Optimizer</h1>
      </div>
      <div className="mx-2">
        <Button className="mr-2 bg-green-600 hover:bg-green-500 transition-colors duration-300">
          <FaPlay /> Calculate
        </Button>
        <Button className="mr-2">
          <FaDownload />
          Save
        </Button>
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
              <form
                onSubmit={form.handleSubmit(onSubmit)}
                className="space-y-8"
              >
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
                            type="number"
                            {...field}
                          />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  /> */}
                  <FormField
                    control={form.control}
                    name="nMaxLayoutSize"
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Max Layout Size</FormLabel>
                        <FormControl>
                          <Input
                            placeholder="Length"
                            type="number"
                            {...field}
                          />
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />
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
                      name="userId"
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
                  <br />
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
                          <FormLabel>Minimize Layout Number</FormLabel>
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
                      <FormItem className="flex flex-row items-start space-x-3 space-y-0 rounded-md border p-4">
                        <FormControl>
                          <Checkbox
                            checked={field.value}
                            onCheckedChange={field.onChange}
                          />
                        </FormControl>
                        <div className="space-y-1 leading-none">
                          <FormLabel>Cut Direction</FormLabel>
                        </div>
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
                <DialogFooter>
                  <Button type="submit" disabled={isLoading}>
                    Save changes
                  </Button>
                </DialogFooter>
              </form>
            </Form>
          </DialogContent>
        </Dialog>

        <Button className="mr-2">Sign In</Button>
      </div>
    </header>
  );
};

export default Header;
