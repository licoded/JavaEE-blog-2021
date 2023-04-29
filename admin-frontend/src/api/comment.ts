import {get, post, addPrefix, ApiPrefix} from '/@/utils/request';

const Api = addPrefix(ApiPrefix.comment, {
    list: '/list',
    deleteList: '/deleteList',
});

export const list = (param:IParamPage) => post(Api.list, param);
export const deleteCommentList = (param:IParamCidList) => post(Api.deleteList, param);