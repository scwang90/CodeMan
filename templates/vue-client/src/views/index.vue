<template>
    <el-container class="body">
        <el-header height="60px">
            <Navbar :collapse="collapse"/>
        </el-header>
        <el-container class="container">
            <el-aside width="250px" class="aside">
                <Sidebar/>
            </el-aside>
            <router-view/>
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
        }
    },
    methods: {
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
</style>
