<template>
    <el-row>
        <el-button type="primary" size="mini" @click="deleteList()">删除选中</el-button>
    </el-row>
    <el-table :data="commentList" style="width: 100%" ref="commentTable" @selection-change="changeFun">
        <el-table-column type="selection" width="55"></el-table-column>
        <el-table-column prop="post" label="博客">
            <template #default="props">
                <router-link :to="getEditLink(props.row)">{{props.row.post}}</router-link>
            </template>
        </el-table-column>
        <el-table-column label="用户">
            <template #default="props">
                <div class="fac">
                    <img :src="props.row.avator" width="24" height="24" style="border-radius: 50%;">
                    {{props.row.uname}}<span v-if="props.row.tname">@{{props.row.tname}}</span>
                </div>
            </template>
        </el-table-column>
        <el-table-column prop="msg" label="评论"></el-table-column>
        <el-table-column prop="favors" label="获赞数"></el-table-column>
    </el-table>
</template>

<script lang="ts">
import { onMounted, reactive, Ref, ref, toRefs } from 'vue';
import { useRouter } from 'vue-router';
import {list, deleteCommentList} from '/@/api/comment';
export default{
    setup(){
        const state = reactive({
            allChecked: false,
        });
        const commentList = ref()
        const commentTable = ref();
        const getData = () => list({page: 1,pageSize:15}).then(data=>{
            console.log(data);   
            commentList.value = data;
        });
        onMounted(()=>{
            getData();
        });
        const toggleAllSelection = ()=>{
            commentTable.value.toggleAllSelection();
        };
        const selected:Ref<Array<number>> = ref([]);
        const changeFun = (val:Array<IPostItem>)=>{
            const nowList = val.map(item=>{
                return item.id;
            });
            console.log(nowList);
            selected.value = nowList;
        };
        const deleteList = async () => {
            await deleteCommentList({
                cidList: selected.value,
            }).then(()=>{
                getData();
            });
        }
        const getEditLink = (item:IPostItem)=>{
            return `/post/${item.id}`;
        }
        return { 
            changeFun, deleteList,getEditLink,
            commentList, ...toRefs(state),
            toggleAllSelection, commentTable 
        };
    }
}
</script>