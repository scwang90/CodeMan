import Vue from 'vue';

export type VueType = typeof Vue;

const Bus = new Vue({
    methods: {
        emit(event: string, ...args: any[]) {
            this.$emit(event, ...args)
        },
        on(event: string, cb: Function) {
            this.$on(event, cb)
        },
        off(event: string, cb: Function) {
            this.$off(event, cb)
        }
    },
});

export default Object.assign(Bus, {
    install(Vue: VueType) {
        Vue.prototype.$bus = Bus;
    }
})

declare module 'vue/types/vue' {
    // 3. 声明为 Vue 补充的东西
    interface Vue {
        $bus: typeof Bus
    }
}