
export interface LoginInfo {
    name?: string
    avatar?: string
    userId?: string
<#if hasOrgan>
    ${orgColumn.fieldName}?: string
</#if>
}

export interface LoginResult {
    token: string
    user: LoginInfo
}
