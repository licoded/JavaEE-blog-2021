<template>
    <header class="header" :class="{ 'fixed-header': curLink == '/' }">
        <div class="header-container">
            <a class="home-link" href="/">
                <div class="logo"></div>
                <span>星际穿越</span>
            </a>
            <ul class="right-list">
                <li class="list-item" v-for="(item,id) in navList" :key="id">
                    <a :href="item.link" class="item-link">{{ item.name }}</a>
                    <!--                         :class="{ active: item.link == curLink }" -->
                </li>
            </ul>
        </div>
    </header>
    <div
        v-show="curLink != '/' && curLink != '/about'"
        id="article-banner"
        :style="{ backgroundImage: 'url(' + svg + ')' }"
    >
        <h2 style="transform: translateY(0px); opacity: 1;">{{ title }}</h2>
        <p class="post-date" style="transform: translateY(0px); opacity: 1;">{{ subtitle }}</p>
        <div
            v-show="curLink.slice(0, 5) == '/post'"
            class="arrow-down"
            style="transform: translateY(0px); opacity: 1;"
        >
            <a href="javascript:;"></a>
        </div>
    </div>
</template>
<script lang="ts">
import { ref, computed, onMounted } from 'vue';
import { svgList } from './svg';
import { navList } from './data';
import { useRoute } from 'vue-router';
import useHeaderOut, { useHeader } from "../store/header";

export default {
    setup() {
        const route = useRoute();
        const svg = ref();
        const title = ref();
        const subtitle = ref();
        const curLink = computed(() => {
            const header = useHeaderOut();
            title.value = header.title;
            subtitle.value = header.subtitle;
            svg.value = svgList[header.svgId];
            return route.path;
        });
        onMounted(() => {

        });
        console.log(curLink.value);

        return { navList, curLink, title, subtitle, svg };
    },
}
</script>
<style scoped>
.header {
    background: none;
    border: none;
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    z-index: 200;
    transition: background 0.5s;
}

.fixed-header {
    position: fixed;
    background-color: rgba(255, 255, 255, 0.98);
    box-shadow: 0 0 3px rgba(14, 14, 14, 0.26);
}
.fixed-header .home-link {
    color: #42b983;
}
.fixed-header .menu .icon-bar {
    background-color: #7f8c8d;
}
.fixed-header .item-link {
    color: #34495e;
}

.header-container {
    max-width: 1200px;
    height: 40px;
    margin: 0 auto;
    padding: 10px 40px;
    position: relative;
}

.logo {
    background: url("../assets/logo.png");
    background-size: contain;
    width: 40px;
    height: 40px;
    margin-right: 10px;
}

.home-link {
    display: flex;
    align-items: center;
    float: left;
    font-weight: 500;
    color: #ffffff;
    font-size: 1.5em;
    line-height: 40px;
}

.right-list {
    list-style: none;
    float: right;
    padding: 0;
}

.list-item {
    display: inline-block;
    margin: 0 8px;
}

.item-link {
    height: 40px;
    line-height: 40px;
    text-decoration: none;
    color: #ffffff;
    padding-bottom: 3px;
}

.item-link:hover {
    border-bottom: 3px solid #42b983;
}

.active {
    border-bottom: 3px solid #42b983;
}

#article-banner {
    width: 100%;
    box-sizing: border-box;
    top: 0;
    left: 0;
    padding: 100px 20px 25px 20px;
    text-align: center;
    position: relative;
    background-repeat: no-repeat;
    background-position: center;
    background-size: cover;
}
#article-banner h2 {
    margin: 0.4em 0;
    font-size: 2.2em;
    color: #ffffff;
    text-shadow: 0 0 40px #34495e;
    opacity: 0;
    transform: translateY(-20px);
    transition: all 0.4s;
}
#article-banner .post-date {
    margin: 10px 0 20px 0;
    color: #ffffff;
    opacity: 0;
    transform: translateY(-20px);
    transition: all 0.4s;
    transition-delay: 0.05s;
}
#article-banner .arrow-down {
    display: flex;
    width: 100%;
    justify-content: center;
    opacity: 0;
    transform: translateY(-20px);
    transition: all 0.4s;
    transition-delay: 0.1s;
}
#article-banner .arrow-down a {
    z-index: 4;
    display: block;
    width: 25px;
    height: 25px;
    -webkit-transform: rotate(315deg);
    transform: rotate(315deg);
    -webkit-animation-iteration-count: infinite;
    animation-iteration-count: infinite;
    border-bottom: 1px solid #ffffff;
    border-left: 1px solid #ffffff;
}
</style>