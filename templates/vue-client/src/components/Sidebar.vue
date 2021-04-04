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
                {name:'客户管理', path:'client', icon:'s-shop'},
                {name:'订单管理', path:'order', icon:'s-order'},
                {name:'公司管理', path:'company', icon:'s-help'},
                {name:'部门管理', path:'depart', icon:'menu'},
                {name:'用户管理', path:'user', icon:'s-custom'},
                {name:'权限管理', path:'permit', icon:'s-check'},
            ]
        }
    },
    computed: {
        ...Vuex.mapState(['setting', 'sidebar']),
    },
    methods: {
        ...Vuex.mapMutations(['pushStore']),
        
        onMenuSelected(index) {
            console.log('onMenuSelect', index);
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