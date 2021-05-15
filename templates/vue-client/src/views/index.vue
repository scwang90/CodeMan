<template>
    <el-container class="body">
        <el-header height="60px">
            <Navbar/>
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
import Vuex from 'vuex';
import Navbar from '@/components/Navbar'
import Sidebar from '@/components/Sidebar'

export default {
    components:{ Navbar, Sidebar },
    data() {
        return {
            auth401Showing: false,
        }
    },
    created() {
        this.$bus.on('net.auth.401', this.onNetAuth401);
    },
    watch: {
        $route(to, from) {
            if (!this.backing) {
                this.backing = null;
                this.showTitle = true;
            }
        }
    },
    computed: {
        ...Vuex.mapMutations('user', ['logout']),
    },
    methods: {
        ...Object.assign({
            requestLogin() {
                this.logout();
                this.$router.push({path:'/login'});
            }
        }),
        ...Object.assign({
            onBackClick() {
                this.backing = this.$route.path;
                this.$router.go(-1);
                setTimeout(() => {
                    if (this.backing == this.$route.path) {
                        this.backing = null;
                        this.showTitle = false;
                    }
                }, 500);
            },
            onNetAuth401() {
                if (!this.auth401Showing) {
                    this.auth401Showing = true;
                    this.$confirm('登录认证已经过期, 需要重新登录, 是否跳转登录?', '提示', {
                        confirmButtonText: '确定',
                        cancelButtonText: '取消',
                        type: 'warning'
                    }).then(() => {
                        this.auth401Showing = false;
                        this.requestLogin(this.selections);
                    }).catch(() => {
                        this.auth401Showing = false;
                        this.$message({ type: 'info', message: '已取消登录'});
                    });
                }
            }
        })
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
