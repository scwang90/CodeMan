import Vuex, { Module } from 'vuex';
import { RootState } from "./types";

const apiBase = '/';//process.env.SETTING_API_BASE;
const baseUrl = apiBase.replace(/\/$/,'')

export interface SettingState {
    baseApi: string
    baseUrl: string
    appName: string
    appTitle: string
    appDetail: string
}

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


