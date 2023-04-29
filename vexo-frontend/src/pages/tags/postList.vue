<template>
    <div class="tag-list">
        <h3 class="tag-name" :id="'tag-'+tagName">{{tagName}}</h3>
        <ul class="tag-preview">
            <li v-for="(item,id) in postList" :key="id">
                <a :href="getPostLink(item)">{{item.title}}</a>
            </li>
        </ul>
    </div>
</template>
<script lang="ts">
import {defineComponent, PropType} from 'vue';
export default defineComponent({
    props: {
        tagName: {
            type: String,
            required: true,
        },
        postList: {
            type: Array as PropType<Array<IPostTitle>>,
            required: true,
        },
    },
    setup(props){
        const getPostLink = (item: IPostTitle) => {
            return `/post/${item.id}`;
        }
        return {...props, getPostLink};
    }
});
</script>
<style scoped>
.tag-list {
    margin-left: 1em;
    margin-right: 1em;
}

.tag-name {
    font-size: 1.4em;
    position: relative;
}

.tag-name:before {
    content: "#";
    color: #42b983;
    position: absolute;
    left: -0.7em;
    top: -2px;
    font-size: 1.2em;
    font-weight: 700;
}

.tag-preview {
    font-size: 1.1em;
    padding-left: 1em;
}

.tag-preview li {
    cursor: pointer;
    margin: 10px 0;
}
</style>