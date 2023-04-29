import {get, post} from '../Axios';
import {addPrefix, ApiPrefix} from '../Prefix';

const Api = addPrefix(ApiPrefix.tag, {
    list: '/list',
    getPostListByTag: '/getPostListByTag/',
    getPostListArrGroupByTag: '/getPostListArrGroupByTag/',
});

export const getTagList = () => post<Array<String>>(Api.list);
export const getPostListArrGroupByTag = () => post<Array<ITagPostList>>(Api.getPostListArrGroupByTag);
export const getPostListByTag = (tagName:string) => post<Array<IPostTitle>>(Api.getPostListByTag + tagName);