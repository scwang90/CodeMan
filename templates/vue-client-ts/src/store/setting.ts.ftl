import Vuex, { Module } from 'vuex';
import { RootState } from "./types";
import { SettingState } from '@/constant/states';

const apiBase = process.env.SETTING_API_BASE || '/';
const baseUrl = apiBase.replace(/\/$/,'')

const store: Module<SettingState, RootState> =  {
    namespaced: true,
    state: {
        baseApi: apiBase,
        baseUrl: baseUrl + '/api/v1',
        appName: process.env.VUE_APP_NAME,
        appTitle: process.env.VUE_APP_TITLE,
        appDetail: process.env.VUE_APP_DETAIL,
    },
    mutations: {
    },
    actions: {
    },
    getters: {
    }
};

export default store;


