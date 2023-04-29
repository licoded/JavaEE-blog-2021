import { defineStore } from "pinia";
import { store, loadStroage } from "..";

const STORAGE_KEY = "_menu_list_";

export const useMenuList = defineStore({
  id: STORAGE_KEY,
  state(){
    return {
      menuList: loadStroage(STORAGE_KEY, [
        {name: '首页', link: '/home', display: true, icon:'el-icon-s-home'},
        {name: '博客管理', link: '/postList', display: true, icon:'el-icon-document'},
        {name: '博客', link: '/post/', display: false, icon:'el-icon-document'},
        {name: '评论管理', link: '/commentList', display: true, icon:'el-icon-s-comment'},
        {name: '登录', link: '/login', display: false},
      ]),
    }
  },
  actions: {
    setMenuList(list:any){
        this.menuList = list;
    },
    getMenuList(){
        return this.menuList;
    }
  },
});

export function useMenuListOut() {
  return useMenuList(store);
}
