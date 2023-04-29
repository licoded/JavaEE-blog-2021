import { nextTick } from 'vue';
import NProgress from 'nprogress';
import loadingCss from '../assets/loading.css'

// 定义方法
export const NextLoading = {
	// 载入 css
	setCss: () => {
		let link = document.createElement('link');
		link.rel = 'stylesheet';
		link.href = loadingCss;
		link.crossOrigin = 'anonymous';
		document.getElementsByTagName('head')[0].appendChild(link);
	},
	// 创建 loading
	start: () => {
        NProgress.start();
		const bodys: any = document.body;
		const div = document.createElement('div');
		div.setAttribute('class', 'loading-next');
		const htmls = `
			<div class="loading-next-box">
			<div class="loading-next-box-warp">
				<div class="loading-next-box-item"></div>
				<div class="loading-next-box-item"></div>
				<div class="loading-next-box-item"></div>
				<div class="loading-next-box-item"></div>
				<div class="loading-next-box-item"></div>
				<div class="loading-next-box-item"></div>
				<div class="loading-next-box-item"></div>
				<div class="loading-next-box-item"></div>
				<div class="loading-next-box-item"></div>
			</div>
		</div>
		`;
		div.innerHTML = htmls;
		bodys.insertBefore(div, bodys.childNodes[0]);
	},
	// 移除 loading
	done: () => {
		nextTick(() => {
			setTimeout(() => {
				const el = document.querySelector('.loading-next');
				el && el.parentNode?.removeChild(el);
                NProgress.done();
			}, 1000);
		});
	},
};
