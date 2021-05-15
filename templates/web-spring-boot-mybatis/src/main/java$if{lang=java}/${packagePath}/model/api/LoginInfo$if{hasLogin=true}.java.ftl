package ${packageName}.model.api;

import ${packageName}.model.db.${loginTable.className};
import io.swagger.annotations.ApiModelProperty;

import java.util.List;

/**
 * 登录信息
 * token 和 详细信息
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class LoginInfo {

    @ApiModelProperty(value = "JWT Token")
    public final String token;
    @ApiModelProperty(value = "登录详细信息")
    public final ${loginTable.className} ${loginTable.classNameCamel};

    public LoginInfo(String token, ${loginTable.className} ${loginTable.classNameCamel}) {
        this.token = token;
        this.${loginTable.classNameCamel} = ${loginTable.classNameCamel};
    }
}
