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
import Vuex from 'vuex'
export default Vue.extend({
    props:{
    },
    data() {
        return {
            menus:[
<#list tables as table>
    <#if table.relateTable == false>
                {name:'${table.remarkName}管理', path:'${table.urlPathName}', icon:'menu'},
    </#if>
</#list>
            ]
        }
    },
    computed: {
        ...Vuex.mapState('user', ['userInfo']),
    },
    methods: {
        onMenuSelected(index: string) {
            if (index) {
                this.$router.push({path:index});
            }
        }
    }
});
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