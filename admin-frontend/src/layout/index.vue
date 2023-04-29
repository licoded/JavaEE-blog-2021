<template>
	<el-container class="layout-container">
		<Aside class="layout-aside"/>
		<el-container class="flex-center layout-backtop ff">
			<Header/>
			<Main />
		</el-container>
	</el-container>
</template>

<script lang="ts">
import { ref } from 'vue';
import Aside from './component/aside.vue';
import Header from './component/header.vue';
import Main from './component/main.vue';
export default {
	name: 'layoutDefaults',
	components: { Aside, Header, Main },
	setup() {
		const isFixedHeader = ref(false);
		return {
			isFixedHeader,
		};
	},
};
</script>
<style scoped>
.ff{
	flex-direction: column;
}
</style>