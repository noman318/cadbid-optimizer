import { STOCK_SHEETS_URL } from "@/constants/urls";
import { apiSlice } from "./apiSlice";

export const stocksApiSlice = apiSlice.injectEndpoints({
  endpoints: (builder) => ({
    getAllStockSheets: builder.query({
      query: () => ({
        url: `${STOCK_SHEETS_URL}`,
      }),
      keepUnusedDataFor: 5,
    }),
    getSingleSheet: builder.query({
      query: (id) => ({
        url: `${STOCK_SHEETS_URL}/${id}`,
      }),
      keepUnusedDataFor: 5,
    }),
    createStock: builder.mutation({
      query: (data) => ({
        url: `${STOCK_SHEETS_URL}`,
        body: data,
        method: "POST",
      }),
    }),
    uploadStocksCsv: builder.mutation({
      query: (data) => ({
        url: `${STOCK_SHEETS_URL}/upload`,
        body: data,
        method: "POST",
      }),
    }),
    deleteStock: builder.mutation({
      query: (id) => ({
        url: `${STOCK_SHEETS_URL}/${id}`,
        method: "DELETE",
      }),
    }),
  }),
});

export const {
  useCreateStockMutation,
  useUploadStocksCsvMutation,
  useGetAllStockSheetsQuery,
  useGetSingleSheetQuery,
  useDeleteStockMutation,
} = stocksApiSlice;
