<template>
	<el-header class="layout-header fac">
		<div class="title">{{title}}</div>
		<div class="right">
			<div class="fac">
				<el-avatar :src="userInfo.avatar"></el-avatar>
				<el-dropdown>
					<span class="el-dropdown-link">
						{{userInfo.username}}<i class="el-icon-arrow-down el-icon--right"></i>
					</span>
					<template #dropdown>
						<el-dropdown-menu>
							<el-dropdown-item>
								<router-link to="/postList">个人中心</router-link>
							</el-dropdown-item>
							<el-dropdown-item>
								<span @click="logout">退出登录</span>
							</el-dropdown-item>
						</el-dropdown-menu>
					</template>
				</el-dropdown>
			</div>
		</div>
	</el-header>
</template>

<script lang="ts">
import {onMounted, ref, watch} from 'vue';
import {useRoute, useRouter} from 'vue-router';
import {useMenuList} from '/@/store/menuList';
import {useUserInfo} from '/@/store/userInfo';
import {clearLocal} from '/@/utils/storage'
export default {
	name: 'layoutHeader',
	components: {},
	setup() {
		const route = useRoute();
		const title = ref();
		const userInfo = useUserInfo().getUserInfo();
		const menuList = useMenuList().getMenuList();
		const router = useRouter();
		const logout = ()=>{
			clearLocal();
			router.push('/login');
		};
		onMounted(()=>{
			const path = route.path;
			title.value = menuList.filter((item:any)=>item.link==path.slice(0, item.link.length))[0].name;
		});
		watch(()=>route.path, (path)=>{
			title.value = menuList.filter((item:any)=>item.link==path.slice(0, item.link.length))[0].name;
		});
		return {title, userInfo, logout};
	},
};
</script>
<style scoped>
.layout-header{
	justify-content: space-between;
	width: 100%;
	height: 48px !important;
	border-bottom: 1px solid #f1f2f3;
}
</style>
