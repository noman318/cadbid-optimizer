import { PANEL_URL } from "@/constants/urls";
import { apiSlice } from "./apiSlice";

export const panelsApiSlice = apiSlice.injectEndpoints({
  endpoints: (builder) => ({
    createPanel: builder.mutation({
      query: (data) => ({
        url: `${PANEL_URL}`,
        body: data,
        method: "POST",
      }),
    }),
    uploadPanelCsv: builder.mutation({
      query: (data) => ({
        url: `${PANEL_URL}/upload`,
        body: data,
        method: "POST",
      }),
    }),
  }),
});

export const { useCreatePanelMutation, useUploadPanelCsvMutation } =
  panelsApiSlice;
