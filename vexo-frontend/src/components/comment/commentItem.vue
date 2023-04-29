<template>
    <div class="user fac">
        <div class="left fac">
            <img class="avatar" :src="item.avatar" width="24" height="24" />
            <span>{{ item.uname }}</span>
            <span v-if="isChild" style="color: #8590a6">回复</span>
            <span v-if="isChild" >{{ item.tname }}</span>
        </div>
        <div class="right">
            {{ item.date }}
        </div>
    </div>
    <div class="content">
        <div class="content-text">{{ item.msg }}</div>
        <div class="info fac">
            <div class="zan-btn fac" @click="addCommentFavor(item.id)">
                <svg class="zan-icon" :style="{color: checkFavor(item.id)?'#06f':'#8590a6'}" fill="currentColor" viewBox="0 0 24 24" width="16" height="16" style="margin-right: 5px;"><path d="M14.445 9h5.387s2.997.154 1.95 3.669c-.168.51-2.346 6.911-2.346 6.911s-.763 1.416-2.86 1.416H8.989c-1.498 0-2.005-.896-1.989-2v-7.998c0-.987.336-2.032 1.114-2.639 4.45-3.773 3.436-4.597 4.45-5.83.985-1.13 3.2-.5 3.037 2.362C15.201 7.397 14.445 9 14.445 9zM3 9h2a1 1 0 0 1 1 1v10a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V10a1 1 0 0 1 1-1z" fill-rule="evenodd"></path></svg>
                <span>{{ item.favors }}</span>
            </div>
            <div class="reply-btn fac" @click="changeReply(item.id)">
                <svg class="reply-icon" fill="currentColor" viewBox="0 0 24 24" width="16" height="16" style="margin-right: 5px;"><path d="M22.959 17.22c-1.686-3.552-5.128-8.062-11.636-8.65-.539-.053-1.376-.436-1.376-1.561V4.678c0-.521-.635-.915-1.116-.521L1.469 10.67a1.506 1.506 0 0 0-.1 2.08s6.99 6.818 7.443 7.114c.453.295 1.136.124 1.135-.501V17a1.525 1.525 0 0 1 1.532-1.466c1.186-.139 7.597-.077 10.33 2.396 0 0 .396.257.536.257.892 0 .614-.967.614-.967z" fill-rule="evenodd"></path></svg>
                <span>{{show?'取消回复':'回复'}}</span>
            </div>
        </div>
        <Reply :show="show" @submitReply="submitReply"/>
    </div>
</template>
<script lang="ts">
import { ref, defineComponent, PropType } from 'vue'
import Reply from './reply.vue';
import {checkFavor, addFavor, addComment} from '/@/api/favor'
import {getUserInfo} from '/@/api/userInfo'
export default defineComponent({
    props: {
        item: {
            type: Object as PropType<IComment>,
            required: true
        },
        show: {
            type: Boolean,
            required: true
        },
        isChild: {
            type: Boolean,
            required: true
        },
        postId: {
            type: Number,
            required: true
        }
    },
    emits:['changeReply','refresh'],
    components:{Reply},
    setup(props, ctx) {
        const changeReply = (id: number) => {
            console.log(id);
            ctx.emit('changeReply', id);
        }
        const addCommentFavor = async (id: number) => {
            await addFavor(id);
            ctx.emit('refresh');
        }
        const submitReply = async(msg:string) => {
            console.log({
                pid: props.postId, 
                msg,
                cid: props.item.id,
                uname: getUserInfo().uname,
                avatar: getUserInfo().avatar,
            });
            
            await addComment({
                pid: props.postId, 
                msg,
                cid: props.item.id,
                uname: getUserInfo().uname,
                avatar: getUserInfo().avatar,
            });
            ctx.emit('changeReply', props.item.id);
            ctx.emit('refresh');
        }
        return { changeReply, checkFavor, addCommentFavor, submitReply };
    }
});
</script>

<style scoped>
.user{
    justify-content: space-between;
}
.left .avatar {
    border-radius: 50%;
}
.left span{
    margin-left: 8px;
}
.info{
    margin-top: 10px;
}
.info div{
    margin-right: 10px;
}
.content{
    margin-left: 24px;
    font-size: 16px;
    color: #303133;
    line-height: 20px;
    padding-bottom: 10px;
    border-bottom: 1px solid #f2f6fc;
}
.content .content-text{
    margin-top: 10px;
}
</style>