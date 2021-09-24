<template>
    <nav class="navbar">
        <div class="left">
            <i class="logo el-icon-eleme"></i>
            <span class="title">简写</span>
            <i class="icon el-icon-menu" @click="onMenuToggleClick"></i>
        </div>
        <div class="middle">
            <span class="title">PYJX</span>
            <span class="detail">${projectName}</span>
        </div>
        <div class="right">
            <el-menu class="menu" mode="horizontal"
                text-color="#FFF"
                active-text-color="#FFF"
                background-color="#2188F0"
                :default-active="index" @select="onMenuSelected">
                <el-menu-item index="/index/home">
                    <i class="el-icon-s-home"></i>
                    <template #title>首页</template>
                </el-menu-item>
                <el-menu-item index="/index/message">
                    <i class="el-icon-message-solid"></i>
                    <template #title>消息</template>
                </el-menu-item>
                <el-submenu index="2" class="user-info">
<#if hasLogin>
                    <template #title>
                        <img class="avatar" v-if="userInfo.avatar" :src="userInfo.avatar" alt="" srcset="">
                        <img class="avatar" v-else src="../../static/images/common/image-avatar.jpg" alt="" srcset="">
                        <div class="content">
                            <span class="name">{{userInfo.name}}</span>
                            <span class="role">{{userInfo.type}}</span>
                        </div>
                    </template>
                    <el-menu-item ><i class="el-icon-s-custom"></i><span>我的资料</span></el-menu-item>
                    <el-menu-item ><i class="el-icon-s-tools"></i><span>系统设置</span></el-menu-item>
                    <el-menu-item @click="onLogoutClick"><i class="el-icon-s-opportunity"></i><span>注销登录</span></el-menu-item>
<#else >
                    <template #title>
                        <img class="avatar" src="/static/images/common/image-avatar.jpg" alt="" srcset="">
                        <div class="content">
                            <span class="name">${author}</span>
                            <span class="role">超级管理员</span>
                        </div>
                    </template>
                    <el-menu-item ><i class="el-icon-s-tools"></i><span>系统设置</span></el-menu-item>
</#if>
                </el-submenu>
            </el-menu>
        </div>
    </nav>
</template>
<script lang="ts">
import Vue from 'vue'
import Vuex from 'vuex'
export default Vue.extend({
    data() {
        return {
            index: '',
        }
    },
<#if hasLogin>
    computed: {
        ...Vuex.mapState('user', ['userInfo']),
    },
    methods: {
        ...Vuex.mapActions('user', ['logout']),

        async onLogoutClick() {
            try {
                await this.logout();
            } catch (error) {
                console.log(error);
            }
            this.$router.push({path:'/login'});
        },
<#else >
    methods: {

</#if>
        onMenuSelected(index: string, indexPath: string) {
            if (index) {
                if (this.$router.currentRoute.path != index) {
                    this.$router.push({ path:index });
                }
                this.index = '';
            }
        },

        onMenuToggleClick() {
        },
    }
});
</script>
<style>
.navbar .el-submenu__title i, .el-menu--horizontal .el-menu-item i {
    color: white;
}
.navbar .menu.el-menu--horizontal .el-submenu__title .el-submenu__icon-arrow.el-icon-arrow-down {
    border-radius: 50%;
    padding: 2.5px;
    border: solid 1px white;
    color: white;
}
.navbar .menu.el-menu--horizontal > .el-menu-item.is-active {
    border-bottom: none;
}
.navbar .menu.el-menu--horizontal > .el-submenu.is-active .el-submenu__title {
    border-bottom: none;
}
.navbar .menu.el-menu--horizontal > .el-menu-item i{
    margin-top: -3px;
}
</style>
<style scoped>
.navbar {
    color: white;
    height: 60px;
    background: linear-gradient(to right, #2562DC, #1F93F6);
    display: flex;
    flex-direction: row;
    align-items: stretch;
}
.navbar i {
    color: white !important;
}
.navbar .left {
    width: 230px;
    display: flex;
    flex-direction: row;
    align-items: center;
}
.navbar .left .logo {
    font-size: 35px;
    font-weight: bold;
    margin: 15px;
}
.navbar .left .title {
    flex: 1;
    font-size: 28px;
    font-weight: bold;
}
.navbar .left .icon {
    font-size: 30px;
}
.navbar .middle {
    flex: 1;
    display: flex;
    flex-direction: column;
    padding: 0 30px;
    justify-content: center;
}
.navbar .middle .title {
    font-weight: 900;
}
.navbar .middle .detail {
    font-size: 14px;
}

.navbar .right {
    display: flex;
    flex-direction: row;
    align-items: stretch;
}

.navbar .right .item {
    min-width: 80px;
    font-size: 30px;
    font-weight: bold;
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: center;
}
.navbar .right .item:hover {
    background-color: #0001;
}
.navbar .right .user-info {
    display: inline-block;
    flex-direction: row;
    align-items: center;
    /* padding: 0 10px; */
}
/* .navbar .right .user-info:hover {
    background-color: #0001;
} */
.navbar .right .user-info .avatar {
    width: 40px;
    height: 40px;
    /* margin: 10px; */
    border-radius: 50%;
    border: solid 2px #FFF5;
}
.navbar .right .user-info .content {
    display: flex;
    flex-direction: column;
    margin: 5px;
    line-height: 1.5em;
}
.navbar .right .user-info .content {
    font-size: 14px;
    display: inline-block;
}
.navbar .right .user-info .name {
    display: block;
    font-weight: bold;
}
.navbar .right .user-info .name {
    display: block;
    font-weight: bold;
}
.navbar .right .user-info .down {
    border-radius: 50%;
    border: solid 1px white;
    margin: 10px;
}

</style>
