import { createApp } from 'vue'
import { setupStore } from "./store";
import App from './App.vue'
import router from "./router";

import ElementPlus from 'element-plus';
import 'element-plus/lib/theme-chalk/index.css';
import '/@/assets/app.css'

const app = createApp(App);
setupStore(app);
app.use(router);
app.use(ElementPlus);
app.mount('#app');
