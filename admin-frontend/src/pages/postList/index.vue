<template>
    <el-row type="flex" justify="space-between">
        <el-row class="fac">
            <!-- <el-checkbox v-model="allChecked" style="padding: 14px;" @click="toggleAllSelection"></el-checkbox> -->
            <el-button type="primary" size="mini" @click="deleteList()">删除选中</el-button>
            <el-button type="primary" size="mini" @click="setState(true)">发布选中</el-button>
            <el-button type="primary" size="mini" @click="setState(false)">取消发布</el-button>
        </el-row>
        <el-row>
            <el-button type="primary" size="mini" @click="newPost">新增博文</el-button>
        </el-row>
    </el-row>
    <el-table :data="postList" style="width: 100%" ref="postTable" @selection-change="changeFun">
        <el-table-column type="selection" width="55"></el-table-column>
        <el-table-column prop="title" label="标题">
            <template #default="props">
                <router-link :to="getEditLink(props.row)">{{props.row.title}}</router-link>
            </template>
        </el-table-column>
        <el-table-column prop="date" label="日期"></el-table-column>
        <el-table-column prop="published" label="是否发布"></el-table-column>
        <el-table-column type="expand">
            <template #default="props">
                {{props.row.summary}}
            </template>
        </el-table-column>
    </el-table>
</template>

<script lang="ts">
import { log } from 'console';
import { onMounted, reactive, Ref, ref, toRefs } from 'vue';
import { useRouter } from 'vue-router';
import {list, setPostState, deletePostList} from '/@/api/post';
export default{
    setup(){
        const state = reactive({
            allChecked: false,
        });
        const postTable = ref();
        const postList = ref([
            {
                "id": 1,
                "title": "Ubuntu服务器搭建Ghost博客",
                "date": "2021-06-11 00:00:00"
            }
        ]);
        const getData = () => list({page: 1,pageSize:15}).then(data=>{
            console.log(data);   
            postList.value = data.records;
        });
        onMounted(()=>{
            getData();
        });
        const toggleAllSelection = ()=>{
            postTable.value.toggleAllSelection();
        };
        const router = useRouter();
        const newPost = () => {
            router.push('/post/new');
        }
        const getEditLink = (item:IPostItem)=>{
            return `/post/${item.id}`;
        }
        const selected:Ref<Array<number>> = ref([]);
        const changeFun = (val:Array<IPostItem>)=>{
            const nowList = val.map(item=>{
                return item.id;
            });
            console.log(nowList);
            selected.value = nowList;
        };
        const setState = async (flag:boolean) => {
            await setPostState({
                pidList: selected.value,
                published: flag,
            }).then(()=>{
                getData();
            });
        }
        const deleteList = async () => {
            await deletePostList({
                pidList: selected.value,
            }).then(()=>{
                getData();
            });
        }
        return { 
            newPost, getEditLink, setState, changeFun, deleteList,
            postList, ...toRefs(state),
            toggleAllSelection, postTable 
        };
    }
}
</script>