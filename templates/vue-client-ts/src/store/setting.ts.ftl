import Vuex, { Module } from 'vuex';
import { RootState } from "./types";

const apiBase = '/';//process.env.SETTING_API_BASE;
const baseUrl = apiBase.replace(/\/$/,'')

export interface SettingState {
    baseApi: string
    baseUrl: string
    webName: string
}

const store: Module<SettingState, RootState> =  {
    namespaced: true,
    state: {
        baseApi: apiBase,
        baseUrl: baseUrl + '/api/v1',
        webName: process.env.VUE_APP_NAME,
    },
    mutations: {
    },
    actions: {
    },
    getters: {
    }
};

export default store;


