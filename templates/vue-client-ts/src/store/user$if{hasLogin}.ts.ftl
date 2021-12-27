
import apiAuth from '@/api/auth'
import Vuex, { Module } from 'vuex';
import { RootState } from "./types";

export interface UserState {
    token: string
    userInfo: {
        name?: string
        avatar?: string
        userId?: string
        companyId?: string
    }
}

const store: Module<UserState, RootState> =  {
    namespaced: true,
    state: {
        token: "",
        userInfo: {
            ${loginTable.nameColumn.fieldName}: "",
            avatar: "",
            userId: "",
            companyId: "",
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
            state.token = "";
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
