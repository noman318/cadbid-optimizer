import { STOCK_SHEETS_URL } from "@/constants/urls";
import { apiSlice } from "./apiSlice";

export const stocksApiSlice = apiSlice.injectEndpoints({
  endpoints: (builder) => ({
    createStock: builder.mutation({
      query: (data) => ({
        url: `${STOCK_SHEETS_URL}/create`,
        body: data,
        method: "POST",
      }),
    }),
  }),
});

export const { useCreateStockMutation } = stocksApiSlice;
