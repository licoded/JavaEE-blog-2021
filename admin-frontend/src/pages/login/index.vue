<template>
	<div class="login-container">
		<div class="login-logo">
			<span>Licoded's Blog</span>
		</div>
		<div class="login-content">
			<div class="login-content-main">
				<h4 class="login-content-title">博客后台管理</h4>
				<Account/>
			</div>
		</div>
	</div>
</template>

<script lang="ts">
import Account from './Account.vue';
export default {
	name: 'login',
	components: { Account },
	setup() {
		return {};
	},
};
</script>

<style scoped>
.login-container {
	width: 100%;
	height: 100%;
	background: url('/@/assets/bg-login.png') no-repeat;
	background-size: 100% 100%;
}
.login-container .login-logo {
    position: absolute;
    top: 30px;
    left: 50%;
    height: 50px;
    display: flex;
    align-items: center;
    font-size: 20px;
    color: #409eff;
    letter-spacing: 2px;
    width: 90%;
    transform: translateX(-50%);
}
.login-container .login-content {
    width: 500px;
    padding: 50px 20px;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%) translate3d(0, 0, 0);
    background-color: rgba(255, 255, 255, 0.99);
    box-shadow: 0 2px 12px 0 #a0cfff;
    border-radius: 4px;
    transition: height 0.2s linear;
    overflow: hidden;
    z-index: 1;
}
.login-container .login-content .login-content-main {
    margin: 0 auto;
    width: 80%;
}
.login-container .login-content .login-content-main .login-content-title {
    color: #333;
    font-weight: 500;
    font-size: 22px;
    text-align: center;
    letter-spacing: 4px;
    margin: 15px 0 30px;
    white-space: nowrap;
}
</style>
