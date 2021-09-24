import request from '@/plugins/request'
import { LoginResult } from "../model/api/login";

// @Summary 用户登录
// @Produce  application/json
// @Param data body {username:"string",password:"string"}
// @Router 'auth/login' [post]
export const login = (data: {username:string,password:string}): Promise<LoginResult> => {
    return request.post<LoginResult>('api/v1/auth/login', data);
}

// @Summary 注销登录
// @Produce  application/json
// @Param data body {}
// @Router 'auth/logout' [post]
export const logout = () => {
    return request.post('api/v1/auth/logout', {});
}

export default {
    login,
    logout
}
