// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import store from './store'
import router from './router'

Vue.config.productionTip = false

import Link from './plugins/link'
Vue.use(Link);

import Logger from './plugins/logger'
Vue.use(Logger);

import Directive from './plugins/directive'
Vue.use(Directive);

import Bus from './plugins/bus'
Vue.use(Bus);

import VueResource from "vue-resource"
Vue.use(VueResource);

import Filters from './plugins/filters'
Vue.use(Filters);

import Element from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
Vue.use(Element);

import Request from './plugins/request'
Vue.use(Request, {root: store.state.setting.baseUrl});

/* eslint-disable no-new */
new Vue({
    el: '#app',
    store,
    router,
    components: { App },
    template: '<App/>'
})
