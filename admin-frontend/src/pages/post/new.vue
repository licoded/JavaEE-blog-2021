<template>
<el-form ref="form" label-width="40px">
  <el-form-item label="标题">
    <el-input v-model="title"></el-input>
  </el-form-item>
  <el-form-item label="摘要">
    <el-input type="textarea" placeholder="请输入内容" :autosize="true" v-model="summary"/>
  </el-form-item>
  <el-form-item label="标签">
    <el-select
    v-model="tags"
    multiple
    filterable
    allow-create
    default-first-option
    placeholder="请选择文章标签">
    <el-option v-for="item in tagOptions"  :key="item" :label="item" :value="item">
    </el-option>
  </el-select>
  </el-form-item>
  <el-form-item label="日期">
    <el-date-picker
      v-model="date"
      type="datetime"
      placeholder="选择日期时间">
    </el-date-picker>
  </el-form-item>
  <el-form-item>
    <el-button type="primary" @click="onSubmit">立即提交</el-button>
  </el-form-item>
  <el-form-item>
    <el-row :gutter="20">
    <el-col :span="12">
      <div class="grid-content bg-purple">
        <el-input type="textarea" placeholder="请输入内容" :autosize="true" v-model="content"/>
      </div>
    </el-col>
    <el-col :span="12">
      <article class="post-content" v-html="compiledMarkdown"></article>
    </el-col>
  </el-row>
  </el-form-item>
</el-form>
  </template>
  <script lang="ts">
  import { ref, onMounted, computed, Ref, reactive, toRefs } from 'vue';
  import { addPost } from '/@/api/post';
  import { getTagList } from '/@/api/tag'
  import { useRoute, useRouter } from 'vue-router';
  
import Moment from 'moment';

  import marked from "marked";
  import hljs from "highlight.js";
  import 'highlight.js/lib/languages/json';
  import 'highlight.js/lib/languages/bash';
  import 'highlight.js/lib/languages/cpp';
  import 'highlight.js/lib/languages/ini';
  import 'highlight.js/styles/monokai-sublime.css';
  
  marked.setOptions({
    renderer: new marked.Renderer(),
    highlight: (code) => {
      return hljs.highlightAuto(code).value;
    },
    pedantic: false,
    gfm: true,
    breaks: false,
    sanitize: false,
    smartLists: true,
    smartypants: false,
    xhtml: false
  }
  );
  
  export default {
    setup() {
      const router = useRouter();
      const tagOptions = ref([]);
      const post = reactive({
        id: 0,
        content: '',
        title: '',
        tags: [],
        date: '',
        summary: '',
        published: false,
      });
      onMounted(async () => {
        await getTagList().then((data)=>{
          tagOptions.value = data;
        });
      });
      const compiledMarkdown = computed(() => {
          setTimeout(() => {
            console.log('begin');
            document.querySelectorAll('pre').forEach(item => item.classList.add('hljs'));
            document.querySelectorAll('article img').forEach(item => {
              console.log(item);
              let element = document.createElement("a");
              element.setAttribute('class', 'fancybox');
              element.setAttribute('rel', 'group');
              element.setAttribute('href', (item.getAttribute('src')as string).split('?')[0]);
              element.setAttribute('title', '点击图片可查看高清大图');
              item.parentNode?.insertBefore(element, item);
              element.appendChild(item);
            });
          }, 300);
        return marked(post.content);
      });
      const onSubmit = async()=>{
        const myPost = post;
        myPost.date = Moment(myPost.date).format("yyyy-MM-DD HH:mm:ss");
        await addPost(post).then(id=>{
          router.push(`/post/${id}`);
        });
      }
      return { compiledMarkdown, ...toRefs(post), tagOptions, onSubmit };
    },
  }
  </script>
  
  <style scoped>
  :deep() article.post-content .hljs {
    padding: 16px 20px;
    line-height: 14px;
  }
  
  :deep() article.post-content blockquote {
    margin: 0;
  }
  
  :deep() article.post-content pre,
  :deep() article.post-content code {
    font-family: "Roboto Mono", Monaco, courier, monospace;
    font-size: 13px;
  }
  :deep() article.post-content p {
    line-height: 1.6em;
    padding: 8px 0px;
  }
  :deep() article.post-content code {
    padding: 3px 5px;
    margin: 0 2px;
    border-radius: 2px;
  }
  
  :deep() article.post-content h1 {
    font-size: 1.8em;
  }
  :deep() article.post-content h2 {
    font-size: 1.5em;
  }
  :deep() article.post-content h3 {
    margin: 1em 0;
    font-size: 1.3em;
    padding-bottom: 0.3em;
    border-bottom: 1px solid #e5e5e5;
  }
  :deep() article.post-content h4 {
    margin: 1em 0;
    font-size: 1.2em;
  }
  
  :deep() article.post-content h4:before {
    content: "#";
    color: #42b983;
    margin-right: 5px;
    font-size: 1.2em;
    font-weight: 700;
  }
  :deep() article.post-content h5 {
    font-size: 1em;
    margin: 0.8em 0;
  }
  
  :deep() article.post-content blockquote {
    margin: 1em 0;
    padding: 0 20px;
    border-left: 4px solid #42b983;
    background: #f8f8f8;
    border-bottom-right-radius: 2px;
    border-top-right-radius: 2px;
  }
  
  :deep() article.post-content ul,
  ol {
    overflow: auto;
    margin: 15px 0;
  }
  
  :deep() article.post-content ul li,
  ol li {
    padding: 5px 0;
  }
  :deep() article.post-content img {
    max-width: 100%;
    display: block;
    margin: 20px auto;
  }
  
  :deep() article.post-content figure {
    background: #f8f8f8;
    padding: 0 10px;
    border-radius: 2px;
    margin: 20px 0;
    overflow: auto;
    position: relative;
  }
  
  :deep() article.post-content figure:after {
    content: attr(data-lang);
    position: absolute;
    top: 0;
    right: 0;
    color: #ccc;
    text-align: right;
    font-size: 0.7em;
    padding: 5px 10px 0;
    line-height: 15px;
    height: 15px;
    font-weight: 500;
  }
  
  :deep() article.post-content hr {
    border: none;
    border-bottom: 1px dashed #e5e5e5;
    margin: 30px 0;
  }
  </style>