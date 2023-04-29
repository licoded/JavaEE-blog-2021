<template>
    <Comment :pid="1" />
</template>
<script lang="ts">
import Comment from '/@/components/comment/index.vue'
export default {
    components: { Comment },
    setup() {
        return { };
    },
}
</script>