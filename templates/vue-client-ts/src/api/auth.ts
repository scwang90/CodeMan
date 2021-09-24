import request from '@/plugins/request'

// @Summary 用户登录
// @Produce  application/json
// @Param data body {username:"string",password:"string"}
// @Router 'auth/login' [post]
export const login = (data) => {
    return request.post('auth/login', data)
}

// @Summary 注销登录
// @Produce  application/json
// @Param data body {}
// @Router 'auth/logout' [post]
export const logout = () => {
    return request.post('auth/logout', {})
}

export default {
    login,
    logout
}
