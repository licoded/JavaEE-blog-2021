import {get, post, addPrefix, ApiPrefix} from '/@/utils/request';

const Api = addPrefix(ApiPrefix.user, {
    token: '/token',
    register: '/register',
});

export const getToken = (param:IParamLogin) => post(Api.token, param);
export const register = (param:IParamLogin) => post(Api.register, param);