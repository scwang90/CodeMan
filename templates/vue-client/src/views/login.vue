<template>
    <div class="body">
        <div class="center">
            <div class="left">
                <div class="header">
                    <!-- <img  class="logo" src="/static/images/common/logo.svg" alt=""> -->
                    <i class="logo el-icon-eleme"></i>
                    <span class="title">旅人后期管理系统</span>
                </div>
                <img class="post" src="/static/images/login/image-post.png" alt="" srcset="">
            </div>
            <div class="right">
                <span class="title">欢迎登录</span>
                <el-form class="form">
                    <el-form-item class="item">
                        <el-input class="username" placeholder="请输入账号" v-model="username" type="text">
                            <template #prepend>
                            <i class="icon el-icon-user"></i>
                            </template>
                        </el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-input class="password" placeholder="请输入密码" v-model="password" type="password">
                            <template #prepend>
                            <i class="icon el-icon-lock"></i>
                            </template>
                        </el-input>
                    </el-form-item>
                    <el-form-item>
                        <div class="btns">
                            <el-checkbox label="记住密码"></el-checkbox>
                            <!-- <v-link to="/">忘记密码</v-link> -->
                            <el-button type="text">忘记密码</el-button>
                        </div>
                    </el-form-item>
                    <el-button class="submit" type="primary" @click="onLoginClick">立即登录</el-button>
                </el-form>
                
            </div>
        </div>
    </div>
</template>
<script>
export default {
    data() {
        return {
            username: 'scwang90',
            password: '********'
        }
    },
    methods: {
        onLoginClick() {
            this.$router.push({path:'/index'});
        }
    }
}
</script>
<style scoped>
.body {
    width: 100%;
    height: 100%;
    background: linear-gradient(to bottom, #035DEB, #00BCF9);
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: center;
}
.center {
    width: 1125px;
    height: 512px;

    display: flex;
    flex-direction: row;

    box-shadow: 0 0 20px #0004;


    transform: translate(-8px, -40px);
}
.left {
    color: white;
    flex: 1;
    background-image: linear-gradient(to bottom, #0082F0, #4CD3FD);
    text-align: center;
}
.left .logo {
    /* width: 2.5rem; */
    /* height: 2.5rem; */
    margin: 0.5em;
}
.left .post {
    max-width: 415px;
    margin-top: 35px;
}
.left .header {
    font-size: 2.3rem;
    margin-top: 50px;
    /* font-weight: bold; */
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: center;
}
.right {
    flex: 1;
    display: flex;
    flex-direction: column;
    background-color: white;
    align-items: center;
    justify-content: center;
}
.right .title {
    font-size: 1.8rem;
}
.right .form {
    width: 350px;
    margin-top: 50px;
}
.right .form .icon {
    font-size: 22px;
}
.right .form .btns {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
}
.right .form .submit {
    width: 100%;
}
</style>