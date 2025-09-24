import { createRouter, createWebHistory } from "vue-router";
import useHeaderOut from "../store/header";
import Home from "../pages/home/index.vue";

import { NextLoading } from '/@/utils/loading';
// import NProgress from 'nprogress';

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: "/",
      component: Home,
    },
    {
      path: "/tags",
      component: () => import("../pages/tags/index.vue"),
    },
    {
      path: "/archives",
      component: () => import("../pages/archives/index.vue"),
    },
    {
      path: "/about",
      component: () => import("../pages/about/index.vue"),
    },
    {
      path: "/post/:id",
      component: () => import("../pages/post/index.vue"),
    },
    {
      path: "/comment",
      component: () => import("../pages/comment/index.vue"),
    },
  ],
});

const rand = (L: number, R: number) => {
  const num = Math.random() * (R - L) + L;
  return Math.round(num);
};

router.beforeEach(async (to, from, next) => {
  NextLoading.start();
  // NProgress.start();
  const header = useHeaderOut();
  if (to.path.slice(0, 5) == "/post") {
  } else if (to.path.slice(0, 5) == "/tags") {
    header.setHeader({ title: "Tags", subtitle: "标签检索", svgId: 0 });
  } else if (to.path.slice(0, 9) == "/archives") {
    header.setHeader({ title: "Archives", subtitle: "文章归档", svgId: 1 });
  } else if (to.path.slice(0, 6) == "/about") {
    header.setHeader({ title: "About", subtitle: "关于我", svgId: 2 });
  }
  window.scrollTo(0, 0);
  next();
});

router.afterEach(()=>{
    // NProgress.done();
    NextLoading.done();
    console.log('fsf');
})

export default router;
