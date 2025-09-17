<template>
    <article class="article-card" v-for="(item,id) in articleList" :key="id">
        <h2 class="article-head">
            <a :href="getPostLink(item)">{{ item.title }}</a>
        </h2>
        <p class="article-date">{{ item.date }}</p>
        <div class="article-summary">{{ item.summary }}</div>
        <a class="more" :href="getPostLink(item)">阅读全文</a>
    </article>
    <div class="guide-pager">
        <a class="unvisible" href="/">
            <span class="page-arrow">←</span> Prev
        </a>
        <a href="/page/2/">
            Next
            <span class="page-arrow">→</span>
        </a>
    </div>
</template>
<script lang="ts">
import { ref, onMounted, Ref } from "vue";
import {getPostList} from '/@/api/post';
import Moment from 'moment'

export default {
    setup() {
        const articleList: Ref<Array<IPostSummary>> = ref([]);
        onMounted(async () => {
            await getPostList({}).then((data) => {
                articleList.value = data.records.map((item:any)=>{
                    item.date = Moment(item.date).format('YYYY年MM月DD日');
                    return item;
                });
            });
        });
        const getPostLink = (item: IPostSummary) => {
            return `/post/${item.id}`;
        }
        return { articleList, getPostLink };
    },
}
</script>
<style scoped>
</style>