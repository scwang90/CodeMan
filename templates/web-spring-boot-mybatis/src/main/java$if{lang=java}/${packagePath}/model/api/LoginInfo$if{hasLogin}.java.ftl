package ${packageName}.model.api;


import io.swagger.annotations.ApiModelProperty;

/**
 * 登录信息
 * token 和 详细信息
 *
 * 由代码生成器生成，可以修改
 * 但是如果删除，下次继续生成时，又会出现
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public class LoginInfo<T> {

    @ApiModelProperty(value = "登录详细信息")
    public final T user;
    @ApiModelProperty(value = "JWT Token")
    public final String token;

    public LoginInfo(String token, T user) {
        this.user = user;
        this.token = token;
    }

}
