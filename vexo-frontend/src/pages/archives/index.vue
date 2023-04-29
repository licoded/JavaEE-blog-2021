<template>
    <div id="archives">
        <section class="time-section" v-for="(key) in keys">
            <h1 class="section-month">{{getDate(key)}}</h1>
            <div class="section-list">
                <div class="section-list-item"
                v-for="(post) in res.get(key)">
                    <p class="archive-date">
                        {{post.date.slice(8,10)}}日
                        <a
                            :href="getPostLink(post)"
                            class="archive-title"
                        >{{post.title}}</a>
                    </p>
                </div>
            </div>
        </section>
    </div>
</template>
<script lang="ts">
import {onMounted, ref} from 'vue';
import {getAllPostList} from '/@/api/post';
export default{
    setup(){
        const keys = ref();
        const res = ref();
        onMounted(()=>{
            getAllPostList().then(data=>{
                const map:Map<String,Array<IPostTitle>> = new Map();
                data.forEach(post => {
                    const key = post.date.slice(0,7);
                    const [year, month] = key.split('-');
                    console.log(parseInt(year), parseInt(month));
                    !map.get(key) && map.set(key, []);
                    const nowArr = map.get(key);
                    (nowArr as Array<IPostTitle>).push(post);
                    map.set(key, (nowArr as Array<IPostTitle>));
                });
                keys.value = map.keys();
                console.log(map.keys());
                
                res.value = map;
                console.log(map);
            });
        });
        const getDate = (key:string) => {
            console.log('getDate', key);
            let [year, month] = key.split('-');
            let year2 = parseInt(year);
            let month2 = parseInt(month)
            return `${year2}年 ${month2}月`;
        }
        const getPostLink = (item: IPostTitle) => {
            return `/post/${item.id}`;
        }
        return {res, getDate, keys, getPostLink};
    }
}
</script>
<style scoped>
#archives:before {
    position: absolute;
    top: 2em;
    bottom: 1em;
    left: 30px;
    height: auto;
    content: "";
    background-color: #42b983;
    width: 4px;
}

.time-section {
    padding-left: 30px;
    position: relative;
}

.time-section .section-month {
    cursor: pointer;
    font-size: 1.8em;
    margin-left: 10px;
}

.time-section .section-month:before {
    position: absolute;
    left: 8px;
    top: 11px;
    content: "";
    background-color: #ffffff;
    width: 12px;
    height: 12px;
    border: 2px solid #42b983;
    border-radius: 50%;
}

.time-section .section-list .section-list-item {
    margin: 20px 0 20px 10px;
    position: relative;
}
.time-section .section-list .section-list-item:before {
    position: absolute;
    left: -29px;
    top: 7px;
    content: "";
    background-color: #42b983;
    width: 10px;
    height: 10px;
    border-radius: 50%;
}

.time-section .section-list .section-list-item .archive-title {
    color: #34495e;
    transition: all 0.3s ease;
    font-size: 1.1em;
}

.time-section .section-list .section-list-item .archive-title:hover {
    color: #42b983;
    padding-left: 10px;
}

.time-section .section-list .section-list-item .archive-date {
    color: #7f8c8d;
    font-size: 0.9em;
    margin: 5px 0;
}
</style>