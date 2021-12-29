import { Module } from 'vuex';
import { RootState } from "./types";
import { SettingState } from '@/constant/states';
import Config from '@/constant/config';

const store: Module<SettingState, RootState> =  {
    namespaced: true,
    state: Config,
    mutations: {
    },
    actions: {
    },
    getters: {
    }
};

export default store;


