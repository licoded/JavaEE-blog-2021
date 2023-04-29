import { defineStore } from "pinia";
import { store} from "..";
import {getLocal} from '/@/utils/storage'

const STORAGE_KEY = "_user_info_";

export const useUserInfo = defineStore({
  id: STORAGE_KEY,
  state(){
    const data = getLocal(STORAGE_KEY) || {};
    console.log(data);
    return {
      userInfo: {
          userId: data?.userId,
          username: data?.username,
          token: data?.token,
          avatar: data?.avatar,
      },
    }
  },
  actions: {
    setUserInfo(info:IUserInfo){
        this.userInfo = info;
    },
    getUserInfo(){
        return this.userInfo;
    }
  },
});

export function useUserInfoOut() {
  return useUserInfo(store);
}
