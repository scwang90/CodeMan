package ${packageName}.model.api;

<#if !hasMultiLogin>
import ${packageName}.model.db.${loginTable.className};
</#if>
import io.swagger.annotations.ApiModelProperty;

import java.util.List;

/**
 * 登录信息
 * token 和 详细信息
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class LoginInfo<#if hasMultiLogin><T></#if> {

    @ApiModelProperty(value = "JWT Token")
    public final String token;
    @ApiModelProperty(value = "登录详细信息")
    <#if hasMultiLogin>
    public final T user;

    public LoginInfo(String token, T user) {
        this.token = token;
        this.user = user;
    }
    <#else >
    public final ${loginTable.className} ${loginTable.classNameCamel};

    public LoginInfo(String token, ${loginTable.className} ${loginTable.classNameCamel}) {
        this.token = token;
        this.${loginTable.classNameCamel} = ${loginTable.classNameCamel};
    }
    </#if>

}
