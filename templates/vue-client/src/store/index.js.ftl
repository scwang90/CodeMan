import Vue from 'vue'
import Vuex from 'vuex'
import VuexPersistence from 'vuex-persist'
// import Storage from '../plugins/storage'

Vue.use(Vuex);
// Vue.use(Storage, {prefix: 'vue'});

<#if hasLogin>
const vuexLocal = new VuexPersistence({
    storage: window.localStorage,
    modules: ['user']
})

import User from "@/store/modules/user"
</#if>
import Setting from "@/store/modules/setting"
// import Router from "@/store/modules/router"

export default new Vuex.Store({
    modules: {
<#if hasLogin>
        user: User,
</#if>
        setting: Setting,
        // router: Router,
    },
<#if hasLogin>
    plugins: [vuexLocal.plugin]
</#if>
})
