
export interface LoginInfo {
    name?: string
    avatar?: string
    userId?: string
    companyId?: string
}

export interface LoginResult {
    token: string
    user: LoginInfo
}
