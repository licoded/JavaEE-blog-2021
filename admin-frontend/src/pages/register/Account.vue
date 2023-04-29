<template>
	<el-form class="login-content-form">
		<el-form-item>
			<el-input
				type="text"
				prefix-icon="el-icon-user"
				v-model="ruleForm.userName"
				clearable
				autocomplete="off"
			>
			</el-input>
		</el-form-item>
		<el-form-item>
			<el-input
				type="password"
				prefix-icon="el-icon-lock"
				v-model="ruleForm.password"
				autocomplete="off"
				show-password
			>
			</el-input>
		</el-form-item>
		<el-form-item>
			<el-button type="primary" class="login-content-submit" round @click="onSignIn" :loading="loading.signIn">
				<span>注册</span>
			</el-button>
		</el-form-item>
	</el-form>
</template>

<script lang="ts">
import {reactive, toRefs} from 'vue';
import {register} from '/@/api/user';
import { useRouter, useRoute } from 'vue-router';
import { useUserInfo } from '/@/store/userInfo';
import {setLocal} from '/@/utils/storage';
export default {
	name: 'Account',
	setup() {
		const router = useRouter();
		const route = useRoute();
		const userInfo = useUserInfo();
        const state = reactive({
			ruleForm: {
				userName: 'admin',
				password: '123456',
			},
			loading: {
				signIn: false,
			},
		});
        const onSignIn = async ()=>{
            console.log('Yout click the sign Button!');
			await register({
				username: state.ruleForm.userName,
				password: state.ruleForm.password,
			}).then(data=>{
				router.push('/login');
			});
        }
		return {
            onSignIn,
            ...toRefs(state),
        };
	},
};
</script>

<style scoped>
.login-content-form {
	margin-top: 20px;
}
.login-content-form .login-content-code {
    display: flex;
    align-items: center;
    justify-content: space-around;
}
.login-content-form .login-content-code .login-content-code-img {
    width: 100%;
    height: 40px;
    line-height: 40px;
    background-color: #ffffff;
    border: 1px solid rgb(220, 223, 230);
    color: #333;
    font-size: 16px;
    font-weight: 700;
    letter-spacing: 5px;
    text-indent: 5px;
    text-align: center;
    cursor: pointer;
    transition: all ease 0.2s;
    border-radius: 4px;
    user-select: none;
}
.login-content-form .login-content-code .login-content-code-img:hover {
    border-color: #c0c4cc;
    transition: all ease 0.2s;
}
.login-content-form .login-content-submit {
    width: 100%;
    letter-spacing: 2px;
    font-weight: 300;
    margin-top: 15px;
}
</style>
