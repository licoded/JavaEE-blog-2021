import { defineStore } from "pinia";
import { store } from "..";

export const usePost = defineStore({
  id: "_post_",
  state: () => ({}),
  actions: {},
});

export default function usePostOut() {
  return usePost(store);
}
