import {get, post} from '../Axios';
import {addPrefix, ApiPrefix} from '../Prefix';

const API = addPrefix(ApiPrefix.post, {
    getPostById: '/',
    list: '/listPublishedDetail',
    listAll: '/listAllPublishedDetail',
});

export const getPostById = (postId: number) => get(API.getPostById + postId);
export const getPostList = (param: any)=> post<IPostSummaryPage>(API.list, param);
export const getAllPostList = ()=> post<Array<IPostTitle>>(API.listAll);