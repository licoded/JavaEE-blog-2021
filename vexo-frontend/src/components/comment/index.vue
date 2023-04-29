<template>
  <div class="wrapper">
    <div class="comment" v-if="comments.length==0" style="text-align: center; padding: 20px 0;">
      暂时还没有评论！
    </div>
    <div class="comment" v-for="(item,id) in comments" :key="id">
      <comment-item :isChild="false" :item="item" :postId="pid" :show="now == item.id" @changeReply="changeReply" @refresh="refreshComments"/>
      <div class="reply">
        <div class="item" v-for="(replyItem,id) in item.children" :key="id">
          <comment-item :isChild="true" :item="replyItem" :postId="pid" :show="now == replyItem.id" @changeReply="changeReply" @refresh="refreshComments"/>
        </div>
      </div>
    </div>
    <Reply :show="true" style="padding: 0 20px;" @submitReply="submitReply"/>
  </div>
</template>

<script lang="ts">
import { ref,watch, onMounted, defineComponent, mergeProps } from 'vue';
import Reply from './reply.vue';
import CommentItem from './commentItem.vue';
import { addComment, getCommentList } from '/@/api/favor';
import {getUserInfo} from '/@/api/userInfo'
export default defineComponent({
  props: {
    pid: {
      type: Number,
      required: true
    },
  },
  components: { Reply, CommentItem },
  setup(props) {
    const inputComment = ref();
    const now = ref();
    const changeReply = (id: string) => {
      if(now.value!=id){
        now.value = id;
      }else{
        now.value = -1;
      }
    }
    const comments = ref([] as Array<IComment>);
    const refreshComments = async()=>{
        await getCommentList(props.pid).then(data => {
            comments.value = data;
        });
    }
    onMounted(async () => {
        // await refreshComments();
    });
    watch(()=>props.pid, async (val)=>{
      await refreshComments();
    });
    const submitReply = async(inputVal:string) => {
      console.log({
        pid: props.pid, 
        msg: inputVal, 
        cid:-1,
        uname: getUserInfo().uname,
        avatar: getUserInfo().avatar,
      });
      await addComment({
        pid: props.pid, 
        msg: inputVal, 
        cid:-1,
        uname: getUserInfo().uname,
        avatar: getUserInfo().avatar,
      });
      await refreshComments();
    }
    return { inputComment, changeReply, now, comments, refreshComments, submitReply };
  }
});
</script>
<style scoped lang="scss">

.wrapper{
  border-radius: 4px;
  box-shadow: 0 1px 3px rgb(18 18 18 / 10%);
  border: 1px solid #ebebeb;
  padding-bottom: 20px;
}
.comment {
  padding: 20px 20px 0 20px;
  display: flex;
  flex-direction: column;
}

.reply {
  margin-left: 24px;
  .item {
    padding-top: 10px;
  }
}
</style>