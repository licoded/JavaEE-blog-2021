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
  },
  getters: {
    appTitle(): string {
      if (!this.title) {
        return "星际穿越 | Licoded's Blog";
      }
      return `${this.title} | 星际穿越`;
    }
  },
});

export default function useHeaderOut() {
  return useHeader(store);
}
