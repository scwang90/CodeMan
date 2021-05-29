package ${packageName}.model.api

<#if !hasMultiLogin>
import ${packageName}.model.db.${loginTable.className}
</#if>
import io.swagger.annotations.ApiModelProperty

/**
 * 登录信息
 * token 和 详细信息
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
data class LoginInfo<#if hasMultiLogin><T></#if> (

    @ApiModelProperty(value = "JWT Token")
    var token: String,

    @ApiModelProperty(value = "登录详细信息")
<#if hasMultiLogin>
    var user: T
<#else >
    var ${loginTable.classNameCamel}: ${loginTable.className}
</#if>

)