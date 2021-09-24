import Vue from 'vue'
import Link from './link.vue'
import {Base64} from 'js-base64'

export type VueType = typeof Vue;

const $link = {
    /**
     * 安装 $Link 插件 到 Vue 中
     * @param {*} Vue 
     */
    install(Vue: VueType) {
        Vue.component(Link.name, Link);
        Vue.prototype.$link = $link;
    },
    /**
     * 获取Base64解密后的查询参数对象Query
     * @param {Route} $route 路由对象
     */
    getRouteQuery($route: { query: { [x:string]:string } }) {
        let query = {};
        Object.keys($route.query || {}).forEach(key => {
            try {
                key = key.replace(/\*/g, "/");
                key = Base64.decode(key);
                key = decodeURIComponent(key);
                query = JSON.parse(key);
            } catch (error) {
                if ($route.query[key] == '') {
                    console.log('getRouteQuery', error);
                }
            }
        });
        return query;
    },
    /**
     * 获取BASE64加密后的Url查询参数
     * @param {Object} query 加密钱的查询参数对象
     * @return {Object} 路由Query对象
     */
    getEncodedQuery(query: string) {
        query = query || "";
        query = Object.prototype.toString.apply(query) === '[object String]' ? query : JSON.stringify(query);
        query = encodeURIComponent(query);
        query = Base64.encode(query);
        query = query.replace(/\//g, "*");
        return {[query]:''};
    }
};

export default $link;
