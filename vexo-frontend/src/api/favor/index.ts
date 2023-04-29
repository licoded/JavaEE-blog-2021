import {get, post} from '../Axios';
import {addPrefix, ApiPrefix} from '../Prefix';

const API = addPrefix(ApiPrefix.comment, {
    getCommentList: '/',
    addFavor: '/addFavor/',
    subFavor: '/subFavor/',
    addComment: '/addComment'
});

export const getCommentList = (pid: number):Promise<Array<IComment>> => {
    return new Promise(async resolve=>{
        await get<Array<IComment>>(API.getCommentList + pid).then(data => {
            data.forEach((comment) => {
                comment.date = comment.date.slice(0,10);
            });
            resolve(data);
        });
    })
};
export const addCommentFavor = (commentId: number) => get(API.addFavor + commentId);
export const subCommentFavor = (commentId: number) => get(API.subFavor + commentId);
export const addComment = (params:any) => post(API.addComment, params);


import {getLocal, setLocal} from '/@/utils/storage';

const FAVORLIST = '__favor_list__';

export const addFavor = async(commentId:number) => {
    let favorArr = getLocal(FAVORLIST) || [];
    if(favorArr.indexOf(commentId)==-1){
        favorArr.push(commentId);
        setLocal(FAVORLIST, favorArr);
        await addCommentFavor(commentId);
    }else{
        favorArr = favorArr.filter((item:number)=>item!=commentId);
        setLocal(FAVORLIST, favorArr);
        await subCommentFavor(commentId);
    }
}

export const checkFavor = (commentId:number) => {
    const favorArr = getLocal(FAVORLIST) || [];
    return favorArr.filter((item:number) => item==commentId).length!=0;
}