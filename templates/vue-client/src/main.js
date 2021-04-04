// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import store from './store'
import router from './router'

Vue.config.productionTip = false

import Link from './plugins/link'
Vue.use(Link)

import Logger from './plugins/logger'
Vue.use(Logger)

import Directive from './plugins/directive'
Vue.use(Directive)

import VueResource from "vue-resource"
Vue.use(VueResource);
Vue.http.options.root = process.env.SETTING_API_BASE;
Vue.http.options.emulateJSON = true
Vue.http.interceptors.push(function(request) {

    // modify method
    // request.method = 'POST';
  
    // modify headers
    request.headers.set('X-CSRF-TOKEN', 'TOKEN');
    request.headers.set('Authorization', 'Bearer TOKEN');
  
});

import Element from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css';
Vue.use(Element)

/* eslint-disable no-new */
new Vue({
  el: '#app',
  store,
  router,
  components: { App },
  template: '<App/>'
})
