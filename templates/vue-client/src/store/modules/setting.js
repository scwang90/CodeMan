
const apiBase = process.env.SETTING_API_BASE;
const baseUrl = apiBase.replace(/\/$/,'')


export default {
    namespaced: true,
    state: {
        baseApi: apiBase,
        baseUrl: baseUrl + '/api/v1',
    },
    mutations: {
    },
    actions: {
    },
    getters: {
    }
}
