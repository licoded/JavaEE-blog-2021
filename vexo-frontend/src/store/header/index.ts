import { defineStore } from "pinia";
import { store } from "..";

export const useHeader = defineStore({
  id: "_header_",
  state: () => ({
    svgId: 0,
    title: "",
    subtitle: "",
  }),
  actions: {
    setHeader(header: IHeader) {
      console.log(header);

      this.svgId = header.svgId;
      this.title = header.title;
      this.subtitle = header.subtitle;
    },
    getHeader() {
      return { title: this.title, subtitle: this.subtitle, svgId: this.svgId };
    },
  },
});

export default function useHeaderOut() {
  return useHeader(store);
}
