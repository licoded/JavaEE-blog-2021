import {get, post} from '../Axios';
import {addPrefix, ApiPrefix} from '../Prefix';

const Api = addPrefix(ApiPrefix.tag, {
    list: '/list',
    getPostListByTag: '/getPostListByTag/',
});

export const getTagList = () => post(Api.list);
export const getPostListByTag = (tagName:string) => post<Array<IPostTitle>>(Api.getPostListByTag + tagName);