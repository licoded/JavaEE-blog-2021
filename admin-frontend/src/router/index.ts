import { createRouter, createWebHistory } from "vue-router";
import NProgress from 'nprogress';
import 'nprogress/nprogress.css';
import { NextLoading } from '/@/utils/loading';
import { clearSession, getLocal } from '/@/utils/storage';
import Home from "../pages/home/index.vue";
import Login from "../pages/login/index.vue";
import Register from "../pages/register/index.vue";
import { sleep } from "../utils/sleep";

const router = createRouter({
  history: createWebHistory(),
  routes: [
	{
		path: '/',
		name: '/',
		component: () => import('/@/layout/index.vue'),
		redirect: '/home',
		children: [
			{
				path: "/home",
				component: Home,
			},
			{
				path: "/postList",
				component: () => import('/@/pages/postList/index.vue'),
			},
			{
				path: "/commentList",
				component: () => import('/@/pages/commentList/index.vue'),
			},
			{
				path: "/post/:id",
				component: () => import('/@/pages/post/index.vue'),
			},
			{
				path: "/post/new",
				component: () => import('/@/pages/post/new.vue'),
			},
		],
	},
	{
		path: "/login",
		component: Login,
	},
	{
		path: "/register",
		component: Register,
	}
  ],
});

const initRouterList = async()=>{
    NextLoading.start();
	await sleep(1000, {});
};

// 路由加载前
router.beforeEach(async (to, from, next) => {
	NProgress.configure({ showSpinner: false });
	if (to.meta.title) NProgress.start();
	const token = getLocal('_user_info_');
	console.log(token);
	if (to.path === '/login'||to.path === '/register') {
		next();
		NProgress.done();
	} else {
		if (!token) {
			next(`/login?redirect=${to.path}`);
			clearSession();
			// resetRoute();
			NProgress.done();
		} else if (token && to.path === '/login') {
			next('/home');
			NProgress.done();
		} else {
            next();
		}
	}
});

// 路由加载后
router.afterEach(() => {
	NProgress.done();
	NextLoading.done();
});

export default router;
