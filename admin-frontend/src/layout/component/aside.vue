<template>
	<el-aside style="width: 200px;">
    <el-menu router :default-active="defaultActive">
      <template v-for="(item) in menuList" :key="item.link" >
        <el-menu-item  :index="item.link">
          <template #title>
            <div class="fac">
              <i :class="item.icon"></i>
              {{item.name}}
            </div>
          </template>
        </el-menu-item>
      </template>
    </el-menu>
  </el-aside>
</template>

<script lang="ts">
import {onMounted, ref,watch} from 'vue';
import {useRoute} from 'vue-router';
import {useMenuList} from '/@/store/menuList';
export default {
	name: 'layoutAside',
	components: {},
	setup() {
    const menuList = ref();
    const defaultActive = ref();
    const route = useRoute();
    onMounted(()=>{
      defaultActive.value = route.path;
      menuList.value = useMenuList().getMenuList().filter((item:any)=>{return item.display;});
    });
    watch(()=>route.path, (path)=>{
			defaultActive.value = path;
		});
		return {
      defaultActive, menuList
    };
	},
};
</script>
