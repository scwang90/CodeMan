<template>
    <div class="body" v-loading="logging">
        <div class="center">
            <div class="left">
                <div class="header">
                    <!-- <img  class="logo" src="/static/images/common/logo.svg" alt=""> -->
                    <i class="logo el-icon-eleme"></i>
                    <span class="title">{{webName}}</span>
                </div>
                <img class="post" src="../../static/images/login/image-post.png" alt="" srcset="">
            </div>
            <div class="right">
                <span class="title">欢迎登录</span>
                <el-form class="form" ref="form" :model="model" :rules="rules" @keyup.enter.native="onLoginClick">
                    <el-form-item class="item">
                        <el-input class="username" placeholder="请输入账号" v-model="model.username" type="text">
                            <template #prepend>
                            <i class="icon el-icon-user"></i>
                            </template>
                        </el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-input class="password" placeholder="请输入密码" v-model="model.password" type="password">
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
import Vuex from 'vuex'

const KEY_USERNAME = 'login.username';
const KEY_PASSWORD = 'login.password';
const KEY_REMEMBER = 'login.remember';

export default {
    data() {
        const checkUsername = (rule, value, callback) => {
            if (value.length < 5 || value.length > 24) {
                return callback(new Error("请输入正确的用户名"));
            } else {
                callback();
            }
        };
        const checkPassword = (rule, value, callback) => {
            if (value.length < 6 || value.length > 24) {
                return callback(new Error("请输入正确的密码"));
            } else {
                callback();
            }
        };
        return {
            logging: false,
            remember: false,
            model: {
                username: 'admin',
                password: '123456'
            },
            rules: {
                username: [{ validator: checkUsername, trigger: "blur" }],
                password: [{ validator: checkPassword, trigger: "blur" }],
            }
        }
    },
    created() {
        this.model.username = localStorage.getItem(KEY_USERNAME);
        this.model.password = localStorage.getItem(KEY_PASSWORD);
        this.remember = localStorage.getItem(KEY_REMEMBER) == 'true';
    },
    computed: {
        ...Vuex.mapState('setting',['webName']),
    },
    methods: {
        ...Vuex.mapActions("user", ["login"]),

        onLoginClick() {
            this.$refs.form.validate(async (v) => {
                if (v) {
                    try {
                        this.logging = true;
                        await this.login(this.model);
                        sessionStorage.setItem("token", 'true');
                        localStorage.setItem(KEY_REMEMBER, this.remember);
                        if (this.remember) {
                            localStorage.setItem(KEY_USERNAME, this.model.username);
                            localStorage.setItem(KEY_PASSWORD, this.model.password);
                        } else {
                            localStorage.setItem(KEY_USERNAME, '');
                            localStorage.setItem(KEY_PASSWORD, '');
                        }
                        this.$router.push({path:'/index'});
                    } catch (error) {
                        this.$message.error(error);
                    } finally {
                        this.logging = false;
                    }
                } else {
                    this.$message({
                        type: "error",
                        message: "请正确填写登录信息",
                        showClose: true,
                    });
                    return false;
                }
            });
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
