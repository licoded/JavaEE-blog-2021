import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

import { resolve } from "path";

function pathResolve(dir: string) {
  return resolve(process.cwd(), ".", dir);
}

// https://vitejs.dev/config/
export default defineConfig({
  base: "/",
  server: {
    host: "0.0.0.0",
    port: 3100,
    proxy: {
      "/api": {
        target: "http://127.0.0.1:9345/",
        changeOrigin: true,
        ws: true,
        rewrite: (path) => path.replace(/^\/api/, ""),
        // rewrite: (path) => path.replace(new RegExp(`^api`), ""),
      },
    },
  },
  plugins: [
    vue({
      template: {
        compilerOptions: {
          // “不要自作主张，所有标签你都应该尝试作为 Vue 组件来解析”，从而强制让 Vue DevTools 能够“看到”并检查所有组件
          // 整个配置项是用来跳过一些第三方的元素/组件，比如 Web Component 库的标签的，比如 <ion-icon>，不然 Vue 会报错
          isCustomElement: (tag) => false,
        },
      },
    }),
  ],
  define: {
    // 启用 Vue DevTools
    __VUE_OPTIONS_API__: true,
    __VUE_PROD_DEVTOOLS__: true,
  },
  resolve: {
    alias: [
      // /@/xxxx => src/xxxx
      {
        find: /\/@\//,
        replacement: pathResolve("src") + "/",
      },
      // /#/xxxx => src/xxxx
      {
        find: /\/#\//,
        replacement: pathResolve("src/components") + "/",
      },
    ],
  },
})
