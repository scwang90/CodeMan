package ${packageName}.model.api;

import ${packageName}.model.Model;
import ${packageName}.model.db.${loginTable.className};
import io.swagger.annotations.ApiModelProperty;

import java.util.List;

/**
 * 登录信息
 * token 和 详细信息
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class LoginInfo extends Model {

    @ApiModelProperty(value = "JWT Token")
    public String token;
    @ApiModelProperty(value = "登录详细信息")
    public ${loginTable.className} ${loginTable.classNameCamel};

    public LoginInfo(String token, ${loginTable.className} ${loginTable.classNameCamel}) {
        this.token = token;
        this.${loginTable.classNameCamel} = ${loginTable.classNameCamel};
    }
}