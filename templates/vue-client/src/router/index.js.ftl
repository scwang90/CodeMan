import Vue from 'vue'
import Router from 'vue-router'
import Login from '@/views/login'
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
            component: Login
        },{
            path: '/login',
            component: Login,
            hidden: true
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
