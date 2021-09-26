package ${packageName}.controller

import com.auth0.jwt.interfaces.DecodedJWT
import ${packageName}.constant.ResultCode
import ${packageName}.model.api.ApiResult
import ${packageName}.model.api.LoginInfo
<#if hasMultiLogin>
    <#list loginTables as table>
import ${packageName}.model.db.${table.className}
    </#list>
</#if>
import ${packageName}.service.AuthService
import ${packageName}.shiro.model.JwtBearer
import ${packageName}.util.JwtUtils
import io.swagger.annotations.Api
import io.swagger.annotations.ApiImplicitParam
import io.swagger.annotations.ApiImplicitParams
import io.swagger.annotations.ApiOperation
import org.apache.shiro.SecurityUtils
import org.apache.shiro.authc.AuthenticationException
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.validation.annotation.Validated
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import springfox.documentation.annotations.ApiIgnore

import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse
import javax.validation.constraints.NotBlank

/**
 * 登录验证 API 实现
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Validated
@RestController
@RequestMapping("api/v1/auth")
@Api(tags = ["登录认证"], description = "JWT Token 登录认证")
class AuthController {

    @Autowired
    private lateinit var service: AuthService

    @GetMapping("version")
    @ApiOperation(value = "版本信息", notes = "获取maven打包版本")
    fun version(): ApiResult<String> {
        return ApiResult.success(IndexController::class.java.getPackage().implementationVersion ?: "调试版本")
    }

<#if hasMultiLogin>
    <#list loginTables as table>
    @PostMapping("login/${table.urlPathName}")
    @ApiOperation(value = "${table.remarkName}登录", notes = "针对${table.remark}的登录接口")
    @ApiImplicitParams(
        ApiImplicitParam(paramType = "form", name = "username", value = "登录名", required = true, defaultValue = "admin"),
        ApiImplicitParam(paramType = "form", name = "password", value = "登录密码", required = true, defaultValue = "admin")<#if table.hasOrgan>,</#if>
        <#if table.hasOrgan>
        ApiImplicitParam(paramType = "form", name = "${table.orgColumn.fieldName}", value = "${table.orgColumn.remarkName}", required = true),
        </#if>
    )
    fun login${table.className}(<#if table.hasOrgan>${table.orgColumn.fieldName}: ${table.orgColumn.fieldType}, </#if>@NotBlank username: String, @NotBlank password: String, request: HttpServletRequest, response: HttpServletResponse): ApiResult<LoginInfo<${table.className}>> {
        return try {
            val info = service.login${table.className}(<#if table.hasOrgan>${table.orgColumn.fieldName}, </#if>username, password)
            JwtUtils.writeToHeader(info.token, request, response)
            return ApiResult.success(info)
        } catch (e: AuthenticationException) {
            e.cause?.also { throw it }
            ApiResult.failClient("登录失败")
        }
    }

    </#list>
<#else >
    @PostMapping("login")
    @ApiOperation(value = "用户登录", notes = "大部分接口都需要先登录后调用")
    @ApiImplicitParams(
        ApiImplicitParam(paramType = "form", name = "username", value = "登录名", required = true, defaultValue = "admin"),
        ApiImplicitParam(paramType = "form", name = "password", value = "登录密码", required = true, defaultValue = "admin")<#if loginTable.hasOrgan>,</#if>
    <#if loginTable.hasOrgan>
        ApiImplicitParam(paramType = "form", name = "${loginTable.orgColumn.fieldName}", value = "${table.orgColumn.remarkName}", required = true),
    </#if>
    )
    fun login(<#if loginTable.hasOrgan>${loginTable.orgColumn.fieldName}: ${loginTable.orgColumn.fieldType}, </#if>@NotBlank username: String, @NotBlank password: String, request: HttpServletRequest, response: HttpServletResponse): ApiResult<LoginInfo> {
        return try {
            val info = service.login(<#if loginTable.hasOrgan>${loginTable.orgColumn.fieldName}, </#if>username, password)
            JwtUtils.writeToHeader(info.token, request, response)
            return ApiResult.success(info)
        } catch (e: AuthenticationException) {
            e.cause?.also { throw it }
            ApiResult.failClient("登录失败")
        }
    }

</#if>
    @PostMapping("status")
    @ApiOperation(value = "登录状态")
    fun status(): ApiResult<Any> {
        val subject = SecurityUtils.getSubject()
        if (!subject.isAuthenticated) {
            return ApiResult.success(arrayOf("未登录"))
        }
        return ApiResult.success(
            arrayOf(
                subject.principals.oneByType(JwtBearer::class.java),
                subject.principals.oneByType(DecodedJWT::class.java)
            )
        )
    }

    @ApiIgnore
    @ApiOperation(value = "请先登录", hidden = true)
    @RequestMapping("failed")
    fun failed(): ApiResult<Any> {
        return ApiResult.fail(ResultCode.Unauthorized)
    }

    @ApiIgnore
    @RequestMapping("expired")
    @ApiOperation(value = "凭证过期", hidden = true)
    fun expired(): ApiResult<Any> {
        return ApiResult.fail(ResultCode.Unauthorized)
    }

}