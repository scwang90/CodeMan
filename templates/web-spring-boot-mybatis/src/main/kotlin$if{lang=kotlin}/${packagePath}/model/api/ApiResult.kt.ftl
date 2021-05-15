package ${packageName}.model.api

import ${packageName}.model.Model
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
        @ApiModelProperty("接口返回实体")
        var result: T? = null,
        @ApiModelProperty("返回代码：200-成功 401-未登录 400-客户端错误 500-服务端错误")
        var code: Int = 200,
        @ApiModelProperty("失败原因")
        var reason: String? = "调用成功") : Model() {

    companion object {
        fun <TT> success(result: TT?): ApiResult<TT> {
            return ApiResult(result, 200)
        }
        fun fail400(reason: String?): ApiResult<String> {
            return ApiResult(null, 400, reason)
        }
        fun fail500(reason: String?): ApiResult<String> {
            return ApiResult(null, 500, reason)
        }
    }
}