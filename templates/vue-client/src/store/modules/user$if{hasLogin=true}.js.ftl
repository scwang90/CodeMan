
import apiAuth from '@/api/auth'

export default {
    namespaced: true,
    state: {
        token: "",
        userInfo: {
            name: "",
            avatar: "",
            userId: "",
<#if hasOrgan>
            companyId: "",
</#if>
        },
    },
    mutations: {
        pushStore(state, {store, field, value}) {
            if (field) {
                if (state[store]) {
                    state[store][field] = value;
                } else {
                    state[store] = {[field]:value};
                }
            } else {
                state[store] = value;
            }
        },
        setUserInfo(state, userInfo) {
            // 这里的 `state` 对象是模块的局部状态
            state.userInfo = userInfo;
        },
        setToken(state, token) {
            // 这里的 `state` 对象是模块的局部状态
            state.token = token;
        },
        logout(state) {
            state.token = "";
            state.userInfo = {};
            sessionStorage.clear();
            window.location.reload();
        },
    },
    actions: {
        async login({ commit }, loginInfo) {
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
        userInfo(state) {
            return state.userInfo
        },
        token(state) {
            return state.token
        },
    }
}
