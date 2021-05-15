package ${packageName}.controller

import ${packageName}.constant.ResultCode
import ${packageName}.constant.UserType
import ${packageName}.exception.ServiceException
import ${packageName}.model.api.ApiResult
import ${packageName}.model.api.LoginInfo
import ${packageName}.service.AuthService
import ${packageName}.shiro.model.JwtBearer
import ${packageName}.util.JwtUtils
import io.swagger.annotations.Api
import io.swagger.annotations.ApiImplicitParam
import io.swagger.annotations.ApiImplicitParams
import io.swagger.annotations.ApiOperation
import org.slf4j.LoggerFactory
import org.springframework.util.DigestUtils
import org.springframework.validation.annotation.Validated
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import springfox.documentation.annotations.ApiIgnore

import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

/**
 * 登录验证 API 实现
 * @author ${author}
 * @since ${now?string("yyyy-MM-dd zzzz")}
 */
@Validated
@RestController
@Api(tags = ["登录认证"])
@RequestMapping("api/v1/auth")
class AuthController {

    private val logger = LoggerFactory.getLogger(this.javaClass)

    @Autowired
    private lateinit var authConfig: AuthConfig
    @Autowired
    private lateinit var jwtAlgorithm: Algorithm

    @GetMapping("version")
    @ApiOperation(value = "版本信息", notes = "获取maven打包版本")
    fun version(): ApiResult<String> {
        return ApiResult.success(IndexController::class.java.getPackage().implementationVersion ?: "调试版本")
    }

    @PostMapping("login")
    @ApiOperation(value = "后台登录", notes = "仅限管理后台登录")
    @ApiImplicitParams(
        ApiImplicitParam(paramType = "form", value = "登录名", name = "username", required = true, defaultValue = "admin"),
        ApiImplicitParam(paramType = "form", value = "登录密码", name = "password", required = true, defaultValue = "admin")
    )
    fun login(@NotBlank username: String, @NotBlank password: String, request: HttpServletRequest, response: HttpServletResponse): ApiResult<LoginInfo> {
        try {
            val info = service.login(username, password)
            JwtUtils.writeToHeader(info.token, request, response)
            return ApiResult.success(info);
        } catch (AuthenticationException e) {
            if (e.getCause() != null) {
            throw e.getCause();
            }
            log.error("登录失败", e);
            return ApiResult.fail400("登录失败");
        }
    }

    @ApiOperation(value = "管理员注销登录")
    @GetMapping("logout")
    fun logout(@ApiIgnore session: HttpSession): ApiResult<String>? {
        if (session.getAttribute(UserType.Admin.name) != null) {
            session.removeAttribute(UserType.Admin.name)
            return ApiResult.success("注销登录成功")
        } else {
            throw ServiceException("请先登录")
        }
    }

    @ApiOperation(value = "请先登录", hidden = true)
    @RequestMapping("failed")
    fun failed(): ApiResult<Any>? {
        return ApiResult(null, ResultCode.C401.code, ResultCode.C401.remark)
    }

}