import {getLocal, setLocal} from '/@/utils/storage';

const USERINFO = '__user_info__';

export const getUserInfo = () => {
    const userInfo = getLocal(USERINFO) || {uname:'Licoded',avatar:'http://ww1.sinaimg.cn/bmiddle/006DLFVFgy1ft0j2q2p8pj30v90uzmzz.jpg'};
    return userInfo;
}

export const setUserInfo = (userInfo:any) => {
    setLocal(USERINFO, userInfo);
}