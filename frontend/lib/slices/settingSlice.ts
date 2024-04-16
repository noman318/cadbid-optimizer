import { SETTINGS_URL } from "@/constants/urls";
import { apiSlice } from "./apiSlice";

export const settingApiSlice = apiSlice.injectEndpoints({
  endpoints: (builder) => ({
    createSetting: builder.mutation({
      query: (data) => ({
        url: `${SETTINGS_URL}`,
        body: data,
        method: "POST",
      }),
    }),
    getSingleSettings: builder.query({
      query: (id) => ({
        url: `${SETTINGS_URL}/${id}`,
      }),
    }),
  }),
});

export const { useCreateSettingMutation, useGetSingleSettingsQuery } =
  settingApiSlice;
