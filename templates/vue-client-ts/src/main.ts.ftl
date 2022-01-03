import Vue from 'vue';
import App from './App.vue';
import router from './router';
import store from './store';

import 'vue-class-component/hooks';

import 'element-ui/lib/theme-chalk/index.css';
import ElementUI from 'element-ui';
Vue.use(ElementUI);

import Link from './plugins/link';
Vue.use(Link);

import Logger from './plugins/logger';
Vue.use(Logger);

import Bus from './plugins/bus';
Vue.use(Bus);

import * as Api from '@/constant/api'
import Config from '@/constant/config';
import Request from './plugins/request';
Vue.use(Request, { baseUrl: Config.appBaseUrl, hookResponse: (result:Api.Result<any>) =>{
  if (result.code == 401) {
    Bus.emit('net.auth.401');//发送登录失效事件
  }
}});

Vue.config.productionTip = false;

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app');
