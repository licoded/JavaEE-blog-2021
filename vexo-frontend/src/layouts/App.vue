<template>
  <AppHeader />
  <router-view v-if="curLink == '/about'" />
  <main v-else class="app-body" style="transform: translateY(0px); opacity: 1;">
    <router-view />
  </main>
</template>

<script lang="ts">
import { computed } from 'vue'
import { useRoute } from 'vue-router';
import AppHeader from './AppHeader.vue';

export default {
  name: 'App',
  components: {
    AppHeader,
  },
  setup() {
    const route = useRoute();
    const curLink = computed(() => {
      return route.path;
    });
    return { curLink };
  }
};
</script>

<style scoped>
.app-body {
  padding: 2em 1em;
  margin: 0 auto;
  /* margin-top: 100px; */
  height: 100%;
  max-width: 1300px;
  max-width: 980px;
  position: relative;
  opacity: 0;
  transform: translateY(-20px);
  transition: all 0.4s;
}
</style>
