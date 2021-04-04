<template>
    <el-container class="body">
        <el-header height="60px">
            <Navbar :collapse="collapse"/>
        </el-header>
        <el-container class="container">
            <el-aside width="250px" class="aside">
                <Sidebar/>
            </el-aside>
            <el-container>
                <el-header class="header">
                    <el-page-header @back="onBackClick" content="详情页面"></el-page-header>
                </el-header>
                <el-main class="main">
                    <router-view/>
                </el-main>
            </el-container>
        </el-container>
    </el-container>
</template>
<script>
import Navbar from '@/components/Navbar';
import Sidebar from '@/components/Sidebar';

export default {
    components:{Navbar,Sidebar},
    data() {
        return {
            collapse: false
        }
    },
    methods: {
        onBackClick() {
            
        }
    }
}
</script>
<style scoped>
.body {
    width: 100%;
    height: 100%;
}
.el-header {
    padding: 0;
}
.header {
    display: flex;
    align-items: center;
    padding: 0 20px;
}
.container {
    overflow: hidden;
}
.main {
    background: #F1F3FA;
    box-shadow:inset 2px 5px 5px -5px #0002;
    padding: 40px 30px;
}
</style>