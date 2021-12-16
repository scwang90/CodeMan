
const apiBase = process.env.SETTING_API_BASE;
const baseUrl = apiBase.replace(/\/$/,'')


export default {
    namespaced: true,
    state: {
        baseApi: apiBase,
        baseUrl: baseUrl + '/api',
        webName: process.env.SETTING_WEB_NAME,
    },
    mutations: {
    },
    actions: {
    },
    getters: {
    }
}
