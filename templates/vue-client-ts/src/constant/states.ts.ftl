
export interface SettingState {
    baseApi: string
    baseUrl: string
    appName: string
    appTitle: string
    appDetail: string
}
<#if hasLogin>
/**
 * 登录用户信息
 */
export interface UserInfo {
    name?: string
    avatar?: string
    userId?: string
<#if loginTable.hasOrgan>
    ${loginTable.orgColumn.fieldName}?: <#if loginTable.orgColumn.stringType>string<#else >number</#if>
</#if>
}

/**
 * 登录用户
 */
export interface UserState {
    token: string
    userInfo: UserInfo
}
</#if>