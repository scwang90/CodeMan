<template>
    <section class="sidebar">
        <el-menu :collapse="sidebar.collapse" @select="onMenuSelected">
            <el-menu-item :index="`/index/${item.path}`" v-for="(item,index) in menus" :key="index">
                <i :class="`el-icon-${item.icon}`"></i>
                <template #title>{{item.name}}</template>
            </el-menu-item>
        </el-menu>
    </section>
</template>
<script>
import Vuex from "vuex";

export default {
    props:{
    },
    data() {
        return {
            menus:[
<#list tables as table>
                {name:'${table.remarkName}管理', path:'${table.urlPathName}', icon:'s-menu'},
</#list>
            ]
        }
    },
    computed: {
        ...Vuex.mapState('user', ['userInfo']),
    },
    methods: {
        onMenuSelected(index) {
            if (index) {
                this.$router.push({path:index});
            }
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
