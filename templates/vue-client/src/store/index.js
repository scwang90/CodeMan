import Vue from 'vue'
import Vuex from 'vuex'
import Storage from '../plugins/storage'

Vue.use(Vuex);
Vue.use(Storage, {prefix: 'vue'});

const $setting = {
    // name: process.env.SETTING_WEB_NAME,
    // apiUrl: process.env.SETTING_API_BASE,
    // siteCode: process.env.SETTING_SITE_CODE,
    debug: process.env.NODE_ENV == 'development',
    // isPC: IsPC()
}

export default new Vuex.Store({
    state: Object.assign({
        setting: $setting,
        sidebar: {
            collapse: false
        },
        // menus: [],//侧边栏栏目菜单
        // menus2: [],//侧边栏栏目菜单(二级菜单)
        // navbar: {},//导航栏信息
        // column: {},//当前栏目
        // breads: [],//详情页面包屑
        // route: { last: null, current: null },//路由
        // login: Util.getCookieValue("WEB-USER"),//登录信息
        // article: {},//当前文章详情
    },  
    // Storage.init({//Storage.init 可以根据 key 如 link，columns 从 浏览器 LocalStorage 中会出上次保存的数据
    //     columns: [],//导航栏栏目菜单
    // }),
    // State, 
    // Storage.init({//Storage.init 可以根据 key 如 link，columns 从 浏览器 LocalStorage 中会出上次保存的数据
    //     link: Object.assign($link, State.link || {}),
    // })
    ),
    actions: {
    },
    mutations: {
        pushStore(state, {store, field, data}) {
            if (field) {
                state[store] = state[store] || {};
                state[store][field] = data;
            } else {
                state[store] = data || {};
            }
        },
        pushStorage(state, payload) {
            this.commit('pushStore', payload);
            Storage.set(payload.store,state[payload.store]);
        },
        pushSession(state, payload) {
            this.commit('pushStore', payload);
            Storage.Session.set(payload.store,state[payload.store]);
        },
        pushDefault(state, {store, data} = {}) {
            if (store && data) {
                if(state[store]) {//如果 store 已经存在
                    Object.keys(data).forEach(field => {//检查内部属性
                        if (!state[store][field]) {
                            this.commit('pushStorage', {store, field, data:data[field]});
                        }
                    });
                } else {
                    this.commit('pushStorage', {store, data});
                }
            }
        },
        pushLink(state, link) {
            state.link = link;
        },
        pushColumn(state, column) {
            const top = findColumn(state.columns, column.TopCode) || column;
            column = findColumn(state.columns, column.Code) || column;
            column.TopName = column.TopName || top.Name;
            state.column = column;
            state.menus = this.getters.getColumnList(column.TopCode);
            state.menus2 = this.getters.getColumnMenu(column.TopCode);
            state.breads = this.getters.getBreadList(column.Code);
        },
        pushColumns(state, columns) {
            const link = {};
            const $link = state.link;
            Object.keys($link).forEach(key=>{
                if ($link[key].Name) {
                    let column = findColumnByName(columns, $link[key]);
                    if (column) {
                        if (column.children && column.children.length > 0) {
                            column = column.children[0];
                        }
                        link[key] = Object.assign(column, Link.getLink(column));
                    } else {
                        link[key] = $link[key];
                    }
                } else {
                    link[key] = $link[key];
                }
            })
            state.link = link;
            state.columns = columns;
            Storage.set('link', link);
            Storage.set('columns', state.columns);
            
            if (state.column && !state.column.Name && state.column.Code) {
                const column = findColumn(state.columns, state.column.Code) || state.column;
                column.TopName = column.TopName || column.Name;
                state.column = column;
                state.menus = this.getters.getColumnList(column.TopCode);
                state.menus2 = this.getters.getColumnMenu(column.TopCode);
                state.breads = this.getters.getBreadList(column.Code);
            }
        },
        pushRoute(state, payload) {
            state.route = payload;
        },
        pushArticle(state, payload) {
            state.article = payload;
        },
        userLogin(state, payload) {
            state.login = payload;
            // Util.setCookieValue("WEB-USER", payload, 12);
        },
        userLogout(state) {
            state.login = null;
            // Util.clearCookie("WEB-USER");
        },
    },
    getters: {
        /**
         * 在 Store 栏目树结构 中 根据名称获取栏目对象
         * @param {String} columnName 栏目名称
         */
        getColumnByName(state) {
            return function(columnName) {
                return findColumnByName(state.columns, columnName);
            }
        },
        /**
         * 在 Store 栏目树结构 中 根据Code获取栏目对象
         * @param {String} columnCode 栏目代码
         */
        getColumnByCode(state) {
            return function (columnCode) {
                const stack = [...state.columns].reverse();
                while(stack.length > 0) {
                    const column = stack.pop();
                    if (columnCode == column.Code) {
                        return column;
                    }
                    if (column.children) {
                        stack.push(...column.children);
                    }
                }
                return null;
            }
        },
        /**
         * 在 Store 的 栏目树结构 中 获取子栏目
         * @param {String} topCode 父栏目code（不传取当前栏目的）
         */
        getColumnList(state) {
            return function(topCode) {
                topCode = topCode || state.column.TopCode || state.column.Code
                if (topCode) {
                    const stack = [...state.columns].reverse();
                    while(stack.length > 0) {
                        const column = stack.pop();
                        if (topCode == column.Code) {
                            return column.children;
                        }
                        if (column.children) {
                            stack.push(...column.children);
                        }
                    }
                }
                return [];   
            }
        },
        /**
         * 在 Store 的 栏目树结构 中 获取子栏目二级菜单
         * @param {String} topCode 父栏目code（不传取当前栏目的）
         */
        getColumnMenu(state) {
            return function name(topCode) {
                topCode = topCode || state.column.TopCode || state.column.Code
                if (topCode) {
                    return findColumnMenuTreeByTopCode(state, topCode, null) || [];
                }
                return [];   
            }
        },
        /**
         * 在 Store 的 栏目树结构 中 构造面包屑栏目列表
         * @param {String} code 栏目代码 （不传取当前栏目的）
         */
        getBreadList(state) {
            function stack(columns,breads,code) {
                for (let i = 0; i < columns.length; i++) {
                    const column = columns[i];
                    breads.push(column);
                    if (column.Code == code) {
                        if (breads.length > 1 && column.Name == breads[breads.length-2].Name) {
                            breads.pop();
                        }
                        return breads;
                    }
                    if (column.children) {
                        const bread = stack(column.children, breads, code);
                        if (bread) {
                            return bread;
                        }
                    }
                    breads.pop();
                }
            }
            return function(code) {
                return stack(state.columns, [], code || state.column.Code) || [];   
            }
        },
    },
})
