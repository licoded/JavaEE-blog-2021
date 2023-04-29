import {get, post, addPrefix, ApiPrefix} from '/@/utils/request';

const Api = addPrefix(ApiPrefix.post, {
    getPostById: '/',
    list: '/listDetail',
    edit: '/edit',
    add: '/add',
    setState: '/setState',
    deleteList: '/deleteList',
});

export const getPostById = (postId: number) => get(Api.getPostById + postId);
export const list = (param:IParamPage) => post(Api.list, param);
export const editPost = (param:IPostAdmin) => post(Api.edit, param);
export const addPost = (param:IPostAdmin) => post(Api.add, param);
export const setPostState = (param:IParamSetState) => post(Api.setState, param);
export const deletePostList = (param:IParamPidList) => post(Api.deleteList, param);