import Vue from 'vue'
import Home from '../views/home.vue'
import Index from '@/views/index.vue'
<#if hasLogin>
import Login from '@/views/login.vue'
</#if>
import VueRouter, { RouteConfig, Route, NavigationGuardNext } from 'vue-router'

Vue.use(VueRouter);

const routes: Array<RouteConfig> = [
    {
        path: '/',
<#if hasLogin>
        component: Login
    },{
        path: '/login',
        component: Login,
<#else>
        redirect: '/index/home',
</#if>
        meta: {
            ignoreAuth: true
        }
    },{
        path: '/index',
        redirect: '/index/home',
        component: Index,
        children: [
            {
                path: 'home',
                component: Home,
<#list tablesForRoute as table>
            },{
                path: '${table.urlPathName}-:page',
                name: '${table.urlPathName}-page',
                component: () => import('@/views/modules/${table.urlPathName}/list.vue'),
            },{
                path: '${table.urlPathName}',
                name: '${table.urlPathName}',
                component: () => import('@/views/modules/${table.urlPathName}/list.vue'),
</#list>
            }
        ]
    }
];


const router = new VueRouter({
    mode: 'history',
    base: process.env.BASE_URL,
    routes
});
<#if hasLogin>

const routerIndex = '/index';
const routerLogin = '/login';
router.beforeEach((to: Route, from: Route, next: NavigationGuardNext<Vue>) => {
    // 判断该路由是否需要登录权限
    if (to.matched.length && !to.matched.every(r=>r.meta.ignoreAuth)) {
        if (sessionStorage.getItem("token") == 'true') {
            // 判断本地是否存在token
            next();
        } else {
            // 未登录,跳转到登陆页面
            next(routerLogin)
        }
    } else if (to.path == routerLogin && to.meta?.ignoreAuth) {
        if(sessionStorage.getItem("token") == 'true'){
            next(routerIndex);
        } else {
            next();
        }
    } else {
        next();
    }
});
</#if>

  export default router;

