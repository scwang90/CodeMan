package ${packageName}.controller

import ${packageName}.constant.ResultCode
import ${packageName}.constant.UserType
import ${packageName}.exception.ServiceException
import ${packageName}.model.api.ApiResult
import io.swagger.annotations.Api
import io.swagger.annotations.ApiImplicitParam
import io.swagger.annotations.ApiImplicitParams
import io.swagger.annotations.ApiOperation
import org.slf4j.LoggerFactory
import org.springframework.util.DigestUtils
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import springfox.documentation.annotations.ApiIgnore
import javax.servlet.http.HttpSession

/**
 * 登录验证 API 实现
 * @author ${author}
 * @date ${.now?string("yyyy-MM-dd zzzz")}
 */
@RestController
@Api("auth", description = "登录验证API")
@RequestMapping("/api/v1/auth")
class AuthController {

    private val logger = LoggerFactory.getLogger(this.javaClass)
//
//    @Autowired
//    private lateinit var mapper : AdminMapper

    @PostMapping("login")
    @ApiOperation(value = "管理员登录", notes = "后台管理相关API都需要先登录")
    @ApiImplicitParams(
        ApiImplicitParam(paramType = "form", value = "登录名", name = "username", required = true, defaultValue = "admin"),
        ApiImplicitParam(paramType = "form", value = "登录密码", name = "password", required = true, defaultValue = "admin")
    )
    fun login(username: String, password: StringBuilder, @ApiIgnore session: HttpSession): ApiResult<Any/*Admin*/>? {
        password.apply {
            DigestUtils.md5DigestAsHex(password.toString().byteInputStream()).apply {
                logger.debug("密文：$this")
                setLength(0)
                append(this)
            }
        }
//        if (mapper.countAll() == 0) {
//            mapper.insert(Admin().apply {
//                this.username="admin"
//                this.password = DigestUtils.md5DigestAsHex("admin".byteInputStream())
//            })
//        }
//        val list = mapper.findWhereByPage("", "WHERE username='$username' AND password='$password'", 1, 0)
        val list = mutableListOf<String>()
        if (username == "admin" && password.toString() == DigestUtils.md5DigestAsHex("admin".byteInputStream())) {
            list.add("超级管理员")
        }
        if (list.isEmpty()) {
            throw ServiceException("用户名或密码错误")
        } else {
            session.setAttribute(UserType.Admin.name, list[0])
            return ApiResult(result = list[0])
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