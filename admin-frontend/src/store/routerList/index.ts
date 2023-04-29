import { defineStore } from "pinia";
import { store, loadStroage } from "..";

const STORAGE_KEY = "_router_list_";

export const useRouterList = defineStore({
  id: STORAGE_KEY,
  state(){
    return {
      routerList: loadStroage(STORAGE_KEY, []),
    }
  },
  actions: {
    setRouterList(list:any){
        this.routerList = list;
    },
    getRouterList(){
        return this.routerList;
    }
  },
});

export function useRouterListOut() {
  return useRouterList(store);
}
