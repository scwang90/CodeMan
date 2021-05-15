<template>
    <el-container class="container">
        <el-header class="header">
            <el-page-header @back="onBackClick" >
                <template #content>
                    <span class="title">{{title}}</span>
                    <slot name="title"></slot>
                </template>
            </el-page-header>
        </el-header>
        <el-main class="main">
            <slot></slot>
        </el-main>
    </el-container>
</template>
<script>
export default {
    props: {
        title: {
            type: String,
            default: '详情页面'
        }
    },
    methods: {
        onBackClick() {
            this.$router.go(-1);
        }
    }
}
</script>
<style>
.container .header .el-page-header {
    width: 100%;
}
.container .header .el-page-header__content {
    flex: 1;
    display: flex;
    flex-direction: row;
    align-items: center;
}
.container .header .el-page-header__content .title{
    flex: 1;
}
.container .header .el-page-header__title {
    line-height: 40px;
}
</style>
<style scoped>
.el-header {
    padding: 0;
}
.header {
    display: flex;
    align-items: center;
    padding: 0 20px;
}
.container {
    height: 100%;
    overflow: hidden;
}
.main {
    background: #F1F3FA;
    box-shadow:inset 2px 5px 5px -5px #0002;
    padding: 20px;
}
</style>
