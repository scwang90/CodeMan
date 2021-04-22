import Vue from 'vue'
import Router from 'vue-router'
<#if hasLogin>
import Login from '@/views/login'
</#if>
import Index from '@/views/index'
import Home from '@/views/home'
<#list tables as table>
import ${table.className} from '@/views/modules/${table.urlPathName}/list'
</#list>

Vue.use(Router)

const router = new Router({
    routes: [
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
                    component: ${table.className},
                },{
                    path: '${table.urlPathName}',
                    name: '${table.urlPathName}',
                    component: ${table.className},
</#list>
                }
            ]
        }
    ]
})


router.beforeEach((to, from, next) => {
    if (to.meta.ignoreAuth) { // 判断该路由是否需要登录权限
        if(sessionStorage.getItem("token") == 'true'){
            next('/index');
        } else {
            next();
        }
    } else {
        if (sessionStorage.getItem("token") == 'true') { // 判断本地是否存在token
            next();
        } else {
            // 未登录,跳转到登陆页面
            next('/login')
        }
    }
});

export default router;
