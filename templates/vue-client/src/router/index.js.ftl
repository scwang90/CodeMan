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

export default new Router({
    routes: [
        {
            path: '/',
<#if hasLogin>
            component: Login
        },{
            path: '/login',
            component: Login,
            hidden: true
<#else>
            redirect: '/index/home',
</#if>
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
