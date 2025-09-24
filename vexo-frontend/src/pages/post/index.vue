<template>
  <article class="post-content" v-html="compiledMarkdown"></article>
  <Comment :pid="parseInt(postId)"/>
</template>
<script lang="ts">
import { ref, onMounted, computed, Ref, watch } from 'vue';
import { getPostById } from '/@/api/post';
import Comment from '/@/components/comment/index.vue'
import { useRoute } from 'vue-router';

import marked from "marked";
import hljs from "highlight.js";
import 'highlight.js/lib/languages/json';
import 'highlight.js/lib/languages/bash';
import 'highlight.js/lib/languages/cpp';
import 'highlight.js/lib/languages/ini';
import 'highlight.js/styles/monokai-sublime.css';
import useHeaderOut from '/@/store/header';

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
  components: {Comment},
  setup() {
    const header = useHeaderOut();
    const route = useRoute();
    const content: Ref<IPost | undefined> = ref();
    const postId = ref();
    onMounted(async () => {
      const _postId = route.params.id as unknown as string;
      postId.value = parseInt(_postId);
      console.log('psotId', postId.value);
      await getPostById(postId.value).then(data => {
        content.value = data;
        header.setHeader({
          title: data.title,
          subtitle: data.date,
          svgId: Math.floor(Math.random() * 3), // 0, 1, 2 中随机选择
        })
      });
      console.log(content.value);
    });

    const compiledMarkdown = computed(() => {
      console.log(content.value);
      if(content.value){
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
          // document.querySelectorAll('.fancybox').fancybox();
        }, 300);
      }
      return marked(content.value ? content.value.content : '');
    });

    return { content, compiledMarkdown, postId };
  },
}
</script>

<style scoped>
:deep() .hljs {
  padding: 16px 20px;
}

:deep() blockquote {
  margin: 0;
}

:deep() pre,
:deep() code {
  font-family: "Roboto Mono", Monaco, courier, monospace;
  font-size: 13px;
}
:deep() p {
  line-height: 1.6em;
  padding: 8px 0px;
}
:deep() code {
  padding: 3px 5px;
  margin: 0 2px;
  border-radius: 2px;
}

:deep() h1 {
  font-size: 1.8em;
}
:deep() h2 {
  font-size: 1.5em;
}
:deep() h3 {
  margin: 1em 0;
  font-size: 1.3em;
  padding-bottom: 0.3em;
  border-bottom: 1px solid #e5e5e5;
}
:deep() h4 {
  margin: 1em 0;
  font-size: 1.2em;
}

:deep() h4:before {
  content: "#";
  color: #42b983;
  margin-right: 5px;
  font-size: 1.2em;
  font-weight: 700;
}
:deep() h5 {
  font-size: 1em;
  margin: 0.8em 0;
}

:deep() blockquote {
  margin: 1em 0;
  padding: 0 20px;
  border-left: 4px solid #42b983;
  background: #f8f8f8;
  border-bottom-right-radius: 2px;
  border-top-right-radius: 2px;
}

:deep() ul,
ol {
  overflow: auto;
  margin: 15px 0;
}

:deep() ul li,
ol li {
  padding: 5px 0;
}
:deep() img {
  max-width: 100%;
  display: block;
  margin: 20px auto;
}

:deep() figure {
  background: #f8f8f8;
  padding: 0 10px;
  border-radius: 2px;
  margin: 20px 0;
  overflow: auto;
  position: relative;
}

:deep() figure:after {
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

:deep() hr {
  border: none;
  border-bottom: 1px dashed #e5e5e5;
  margin: 30px 0;
}
</style>