import {get, post, addPrefix, ApiPrefix} from '/@/utils/request';

const Api = addPrefix(ApiPrefix.tag, {
    list: '/list',
});

export const getTagList = () => post(Api.list);