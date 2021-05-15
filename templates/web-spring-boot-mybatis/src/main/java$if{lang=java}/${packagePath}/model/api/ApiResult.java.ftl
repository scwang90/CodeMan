package ${packageName}.model.api;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * Api 通用返回格式实体类
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@ApiModel(description = "通用返回格式")
public class ApiResult<T> {

    @ApiModelProperty("接口返回实体")
    public T result;
    @ApiModelProperty("返回代码：200-成功 401-未登录 400-客户端错误 500-服务端错误")
    public int code;
    @ApiModelProperty("失败原因")
    public String message = "调用成功";
    @ApiModelProperty("错误详细")
    public Object errors = "";

    public ApiResult(T result, int code) {
        this.result = result;
        this.code = code;
    }

    public ApiResult(T result, int code, String message) {
        this.result = result;
        this.code = code;
        this.message = message;
    }

    public ApiResult(T result, int code, String message, Object errors) {
        this(result, code, message);
        this.errors = errors;
    }

    public static <T> ApiResult<T> msg(String msg) {
        return new ApiResult<>(null, 200, msg);
    }

    public static <T> ApiResult<T> success(T result) {
        return new ApiResult<>(result, 200);
    }

    public static <T> ApiResult<T> success(T result, String msg) {
        return new ApiResult<>(result, 200, msg);
    }

    public static <T> ApiResult<T> fail(int code, String msg) {
        return new ApiResult<>(null, code, msg);
    }

    public static <T> ApiResult<T> fail400(String message) {
        return new ApiResult<>(null, 400, message);
    }

    public static <T> ApiResult<T> fail500(String message) {
        return new ApiResult<>(null, 500, message);
    }
}