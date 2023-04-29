<template>
    <div id="tag-cloud">
        <a v-for="(tag,id) in allTags" :class="'tag'+(id%3+1)" :data-name="'tag-'+tag">{{tag}}</a>
    </div>
    <PostList v-for="(tag,id) in allTags"  :tag-name="tag"/>
</template>
<script lang="ts">
import { onMounted, ref } from 'vue';
import {getTagList} from '/@/api/tag';
import PostList from './postList.vue'
export default{
    components: {PostList},
    setup(){
        const allTags = ref();
        onMounted(async()=>{
            await getTagList().then(data=>{
                allTags.value = data;
            });
        });
        return {allTags};
    }
}
</script>
<style scoped>
#tag-cloud {
    margin: 30px 0;
    text-align: center;
}

#tag-cloud a {
    border: none;
    line-height: 28px;
    margin: 0 4px;
    margin-bottom: 8px;
    background: #63a35c;
    display: inline-block;
    border-radius: 4px;
    padding: 0 10px;
    color: #ffffff;
    transition: background 0.5s;
}

#tag-cloud a:hover {
    background: rgb(0, 133, 161);
}

#tag-cloud .tag0 {
    background: #bbe;
}

#tag-cloud .tag1 {
    background: #9cb2e1;
}

#tag-cloud .tag2 {
    background-color: rgba(0, 133, 161, 0.8);
}
</style>