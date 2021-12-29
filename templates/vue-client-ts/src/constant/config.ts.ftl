const baseUrl = process.env.VUE_APP_BASE_URL || process.env.BASE_URL || '/';

export default {
    appName: process.env.VUE_APP_NAME || 'Vue',
    appTitle: process.env.VUE_APP_TITLE || 'Vue2',
    appDetail: process.env.VUE_APP_DETAIL || 'Vue Build By Typescript',
    appBaseUrl: baseUrl.replace(/\/$/,'') + '/api/'
}
