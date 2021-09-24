import Vue from 'vue'
import VueRouter, { RouteConfig } from 'vue-router'
import Home from '../views/home.vue'
import Index from '@/views/index.vue'
<#if hasLogin>
import Login from '@/views/login'
</#if>

Vue.use(VueRouter);

const routes: Array<RouteConfig> = [
    {
        path: '/',
<#if hasLogin>
        component: Login
    },{
        path: '/login',
        component: Login,
        hidden: true,
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
        hidden: true,
        children: [
            {
                path: 'home',
                component: Home,
<#list tables as table>
            },{
                path: '${table.urlPathName}-:page',
                name: '${table.urlPathName}-page',
                component: () => import('@/views/modules/${table.urlPathName}/list'),
            },{
                path: '${table.urlPathName}',
                name: '${table.urlPathName}',
                component: () => import('@/views/modules/${table.urlPathName}/list'),
</#list>
            }
        ]
    }, {
        path: '/about',
        name: 'About',
        // route level code-splitting
        // this generates a separate chunk (about.[hash].js) for this route
        // which is lazy-loaded when the route is visited.
        component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')
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
router.beforeEach((to, from, next) => {
    // 判断该路由是否需要登录权限
    if (to.matched.length && !to.matched.every(r=>r.meta.ignoreAuth)) {
        if (sessionStorage.getItem("token") == 'true') {
            // 判断本地是否存在token
            next();
        } else {
            // 未登录,跳转到登陆页面
            next(routerLogin)
        }
    } else if (to.path == routerLogin && to.meta.ignoreAuth) {
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

