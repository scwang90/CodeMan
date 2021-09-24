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
<script lang="ts">
import Navbar from '@/components/Navbar.vue'
import Sidebar from '@/components/Sidebar.vue'
import Component from 'vue-class-component';
import { Route } from 'vue-router'
import { namespace } from 'vuex-class';
import { Vue, Watch } from 'vue-property-decorator';

const user = namespace('user');

@Component({ components: {Navbar, Sidebar} })
export default class Index extends Vue {

    private backing: string = ''
    private showTitle: boolean = false
    private auth401Showing: boolean = false

    @user.Mutation("logout") logout: any;

    @Watch("$route")
    watchRoute(to: Route, from: Route) {
        if (!this.backing) {
            this.backing = '';
            this.showTitle = true;
        }
    }

    created() {
        this.$bus.on('net.auth.401', this.onNetAuth401);
    }

    requestLogin() {
        this.logout();
        this.$router.push({path:'/login'});
    }

    onBackClick() {
        this.backing = this.$route.path;
        this.$router.go(-1);
        setTimeout(() => {
            if (this.backing == this.$route.path) {
                this.backing = '';
                this.showTitle = false;
            }
        }, 500);
    }

    onNetAuth401() {
        if (!this.auth401Showing) {
            this.auth401Showing = true;
            this.$confirm('登录认证已经过期, 需要重新登录, 是否跳转登录?', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                this.auth401Showing = false;
                this.requestLogin();
            }).catch(() => {
                this.auth401Showing = false;
                this.$message({ type: 'info', message: '已取消登录'});
            });
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
</style>

