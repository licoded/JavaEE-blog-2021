import { createApp, watch } from "vue";
import router from "./router";
import { setupStore } from "./store";
import useHeaderOut from "./store/header";
import App from "./layouts/App.vue";


const app = createApp(App);
setupStore(app);
app.use(router);

// 初始化header store的document.title同步
const header = useHeaderOut();
// 监听title变化并自动更新document.title
watch(() => header.appTitle, (newTitle) => {
  document.title = newTitle;
}, {
  immediate: true
});

app.mount("#app");

import NProgress from 'nprogress';
import 'nprogress/nprogress.css';
NProgress.configure({     
    easing: 'ease',  // 动画方式    
    speed: 500,  // 递增进度条的速度    
    showSpinner: false, // 是否显示加载ico    
    trickleSpeed: 200, // 自动递增间隔    
    minimum: 0.3 // 初始化时的最小百分比
});
