import Vue from 'vue'

const Bus = new Vue({
    methods: {
        emit(event, ...args) {
            this.$emit(event, ...args)
        },
        on(event, cb) {
            this.$on(event, cb)
        },
        off(event, cb) {
            this.$off(event, cb)
        }
    },
});

export default Object.assign(Bus, {
    install(Vue) {
        Vue.prototype.$bus = Bus;
    }
})
