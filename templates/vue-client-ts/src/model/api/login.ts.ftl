
export interface LoginInfo {
    name?: string
    avatar?: string
    userId?: string
<#if hasLogin>
    ${orgColumn.fieldName}?: string
</#if>
}

export interface LoginResult {
    token: string
    user: LoginInfo
}
