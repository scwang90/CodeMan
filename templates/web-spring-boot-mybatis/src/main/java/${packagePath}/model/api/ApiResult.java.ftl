package ${packageName}.model.api;

import ${packageName}.model.Model;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * Api 通用返回格式实体类
 * @author ${author}
 * @since ${.now?string("yyyy-MM-dd zzzz")}
 */
@ApiModel(description = "通用返回格式")
public class ApiResult<T> extends Model {

    @ApiModelProperty("接口返回实体")
    public T result;
    @ApiModelProperty("返回代码：200-成功 401-未登录 400-客户端错误 500-服务端错误")
    public int code;
    @ApiModelProperty("失败原因")
    public String reason = "调用成功";

    public ApiResult(T result, int code) {
        this.result = result;
        this.code = code;
    }

    public ApiResult(T result, int code, String reason) {
        this.result = result;
        this.code = code;
        this.reason = reason;
    }

    public static <TT> ApiResult<TT> success(TT result) {
        return new ApiResult<>(result, 200);
    }

    public static <TT> ApiResult<TT> failure400(String reason) {
        return new ApiResult<>(null, 400, reason);
    }

    public static <TT> ApiResult<TT> failure500(String reason) {
        return new ApiResult<>(null, 500, reason);
    }
}