import {get, post} from "./axios";

export {get, post};

export const ApiPrefix = {
    user: '/user',
    post: '/post',
    tag: '/tag',
    comment: '/comment',
};

export function addPrefix(URL_PREFIX:string, API:IApi) {
  for (let key in API) {
    API[key] = URL_PREFIX + API[key];
  }
  return API;
}