import {getPostById} from '/@/api/post'

export const getPost = (postId: number) => getPostById(postId)
