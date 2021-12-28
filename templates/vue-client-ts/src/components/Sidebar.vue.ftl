<template>
    <section class="sidebar">
        <el-menu @select="onMenuSelected">
            <el-menu-item :index="`/index/${r"$"}{item.path}`" v-for="(item,index) in menus" :key="index">
                <i :class="`el-icon-${r"$"}{item.icon}`"></i>
                <template #title>{{item.name}}</template>
            </el-menu-item>
        </el-menu>
    </section>
</template>
<script lang="ts">
import Vue from 'vue'
import Component from 'vue-class-component';
<#if hasLogin>
import { namespace } from 'vuex-class';
import { UserInfo } from '@/constant/states';

const user = namespace('user');
</#if>

interface MenuItem {
    name: string
    path: string
    icon: string
}

@Component({})
export default class Sidebar extends Vue {
    <#if hasLogin>

    @user.State("userInfo") userInfo!: UserInfo
    </#if>

    private menus: Array<MenuItem> = [
<#list tables as table>
    <#if table.relateTable == false>
        {name:'${table.remarkName}管理', path:'${table.urlPathName}', icon:'menu'},
    </#if>
</#list>
    ]

    onMenuSelected(index: string) {
        if (index) {
            this.$router.push({path:index});
        }
    }
}
</script>
<style>
.sidebar .el-menu-item i {
    margin-top: -3px;
}
</style>
<style scoped>
.sidebar {
    height: 100%;
}
.el-menu {
    height: 100%;
}
</style>
