package ${packageName}.model.api

import ${packageName}.constant.ResultCode
import io.swagger.annotations.ApiModel
import io.swagger.annotations.ApiModelProperty

/**
 * Api 通用返回格式实体类
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Suppress("unused")
@ApiModel(description = "通用返回格式")
class ApiResult<T>(
        @ApiModelProperty("返回代码：200-成功 401-未登录 400-客户端错误 500-服务端错误")
        var code: Int = 200,
        @ApiModelProperty("接口返回实体")
        var result: T? = null,
        @ApiModelProperty("失败原因")
        var reason: String? = "调用成功") {

    companion object {
        fun <T> success(result: T?): ApiResult<T> {
            return ApiResult<T>(ResultCode.OK.code, result, "")
        }
        fun <T> success(result: T, message: String): ApiResult<T> {
            return ApiResult<T>(ResultCode.OK.code, result, message)
        }
        fun <T> message(message: String): ApiResult<T> {
            return ApiResult(ResultCode.OK.code, null, message)
        }
        fun <T> fail(code: ResultCode): ApiResult<T> {
            return ApiResult(code.code, null, code.msg)
        }
        fun <T> fail(code: Int, message: String): ApiResult<T> {
            return ApiResult(code, null, message)
        }
        fun <T> failClient(message: String): ApiResult<T> {
            return ApiResult(ResultCode.BadRequest.code, null, message)
        }
        fun <T> failServer(message: String): ApiResult<T> {
            return ApiResult(ResultCode.ServerError.code, null, message)
        }
    }
}