
export interface SettingState {
    baseApi: string
    baseUrl: string
    appName: string
    appTitle: string
    appDetail: string
}

export interface UserInfo {
    name?: string
    avatar?: string
    userId?: string
    isSuper?: boolean
}

export interface UserState {
    token: string
    userInfo: UserInfo
}