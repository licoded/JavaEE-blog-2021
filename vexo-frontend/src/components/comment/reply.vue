<template>
    <transition name="fade">
        <div class="input-wrapper fac" v-if="show">
            <input class="wide-input"
                v-model="inputComment"
                autofocus
                placeholder="写下你的评论"
            />
            <button class="bg-btn" @click="submitReply">发布</button>
        </div>
    </transition>
</template>

<script lang="ts">
import { ref, defineComponent } from 'vue'
export default defineComponent({
    emits: ['submitReply'],
    props: {
        show: {
            type: Boolean,
            required: true
        },
    },
    setup(props, ctx) {
        const inputComment = ref();
        const cancel = () => {
            inputComment.value = '';
        }
        const submitReply = () => {
            ctx.emit('submitReply', inputComment.value);
            inputComment.value = '';
        }
        return { inputComment, cancel, submitReply };
    }
});
</script>
<style scoped lang="scss">
.fade-enter-active,
fade-leave-active {
    transition: opacity 0.5s;
}
.fade-enter,
.fade-leave-to {
    opacity: 0;
}
.input-wrapper {
    justify-content: space-between;
    padding: 10px 0;
    .wide-input{
        height: 32px;
        line-height: 32px;
        width: 88%;
        padding: 0 10px;
    }
    .bg-btn{
        height: 36px;
        line-height: 36px;
        color: #fff;
        background-color: #06f;
        padding: 0 16px;
        font-size: 14px;
        border: 1px solid;
        border-radius: 3px;
    }
}
</style>