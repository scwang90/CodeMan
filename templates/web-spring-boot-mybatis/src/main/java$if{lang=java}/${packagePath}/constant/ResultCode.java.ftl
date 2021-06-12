package ${packageName}.constant;

import org.springframework.http.HttpStatus;

/**
 * 统一返回错误代码
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
public enum ResultCode {

    OK(HttpStatus.OK.value(), "请求成功"),
    BadRequest(HttpStatus.BAD_REQUEST.value(), "客户端错误"),
    Unauthorized(HttpStatus.UNAUTHORIZED.value(), "请先登录"),
    Forbidden(HttpStatus.FORBIDDEN.value(), "凭证过期"),
    NotFound(HttpStatus.NOT_FOUND.value(), "未找到路径"),
    ServerError(HttpStatus.INTERNAL_SERVER_ERROR.value(), "服务器错误");

    public final int code;
    public final String message;

    ResultCode(int code, String message) {
        this.code = code;
        this.message = message;
    }
}
