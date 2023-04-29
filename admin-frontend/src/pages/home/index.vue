<template>
<el-col style="width: 500px;">
    <el-card class="box-card" shadow="hover">
        <template #header>
            <div class="card-header">
                <span>博客总览</span>
            </div>
        </template>
        <div>
            博文总数: {{postNum}}<br><br>
            评论总数: {{commentNum}}<br><br>
            点赞总数: {{favorNum}}<br><br>
            阅读总数: {{readNum}}<br><br>
        </div>
    </el-card>
</el-col>
</template>
<script lang="ts">
import {ref} from 'vue';
import * as post from '/@/api/post';
import * as comment from '/@/api/comment';
export default{
    setup(){
        const postNum = ref();
        const commentNum = ref();
        const favorNum = ref(0);
        const readNum = ref(0);
        post.list({}).then(data=>{
            postNum.value = data.records.length;
            data.records.forEach((item:any) => {
                readNum.value += item.readNum;
            });
        });
        comment.list({}).then(data=>{
            commentNum.value = data.length;
            data.forEach((item:any) => {
                favorNum.value += item.favors;
            });
        });
        return {postNum, commentNum, favorNum, readNum};
    }
}
</script>