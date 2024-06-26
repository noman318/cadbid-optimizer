import { PANEL_URL } from "@/constants/urls";
import { apiSlice } from "./apiSlice";

export const panelsApiSlice = apiSlice.injectEndpoints({
  endpoints: (builder) => ({
    getAllPanels: builder.query({
      query: () => ({
        url: `${PANEL_URL}`,
      }),
      keepUnusedDataFor: 5,
    }),
    getSinglePanel: builder.query({
      query: (id) => ({
        url: `${PANEL_URL}/${id}`,
      }),
      keepUnusedDataFor: 5,
    }),
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
    deletePanel: builder.mutation({
      query: (id) => ({
        url: `${PANEL_URL}/${id}`,
        method: "DELETE",
      }),
    }),
    updatePanel: builder.mutation({
      query: ({ id, data }) => ({
        url: `${PANEL_URL}/${id}`,
        method: "PUT",
        body: data,
      }),
    }),
  }),
});

export const {
  useCreatePanelMutation,
  useUploadPanelCsvMutation,
  useGetAllPanelsQuery,
  useGetSinglePanelQuery,
  useDeletePanelMutation,
  useUpdatePanelMutation,
} = panelsApiSlice;
