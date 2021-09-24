import Vue from 'vue';
import Vuex, { StoreOptions } from 'vuex';
import VuexPersistence from 'vuex-persist'
<#if hasLogin>
import User from './user';
</#if>
import Setting from './setting';
import { RootState } from "./types";

Vue.use(Vuex)
<#if hasLogin>

const vuexLocal = new VuexPersistence({
  modules: ['user'],
  storage: window.localStorage
});
</#if>

const store: StoreOptions<RootState> = {
    state: {
    },
    mutations: {
    },
    actions: {
    },
<#if hasLogin>
    modules: {
        user: User,
        setting: Setting
    },
    plugins: [vuexLocal.plugin]
<#else >
    modules: {
      setting: Setting
    }
</#if>
};

export default new Vuex.Store(store);
