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

	// 锁定页面滚动
	lockScroll: () => {
		document.body.style.overflow = 'hidden';
		document.body.style.position = 'fixed';
		document.body.style.top = `-${window.scrollY}px`;
		document.body.style.width = '100%';
	},

	// 解锁页面滚动
	unlockScroll: () => {
		const scrollY = document.body.style.top;
		document.body.style.overflow = '';
		document.body.style.position = '';
		document.body.style.top = '';
		document.body.style.width = '';
		window.scrollTo(0, parseInt(scrollY || '0') * -1);
	},

	// 创建 loading
	start: () => {
		NProgress.start();

		// 如果已存在loading，先移除
		const existingEl = document.querySelector('.loading-next');
		if (existingEl) {
			existingEl.remove();
		}

		// 锁定滚动
		NextLoading.lockScroll();

		// 创建loading overlay
		const overlay = document.createElement('div');
		overlay.setAttribute('class', 'loading-next');
		overlay.innerHTML = `
			<div class="loading-next-backdrop"></div>
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

		// 添加到body末尾而不是开头
		document.body.appendChild(overlay);
	},

	// 移除 loading
	done: () => {
		nextTick(() => {
			setTimeout(() => {
				const el = document.querySelector('.loading-next') as HTMLElement;
				if (el) {
					// 添加淡出效果
					el.style.opacity = '0';
					el.style.transition = 'opacity 0.3s ease-out';

					setTimeout(() => {
						el.remove();
						// 解锁滚动
						NextLoading.unlockScroll();
					}, 300);
				}
				NProgress.done();
			}, 500); // 减少延迟时间
		});
	},
};
