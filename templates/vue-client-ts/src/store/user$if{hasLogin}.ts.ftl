
import apiAuth from '@/api/auth'
import { Module } from 'vuex';
import { RootState } from "./types";
import { UserState } from '@/constant/states';

const store: Module<UserState, RootState> =  {
    namespaced: true,
    state: {
        token: '',
        userInfo: {
            ${loginTable.nameColumn.fieldName}: '',
            avatar: '',
            userId: '',
<#if loginTable.hasOrgan>
            ${loginTable.orgColumn.fieldName}: <#if loginTable.orgColumn.stringType>''<#else >0</#if>
</#if>
        },
    },
    mutations: {
        setUserInfo(state: UserState, userInfo: any) {
            // 这里的 `state` 对象是模块的局部状态
            state.userInfo = userInfo;
        },
        setToken(state: UserState, token: string) {
            // 这里的 `state` 对象是模块的局部状态
            state.token = token;
        },
        logout(state: UserState) {
            state.token = '';
            state.userInfo = {};
            sessionStorage.clear();
            window.location.reload();
        },
    },
    actions: {
        async login({ commit }, loginInfo: {username:string,password:string}) {
            const res = await apiAuth.login(loginInfo)
            commit('setToken', res.token);
            commit('setUserInfo', res.user);
            return res;
        },
        async logout({ commit }) {
            await apiAuth.logout();
            commit("logout");
        }
    },
    getters: {
        userInfo(state: UserState) {
            return state.userInfo
        },
        token(state: UserState) {
            return state.token
        },
    }
}

export default store;
